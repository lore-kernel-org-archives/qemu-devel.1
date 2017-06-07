Received: from eggs.gnu.org ([2001:4830:134:3::10]:44993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dId9F-0002Fw-1X
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dId9A-0000nw-4A
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:45:29 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:44573 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dId99-0000nS-Oa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:45:24 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
Date: Wed, 07 Jun 2017 18:45:10 +0300
In-Reply-To: <CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
	(Peter Maydell's message of "Wed, 7 Jun 2017 13:07:59 +0100")
Message-ID: <87zidjztrt.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Peter Maydell writes:

> On 7 June 2017 at 12:12, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wrote:
>> My understanding was that adding a public instrumentation interface woul=
d add
>> too much code maintenance overhead for a feature that is not in QEMU's c=
ore
>> target.

> Well, it depends what you define as our core target :-)
> I think we get quite a lot of users that want some useful ability
> to see what their guest code is doing, and these days (when
> dev board hardware is often very cheap and easily available)
> I think that's a lot of the value that emulation can bring to
> the table. Obviously we would want to try to do it in a way
> that is low-runtime-overhead and is easy to get right for
> people adding/maintaining cpu target frontend code...

In that case I would say that QEMU is now much more in line with what I
proposed. The mechanisms I have (and most have been sent here in the form of
patch series) are architecture-agnostic (the generic code translation loop I
RFC'ed some time ago) and provide relatively good performance.

I did some tests tracing memory accesses of SPEC benchmarks in x86-64, and =
QEMU
is consistently faster than PIN in most cases. Even better, it works for any
guest architecture and for both apps and full systems.

This speed comes at the cost of exposing TCG operations to the instrumentat=
ion
library (i.e., the library can inject TCG code; AFAIR, calling out into a
function in the instrumentation library is slower than PIN). I have a separ=
ate
project that translates a higher-level language into the TCG instrumentation
primitives (providing something like PIN's instrumentation auto-inlining), =
but I
think that's a completely separate discussion.

If there is such renewed interest, I will carve a bit more time to bring the
patches up to date and send the instrumentation ones for further discussion.


Cheers,
  Lluis

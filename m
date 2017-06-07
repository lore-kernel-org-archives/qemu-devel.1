Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIdWK-0005fO-15
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIdWF-0002xf-EN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:09:19 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIdWF-0002wZ-53
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:09:15 -0400
Received: by mail-wm0-x229.google.com with SMTP id n195so14544616wmg.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 09:09:15 -0700 (PDT)
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
	<000023f1-57a6-b211-d9d1-87b8f39326d5@redhat.com>
	<87fufbztfm.fsf@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87fufbztfm.fsf@frigg.lan>
Date: Wed, 07 Jun 2017 17:09:39 +0100
Message-ID: <87bmpzdbjw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alessandro Di Federico <ale+qemu@clearmind.me>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Paolo Bonzini writes:
>
>> On 07/06/2017 14:07, Peter Maydell wrote:
>>>> My understanding was that adding a public instrumentation interface would add
>>>> too much code maintenance overhead for a feature that is not in QEMU's core
>>>> target.
>>> Well, it depends what you define as our core target :-)
>>> I think we get quite a lot of users that want some useful ability
>>> to see what their guest code is doing, and these days (when
>>> dev board hardware is often very cheap and easily available)
>
>> and virtualization is too...
>
> Actually, in this case I was thinking of some way to transition between KVM and
> TCG back and forth to be able to instrument a VM at any point in time.

While we are blue sky thinking another fun thing might be doing system
emulation without SoftMMU but instead using the hosts virtualized page
tables (i.e. running TCG code inside KVM). Obviously there are mapping
issues given differing page sizes and the like but it would save the
SoftMMU overhead.
>
>
>>> I think that's a lot of the value that emulation can bring to
>>> the table. Obviously we would want to try to do it in a way
>>> that is low-runtime-overhead and is easy to get right for
>>> people adding/maintaining cpu target frontend code...
>
>> Indeed.  I even sometimes use TCG -d in_asm,exec,int for KVM unit tests,
>> because it's easier to debug them that way :) so introspection ability
>> is welcome.
>
> AFAIR, Blue Swirl once proposed to use the instrumentation features to implement
> unit tests.
>
>
>> Related to this is also Alessandro's work to librarify TCG (he has a
>> TCG-> LLVM backend for example).
>
> Maybe I misunderstood, but that would be completely orthogonal, even though
> instrumentation performance might benefit from LLVM's advanced IR
> optimizers. But this goes a long way to hot code identification and asynchronous
> optimization (since code that is not really hot will just run faster with
> simpler optimizations, like in the TCG compiler). This actually sounds pretty
> much like Java's HotSpot, certainly a non-trivial effort.

--
Alex Bennée

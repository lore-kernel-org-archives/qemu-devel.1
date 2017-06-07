Received: from eggs.gnu.org ([2001:4830:134:3::10]:58184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIb7f-0001UU-9J
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIb7a-0004M5-CE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIb7a-0004Lm-6I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:35:38 -0400
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <000023f1-57a6-b211-d9d1-87b8f39326d5@redhat.com>
Date: Wed, 7 Jun 2017 15:35:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] GSoC 2017 Proposal: TCG performance enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alessandro Di Federico <ale+qemu@clearmind.me>



On 07/06/2017 14:07, Peter Maydell wrote:
>> My understanding was that adding a public instrumentation interface would add
>> too much code maintenance overhead for a feature that is not in QEMU's core
>> target.
> Well, it depends what you define as our core target :-)
> I think we get quite a lot of users that want some useful ability
> to see what their guest code is doing, and these days (when
> dev board hardware is often very cheap and easily available)

and virtualization is too...

> I think that's a lot of the value that emulation can bring to
> the table. Obviously we would want to try to do it in a way
> that is low-runtime-overhead and is easy to get right for
> people adding/maintaining cpu target frontend code...

Indeed.  I even sometimes use TCG -d in_asm,exec,int for KVM unit tests,
because it's easier to debug them that way :) so introspection ability
is welcome.

Related to this is also Alessandro's work to librarify TCG (he has a
TCG->LLVM backend for example).

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIeQa-0001nT-N7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIeQV-0002xQ-Mx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:07:28 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dIeQV-0002x0-Gz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:07:23 -0400
Received: by mail-wr0-x242.google.com with SMTP id u101so1727608wrc.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 10:07:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAJhHMCBwu-pVAyxN+w8SSo19wi3DW3JCRRF-K1Sj9zYqGYkFvQ@mail.gmail.com>
	<20170606171320.GA8115@flamenco> <877f0o3vbn.fsf@frigg.lan>
	<CAFEAcA8RBMtfS+5GP=cGeAdV+zgGRg5OPEAu_PY+_hEPcWaJqw@mail.gmail.com>
	<000023f1-57a6-b211-d9d1-87b8f39326d5@redhat.com>
	<87fufbztfm.fsf@frigg.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0a7218b-e472-7d83-500c-098becf9e347@redhat.com>
Date: Wed, 7 Jun 2017 19:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <87fufbztfm.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alessandro Di Federico <ale+qemu@clearmind.me>



On 07/06/2017 17:52, Lluís Vilanova wrote:
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

That's not really easy because KVM exposes different hardware (on x86:
kvmclock, hypercalls, x2apic, more MSRs).  But we are digressing.

>> Related to this is also Alessandro's work to librarify TCG (he has a
>> TCG-> LLVM backend for example).
> 
> Maybe I misunderstood, but that would be completely orthogonal, even though
> instrumentation performance might benefit from LLVM's advanced IR
> optimizers.

It is different, but it shows the interest in bringing QEMU's
translation engine (the front-end in Alessandro's case, the back-end in
yours) beyond the simple usecase of dynamic recompilation.

Paolo

> But this goes a long way to hot code identification and asynchronous
> optimization (since code that is not really hot will just run faster with
> simpler optimizations, like in the TCG compiler). This actually sounds pretty
> much like Java's HotSpot, certainly a non-trivial effort.
> 
> 
> Cheers,
>   Lluis
> 

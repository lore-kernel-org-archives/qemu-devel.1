Received: from eggs.gnu.org ([2001:4830:134:3::10]:44330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnk8R-0000uM-5K
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnk8Q-0000jt-AW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:56:59 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnk8Q-0000jf-3o
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:56:58 -0400
Received: by mail-wr0-x22e.google.com with SMTP id u108so121198049wrb.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:56:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wpbstesf.fsf@secure.mitica>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:56:36 +0100
Message-ID: <CAFEAcA9nZszkmH7-P9jkxoGxLYHKspDiS-PFUyVZrrtDfgPNMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On 14 March 2017 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
>>> The minimum requirements for the new language:
>>> 1. Does it support the host operating systems that QEMU runs on?
>>> 2. Does it support the host architectures that QEMU runs on?
>>
>> Speaking of this, I was thinking that we should introduce
>> a rule that for any host OS/arch we support we must have
>> a build machine so we can at least do a compile test.
>> For instance if you believe configure we support Solaris
>> and AIX, but I bet they're bit-rotting. The ia64 backend
>> has to be a strong candidate for being dumped too.
>> Demanding "system we can test on or we drop support"
>> would let us more clearly see what we're actually running
>> on and avoid unnecessarily ruling things out because they
>> don't support Itanium or AIX...
>
> YES, YES and YES.
>
> I demand an osX build machine NOW!!!!  Remote access is ok.

OSX is actually in the set that's OK because I have a
machine I can test on. The ones that are problems are
all the BSDs, AIX, Solaris, Haiku, and architectures
sparc, mips, ia64, s390.

thanks
-- PMM

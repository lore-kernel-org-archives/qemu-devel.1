Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnipa-0001ne-U1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnipW-0006X6-Vq
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnipW-0006Wo-Pz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:33:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
Date: Tue, 14 Mar 2017 10:33:19 +0100
In-Reply-To: <CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	(Peter Maydell's message of "Tue, 14 Mar 2017 09:37:24 +0100")
Message-ID: <87efy0mcdc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
>> The minimum requirements for the new language:
>> 1. Does it support the host operating systems that QEMU runs on?
>> 2. Does it support the host architectures that QEMU runs on?
>
> Speaking of this, I was thinking that we should introduce
> a rule that for any host OS/arch we support we must have
> a build machine so we can at least do a compile test.
> For instance if you believe configure we support Solaris
> and AIX, but I bet they're bit-rotting. The ia64 backend
> has to be a strong candidate for being dumped too.
> Demanding "system we can test on or we drop support"
> would let us more clearly see what we're actually running
> on and avoid unnecessarily ruling things out because they
> don't support Itanium or AIX...

Yes, please.

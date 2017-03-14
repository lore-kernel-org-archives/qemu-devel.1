Received: from eggs.gnu.org ([2001:4830:134:3::10]:60045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnqGi-0004wQ-Br
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnqGe-00015W-FH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnqGe-00015M-9N
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:29:52 -0400
Date: Tue, 14 Mar 2017 17:29:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170314172947.GP2445@work-vm>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<CAFEAcA9Ogy_XnpaaGWHsuAQC=CYNQsT0ESCZ68tn4bg4GFi7LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Ogy_XnpaaGWHsuAQC=CYNQsT0ESCZ68tn4bg4GFi7LQ@mail.gmail.com>
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
Cc: Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 14 March 2017 at 17:01, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > I also do a FreeBSD VM
> 
> Do you have repro instructions for how to conveniently set
> this up?

No, but given that it's the first time I've set up a BSD in ~20 years
it can't have been that hard.
It's just a guest with IDE disk, rtl8139 ether.

Then I've got:
https://www.freebsd.org/doc/handbook/pkgng-intro.html

set up, so then you can just do   pkg install whatever

Remember you need gmake but other than that it gets as far
as moaning about the asm in the optionrom but other than that it
compiles fine.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

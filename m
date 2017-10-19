Received: from eggs.gnu.org ([2001:4830:134:3::10]:34203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e57G4-0001kF-F8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e57G0-0000r0-F0
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:36:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1e57G0-0000pv-9C
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:36:52 -0400
Date: Thu, 19 Oct 2017 11:36:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171019093647.GA6195@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-4-anatol.pomozov@gmail.com>
	<CAOMFOmUaJT+OdfN9Yin91AiP_+HXMbVFXuPY0FORb1PNvzYCmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmUaJT+OdfN9Yin91AiP_+HXMbVFXuPY0FORb1PNvzYCmw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>

Am 18.10.2017 um 19:22 hat Anatol Pomozov geschrieben:
> Hello qemu-devs,
> 
> This patchset has been posted a while ago. I would like to move
> forward with it and look at the next task (e.g. multiboot2 support in
> QEMU). Who is the multiboot code maintainer who can help to review
> this patchset and give go/no-go answer?

I think that's exactly your problem, there is nobody who feels
responsible for Multiboot support. Officially, it is part of the PC/x86
subsystems:

$ scripts/get_maintainer.pl -f hw/i386/multiboot.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
Richard Henderson <rth@twiddle.net> (maintainer:X86)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
qemu-devel@nongnu.org (open list:All patches CC here)

I'm not sure if any of them know much about Multiboot. Myself, I am
personally interested in having Multiboot support, which is why I've
even commented on your patches, but I'm not the maintainer.

The last few Multiboot patches seem to have been merged by Paolo.

Kevin

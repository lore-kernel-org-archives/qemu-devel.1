Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNDy-0002aI-W1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNDu-0008NL-Up
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:22:14 -0500
Date: Thu, 1 Mar 2018 13:21:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180301132148.3ea75777.cohuck@redhat.com>
In-Reply-To: <0f981ba8-d711-2b9e-942a-c124fc9dd5cf@redhat.com>
References: <20180227132150.13847-1-cohuck@redhat.com>
	<CAFEAcA9=59C4NcFTCf489iYttbw56BTLufb5Ee3VnnhQr8xiwg@mail.gmail.com>
	<20180301112702.1812057c.cohuck@redhat.com>
	<0f981ba8-d711-2b9e-942a-c124fc9dd5cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/26] s390x updates (and friends)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 1 Mar 2018 12:17:12 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 01.03.2018 11:27, Cornelia Huck wrote:
> > On Thu, 1 Mar 2018 10:12:53 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> >> On 27 February 2018 at 13:21, Cornelia Huck <cohuck@redhat.com> wrote:  
> >>> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
> >>>
> >>>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   git://github.com/cohuck/qemu tags/s390x-20180227
> >>>
> >>> for you to fetch changes up to eae9f29130f3ed40ad77f40a3bae4b9ebff28907:
> >>>
> >>>   Merge tag 'tags/s390-ccw-bios-2018-02-26' into s390-next (2018-02-27 13:54:37 +0100)
> >>>
> >>> ----------------------------------------------------------------
> >>> - add query-cpus-fast and deprecate query-cpus, while adding s390 cpu
> >>>   information
> >>> - remove s390x memory hotplug implementation, which is not useable in
> >>>   this form
> >>> - add boot menu support in the s390-ccw bios
> >>> - expose s390x guest crash information
> >>> - fixes and cleaups
> >>>
> >>> ----------------------------------------------------------------    
> >>
> >> Something seems to be broken here: this failed 'make check' on
> >> most hosts with
> >> TEST: tests/pxe-test... (pid=48288)
> >>   /s390x/pxe/ipv4/s390-ccw-virtio/virtio-net-ccw:                      **
> >> ERROR:/home/pm215/qemu/tests/boot-sector.c:158:boot_sector_test:
> >> assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
> >>
> >> and just failed without an error on the rest (with the exception of
> >> my Linux box, where that test hung entirely with qemu-system-s390x
> >> using 100% of cpu).
> >>
> >> thanks
> >> -- PMM  
> > 
> > Hm, smells bootloader patches related... Thomas?  
> FWIW, I just bisected the issue and it's not due to the bootloader
> changes, but due to this one:
> 
>  f26852aa31d49bf83a8defd65538137a2f9da82c is the first bad commit
>  commit f26852aa31d49bf83a8defd65538137a2f9da82c
>  Author: David Hildenbrand <david@redhat.com>
>  Date:   Tue Feb 13 17:12:40 2018 +0100
>  Subject: s390x/tcg: fix disabling/enabling DAT

David already sent "s390x/tcg: fix loading 31bit PSWs with the highest
bit set", I'll think I'll queue on top and resend (after testing).

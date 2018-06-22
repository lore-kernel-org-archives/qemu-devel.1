Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fWLar-0002Vw-Kh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fWLaq-0003iX-Bi
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:55:13 -0400
Date: Fri, 22 Jun 2018 14:55:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180622125502.GF4366@localhost.localdomain>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>, libvir-list@redhat.com, eblake@redhat.com, pkrempa@redhat.com

Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> 
> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> > The -drive option serial was deprecated in QEMU 2.10. It's time to
> > remove it.
> > 
> > Tests need to be updated to set the serial number with -global instead
> > of using the -drive option.
> 
> libvirt 4.5 still creates those (at least on s390x)
> 
>     <disk type='file' device='disk'>
>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
>       <target dev='hda' bus='virtio'/>
>       <serial>skel</serial>
>       <boot order='1'/>
>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
>     </disk>
> 
> 
> -> 
> [...]
> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
> [...]
> 
> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
> 
> So it seems that this breaks s390x.

Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
released.

Sadly, it also shows that deprecation warnings in log files go
unnoticed.

Kevin

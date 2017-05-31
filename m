Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dG6Cg-0006Mr-5F
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dG6Cf-0006w9-3Q
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:10:34 -0400
Date: Wed, 31 May 2017 17:10:26 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170531161026.GG27432@redhat.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Wed, May 31, 2017 at 06:54:33PM +0300, Pavel Butsykin wrote:
> It is assumed that the user has already made a preparatory with the
> image:
> 1. freeing space at the end of the image
> 2. reducing the last partition on the disk
> 3. rebuilding fs
> Only after these steps, the user can reduce the image by qemu-img.

It's tricky with GPT, as GPT puts a second copy of the header in the
last few sectors of the disk.  I always advise people to use trim (or
virt-sparsify) instead of trying to adjust virtual disk size.

Nevertheless I don't think we should prevent shrinking qcow2 virtual
size.  It's likely useful to someone.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

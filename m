Received: from eggs.gnu.org ([2001:4830:134:3::10]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dspT7-0002kK-Ms
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dspT6-0008VD-Qj
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:11:37 -0400
Date: Fri, 15 Sep 2017 14:11:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170915121119.GB4077@localhost.localdomain>
References: <20170913091038.2900-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913091038.2900-1-cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] iotests: cure s390x failures by
 switching to ccw/aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, haoqf@linux.vnet.ibm.com

Am 13.09.2017 um 11:10 hat Cornelia Huck geschrieben:
> Recent changes in s390x made pci support dependant on the zpci cpu
> feature, which is not provided on all models (and not on by default).
> This means we cannot instatiate pci devices on a standard qemu
> invocation for s390x. Moreover, the zpci instructions are not even
> wired up for tcg yet, so actually doing anything with those pci devices
> is bound to fail on tcg.
> 
> For 040, 051, 139, and 182, this can be fixed by switching to virtio-ccw
> from virtio-pci on s390x. 051 also needs a bit of post-processing on
> the output.
> 
> For 067, it is easier to switch to virtio aliases, which will pick
> virtio-ccw on s390x and virtio-pci elsewhere. It also exercises the
> aliasing path.

Thanks, dropped the whitespace change in patch 3 and applied to the
block branch.

Kevin

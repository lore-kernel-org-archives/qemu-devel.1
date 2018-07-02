Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fZrBP-00021r-JP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fZrBM-0004qg-Eg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fZrBM-0004qB-7R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:15:24 -0400
Date: Mon, 2 Jul 2018 01:15:21 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2075134933.47253277.1530508521878.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180629170919.GE16547@stefanha-x1.localdomain>
References: <20180627112520.26085-1-pagupta@redhat.com>
	<20180629170919.GE16547@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] virtio-rng: process pending requests
 when driver is ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: amit@kernel.org, qemu-devel@nongnu.org, slopezpa@redhat.com, mst@redhat.com


> 
> On Wed, Jun 27, 2018 at 04:55:20PM +0530, Pankaj Gupta wrote:
> > +static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> > +{
> > +    VirtIORNG *vrng = VIRTIO_RNG(vdev);
> > +
> > +    if (!vdev->vm_running) {
> > +        return;
> > +    }
> > +    vdev->status = status;
> 
> Please add a comment to explain this, otherwise someone might think this
> is unnecessary since virtio.c also does it.

Sure. Will add a comment and send v3.

Thanks,
Pankaj

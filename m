Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHbu-0003eC-Lo
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHbq-0002Pg-0J
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVHbp-0002Os-R8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:23:17 -0400
Date: Wed, 12 Jul 2017 15:23:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712152311.40c8561b@dhcp-192-215.str.redhat.com>
In-Reply-To: <9d882fcb-2600-877c-8355-246fb9b30f48@redhat.com>
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
	<5d875407-37fd-bd27-8a04-619247fc2d91@de.ibm.com>
	<9d882fcb-2600-877c-8355-246fb9b30f48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/11] Implement network booting in the
 s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Wed, 12 Jul 2017 15:04:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 12.07.2017 15:00, Christian Borntraeger wrote:
> > On 07/12/2017 02:49 PM, Thomas Huth wrote:  
> >> It's already possible to do a network boot of an s390x guest with an
> >> external netboot image based on a Linux installation, but it would
> >> be much more convenient if the s390-ccw firmware supported network
> >> booting right out of the box, without the need to assemble such an
> >> external image first.
> >>
> >> This patch series now introduces a s390-netboot.img that can be used
> >> for network booting via DHCP and TFTP by re-using the networking stack
> >> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> >> and adds a driver for virtio-net-ccw devices.  
> [...]
> > thanks applied.
> > 
> > (will do some testing and rebuilding of the image files on top). Where do
> > we want to put the binary result? pc-bios/s390-netboot.img I assume?  
> 
> Yes. And I guess we need to add a BLOBS entry in main Makefile for this,
> too, so that it gets installed properly? Could you please do that, too,
> after you've added the binary?

+1

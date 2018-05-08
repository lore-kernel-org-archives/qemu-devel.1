Received: from eggs.gnu.org ([2001:4830:134:3::10]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFuom-0002oe-RA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 01:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fFuoj-0004tU-LC
	for qemu-devel@nongnu.org; Tue, 08 May 2018 01:05:40 -0400
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68c360c2-2da0-5a26-c9be-27fef9fa031b@redhat.com>
Date: Tue, 8 May 2018 07:05:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/2] s390x/ccw: make sure all
 ccw devices are properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 07.05.2018 17:51, Cornelia Huck wrote:
> Thomas reported that the subchannel for a  3270 device that ended up
> in a broken state (status pending even though not enabled) did not
> get out of that state even after a reboot (which involves a subsytem
> reset). The reason for this is that the 3270 device did not define
> a reset handler.
> 
> Let's fix this by introducing a base reset handler (set up for all
> ccw devices) that resets the subchannel and have virtio-ccw call
> its virtio-specific reset procedure in addition to that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/ccw-device.c | 8 ++++++++
>  hw/s390x/virtio-ccw.c | 9 ++++++---
>  hw/s390x/virtio-ccw.h | 1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)

Looks good!

Reviewed-by: Thomas Huth <thuth@redhat.com>

I also checked that the broken 3270 device is now operational after a
reboot again with your two patches, so:

Tested-by: Thomas Huth <thuth@redhat.com>

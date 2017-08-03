Received: from eggs.gnu.org ([2001:4830:134:3::10]:35333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddHNP-00015p-RU
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddHNL-0002QO-3v
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddHNK-0002Nl-TF
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:23 -0400
Date: Thu, 3 Aug 2017 11:45:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170803144508.GI3108@localhost.localdomain>
References: <20170801230155.21083-1-ehabkost@redhat.com>
	<61e65941-a035-a1fd-4a09-3dc54aac7354@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e65941-a035-a1fd-4a09-3dc54aac7354@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Mark virtio-device as
 non-user-creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Aug 02, 2017 at 02:33:00PM +0200, Halil Pasic wrote:
> 
> 
> On 08/02/2017 01:01 AM, Eduardo Habkost wrote:
> > TYPE_VIRTIO_DEVICE devices are already not usable with -device
> > and device_add, but they are reported as user-creatable on
> > "-device help" and through monitor interfaces.
> 
> I've tried -device virtio-rng on s390x and from what I see, it
> seems we 'auto-magically' create the 'controlling' virtio-rng-ccw
> device. So I have to ask what do you mean by 'already not usable'?

virtio-rng is just an alias for virtio-rng-<transport>, and it's
not a TYPE_VIRTIO_DEVICE device.

virtio-rng-device is the TYPE_VIRTIO_DEVICE subclass, and you
shouldn't be able to use "-device virtio-rng-device".  Except
that it works with "qemu-system-arm -machine virt", as I noted on
another message, and this patch breaks it.

-- 
Eduardo

Received: from eggs.gnu.org ([209.51.188.92]:51170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1BD6-0000Lc-30
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1BD4-0005uf-BY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:38:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1BD3-0005u7-SL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:38:22 -0500
Date: Tue, 5 Mar 2019 15:38:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Amit Shah <amit@kernel.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cole Robinson <crobinso@redhat.com>, Daniel Berrange <berrange@redhat.com>

  Hi,

>   -device virtio-blk-pci-non-transitional \
>   -device virtio-net-pci-non-transitional \
>   -device virtio-gpu-pci-non-transitional \
> 
> and you wouldn't have to question why you can use the
> non-transitional variant for pretty much everything, except for the
> few cases where you can't - for no apparent reason...

Well, there are no variants, only a single virtio-$foo-pci* device.  So
you don't have to worry about picking one of the available variants,
there is no choice in the first place.

When adding an virtio-gpu-pci-non-transitional variant we'll create
confusion too, because it wouldn't be a real variant.  We would have two
100% identical devices then, and people will probably wonder why they
exist and what the difference is ...

So I can't see how this would be so much better.  We have to document
the mess no matter what.

cheers,
  Gerd

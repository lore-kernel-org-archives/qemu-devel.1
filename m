Received: from eggs.gnu.org ([2001:4830:134:3::10]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gCUIe-0000Rj-PW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gCUIb-00034y-Qt
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gCUIa-00032r-QZ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:42:33 -0400
Date: Tue, 16 Oct 2018 20:42:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181016184218.fhtmkfntj4xfg5oy@sirius.home.kraxel.org>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181015081641.q6r5wnhm7rq5tgfh@sirius.home.kraxel.org>
	<20181015062543-mutt-send-email-mst@kernel.org>
	<20181015230342.GJ31060@habkost.net>
	<20181016064816.34ykasexdp5ikioz@sirius.home.kraxel.org>
	<20181016133921.GQ31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016133921.GQ31060@habkost.net>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>

  Hi,

> > See above.  We can't drop disable-modern.
> 
> Good point.  But this doesn't require it to be a supported device
> option for users/management.  Maybe we should rename it to
> "x-disable-modern" (but that's a separate discussion).

I think it would be more useful to allow properties being tagged as
"no-user", simliar to devices which we do not want be created via
-device.

> > > If we still want to provide a legacy-only virtio device, it should be
> > > a separate device type.
> > 
> > I can't see a reason why we should provide legacy-only virtio devices.
> 
> If the only reason for disable-modern to exist is for internal
> usage by machine-type code, I agree we don't need the -0.9 device
> types.

In the early virtio-1.0 days it was required for testing.  We had one or
two releases with virtio-1.0 support merged but not (yet) turned on by
default, so you had to use disable-modern=off to enable virtio-1.0
support.  That use case is gone though since we flipped the default.

cheers,
  Gerd

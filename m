Received: from eggs.gnu.org ([2001:4830:134:3::10]:58317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuwfY-0005V3-2Z
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuwXx-000777-Kk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:13:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fuwXx-00075Q-Ca
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3ED985788
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 09:13:50 +0000 (UTC)
Date: Wed, 29 Aug 2018 10:13:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180829091343.GH31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-30-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-30-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 29/29] hw/display: add vhost-user-vga &
 gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com, kraxel@redhat.com

On Fri, Jul 13, 2018 at 03:09:16PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Add new virtio-gpu devices with a "vhost-user" property. Tthe
> associated vhost-user backend is used to handle the virtio rings and
> provide rendering results thanks to the vhost-user-gpu protocol.
>=20
> Example usage:
> -object vhost-user-backend,id=3Dvug,cmd=3D"./vhost-user-gpu"
> -device vhost-user-vga,vhost-user=3Dvug

This is a pretty different approach from what QEMU has done for modelling
in the past. We've always had separation between the frontend device and
the backend provider, with a single frontend device impl being plugged
into an arbitrary backend type. This though is introducing a frontend
device that actually has the name of a backend which is rather bizarre
and quite misleading as it on first sight looks like a new device type.

If we must introduce new device types, at very least the confusion could
be reduced by calling it "virtio-vga-vhost" so it is clear its the same
device type as virtio-vga, likewise 'virtio-gpu-pci-vhost'

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

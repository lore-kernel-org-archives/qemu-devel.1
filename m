Received: from eggs.gnu.org ([209.51.188.92]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyz8b-0006KV-Kg
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyz8a-0007qr-QJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyz8a-0007oY-Gw
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:20:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6124C30ABAB6
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:14:03 +0000 (UTC)
Date: Wed, 27 Feb 2019 14:13:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190227131356.txkyhzr7w3zwrxph@sirius.home.kraxel.org>
References: <20190227103017.29515-1-marcandre.lureau@redhat.com>
	<20190227103017.29515-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190227103017.29515-12-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/12] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Wed, Feb 27, 2019 at 11:30:16AM +0100, Marc-Andr=E9 Lureau wrote:
> Add a new virtio-input device, which connects to a vhost-user
> backend.
>=20
> vhost-user-input is similar to virtio-input-host, it is wrapped by
> vhost-user-input-pci. Instead of reading configuration directly from
> an input device / evdev, it reads it over vhost-user protocol with
> INPUT_GET_CONFIG message. Then vhost-user-backend takes care of
> interfacing the virtio device with the backend, for the queue & events
> processing.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

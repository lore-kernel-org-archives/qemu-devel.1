Received: from eggs.gnu.org ([209.51.188.92]:37301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkbV-0004c7-Sr
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkbV-0003fP-3G
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwkbU-0003eu-Ko
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:25:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E86FB307EA97
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:25:15 +0000 (UTC)
Date: Thu, 21 Feb 2019 10:25:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221092510.gu2rj7d6lrzpxkl6@sirius.home.kraxel.org>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-12-marcandre.lureau@redhat.com>
	<20190208102812-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208102812-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/13] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Fri, Feb 08, 2019 at 10:28:38AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 08, 2019 at 12:23:55PM +0100, Marc-Andr=E9 Lureau wrote:
> > Add a new virtio-input device, which connects to a vhost-user
> > backend.
> >=20
> > vhost-user-input is similar to virtio-input-host, it is wrapped by
> > vhost-user-input-pci. Instead of reading configuration directly from
> > an input device / evdev, it reads it over vhost-user protocol with
> > INPUT_GET_CONFIG message. Then vhost-user-backend takes care of
> > interfacing the virtio device with the backend, for the queue & event=
s
> > processing.
> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Gerd what's your take on this? Do we want this functionality?

Yes, I think it makes sense.  Moving this to a separate process isn't
that useful for virtio-input, other devices like virtio-gpu will benefit
much more from it from a security and performance point of view.  It
still is useful for (a) testing the vhost-user infrastructure and (b) as
relatively simple example.

cheers,
  Gerd

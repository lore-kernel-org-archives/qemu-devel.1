Received: from eggs.gnu.org ([209.51.188.92]:60524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghKrM-0001X1-Cc
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghKrL-0007XV-K8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghKrL-0007Wp-Ej
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:55 -0500
Received: by mail-wr1-x435.google.com with SMTP id 96so9099606wrb.2
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 12:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
	<20181219103112-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLKftEt8g5WyW8NPOPNsKPXhNnS3BkdVqjrny4cjb+kWw@mail.gmail.com>
	<20181220113338-mutt-send-email-mst@kernel.org>
	<CAJ+F1CK1jeJgk07TXwHWpZLhO59Rrf7gSfpB6=J-NO+sYFfwpA@mail.gmail.com>
	<20190109084501.bp6m3rzp6xrqzn2r@sirius.home.kraxel.org>
In-Reply-To: <20190109084501.bp6m3rzp6xrqzn2r@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Jan 2019 00:53:41 +0400
Message-ID: <CAJ+F1CKB0T12DhGLtwcv3DiLJWHp1QvL4SFpE4xwzN8oWRXmYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

Hi

On Wed, Jan 9, 2019 at 12:45 PM Hoffmann, Gerd <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Unfortunately, vdev is not set before vhost_dev_start().
> >
> > We could add the migration blocker there somehow?
>
> Sure.  Just use migrate_add_blocker() to do that at any time (see qxl.c
> for an example).

VhostUserInput inherits from VirtioInput, which implements vmsd.

The "Add vhost-user-input-pci" patch override the DeviceClass vmsd to
set it as unmigratable. If I understand correctly, Michael suggested
to add a check for device vmsd =3D=3D NULL in hw/virtio/vhost-user.c
instead.

However, vhost-user devices would still need to overwrite vmsd to NULL.

I don't think there is a benefit in the generic vmsd =3D=3D NULL check, as
you still need not to forget to overwrite vmsd to NULL in the
vhost-user device.

Am I missing something?

--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdgi-000221-6w
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdgd-0002ha-Sp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:43:40 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdgd-0002hW-LR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:43:35 -0400
Received: by mail-wm0-x241.google.com with SMTP id b84so23882566wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:43:35 -0700 (PDT)
Date: Tue, 30 May 2017 10:43:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530094332.GM11362@stefanha-x1.localdomain>
References: <20170529130956.20297-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8UbHMnQwI7BF+TB"
Content-Disposition: inline
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] usb patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--c8UbHMnQwI7BF+TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 03:09:47PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here comes the usb patch queue.  As usual some bugfixes, legacy options
> and hmp commands are deprecated, xhci is splitted so nec-xhci can have
> its own config option.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-usb-20170529-1
>=20
> for you to fetch changes up to 3bfecee2cb71f21cd39d6183f18b446c01917573:
>=20
>   ehci: fix frame timer invocation. (2017-05-29 14:19:16 +0200)
>=20
> ----------------------------------------------------------------
> usb: depricate legacy options and hmp commands
> usb: fixes for ehci and hub, split xhci variants
>=20
> ----------------------------------------------------------------
> Gerd Hoffmann (5):
>       ehci: fix overflow in frame timer code
>       xhci: split into multiple files
>       xhci: add CONFIG_USB_XHCI_NEC option
>       usb: don't wakeup during coldplug
>       ehci: fix frame timer invocation.
>=20
> Ladi Prosek (1):
>       usb-hub: set PORT_STAT_C_SUSPEND on host-initiated wake-up
>=20
> Thomas Huth (3):
>       usb: Deprecate the legacy -usbdevice option
>       usb: Deprecate HMP commands usb_add and usb_del
>       usb: Simplify the parameter parsing of the legacy usb serial device
>=20
>  hw/usb/hcd-xhci.h       | 226 ++++++++++++++++++++++++++++++++++++++++++=
+++
>  hw/usb/core.c           |   8 ++
>  hw/usb/dev-hub.c        |  15 ++-
>  hw/usb/dev-serial.c     |  21 +----
>  hw/usb/hcd-ehci.c       |  15 ++-
>  hw/usb/hcd-xhci-nec.c   |  63 +++++++++++++
>  hw/usb/hcd-xhci.c       | 238 +-----------------------------------------=
------
>  vl.c                    |   8 ++
>  default-configs/pci.mak |   1 +
>  hmp-commands.hx         |   6 +-
>  hw/usb/Makefile.objs    |   1 +
>  qemu-options.hx         |   9 +-
>  12 files changed, 348 insertions(+), 263 deletions(-)
>  create mode 100644 hw/usb/hcd-xhci.h
>  create mode 100644 hw/usb/hcd-xhci-nec.c
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--c8UbHMnQwI7BF+TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLT7EAAoJEJykq7OBq3PI2lMIAKCjbnygSEb15auXtrEYvb0X
rsjODvkTIuRG+My+ljVvX5j3RPvMxAUQoV0K/BpygW+KyT31CpeWpn6DF8iFfysu
ak0ZS0X6YSAToU5scNZiP5Eo7ULYzP0wO2bntNn5Lr4OF8zSIpLgCa7KfAs5Yxhh
nsF8rkMSBF+mvlemwjVpk4gQCjVqsrVBBKKTxqXRdgCWG5NM6UfZF84pLqXXaKeG
D7To/EfUqh3W2B8W3IC6WkVpPmVWDmPkwXyeZh7oY5fPQadNMFN7H8cXQWWKgcLA
4J0cZR8JKq/fV4Kbzer8NqZWATlEqAXXeSS37xLt7rLcCJmtU8B6DCOc0cadi5M=
=gwXF
-----END PGP SIGNATURE-----

--c8UbHMnQwI7BF+TB--

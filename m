Received: from eggs.gnu.org ([2001:4830:134:3::10]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQn4-0006UV-PI
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQn1-0003HM-Ms
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:49:22 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHQn1-0003HC-Gt
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:49:19 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so8262326wjc.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 23:49:19 -0800 (PST)
Date: Thu, 15 Dec 2016 07:48:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215074816.GC26169@stefanha-x1.localdomain>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215004752-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20161215004752-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH for-2.8] ui/gtk: fix "Copy" menu item
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 12:49:06AM +0200, Michael S. Tsirkin wrote:
> On Wed, Dec 14, 2016 at 02:25:18PM +0000, Stefan Hajnoczi wrote:
> > The "Copy" menu item copies VTE terminal text to the clipboard.  This
> > only works with VTE terminals, not with graphics consoles.
> >=20
> > Disable the menu item when the current notebook page isn't a VTE
> > terminal.
> >=20
> > This patch fixes a segfault.  Reproducer: Start QEMU and click the Copy
> > menu item when the guest display is visible.
> >=20
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> I don't think it's 2.8 personally, patch just disables an
> illegal action. Similar to the hotplug crash fix I
> have queued. Just document this as a known issue.

I mistakenly thought this bug was introduced in QEMU 2.8, but now that I
look back at git log I realize it already existed.

Stefan

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUkrAAAoJEJykq7OBq3PIZQQH/RC2WHpARq5ZIzK5n7wm1FkF
G8dQqwQQLYxvGxqMzISGEnvdbmB9JZjT9pPFLS8EMRfiXTGfyQbqhf0RMQjbRlQS
G54JAM5ZuZi4P4ZC8XM+dSm4q/LvUw9yv53m79Kz8nudUuegt4RZB6AeDkGj93fQ
oUotptnoTDR/rT1pPH/vnh8ZqWUa6I1LiyY6qiO//rprEpXkZzOoNri3J9lJmqnF
6DSEbOsplLjlu5hsDvmzv3Nyum1VtU3uhJki0bcHS41zFMJ2yVzaCBQC6LJOWv4n
ljPEgZyDCgE74DA4Q7EULbvwfMKHQrwKKVAoW3KmcosyBBVtNig+QD7aFRXI+t4=
=ABSP
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

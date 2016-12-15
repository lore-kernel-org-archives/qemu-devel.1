Received: from eggs.gnu.org ([2001:4830:134:3::10]:39671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQZn-0006zY-Uq
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQZj-0007Qj-ND
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:35:39 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHQZj-0007Ld-Gy
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:35:35 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so8189772wjc.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 23:35:12 -0800 (PST)
Date: Thu, 15 Dec 2016 07:34:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215073409.GA26169@stefanha-x1.localdomain>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215004752-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
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


--TB36FDmn/VVEgNH/
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
>=20
>=20
>=20
> BTW - any idea how to make paste work?

Maybe Gerd has a recommendation.  I have never touched GTK or VTE before
this patch.

Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUkdxAAoJEJykq7OBq3PImkkH/3EsldNbM3EctQfXfDB+thMk
3KhPgleHxirFtIUAyNS/HRY6cYanYlmdKiLp74Da4ye8rPo+P/Gx9gzo+WF2q+hd
4iHQn9q0Q/SIH0XMajijHtypuOCPWiEhskZWT1imqTbqc4NjMzu/Lwj0kWwiV7BN
MP7MNwoTueILiEXPuRMnbqwKMnsXjn9/+pqiF73Cf5lqt7Eyksd+GLHhfRZ12Wc2
CktsBim6UFEQ7JSyfKLqypbUPWB6JXMk7jAD3aEtU7yAftoF8kf9jlgA6ttFxnM1
Fj2WYQqBgMTRv0TPFT2TXvxnOIRUZEM7vMCnDsToznP2G8fxlxN5oQFRkFlctk0=
=S1o0
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

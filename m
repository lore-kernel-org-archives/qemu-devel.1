Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1g7iEq-00033W-9o
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1g7iEn-0007kw-IH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1g7iEn-0007jp-8O
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:34:53 -0400
Date: Wed, 3 Oct 2018 15:34:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181003143446.GA3012@stefanha-x1.localdomain>
References: <20180827184103.32190-1-jusual@mail.ru>
	<20180827184103.32190-2-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180827184103.32190-2-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] chardev: Add websocket support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2018 at 09:41:02PM +0300, Julia Suvorova wrote:
> New option "websock" added to allow using websocket protocol for
> chardev socket backend.
> Example:
>     -chardev socket,websock,id=...

Please make user-facing interfaces use the name "websocket" instead of
"websock" for consistency.  The official protocol name is WebSocket and
QEMU already exposes "websocket" to the user in qapi/ui.json and
qemu-options.hx documentation.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbtNOFAAoJEJykq7OBq3PIwnAIAKIzKoN5gZymI++BoB6yPUry
g2TnubehIkFuY8zB26vB0t7SUeppbkaB9yLOtuHJoFlU8BAVMh6OB4HIDV/JWbIm
rZZ7BU0Kae8uF4+K9fG8crwfRp8OCsDCr2Tlchd7VEHGakkvozMYgg4yY//FfyXQ
vym7Iw0cPGb4bYYhqtWLExJV9bnG2xmWKRgTR2TuPvxvTsMeoCqp9qS3HkonFY5k
DWTLLuygkIEwj6Xg4QZj8TKFj/EWK0Fxyd7U5JPubKErf1DI6aKpoez6Xklx9dv7
HRKlllsUy0DFRiH+jLvuc0iTaSEYHwN+OJslfdspKGJ/Ab/KRJ3NyNVm92arM4s=
=wcBx
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

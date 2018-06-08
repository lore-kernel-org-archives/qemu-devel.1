Received: from eggs.gnu.org ([2001:4830:134:3::10]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCKp-0004i9-HY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCKj-0003mR-RP
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:01:23 -0400
Date: Fri, 8 Jun 2018 09:01:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180608080114.GG29183@stefanha-x1.localdomain>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
	<20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
	<20180607102455.GD19032@stefanha-x1.localdomain>
	<20180607125853.5hcd2bhhjedfngre@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline
In-Reply-To: <20180607125853.5hcd2bhhjedfngre@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [RFC v3] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 02:58:53PM +0200, Gerd Hoffmann wrote:
> > Gerd: What is your preference?  Do you want board-specific fake displays
> > inside the QEMU process as the long-term direction for UIs?
>=20
> Well, it isn't the one or the other, we could actually do both.  For the
> deployments you are looking for the websocket approach proably works
> best.  Being able to do at least simple stuff (say led display and
> a+b+reset buttons) with a fake display, without requiring setting up
> something separate for the UI can be quite useful too.
>=20
> Your call.

Okay.  There is an existing micro:bit web UI that we're interested in
either reusing or at least closely following as a model
(https://groklearning.com/learn/hoc-virtual-pet/intro/2/), so WebSockets
makes sense for this.

Stefan

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGjfKAAoJEJykq7OBq3PIno8IAMQoVKl0Ifhr0+2Mbv6sBmdG
K2IDEwmfNDjo3I2phNewRe8QBHOMqvR7TfHJgYkS5/fP07uN8NdaQIY8gc7mzPzW
ONkKFPSEnAXw4r9WODs3YXhvB0iZaGTgJEQ/s0Qi6nfollY7y706aShtZHl69V0k
/+NkGK7E3QykB88pshN34RQh6RBMxe5oED1PxQHjOwoEYmCKCRg5v2dbwgLlIlbK
PvF8z9ptYRqCSVpdJtW0twMUiEExqaJxNrfVP83JM3+LYWuUazcbZq5hiW33XV1N
J7bMAmHA2qHoNY5S7tON5QY20pEWqKgZVjpmUpzDVyxlyO3fPWHWIEsDp69DdoY=
=I4Z6
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQs6I-0002y7-4K
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQs6E-0006On-W5
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:25:02 -0400
Date: Thu, 7 Jun 2018 11:24:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607102455.GD19032@stefanha-x1.localdomain>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
	<20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
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


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 12:12:21PM +0200, Gerd Hoffmann wrote:
> On Mon, Jun 04, 2018 at 10:29:40AM +0100, Peter Maydell wrote:
> > On 4 June 2018 at 10:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > Many of these inputs/outputs can be tied to an external UI.  A degree=
 of
> > > timing precision is required so that the UI is responsive, although
> > > cycle-accurate timing is not what I'd expect from QMP.
> >=20
> > Would we also be able to tie them to an internal UI, ie
> > something that appears as another view in the GTK/etc
> > UI frontends we have?
>=20
> Should be doable too.  Basically a display device, which isn't a *real*
> display but the UI.  Could show a rendering of the board, simliar to how
> web emulation environments are doing it.  LED status could be rendered
> directly to the board.  A virtual mouse could map mouse clicks to button
> presses.
>=20
> Doing more complex input that way (say a slider for the temperature
> sensor) isn't going to work very well though ...
>=20
> Sensor input in general is pretty much unsupported in qemu.

For the micro:bit we've been thinking of a WebSocket monitor interface.
This way a web UI can work with both local and remote QEMU instances.

For security reasons, the WebSocket cannot be the regular QMP monitor.
A slimmed down monitor is required with a subset of QMP commands and
events.  For example, users must not be able to migrate to an exec:
destination so we need to ban that command on the UI monitor :-).

Pros:
 + Remote control is possible over sockets
   (Important for hosting QEMU on a server.  Nowadays this is becoming a
   popular way to deliver emulation to users.  They don't need to
   install software locally.)
 + UI is cleanly isolated from QEMU process
Cons:
 - Binary or high-frequency I/O is a bad fit for a JSON WebSocket
   interface

I prefer the WebSocket route over creating a fake display that will not
be able to implement complex widgets well.

Gerd: What is your preference?  Do you want board-specific fake displays
inside the QEMU process as the long-term direction for UIs?

Stefan

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGQf3AAoJEJykq7OBq3PINoYH+wQeFaTA29kp934I6W3zeHof
0J/eKiigJqbt4VMkKhCwjnH8YxmijxymHi0lK9PcOJZnRY8oVavXFKmr7fE8KDri
f+a53pkcrF39ftqtmKnIsmTKfRmy7ikdnYQdmlb5eZcpVDrESpwZs+mNb2FKlFDB
6B8YhLOvLWYdeyg3CqdUHbgeAY6II9m6rJUOAaWEsLue/WmamdqeJYoedvBKAZL1
2CdJR+5rng8F3PASqhx1KQtIDUEdCxG3tV17OeD4UoediCdcImPrPQYJ0MDn4LI9
ak6hDtBKPBfII1n5GUwzDsdNegAmTO1LeUc5nQDmsx0kPVtsGP47DA4P8721Jv8=
=5lCM
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCI8-0001fq-AW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCI5-0001gP-7u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:58:36 -0400
Date: Fri, 8 Jun 2018 08:58:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180608075830.GF29183@stefanha-x1.localdomain>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
	<20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
	<20180607102455.GD19032@stefanha-x1.localdomain>
	<20180607103307.GI28827@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <20180607103307.GI28827@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 11:33:07AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 07, 2018 at 11:24:55AM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jun 04, 2018 at 12:12:21PM +0200, Gerd Hoffmann wrote:
> > > On Mon, Jun 04, 2018 at 10:29:40AM +0100, Peter Maydell wrote:
> > > > On 4 June 2018 at 10:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > > Many of these inputs/outputs can be tied to an external UI.  A de=
gree of
> > > > > timing precision is required so that the UI is responsive, althou=
gh
> > > > > cycle-accurate timing is not what I'd expect from QMP.
> > > >=20
> > > > Would we also be able to tie them to an internal UI, ie
> > > > something that appears as another view in the GTK/etc
> > > > UI frontends we have?
> > >=20
> > > Should be doable too.  Basically a display device, which isn't a *rea=
l*
> > > display but the UI.  Could show a rendering of the board, simliar to =
how
> > > web emulation environments are doing it.  LED status could be rendered
> > > directly to the board.  A virtual mouse could map mouse clicks to but=
ton
> > > presses.
> > >=20
> > > Doing more complex input that way (say a slider for the temperature
> > > sensor) isn't going to work very well though ...
> > >=20
> > > Sensor input in general is pretty much unsupported in qemu.
> >=20
> > For the micro:bit we've been thinking of a WebSocket monitor interface.
> > This way a web UI can work with both local and remote QEMU instances.
> >=20
> > For security reasons, the WebSocket cannot be the regular QMP monitor.
>=20
> FWIW, add ability to use websockets protocol over chardevs is fairly
> easy. We already have a QIOChannelWebsock for the VNC server, so it
> is just a little work to wire it into the chardev.

Cool, good to know.

> If the -monitor / -qmp arg took a filename containing a whitelist of
> allowed monitor commands, you could indeed use the regular QMP monitor
> instead of writing something new.

Yes, this is exactly what we need.

> > A slimmed down monitor is required with a subset of QMP commands and
> > events.  For example, users must not be able to migrate to an exec:
> > destination so we need to ban that command on the UI monitor :-).
>=20
> FWIW, you could  use the "-sandbox spawn=3Doff,elevateprivileges=3Doff"
> arg to prevent ability of QEMU to fork/exec/setuid. Even if the
> monitor still allows it, it thus get blocked, albeit by immediately
> terminating the process.

True, but that's just one example of many.  Another one is "pmemsave",
which writes to the host file system.

I think a whitelist is the way to go.  It will allow us to secure the
monitor and expose it to untrusted UIs.

Stefan

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGjcmAAoJEJykq7OBq3PIi34H/idlvdlDyp2jvOgj+2SFwkZ8
4lWTcAcPb1SifThGOcKhpSAXEs2e0mZtmdOyLiCZmAor4XV7TC7HGWvpxcEe41H+
lmqowY0hinj1ojO1Lk/qStVnbFxxTx0p9cF5cTqPTs3k4pMDeWvLgUdFsDbWvUEg
8lUtOnx7pGgVwSj+K3PmyfV/D8C7pM4v6PiasIYsjO0ssqszFpMoUpL3vo1M/hfn
VEPYh9QHDsBxNDgGW0J9XHJqLT2dmSrWGYcn0JDjYd4M2kEnoV28ysqLzYkNTOv0
JIo5WKpNBhd7I1JGY6F9CprGBsqpxFknRGpoxqTMQ/A6IxnEFLFbxA5QRkW51KY=
=ByDc
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

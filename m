Received: from eggs.gnu.org ([2001:4830:134:3::10]:34155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHEre-0006Ca-Qv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHErb-00012R-Jv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:05:18 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHErb-000120-Dc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:05:15 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so6404136wjc.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:05:15 -0800 (PST)
Date: Wed, 14 Dec 2016 19:04:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161214190411.GA20648@stefanha-x1.localdomain>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<20161213103700.GD3103@stefanha-x1.localdomain>
	<20161213121749.l572tsrnmnhnckvq@grep.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20161213121749.l572tsrnmnhnckvq@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Bligh <alex@alex.org.uk>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 01:17:49PM +0100, Wouter Verhelst wrote:
> On Tue, Dec 13, 2016 at 10:37:00AM +0000, Stefan Hajnoczi wrote:
> > On Mon, Dec 12, 2016 at 09:43:13PM +0100, Wouter Verhelst wrote:
> > I'd prefer a programming model where the contexts don't need to be set
> > for the lifetime of the connection.  Instead the client passes a bitmap
> > (64-bits?) of contexts along with each BLOCK_STATUS command.  That way
> > the client can select contexts on a per-command basis.  It's unlikely
> > that more than 64 contexts need to be available at once but I admit it's
> > an arbitrary limitation...
> >=20
> > I guess you've considered this model and decided it's better to
> > negotiate upfront, it's wasteful to enable multiple contexts and then
> > discard the response data on the client side because only a subset is
> > needed for this command invocation.
>=20
> I do agree that it might be nice to be able to enable or disable
> particular metadata contexts for the lifetime of one BLOCK_STATUS
> command. However, the problem then becomes one of "where do we do that".
> The request header has a fixed size, and there is no space for such data
> in the request header. This could be worked around in ways that do not
> break compatibility with older implementations (not in the least because
> we're defining a new command that needs to be negotiated first, and so
> we could say that the server needs to understand a new request format),
> but I haven't found a way to do so that doesn't strike me as "very
> ugly".
>=20
> In addition, most use cases that we've been presented with seem to
> require only one or (at most) a handful of metadata contexts. In that
> case, the ability to select which metadata contexts are to be used in
> transmission doesn't strike me as a very useful possibility, which would
> be used often. Given that, and given the problems described in the
> previous paragraph, I'm not convinced it's worth complicating things
> much over.
>=20
> However, I could be convinced otherwise by strong arguments and by a
> suggested spec for how to pass the required information in a clean way.

Thanks for the responses, Woulter and Alex.

I don't have a strong argument for why context selection should be
per-command and you've explained that it would be awkward to add it to
the protocol.

Stefan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUZerAAoJEJykq7OBq3PIlW4H/1gQlGRPSoGEufLf2pd94U0K
xI4h9v05eV96n2vAisyHlOGrQxvyE1GaWZmbORwFFMdTgAHxa07DjETZEPUi4il7
I1NEIShsbnfLSpbE/hOxyITfyhx33zPI1Jd/0kjfN/RysdU2GUHt54ffpWiwwB1o
rxkQGAvoPFKHu1RqcwTwoNYi5bFdWMkpquNSvBWy2rNNNVx9HqCW5psjvI/aAD9l
PM7sEs76YXSrECxXPn4syKq8pI8nK2e/78s9HOE4VsfCw9PSx/I9RyG4BTWQ1Rh1
BSHWO9PrTv94iLaXzI9s8Op/cClayZ9ey1v4NKgKYjfDOrQoMVRktKlalTMCj6E=
=OeZy
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

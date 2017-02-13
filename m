Received: from eggs.gnu.org ([2001:4830:134:3::10]:48412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGxp-0007wx-W6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdGxk-0002Pz-W3
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:46:46 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdGxk-0002Pk-PP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:46:40 -0500
Received: by mail-wj0-x244.google.com with SMTP id i7so192048wjf.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 05:46:40 -0800 (PST)
Date: Mon, 13 Feb 2017 13:46:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213134637.GC10361@stefanha-x1.localdomain>
References: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
	<CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
	<e5673883-cd68-7d4a-01fc-394c506b18a9@redhat.com>
	<CAFEAcA8zSZ8S09APwV8SGy3oHeiutY1j+LSSP327hyZLFfDURw@mail.gmail.com>
	<DM5PR03MB2827878B91C80E6DA61C56589E450@DM5PR03MB2827.namprd03.prod.outlook.com>
	<CAFEAcA_zXQOBWqOmyH-_RA5pcREutKPUZAOm-OBuCExp-nMSGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zXQOBWqOmyH-_RA5pcREutKPUZAOm-OBuCExp-nMSGw@mail.gmail.com>
Subject: Re: [Qemu-devel] Call for GSoC 2017 mentors & project ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 10:17:45PM +0000, Peter Maydell wrote:
> On 9 February 2017 at 22:12, Andrew Baumann
> <Andrew.Baumann@microsoft.com> wrote:
> >> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >> Sent: Thursday, 9 February 2017 14:02
> >> On 9 February 2017 at 20:46, John Snow <jsnow@redhat.com> wrote:
> >> > On 02/09/2017 07:46 AM, Peter Maydell wrote:
> >> >> Slightly late, but I had an idea last night: would "get
> >> >> Raspbian booting on our raspi2 board model" be a good
> >> >> project? Would involve some mix of bug fixing, cleaning
> >> >> up and adding device models from the raspi2 tree on github,
> >> >> and implementing missing devices. Bit of a "how long is a
> >> >> piece of string" project, but on the other hand breaks
> >> >> down easily into small parts that can all go upstream
> >> >> individually. Would suit student who likes debugging :-)
> >>
> >> > Who was working on this most recently? There was someone submitting
> >> > patches pretty frequently for the raspi2 board within the last year,
> >> > wasn't there?
> >>
> >> That was Andrew Baumann, but I think his use case was
> >> getting Windows 10 to boot on it, which exercises
> >> different bits of the hardware.
> >
> > That's right, but I thought we also had Raspbian working after
> > Peter C's implementation of SETEND. (I wouldn't be surprised if
> > it had regressed, however.)
>=20
> For the raspbian kernel image I had it never worked -- I
> think the kernel gained some new functionality that means
> it now touches some device we don't yet implement (vague
> recollection it was somethnig message-box related?).
>=20
> > I've dropped the ball on this, and don't forsee finding time
> > for it in the immediate future, but if anyone wants to work
> > on it there are still some outstanding bits of emulation
> > lurking in my github tree (github.com/0xabu/qemu)
>=20
> Yeah, I figured that was probably the situation, and I
> don't personally have the time to do it either; but
> it seemed like maybe it would make a GSoC project.

It sounds like this can be broken down into tasks by a mentor willing to
participate and knowledgable (or willing to do the homework) on device
support status.

Are there any volunteers?

This would be a great project to have on board.

Stefan

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobi9AAoJEJykq7OBq3PIO6oH/Al1VaFcztR73sxmLuuGxO78
qEwBuVHWE9L7TnLjNexblBDijp2F7KHL40y+YJ203FoOEFwtK6xRiop7cY8l0Sq5
+xf8kCL8T0diFH+FuLwPuaTKMIxX4IN56CeqeL2mYbwELnigLiiCfmrt2Ca7JTpz
nLLxdvMTxf3PxLWH3YgGlX3x2HGCVvdGtJWN1jDVcERagNrIxNxvRBAbqL26aI+o
xpDKucRkFVIlo7hx243LPUiJH00nlpWQZfIq/1wEkvIh0vE3bYnvbn4ICCgjYLOT
0PMzE5iEUbOPLJVzr5NfD1wozyz1dtzTr3X8qoYlScHY4WKvWdmcBQWjAUspLA0=
=PlZO
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

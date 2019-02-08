Received: from eggs.gnu.org ([209.51.188.92]:51017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gs0MC-0004uZ-Cz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gs0MA-0003GV-Ho
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gs0MA-0003F6-C4
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:13:50 -0500
Date: Fri, 8 Feb 2019 15:13:36 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190208071336.GH16257@stefanha-x1.localdomain>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-16-mst@redhat.com>
	<20190204150748.GP1905@redhat.com>
	<20190204101130-mutt-send-email-mst@kernel.org>
	<20190204152921.GQ1905@redhat.com>
	<20190204204804-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <20190204204804-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 08:48:14PM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 03:29:21PM +0000, Daniel P. Berrang=E9 wrote:
> > On Mon, Feb 04, 2019 at 10:19:42AM -0500, Michael S. Tsirkin wrote:
> > > Hmm I do think we want to build the contrib tools,
> > > otherwise they bitrot too quickly, witness follow-up
> > > patches that fix the compilation.
> > >=20
> > > And I think we need tests that actually use them.
> > >=20
> > > However I agree adding them to tools and installing
> > > is probably rushing things, e.g. there's no
> > > manpage even.
> >=20
> > Yes, if we build, but do not install, the binary that would be ok
> >=20
> >=20
> > Regards,
> > Daniel
>=20
> OK I reverted this for now.

Yes, I requested this patch to avoid further bitrot.  Installing isn't
necessary though.

Stefan

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcXSwgAAoJEJykq7OBq3PIzysH/iZLNgAD5jbw2ziFpzlqdLjl
CtdJoKEe5m7D4lBwxARVWOlLAceS0RVubRK22yrsOipOYxj6U0PgZ+9asIRlDNZC
pMaeR4BgHIOkO13YI+c+vpLchrRCwyMQaH7d5/3aHcK7w/5ZbD1Y/7RSK/45KMM5
sVaZ3Yk2PmwulOC5pSzgJm+XaQwhYC/hoUGZoirzXvlGPsxNN9utkUlkPBRZuNWs
AOjPRVC+MQ+ex3ef04DarC+W+L6klnLc85O5OMyiJGa9UYf+LF/iDGfFcvYTT6ul
B4AsP6YI20Al3ompghOB53FL5bRbbYkSuOaA87GeQ0hXr7rz3+c3njoEGCDEBeA=
=ILj2
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

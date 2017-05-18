Received: from eggs.gnu.org ([2001:4830:134:3::10]:53702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHKc-0002DN-0G
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHKY-0001ST-1O
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:50 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHKX-0001SP-RM
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:02:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id w50so5212898wrc.0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:02:45 -0700 (PDT)
Date: Thu, 18 May 2017 10:02:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518090242.GD30862@stefanha-x1.localdomain>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
	<20170515125840.GC1201@stefanha-x1.localdomain>
	<20170515160256-mutt-send-email-mst@kernel.org>
	<20170518003940-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20170518003940-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 0/9] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 12:40:01AM +0300, Michael S. Tsirkin wrote:
> On Mon, May 15, 2017 at 04:04:33PM +0300, Michael S. Tsirkin wrote:
> > On Mon, May 15, 2017 at 01:58:40PM +0100, Stefan Hajnoczi wrote:
> > > On Wed, May 10, 2017 at 10:07:58PM +0300, Michael S. Tsirkin wrote:
> > > > The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250=
cde887bb:
> > > >=20
> > > >   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3=
' into staging (2017-05-09 15:49:14 -0400)
> > > >=20
> > > > are available in the git repository at:
> > > >=20
> > > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstr=
eam
> > > >=20
> > > > for you to fetch changes up to 8b12e48950a3d59188489b2ff6c5ad9cc09e=
9866:
> > > >=20
> > > >   acpi-defs: clean up open brace usage (2017-05-10 22:04:23 +0300)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > pci, virtio, vhost: fixes
> > > >=20
> > > > A bunch of fixes that missed the release.
> > > >=20
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >=20
> > > Please resend with the checkpatch.pl issue fixed.
> >=20
> >=20
> > There's no issue - new patch followed surrounding code which
> > was not refactored to match checkpatch.
> > Last patch of the series refactors all of that file to match.
> >=20
> > We do not need to worry abut bisect for checkpatch issues IMHO.
>=20
> Ping - is this going to get merged? I'm preparing the next pull request
> meanwhile ...

Sorry, I forgot about this one.  Applied now.

Stefan

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWMyAAoJEJykq7OBq3PI304H/1LNDyEehxsOt8bd16g+jEXn
7AY27f6mHxFfu2lfGh3jLlABrvLBM4QSAoU3p3JyG7rGLwnLH5x9UjJTBoyDf4Jo
piT2UfvEeNYZROTSPE0R7L9Fx3V4qBTVSVeTLWJOiO+jFNMk3IzWZ7ZVHP8ulfBH
zTV6P+wzDeSuJH2yfaY+x3OYAu0HLfGrgxQk4H0G9NacyGgOcTnbANS3jmnpDeJp
5rjU5BE5A+EWN4kGTt7/7ctDQJYQE2HLZrd8F6yFBbwlK7TjWwOECIjJaOFAUFeU
MQ0fWErN8oVvLDj6qkjBCRJj5wmjsYCbniWoiNYV30yPsusYGdSNE6DMSDofIi8=
=16XG
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--

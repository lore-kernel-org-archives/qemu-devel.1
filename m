Received: from eggs.gnu.org ([209.51.188.92]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZtg-0001eT-3v
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZte-0000UN-TX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJZte-0000SP-Jz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so8207218wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:38:22 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:38:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425083819.GE30231@stefanha-x1.localdomain>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
>=20
>=20
> > On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> >> Hi,
> >>=20
> >> This patch series aims to add supprot to migrate a VM with a vhost-scs=
i device.
> >>=20
> >> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backen=
d when a
> >> VM is stopped (As happens on migratino pre-copy completion).
> >>=20
> >> The 2nd patch adds ability to save/load vhost-scsi device state in VMS=
tate.
> >>=20
> >> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin =
to specify
> >> it's setup supports vhost-scsi migratino. For more detailed informatio=
n on why
> >> this is valid, see commit message of specific patch.
> >>=20
> >> Regards,
> >> -Liran
> >=20
> > Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> > with vhost-user-scsi.
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Gentle Ping.

This should go either through Michael's virtio/vhost tree or Paolo's
SCSI tree.

Stefan

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXH7AAoJEJykq7OBq3PIoZMH/i8cF/6RyjMqK/KE38KeS6fU
LgcrxlIz5QO6ejRaaRtTsjoMV5ewKrj5lVjUa+i86ONdnx4XTuG22J11QndAWhJD
26Zl2Hg8uEKi5OdVWoHRe+7XxCzyu5uPRF7Y1Cv64wUBX8qmEdjmkjlB3kOd5l0L
XEDNMn+fiTi6c4MGfjWjapL+cM/513PVkpRDKa93gcmiTdodi5WOwbu2+7TAOJS6
S19uQEcthNCzxyOWa2ZqVgkWfeJQCVQ92hT8Upok7JpRXyQkLv3ckQ/Ub7Zet7Md
6sTBNE3VQ7M+oJDmt0mGDPC5Hc68hJ0oZ2cv6s13FL7dhYk1O+lEtawcVfHS3yo=
=9V17
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

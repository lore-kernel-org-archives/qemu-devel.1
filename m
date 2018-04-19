Received: from eggs.gnu.org ([2001:4830:134:3::10]:54947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f8x8h-0007KU-Kh
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 20:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f8x8e-000229-Ez
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 20:09:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f8x8e-000205-9a
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 20:09:24 -0400
Date: Thu, 19 Apr 2018 10:09:00 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180419100900.7b66fde0@umbus.fritz.box>
In-Reply-To: <b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/5pdJ4rE1wTuNzrgjberFAlL";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

--Sig_/5pdJ4rE1wTuNzrgjberFAlL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2018 10:32:06 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 04/18/18 08:02, Gerd Hoffmann wrote:
>  [...] =20
>  [...] =20
> >
> > Looks good to me overall.
> > =20
> >> +{ 'enum' : 'FirmwareType',
> >> +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] } =20
> >
> > openbios missing.
> > =20
> >> +{ 'enum' : 'FirmwareArchitecture',
> >> +  'data' : [ 'aarch64', 'arm', 'i386', 'x86_64' ] } =20
> >
> > ppc(64) missing (but you have slof above ;) ...
> > s390 too. =20
>=20
> I figured those would be contributed by people that actually use them,
> as separate patches :) In fact I would rather prefer removing "slof" and
> "uboot" from this initial version, because I have zero clue about them.

I've only been able to skim this discussion, so apologies if I've
missed things.  I'm pretty unclear on the overall purpose of this, but
in particular this FirmwareType field seems pretty weird.

Specifically the things in the list don't really seem comparable to
each other: UEFI is a specified interface, BIOS is a de-facto
interface.  So far so good.  But SLOF is a specific implementation of
Open Firmware (of which we have a couple of other partial
implementations used for other qemu platforms).  U-Boot is somewhere in
between the two, a specific implementation that defines a fair bunch of
its own interfaces.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/5pdJ4rE1wTuNzrgjberFAlL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrX3hwACgkQbDjKyiDZ
s5IiTQ//e3mpRPNLJ3LIdGLL3FtkNpdv1vm/kI9dUOQksQoYR7CNtyR4VOvY/3aY
0X+S3v7phVlGhs9MxBiAYVIpwwkW/qRX1nnzCWrzabNCQXkBgA4/TSWYrmRJF9yY
Fc7BFdDKGWq2A+zMRUWIIHIeG7biJdLoffpmt36wER6FhvQiR5/PMoXut97dvelH
h11rk7jfzHmvo8Ss54p1okymlKQlGIj9kLysx05Cfs4sMweANiCqSdVgFMma48Rx
i2Ia2t6IXti0q2X06+IsjG71+UESI9/n3Wp1ScEsfwKrl9LX+q4pcIsdwesobP1D
PymJmCYZxdPKP/7F2S8wKlAMfMN/Eq0sBs+I86NDMgIdQLxs+7SdWtRgWKHSHipb
OBuMiVcS7zf06rC3OKIAO3elRPfldVmX5n8V8MkuO33rh7Hqcq+qZ5wKvpo60NXV
U4JZ53c51qPpn0WKgxJb3CR2XbBIEu2esI4J8ZNMg16eHCOSlnRzv0gVFdQbGR86
czRUbcn77NrgTo+FOQU/KF3UOxYTpzVyNEKcbODFgZevCNWp9s+nbgGW0+8q/kw1
8n9FB0b2wrUYFf3kDgcXV6QFfghIBdTpJRwYJolCJrqxW7QW93tusdFjzB7nn10v
UGjtcbpyFRcOFflHMmmSt9PLn65HfM3OVZHaC9xqEa/bllOnjtM=
=IIrK
-----END PGP SIGNATURE-----

--Sig_/5pdJ4rE1wTuNzrgjberFAlL--

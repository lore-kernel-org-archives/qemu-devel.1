Received: from eggs.gnu.org ([2001:4830:134:3::10]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRjT-0004Pi-IT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXRjP-0001wB-Ln
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXRjP-0001uT-Bm
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:36:03 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<20170718072351.GB11927@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <503be976-144b-d468-04b2-12dd99947bf1@redhat.com>
Date: Tue, 18 Jul 2017 07:35:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170718072351.GB11927@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mj5AGN05sCm0Hfxk8vNWvtHw23dAbcATU"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mj5AGN05sCm0Hfxk8vNWvtHw23dAbcATU
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
Message-ID: <503be976-144b-d468-04b2-12dd99947bf1@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <20170717164641.GA31820@work-vm>
 <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
 <20170718072351.GB11927@redhat.com>
In-Reply-To: <20170718072351.GB11927@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 02:23 AM, Daniel P. Berrange wrote:
>> How would it not help?  Are we using gcc 7 on windows builds?  Adding
>> the assert is enough to shut up new gcc; old gcc was already silent; a=
nd
>> if mingw is still on old gcc, it doesn't matter whether assert() is
>> marked noreturn for what this patch is doing.
>=20
> Mingw isn't using a fork of GCC anymore, its all mainline. Thus Fedora'=
s
> mingw gcc packages track native gcc packages. IOW i686-w64-mingw32-gcc
> is already on version 7.1.0 in Fedora

So I guess that means running 'make docker-test-mingw@fedora' on Fedora
26 will find out if we need further tweaks?  Trying it now...

Nope, didn't get very far :(

$ make docker-test-mingw@fedora
  BUILD   fedora
make[1]: Entering directory '/home/eblake/qemu'
  ARCHIVE qemu.tgz
usage: git archive [<options>] <tree-ish> [<path>...]
=2E..
make[1]: *** [/home/eblake/qemu/tests/docker/Makefile.include:35:
docker-src.2017-07-18-07.35.20.4101] Error 129
make[1]: Leaving directory '/home/eblake/qemu'
make: *** [/home/eblake/qemu/tests/docker/Makefile.include:156:
docker-run-test-mingw@fedora] Error 2

Am I not doing it right?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mj5AGN05sCm0Hfxk8vNWvtHw23dAbcATU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluAK4ACgkQp6FrSiUn
Q2rWCAf/SSX5prGPbuJVtBS1JP8cWSUsGuGYlXDmL0Q4KF2pNXd8iWmQkzpzMF5n
U3VM+uwXRMQX777bCG1XstD60LtSjMUH8Xl5DEzvO7owhdDlWHuq5ELl/hfvJTmD
IIPAOcMiLN8f6c+TQ0cMm5J9SDRXyjzYqhXJva4UMV3b1vPYLkJdRgpggeCI6wma
7cO1JqjeTuSXmy3sJB2tVfb5Fz0bR196cWaAefh70OVivOhd2F09pcyq4/dfyFSM
vmzCOpO6NrjKgJPwSM+cO0EsZ1vvy9VV77n0TeeR38baRQvTiu18oI2KPlRHCHsb
3qq0QTs3mkA+/QNmROKP2T31Rw35bw==
=wXQC
-----END PGP SIGNATURE-----

--mj5AGN05sCm0Hfxk8vNWvtHw23dAbcATU--

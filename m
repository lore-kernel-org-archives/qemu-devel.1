Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckBR5-0003JN-Lu
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckBR1-00040E-ME
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:17:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckBR1-000404-Ca
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 10:17:27 -0500
References: <148856193073.554.6631259860971664030.stgit@bahia>
	<ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
	<ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
	<20170304122139.63796173@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25006c6b-915c-a0a0-a85a-89cee74e0ed4@redhat.com>
Date: Sat, 4 Mar 2017 09:17:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170304122139.63796173@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="td0NebPnK8xQv7O3c9Mfca5b1h3i6WTpL"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--td0NebPnK8xQv7O3c9Mfca5b1h3i6WTpL
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <25006c6b-915c-a0a0-a85a-89cee74e0ed4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
References: <148856193073.554.6631259860971664030.stgit@bahia>
 <ef91a081-c25f-881e-eb60-90798df36a5a@redhat.com>
 <ebe5c30c-0af6-7f5b-15bf-4626773a2a9d@redhat.com>
 <20170304122139.63796173@bahia.lan>
In-Reply-To: <20170304122139.63796173@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2017 05:21 AM, Greg Kurz wrote:
> On Fri, 3 Mar 2017 17:43:49 -0600
> Eric Blake <eblake@redhat.com> wrote:
>=20

> It is acceptable to ignore O_PATH here because we have O_DIRECTORY, and=

> we know openat_dir() will hence fail. But this code sits in a header
> file, and we probably don't want O_PATH to be silently converted to 0 i=
n
> other potential cases where it is used without O_DIRECTORY.
>=20
> I'd rather do something like the following then:
>=20
> #ifdef O_PATH
> #define OPENAT_DIR_O_PATH O_PATH
> #else
> #define OPENAT_DIR_O_PATH 0
> #endif
>=20
> Makes sense ?

Yes, that's reasonable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--td0NebPnK8xQv7O3c9Mfca5b1h3i6WTpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYutqFAAoJEKeha0olJ0NqulQH+gN3NYN6czEzWjqmq6kOmBfy
WxBLt0ELBuzJfhPrQ2q2KIRixq2wdGr1kdZbeCvtIM94VU8Srtoz5tss+uQuP8DA
kbZiF7zC2EtjpMkMRcBr+o3aHxq0SfJ2lJEYbR4rv/mzN+CEK/ExHaROcmDAst5Z
NZmXM6xksahJDPLrwXtXA/xg4D95AIXFfO32xOkPZDfBJYJH73/HgQi3d6mFxQnD
lOgqiMCEN8E0ONyAWeNCe7vCmM6+r3Yi9Mdii9IlKP/EpKzJBLuFeJt1PZ72LhE/
VNcqNJXTtUFuX2iIoAOZQeeApHnLZju4bvIOOTEwJKc4q4GMr/l6iUrCg8trsmw=
=C+kv
-----END PGP SIGNATURE-----

--td0NebPnK8xQv7O3c9Mfca5b1h3i6WTpL--

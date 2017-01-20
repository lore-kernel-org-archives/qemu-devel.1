Received: from eggs.gnu.org ([2001:4830:134:3::10]:57924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUbFF-0001qn-PQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUbFE-0006Qw-QO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:36:53 -0500
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
	<1484905570-10520-3-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f7747d5-17dc-0d3b-143a-9e7bb22095ff@redhat.com>
Date: Fri, 20 Jan 2017 09:36:39 -0600
MIME-Version: 1.0
In-Reply-To: <1484905570-10520-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rHEDPUHSdHhe9wXWdIMXxjI12k17rLGXU"
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nfs: fix naming of runtime opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHEDPUHSdHhe9wXWdIMXxjI12k17rLGXU
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com,
 jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <2f7747d5-17dc-0d3b-143a-9e7bb22095ff@redhat.com>
Subject: Re: [PATCH 2/2] block/nfs: fix naming of runtime opts
References: <1484905570-10520-1-git-send-email-pl@kamp.de>
 <1484905570-10520-3-git-send-email-pl@kamp.de>
In-Reply-To: <1484905570-10520-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 03:46 AM, Peter Lieven wrote:
> commit 94d6a7a accidently left the naming of runtime opts and QAPI
> scheme inconsistent. As one consequence passing of parameters in the
> URI is broken. Sync the naming of the runtime opts to the QAPI
> scheme.

The commit message should explicitly mention that this is technically
backwards incompatible with the 2.8 release, but that the 2.8 release is
the only version that had the wrong naming and that release also had the
(just-fixed) bug of a crash during URI parsing.

>=20
> Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rHEDPUHSdHhe9wXWdIMXxjI12k17rLGXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgi6HAAoJEKeha0olJ0NquaIH/jmO5/bUYTrW1e2t6t+5Nhds
Omlhm5VcGg/3FMQOoqKXC0KsIaChmcWwChwrYRquCkwD4JlS3lvKK3aGF74uJUTT
opT/ldNFScdsqYBAsiJ2A5/SYGxUOdFVAGEba/OVrM+YW1Jn4Qx560xIR+P0PY2U
jhzRB7w8TtTDUuAJr9Dl91ZDEFVkkj5zUI7dtFz+ofttyvqCeYPKGZKX/h6a2VWl
3jfATVMRqs0jABqWrwkgthDKaVI8qnu/zpfkMVIpVS7wL56fUz2LMOx/MxeM+sgu
dSAv9irrnro+Ge3IGAHCwf2Z7zENLSArNKVgl2wLKrV3FhJZpBEYrqcTpr8clow=
=Q1xg
-----END PGP SIGNATURE-----

--rHEDPUHSdHhe9wXWdIMXxjI12k17rLGXU--

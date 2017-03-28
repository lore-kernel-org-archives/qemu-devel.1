Received: from eggs.gnu.org ([2001:4830:134:3::10]:55720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cssRR-0001F2-Ut
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cssRQ-0007TL-Oe
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:49:50 -0400
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6fb77120-dcab-042f-bb51-20ccbaa38354@redhat.com>
Date: Tue, 28 Mar 2017 09:49:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pf7epeAqWdECpVQwouFEJKQSCntuKrxx2"
Subject: Re: [Qemu-devel] Making QMP 'block-job-cancel' transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pf7epeAqWdECpVQwouFEJKQSCntuKrxx2
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <6fb77120-dcab-042f-bb51-20ccbaa38354@redhat.com>
Subject: Re: Making QMP 'block-job-cancel' transactionable
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
In-Reply-To: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 07:34 AM, Kashyap Chamarthy wrote:
> While debugging some other issue, I happened to stumble across an old
> libvirt commit[*] that adds support for pivot (whether QEMU should
> switch to a target copy or not) operation as a result of issuing QMP
> 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
> copy").
>=20
> In the libvirt commit message[*] Eric Blake writes:
>=20
>     "[...] There may be potential improvements to the snapshot code to
>     exploit block copy over multiple disks all at one point in time.
>     And, if 'block-job-cancel' were made part of 'transaction', you
>     could copy multiple disks at the same point in time without pausing=

>     the domain. [...]"
>=20
> I realize that 'block-job-cancel' is currently not part of the
> @TransactionAction.  Is it worthwhile to do so?

Yes, it is still worthwhile to make that improvement, although it is now
2.10 material.

>=20
> Given the current behavior of QMP 'drive-mirror':
>=20
>   - Upon 'block-job-complete', synchronization will end, and live QEMU
>     pivots to the target (i.e. the copy)
>=20
>   - Upon 'block-job-cancel', a point-in-time (at the time of cancel)
>     copy gets created, and live QEMU will _not_ pivot.
>=20
> I realize that it is not possible to perform a "block copy" of multiple=

> disks at the same point in time without pausing QEMU.  From a brief cha=
t
> with Stefan Hajnoczi on IRC, he does confirm that there's no current AP=
I
> for doing it atomically across multiple disks.
>=20
> Since Stefan asked if a bug exists for adding 'transaction' support to
> 'block-job-cancel', thought I might bring it up here first.
>=20
>=20
> [*] https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommit;h=3Deaba79d --
>     blockjob: support pivot operation on cancel
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pf7epeAqWdECpVQwouFEJKQSCntuKrxx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2ngEAAoJEKeha0olJ0NqMqYH/RH26Rlsxd5rdibKc/Nch/VZ
JjOib2FqL/pDvMPqXWsArX9s4jSp9cTZNnNAxDPk1Q3E82+2Y3VyjQeYND1pabA2
bZ9qzVVcwcX4bP6vl9RL3bKAvOXupfosxOBUzqW1q8V3gUk2Yu9QPv1Eu13RpNyT
b4hSszKA4AVJTY4S8dPrnaCzWcsq9vT88Co7PpY/hoA0nq81Hq3yCuDa2fszpHwu
YE1xmIKEiUDXqTx16IMioP3au6lWZmbqiqXXjeoJYrxjNSWYRJFsuid5W3Xvjdq/
vaYf4m4aKD4iMUYZvrijtiCCv9T/3ze31BNuyyr6rrAVIOQq8g36P/NIMbrymsc=
=IpxG
-----END PGP SIGNATURE-----

--pf7epeAqWdECpVQwouFEJKQSCntuKrxx2--

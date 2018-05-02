Received: from eggs.gnu.org ([2001:4830:134:3::10]:57713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwBn-0008Rn-K4
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwBm-0003w0-96
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:09:15 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-3-mreitz@redhat.com>
	<c1b70360-a112-2d7c-33df-0ed5ec0ec3f9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <496ae9da-458d-1308-48ae-17326586b670@redhat.com>
Date: Wed, 2 May 2018 20:08:59 +0200
MIME-Version: 1.0
In-Reply-To: <c1b70360-a112-2d7c-33df-0ed5ec0ec3f9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vYiGJIMlqgqJe2AzgJLjRfG5ogvlGKOqm"
Subject: Re: [Qemu-devel] [PATCH 2/7] block: Add Error parameter to
 bdrv_amend_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vYiGJIMlqgqJe2AzgJLjRfG5ogvlGKOqm
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <496ae9da-458d-1308-48ae-17326586b670@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] block: Add Error parameter to
 bdrv_amend_options
References: <20180421165423.30759-1-mreitz@redhat.com>
 <20180421165423.30759-3-mreitz@redhat.com>
 <c1b70360-a112-2d7c-33df-0ed5ec0ec3f9@redhat.com>
In-Reply-To: <c1b70360-a112-2d7c-33df-0ed5ec0ec3f9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 19:52, Eric Blake wrote:
> On 04/21/2018 11:54 AM, Max Reitz wrote:
>> Looking at the qcow2 code that is riddled with error_report() calls,
>> this is really how it should have been from the start.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/block/qcow2.c
>> @@ -4049,7 +4049,8 @@ static int qcow2_load_vmstate(BlockDriverState
>> *bs, QEMUIOVector *qiov,
>> =C2=A0=C2=A0 * have to be removed.
>> =C2=A0=C2=A0 */
>> =C2=A0 static int qcow2_downgrade(BlockDriverState *bs, int target_ver=
sion,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BlockDriverAmendStatusCB *status_cb, void
>> *cb_opaque)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BlockDriverAmendStatusCB *status_cb, void
>> *cb_opaque,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int current_version =3D s->qcow_version=
;
>> @@ -4058,13 +4059,17 @@ static int qcow2_downgrade(BlockDriverState
>> *bs, int target_version,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (target_version =3D=3D current_versi=
on) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (target_version > current_ver=
sion) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Cannot d=
owngrade an image from version %i
>> to %i",
>=20
> %i is unusual compared to %d, but as they do the same, I won't make you=

> change it, if we keep it.=C2=A0 That said, this function is static; and=
 the
> lone caller qcow2_amend_options is already doing sanity checks, right?
> (Yes - it does qemu_opt_get(opts, BLOCK_OPT_COMPAT_LEVEL), and then
> validates that the user's information is in range, which already filter=
s
> out everything but v2 and v3; then _this_ function is called exactly fo=
r
> 3 downto 2).=C2=A0 So this should be an assert() instead of an error me=
ssage.

OK, I'll change it to an assertion.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current_version, target_version);=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (target_version !=3D 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Cannot d=
owngrade an image to version %i
>> (only "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "target version 2 is supported)",=
 target_version);
>=20
> And again.
>=20
>> @@ -4072,6 +4077,8 @@ static int qcow2_downgrade(BlockDriverState *bs,=

>> int target_version,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->incompatible_features & QCOW2_IN=
COMPAT_DIRTY) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_m=
ark_clean(bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "Failed to make the image clean: %s",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(=
-ret));
>=20
> error_setg_errno(), please.

Right, forgot we had that...

>> @@ -4094,6 +4103,8 @@ static int qcow2_downgrade(BlockDriverState *bs,=

>> int target_version,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_expand_zero_cluste=
rs(bs, status_cb, cb_opaque);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Failed t=
o turn zero into data clusters: %s",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(-ret));
>=20
> and again
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 @@ -4101,6 +4112,8 @@ static int qcow2_downgrade(BlockDriverSta=
te
>> *bs, int target_version,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_update_header(bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->qcow_version=
 =3D current_version;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Failed t=
o update the image header: %s",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strerror(-ret));
>=20
> etc.=C2=A0 I'll quit pointing it out, but there are more.
>=20
>> @@ -4293,18 +4311,17 @@ static int
>> qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int refcount_or=
der =3D ctz32(refcount_bits);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_=
version < 3 && refcount_bits !=3D 16) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("Different refcount widths than 16 bits
>> require "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "compatibility level 1.1 or above (use
>> compat=3D1.1 or "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "greater)");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "Different refcount widths than 16 bits
>> require "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "compatib=
ility level 1.1 or above (use
>> compat=3D1.1 or "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "greater)=
");
>=20
> Not your fault, but that reads poorly.=C2=A0 Better would be:
>=20
> Refcount widths other than 16 bits require compatibility level 1.1 or a=
bove

Sure it's my fault, I wrote this in the first place. :-)

Max

>> +++ b/qemu-img.c
>> @@ -3730,10 +3730,10 @@ static int img_amend(int argc, char **argv)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* In case the driver does not c=
all amend_status_cb() */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_progress_print(0.f, 0);
>> -=C2=A0=C2=A0=C2=A0 ret =3D bdrv_amend_options(bs, opts, &amend_status=
_cb, NULL);
>> +=C2=A0=C2=A0=C2=A0 ret =3D bdrv_amend_options(bs, opts, &amend_status=
_cb, NULL, &err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_progress_print(100.f, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Error while =
amending options: %s",
>> strerror(-ret));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(err);
>=20
> Definitely nicer, but does change various outputs; glad you fixed
> iotests to match.
>=20
> Overall a nice patch, looking forward to v2.
>=20



--vYiGJIMlqgqJe2AzgJLjRfG5ogvlGKOqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrp/rsACgkQ9AfbAGHV
z0B7GggAmnNJphKMpDcY/P3HvlUlpH3M2QsSnXiRryhMt4a0Hzh6zBQh7gequu92
C0JEWLCoiGeFAFl3xLWCNpUrTe3ANNs0BSZkmMIGGhWLP/gR2wip5CQ6ldwqTLU1
7oaQK13E+eOpAvoFpUqrkzTBneNjc/y7vSDfq/1G0i4gOz0zAg1PtzeoeueGjQE3
KqptqnLHPCktzE1ASzGM14AbJe8PoxsES9wT0R3wGY8uUVpyUcZogOkWmoX95ytq
6hlCsQHYwV+U+wr+jxgU0vMHPzOdUHrSRcdcCm5EI1U4fuqlTV0ui5QRsHS4A3Tz
Ho9q5LyKg70A10505oNfZiT0r+6ByQ==
=XTGf
-----END PGP SIGNATURE-----

--vYiGJIMlqgqJe2AzgJLjRfG5ogvlGKOqm--

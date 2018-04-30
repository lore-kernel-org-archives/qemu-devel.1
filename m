Received: from eggs.gnu.org ([2001:4830:134:3::10]:32784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDAWE-0002Gq-Qd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDAWD-0001cW-V1
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:15:10 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-3-mreitz@redhat.com>
	<26182b94-a34a-ad71-255b-f18dd677efd6@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <829a7d2a-1202-c0ac-f3a2-b9de4afccff6@redhat.com>
Date: Mon, 30 Apr 2018 17:14:54 +0200
MIME-Version: 1.0
In-Reply-To: <26182b94-a34a-ad71-255b-f18dd677efd6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nqGBwCsjFP1F4Njks4stBq6iAgUdjSN3q"
Subject: Re: [Qemu-devel] [PATCH 2/5] qemu-io: Let command functions return
 error code
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
--nqGBwCsjFP1F4Njks4stBq6iAgUdjSN3q
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <829a7d2a-1202-c0ac-f3a2-b9de4afccff6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] qemu-io: Let command functions return
 error code
References: <20180428144123.30333-1-mreitz@redhat.com>
 <20180428144123.30333-3-mreitz@redhat.com>
 <26182b94-a34a-ad71-255b-f18dd677efd6@redhat.com>
In-Reply-To: <26182b94-a34a-ad71-255b-f18dd677efd6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-30 17:08, Eric Blake wrote:
> On 04/28/2018 09:41 AM, Max Reitz wrote:
>> This is basically what everything else in the qemu code base does, so =
we
>> can do it here, too.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/qemu-io.h |=C2=A0=C2=A0 4 +-
>> =C2=A0 qemu-io-cmds.c=C2=A0=C2=A0=C2=A0 | 346
>> ++++++++++++++++++++++++++++++++----------------------
>> =C2=A0 qemu-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 34 ++++--
>> =C2=A0 3 files changed, 227 insertions(+), 157 deletions(-)
>>
>> diff --git a/include/qemu-io.h b/include/qemu-io.h
>> index 06cdfbf660..380724ad59 100644
>> --- a/include/qemu-io.h
>> +++ b/include/qemu-io.h
>> @@ -22,7 +22,7 @@
>> =C2=A0 =C2=A0 #define CMD_FLAG_GLOBAL ((int)0x80000000) /* don't itera=
te "args" */
>> =C2=A0 -typedef void (*cfunc_t)(BlockBackend *blk, int argc, char **ar=
gv);
>> +typedef int (*cfunc_t)(BlockBackend *blk, int argc, char **argv);
>=20
> Quite a bit of churn on the definition here; squashing 1 and 2 might
> make for a smaller patch.=C2=A0 But I agree that doing it this way (2
> separate patches) forces us to audit (with the compiler's help) that al=
l
> callers are caught and adjusted to the new semantics.
>=20
> However, a comment before the typedef would be useful, so that writing =
a
> new command knows what semantics it must provide.=C2=A0 It can be as si=
mple as:
>=20
> /* Implement a qemu-io command.
> =C2=A0* Operate on @blk using @argc/@argv as the command's arguments, a=
nd
> =C2=A0* return 0 on success or negative errno on failure.
> =C2=A0*/

Yep, will do.

> With a comment added,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max



--nqGBwCsjFP1F4Njks4stBq6iAgUdjSN3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrnMu4ACgkQ9AfbAGHV
z0ATXQf/Wm044U7g4giotWfD/RhWF8mKkkCHXulfyAB5fuQfcLxNRGyai5CII52J
+Xn3ubbVgyqQO0SbRfq9TuPDotcrXDrDs9HxOeyNzcfEBMh146LRV87Q8AWCsvOg
HciPnf7oTiAUipz/RxSW3K8a3IX1Yz20ZTahzK/BCrV6dLaJfmyMR/iKGPTZ47Wp
qbuvWshRndHvw2Ral1qEUelJNlw7ucATAOFUqS8sThdPfztNLWD+DTvZb200elmE
caAdJ//AN0LykKZElOm25S5JNcAVp2+Xs7w0B4WnFGPtLcekFQVJMTSqePMq1a6x
LpZG9Q1eMZHm/bYnIA8mHSlD/SI+Zg==
=XzBs
-----END PGP SIGNATURE-----

--nqGBwCsjFP1F4Njks4stBq6iAgUdjSN3q--

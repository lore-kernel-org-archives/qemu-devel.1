Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1djfbS-0008UP-9e
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1djfbP-00086g-5T
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:50:22 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1djfbO-0007u9-T7
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 01:50:19 -0400
Received: by mail-io0-x241.google.com with SMTP id p141so2729189iop.1
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 22:50:17 -0700 (PDT)
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
	<20170818131853.GB17654@stefanha-x1.localdomain>
	<20170821043125.GH12356@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6e2ae379-9cff-9615-c19f-747867328cb5@ozlabs.ru>
Date: Mon, 21 Aug 2017 15:50:09 +1000
MIME-Version: 1.0
In-Reply-To: <20170821043125.GH12356@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3QAtLRFcO5NlWl2iCuq1KMgmFGlw9NDFe"
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QAtLRFcO5NlWl2iCuq1KMgmFGlw9NDFe
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <6e2ae379-9cff-9615-c19f-747867328cb5@ozlabs.ru>
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
 <20170818131853.GB17654@stefanha-x1.localdomain>
 <20170821043125.GH12356@umbus.fritz.box>
In-Reply-To: <20170821043125.GH12356@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21/08/17 14:31, David Gibson wrote:
> On Fri, Aug 18, 2017 at 02:18:53PM +0100, Stefan Hajnoczi wrote:
>> On Fri, Aug 18, 2017 at 03:39:20PM +1000, Alexey Kardashevskiy wrote:
>>> =3D=3D94451=3D=3D -------------------- 4 of 10 --------------------
>>> =3D=3D94451=3D=3D max-live:    314,649,600 in 150 blocks
>>> =3D=3D94451=3D=3D tot-alloc:   314,649,600 in 150 blocks (avg size 20=
97664.00)
>>> =3D=3D94451=3D=3D deaths:      none (none of these blocks were freed)=

>>> =3D=3D94451=3D=3D acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-writt=
en)
>>> =3D=3D94451=3D=3D    at 0x4895600: memalign (in
>>> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
>>> =3D=3D94451=3D=3D    by 0x48957E7: posix_memalign (in
>>> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
>>> =3D=3D94451=3D=3D    by 0xB744AB: qemu_try_memalign (oslib-posix.c:10=
6)
>>> =3D=3D94451=3D=3D    by 0xA92053: qemu_try_blockalign (io.c:2493)
>>> =3D=3D94451=3D=3D    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
>>> =3D=3D94451=3D=3D    by 0xA35627: qcow2_open (qcow2.c:1526)
>>> =3D=3D94451=3D=3D    by 0x9FB94F: bdrv_open_driver (block.c:1109)
>>> =3D=3D94451=3D=3D    by 0x9FC413: bdrv_open_common (block.c:1365)
>>> =3D=3D94451=3D=3D    by 0x9FF823: bdrv_open_inherit (block.c:2542)
>>> =3D=3D94451=3D=3D    by 0x9FFC17: bdrv_open (block.c:2626)
>>> =3D=3D94451=3D=3D    by 0xA71027: blk_new_open (block-backend.c:267)
>>> =3D=3D94451=3D=3D    by 0x6D3E6B: blockdev_init (blockdev.c:588)
>>
>> This allocation is unnecessary.  Most qcow2 files are not encrypted so=

>> s->cluster_data does not need to be allocated upfront.
>>
>> I'll send a patch.
>=20
> Is that sufficient to explain the problem, I can't quickly see how big
> that unnecessary allocation is - but would it account for the 10s of
> gigabytes usage we're seeing here?
>=20
> I'm suspecting we accidentally have a O(n^2) or worse space complexity
> going on here.
>=20

No, it is a small fraction only. See "[PATCH] qcow2: allocate
cluster_cache/cluster_data on demand" thread for more details.



--=20
Alexey


--3QAtLRFcO5NlWl2iCuq1KMgmFGlw9NDFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZmnSSDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5tgUQAJXR
Iq3zEoux3iS8bwChRb4njh/G/eHkctpb2fyjbT9XNgzPETAy87nDUp48KDL4qvQt
c0ye4IcXyF35LuYGnG682m5F78zB/zre9p8d5VEV37USuL/yhCjuEIs5nWgMOQ/L
v9KV2j0uY9jqVFr1eyltoHmxzso91T59Cx5jYpJngRitF//TI3EpADdlKBt6FLi3
AY8YJUQv6EJME7LyczS/H3QigZyd8qPBajilhFSL+xUHtwBH+VRW50bt7kVhbNct
eFIi3SO5zCEG2DfRBZbaOUhbD8RHhMWGksqjTPWrp96mdnFM2krTuWQT+Ty1YXLz
c1sElPfCna0S4A8ycGIU/ZnzLzDQr94Y/XQ7yLtrK1x2/UCqhIAZsfVVBrHcJawm
Qk+LfY/TX+kT6FAmwiMWjIpzuNxcc4oqfJzutq+FhFZ2ksX6QIrqHgXCx/9ODAu9
aZoPVtvEVDtPYJcrAYQpmBaR2PEpNRdEhcgaOtAArX0RuMDlKRIMtDMA6fbZLj84
93KOME4djuLE4m/hrz4LsD8BmT3uESYpvxRiF7GTIJ1CDu9ZFLlS+ccY5C02fmsa
+ZbA+CEyg1C7CXfPIiV6OeoAiziFTBORf62Za5Hr/rnTujiWv1mWzYRW1HXUaPCE
t7Xd+yjfDXxG8K0S1WTcNdnwTZVbBrS4mGTK2cB1
=mMyb
-----END PGP SIGNATURE-----

--3QAtLRFcO5NlWl2iCuq1KMgmFGlw9NDFe--

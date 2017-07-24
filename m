Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc8V-0000zA-9Y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc8R-0003Oa-9o
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:06:55 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
	<88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <158d2038-b538-4205-b4e9-0680c03f6417@redhat.com>
Date: Mon, 24 Jul 2017 07:06:41 -0500
MIME-Version: 1.0
In-Reply-To: <88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VBlGEA3r3qPeBQJA9rHwWm07NC650toJg"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based
 block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VBlGEA3r3qPeBQJA9rHwWm07NC650toJg
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <158d2038-b538-4205-b4e9-0680c03f6417@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based block
 status
References: <20170721183243.22706-1-eblake@redhat.com>
 <88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
In-Reply-To: <88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 07:05 AM, Eric Blake wrote:
> On 07/21/2017 01:32 PM, Eric Blake wrote:
>> Series 2-4 of my byte-based conversion missed soft freeze, so they
>> are now 2.11 material.  However, there are some bug fixes in those
>> series that we should fix now in 2.10 (patch 1 from series two
>> on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure(=
)
>> to byte-based iteration" from series three on block status).
>>
>> I don't know if it is worth enhancing iotest 178 to probe the size
>> of a 2T image.  The test is simple, and fast when patched:
>>
>> $ qemu-img create -f qcow2 -o cluster_size=3D2M huge 2T
>> $ time ./qemu-img measure -O qcow2 -f qcow2 huge
>> required size: 335806464
>> fully allocated size: 2199359062016
>>
>> real	0m0.021s
>> user	0m0.017s
>> sys	0m0.004s
>>
>> but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
>> occupies 6 megabytes on disk, so it's not that invasive.
>>
>> Eric Blake (2):
>>   dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
>>   qcow2: Fix sector calculation in qcow2_measure()
>=20
> Thanks; queued on my NBD branch:
> git://repo.or.cz/qemu/ericb.git nbd

Sorry, replied to the wrong thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VBlGEA3r3qPeBQJA9rHwWm07NC650toJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll14tEACgkQp6FrSiUn
Q2o4mwf/Y2BaOpBAaNCT/NvtEWX+mms7U+7bU6w0emPQEwGumx2j5RkGR1/+DnPt
3XODlnm80N43Zt65GVIzGRqK0BAeFlnoN4L5Mchy473r7tUotfzKTpc8URWoJzJO
PT/qmk483O3rGQJbsRwwb0mqJ45HDLlcQ0CEMrOsd0fc14A0i0ZUKn9UOLDBuaLV
FUrVIVyRRp+rfulmefSkYFeKLaHmGE+DOfI5LIfCjEbsUomUhH9DycwcejNQRi+I
ZgrWL1CV377QeUrzE89JFwpeuhWx37pqd6C7r47qjmAQE+SnOyicW3psdtDx7jF9
ZszdQPppF73sKKxXHh4dzz1X5EG78Q==
=adqL
-----END PGP SIGNATURE-----

--VBlGEA3r3qPeBQJA9rHwWm07NC650toJg--

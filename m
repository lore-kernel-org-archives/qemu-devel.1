Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HQ6-0007lU-5G
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 20:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0HQ5-0006U2-7o
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 20:55:02 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-14-eblake@redhat.com>
	<4b9db542-0b8f-7c81-9c01-75b252888bd3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a71341fb-c2b0-7008-e055-e881ed46d420@redhat.com>
Date: Mon, 17 Apr 2017 19:54:50 -0500
MIME-Version: 1.0
In-Reply-To: <4b9db542-0b8f-7c81-9c01-75b252888bd3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pTQFWKmTp9Dq5fxgpr7Ef7ME7JvPiu6Kh"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 13/17] backup: Switch
 block_backup.h to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, qemu-block@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pTQFWKmTp9Dq5fxgpr7Ef7ME7JvPiu6Kh
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 qemu-block@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <a71341fb-c2b0-7008-e055-e881ed46d420@redhat.com>
Subject: Re: [Qemu-block] [PATCH 13/17] backup: Switch block_backup.h to
 byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-14-eblake@redhat.com>
 <4b9db542-0b8f-7c81-9c01-75b252888bd3@redhat.com>
In-Reply-To: <4b9db542-0b8f-7c81-9c01-75b252888bd3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 06:24 PM, John Snow wrote:
>=20
>=20
> On 04/11/2017 06:29 PM, Eric Blake wrote:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Continue by converting
>> the public interface to backup jobs (no semantic change), including
>> a change to CowRequest to track by bytes instead of cluster indices.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>>
>> -void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sect=
or_num,
>> -                                          int nb_sectors);
>> +void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offs=
et,
>> +                                          uint64_t bytes);
>>  void backup_cow_request_begin(CowRequest *req, BlockJob *job,
>> -                              int64_t sector_num,
>> -                              int nb_sectors);
>> +                              int64_t offset, uint64_t bytes);
>>  void backup_cow_request_end(CowRequest *req);
>=20
> Should we adjust the parameter names of cow_request_begin and
> wait_for_overlapping_requests, too?

Sure, I can do that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pTQFWKmTp9Dq5fxgpr7Ef7ME7JvPiu6Kh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9WPbAAoJEKeha0olJ0Nq/8UH/RNRXjI5RjWmolYME/8PlQtm
qCRUadykvD9qlDt6VfwbbBNcYSq0MrQ/ystxUGxml/DhCRlmrODMZ8hn+e9BNVyS
2VCtNbdvceiNm3uYROg7Qc3O11V820U1kL3Cnoe8OeqJvSXbI+HXTjfDx5AyJR4L
uxIeOtNAyfJ43Zaeb1y39Ix9mb3ETkXR8LNPknREOJBDLakk7zBRmxcp6QodTqnM
3uTKGfj9RHkp3F411iaN4ZxpytwzWv/x6+lQLhr2zpPiaUGCpheXhfXHsbT8dcWw
pb7vcok0XLh81VQspl5h+zBDaX3VL1nu+wRi1cEYbPVcyyoymYhrehmr0IxLT+g=
=OX/S
-----END PGP SIGNATURE-----

--pTQFWKmTp9Dq5fxgpr7Ef7ME7JvPiu6Kh--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFDT-0004B7-UP
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFDT-00012N-0C
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:54:08 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-7-eblake@redhat.com>
	<09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <245066df-3ab6-081f-dc4f-badd61b0d636@redhat.com>
Date: Mon, 30 Jan 2017 10:54:01 -0600
MIME-Version: 1.0
In-Reply-To: <09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b4QB1GvLdpE5NqP97Etp6WppULFnoTre5"
Subject: Re: [Qemu-devel] [PATCH v4 6/7] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b4QB1GvLdpE5NqP97Etp6WppULFnoTre5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:blkdebug" <qemu-block@nongnu.org>
Message-ID: <245066df-3ab6-081f-dc4f-badd61b0d636@redhat.com>
Subject: Re: [PATCH v4 6/7] blkdebug: Add ability to override unmap geometries
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-7-eblake@redhat.com>
 <09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
In-Reply-To: <09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2017 02:57 PM, Max Reitz wrote:
> On 20.12.2016 20:15, Eric Blake wrote:
>> Make it easier to simulate various unusual hardware setups (for
>> example, recent commits 3482b9b and b8d0a98 affect the Dell
>> Equallogic iSCSI with its 15M preferred and maximum unmap and
>> write zero sizing, or b2f95fe deals with the Linux loopback
>> block device having a max_transfer of 64k), by allowing blkdebug
>> to wrap any other device with further restrictions on various
>> alignments.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +++ b/qapi/block-core.json
>> @@ -2072,6 +2072,26 @@
>>  # @align:           #optional required alignment for requests in byte=
s,
>>  #                   must be power of 2, or 0 for default
>>  #
>> +# @max-transfer:    #optional maximum size for I/O transfers in bytes=
,
>> +#                   must be multiple of @align
>=20
> ...and the file's request alignment. Should that be noted here?

As in - if we set @align to 1, but the underlying file still requires an
alignment of 512, then @max-transfer has to be at least 512.  Yeah, that
makes sense to document.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--b4QB1GvLdpE5NqP97Etp6WppULFnoTre5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj2+pAAoJEKeha0olJ0NqH/AH/1Ds1JSFJCrTNT4iUXkXKhyi
0BrHHiMtT8vCd81NOeq568cL3lizO8AjzORnucCdiEuloCx9sezDeR4WMY1Gm6l0
+swjYOAr1UZGfj/rADmsxTmU7EO17dk6hLj3QyKCznQdA57m2Yin+D9zEeniE62C
IUBNsalqJ028reOeckqObmFrJ6SdVhdTjPYgvjcLOha7MB0DkIdr7ftoA6c58pi2
ZLLf8GbArtYatrSO0G3V9fbc54xwjWPdOe5jgvK203JtjhVF5kRyYNmBPa+PM4oX
IpMRRvnTou1O//nHeUSTqrPd9Y67OnWfwtYYcvVevLa6WTkQq1qt+0inJcANq9I=
=JMh3
-----END PGP SIGNATURE-----

--b4QB1GvLdpE5NqP97Etp6WppULFnoTre5--

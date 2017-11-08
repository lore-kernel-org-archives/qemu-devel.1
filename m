Received: from eggs.gnu.org ([2001:4830:134:3::10]:35416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVUM-00073k-R2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVUL-0005bm-VK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:54:14 -0500
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-17-mreitz@redhat.com>
	<w51shdwwxpn.fsf@maestria.local.igalia.com>
	<b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
	<c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
	<w51lgji2sxf.fsf@maestria.local.igalia.com>
	<20171108170918.GG30890@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b31d8801-9fa7-7e55-e794-c1e923ce1f9b@redhat.com>
Date: Wed, 8 Nov 2017 19:54:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171108170918.GG30890@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cmjnvg11bFNbOFOnr1jdWHret1tvFdLrw"
Subject: Re: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cmjnvg11bFNbOFOnr1jdWHret1tvFdLrw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <b31d8801-9fa7-7e55-e794-c1e923ce1f9b@redhat.com>
Subject: Re: [PATCH v6 16/25] block: Add 'base-directory' BDS option
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-17-mreitz@redhat.com>
 <w51shdwwxpn.fsf@maestria.local.igalia.com>
 <b28222f7-e360-a31b-dc24-798e2db7d089@redhat.com>
 <c12f0934-d3a6-10e2-918f-7602518789ad@redhat.com>
 <w51lgji2sxf.fsf@maestria.local.igalia.com>
 <20171108170918.GG30890@localhost.localdomain>
In-Reply-To: <20171108170918.GG30890@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-08 18:09, Kevin Wolf wrote:
> Am 07.11.2017 um 13:07 hat Alberto Garcia geschrieben:
>> On Thu 02 Nov 2017 11:06:28 PM CET, Eric Blake wrote:
>>
>>>>>> Using this option, one can directly override what bdrv_dirname()
>>>>>> will return. This is useful if one uses e.g. qcow2 on top of quoru=
m
>>>>>> (with only protocol BDSs under the quorum BDS) and wants to be abl=
e
>>>>>> to use relative backing filenames.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>
>>>>> Who would be using this option in practice? I understand that
>>>>> management tools should be using always absolute filenames, and thi=
s
>>>>> API doesn't seem so convenient for humans.
>>>>
>>>> Hmmm.  I seem to recall Eric liked it a couple of years ago when he
>>>> was still more on the libvirt side of things. :-)
>>>
>>> Ideally, libvirt should be using node names rather than filenames
>>> (whether absolute or relative); but I still think it could be
>>> something that turns out to be useful.
>>
>> But what would be the use case? For a management tool it's not more
>> convenient to use relative file names, or is it?
>=20
> If we add an external API, we must maintain compatibility in future
> versions, so taking the patch comes with a cost. So I agree with you
> that we better wait for an actual use case rather than just "could turn=

> out to be useful to someone maybe".

OK, fair enough.  Also, adding it later would hopefully be as simple as
just sending this patch again.

Max


--cmjnvg11bFNbOFOnr1jdWHret1tvFdLrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDUsgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3wsH/RXmkT08EFJEOZsxRJd6vIvW2kd1ez7w
sqypdy0/k9EHXJ/VXxj1xpbipfjgMqvfRKFxE7ibXyvxmX9tDqO91nV5KdStRVNK
ZQJ0SPI567au4A7lFkZyRJoCL8AGCerzP8kwZWJG3nOgeVnmeWy0qBqqqzeoXkZv
SDKQYXnYVKYaJ0w1TcCxH596bDtLEzQ0BAx3Rif7l8/u83EWF7Ep+3MwpByDQ0VV
2EG2/cHQ94C1crzjep5Nqw2veX3eXl/ODKEyLWJLAxR03AvJbGOymUpfvZz/s56e
Ctqy2/F+01jKBlrjOGexs+mSqUx3jgxo53etK/A0BJadGj9+fe2Z8mQ=
=SANq
-----END PGP SIGNATURE-----

--cmjnvg11bFNbOFOnr1jdWHret1tvFdLrw--

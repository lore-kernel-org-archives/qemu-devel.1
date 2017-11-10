Received: from eggs.gnu.org ([2001:4830:134:3::10]:50251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHlF-0003jI-Oz
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHlE-0002v1-WA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:26:53 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-3-mreitz@redhat.com>
	<40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fa57f222-edbc-4604-acb3-94223d7cd902@redhat.com>
Date: Fri, 10 Nov 2017 23:26:44 +0100
MIME-Version: 1.0
In-Reply-To: <40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5hOHnxK7Wb8oaPRFbnqPwFAirgO8bLQ4j"
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing
 link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5hOHnxK7Wb8oaPRFbnqPwFAirgO8bLQ4j
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <fa57f222-edbc-4604-acb3-94223d7cd902@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing link
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-3-mreitz@redhat.com>
 <40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
In-Reply-To: <40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 23:22, Eric Blake wrote:
> On 11/10/2017 04:13 PM, Max Reitz wrote:
>> Instead of converting all "backing": null instances into "backing": ""=
,
>> handle a null value directly in bdrv_open_inherit().
>>
>> This enables explicitly null backing links for json:{} filenames.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c                    |  2 +-
>>  blockdev.c                 | 14 --------------
>>  tests/qemu-iotests/089     | 20 ++++++++++++++++++++
>>  tests/qemu-iotests/089.out |  8 ++++++++
>>  4 files changed, 29 insertions(+), 15 deletions(-)
>>
>=20
>> @@ -3899,19 +3898,6 @@ void qmp_blockdev_add(BlockdevOptions *options,=
 Error **errp)
>> =20
>>      qdict_flatten(qdict);
>> =20
>> -    /*
>> -     * Rewrite "backing": null to "backing": ""
>> -     * TODO Rewrite "" to null instead, and perhaps not even here
>> -     */
>=20
> Nice that the TODO told you what to do :)

Well, not really, because I disagree that it needs to be rewritten at
all.  I think we just need to deprecate and later disallow "backing":
"", which would absolve us from all of the rewriting trouble.

This code was added here because Markus needed to allow "backing": null
in a hurry (as far as I remember), so he added it centrally here instead
of checking how many places there are that evaluate "backing": "".

I should maybe have said that patch 3 is more of an RFC.  I'm not sure
whether other people agree that "backing": "" should be deprecated --
and if not, we would have to rewrite it still.

Max


--5hOHnxK7Wb8oaPRFbnqPwFAirgO8bLQ4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGJ6QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4HIH/3rx2sSPcTAAPcR3jmxK0whMA61TjVHw
WG9CwsUTEQQBaDFg2unbXAyhd0m8oXAk3oe+OXcs4v+e4KDCOQLDIULu+9anKRlg
OWKDObpqB1K59HmplGvI82Zx5Xm6QGikzkxo5wI7T2MmpxfYdWekLR0jNSN/WS6U
N3iG4cDCQAH26Bj8Qj3ePdEXErUhl5EU698+8PE+P/VZ3rsvFdKSDYobf2tZ8zOY
e7pGz1Mgrm3XcEqvJ9vN343Lxsx358chKgjvrtEcmDreUm3rtUjk9jMp+CCJfTSI
8tZ9OR/06+p7vStWOix5QV2DrYt1bqDs7O/WnGhbKEEymZgv43XfC8E=
=7cdW
-----END PGP SIGNATURE-----

--5hOHnxK7Wb8oaPRFbnqPwFAirgO8bLQ4j--

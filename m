Received: from eggs.gnu.org ([2001:4830:134:3::10]:40319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSPU-0007w0-Rk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSPT-0001VE-No
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:31:00 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-26-vsementsov@virtuozzo.com>
	<87r2xs65a5.fsf@dusky.pond.sub.org> <20170707081305.GA15945@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6ae8d91-c348-8fea-b957-8e150301c35f@redhat.com>
Date: Fri, 7 Jul 2017 07:30:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170707081305.GA15945@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f8cQs1nMrEqLLpHd0wgLgHCNX5DSjAfmp"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v22 25/30] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8cQs1nMrEqLLpHd0wgLgHCNX5DSjAfmp
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <e6ae8d91-c348-8fea-b957-8e150301c35f@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v22 25/30] qmp: add
 x-debug-block-dirty-bitmap-sha256
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-26-vsementsov@virtuozzo.com>
 <87r2xs65a5.fsf@dusky.pond.sub.org> <20170707081305.GA15945@redhat.com>
In-Reply-To: <20170707081305.GA15945@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 03:13 AM, Daniel P. Berrange wrote:
> On Fri, Jul 07, 2017 at 10:05:22AM +0200, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>  block/dirty-bitmap.c         |  5 +++++
>>>  blockdev.c                   | 25 +++++++++++++++++++++++++
>>>  include/block/dirty-bitmap.h |  1 +
>>>  include/qemu/hbitmap.h       |  8 ++++++++
>>>  qapi/block-core.json         | 27 +++++++++++++++++++++++++++
>>>  tests/Makefile.include       |  2 +-
>>>  util/hbitmap.c               | 11 +++++++++++
>>>  7 files changed, 78 insertions(+), 1 deletion(-)
>> [...]
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 5c42cc7790..6ad8585400 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1644,6 +1644,33 @@
>>>    'data': 'BlockDirtyBitmap' }
>>> =20
>>>  ##
>>> +# @BlockDirtyBitmapSha256:
>>> +#
>>> +# SHA256 hash of dirty bitmap data
>>> +#
>>> +# @sha256: ASCII representation of SHA256 bitmap hash
>>
>> Spell it SHA-256, please.  The member name @sha256 can stay.
>>
>> SHA-256 is 256 binary bits.  Please specify how they are represented i=
n
>> ASCII.  It better be base64 (RFC 4648), because we use that elsewhere.=

>=20
> It is filled later in this patch using qcrypto_hash_digest, so it is ju=
st
> a hex string representing the hash, not base64. For the latter you can
> use qcrypto_hash_base64

hex (aka base16) is used for displaying UUIDs across QMP.  Furthermore,
this is an x- command, useful only for debugging, so we can feel free to
change the underlying implementation without breaking clients (if we
prefer to go with the shorter base64 string instead of the longer hex
string, even if we make that switch after a release).  Still, it's nice
to avoid churn, and Markus does have a point about reusing a common
base64 theme for displaying arbitrary binary data, rather than having ad
hoc differences.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f8cQs1nMrEqLLpHd0wgLgHCNX5DSjAfmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX37vAAoJEKeha0olJ0NqQvQH/RaCJm+tkde3iSkxw+lA4JR1
crHjIxqBuUMN0fqbNe6fnFPuYh5ezV0TvyR0MIDV5znOkve7ic0kTEC5VDRDOtoQ
qsWJ/oBJwpzReFja1Y9bGwDxOZZ7l6r3kzfka856rq18rllD22TDvwPk2V+nBAlP
clvYuZQ9XnvitGi0sEpnX4v7JR6mmiHbhsRhozz/3VCPtKFhF68qfR9ZOgu8Nq5F
6ToOYfWNRjVtAciJd8Q6fMiJiYTAAWoUAsm5V4/n73vXdqZGvfM0jzIvPP2tIB+V
POeRNU0BDL1aqG2OdsCJalR6eqNHFjZxoCr7ZPnX7C0F/8/K7VvAWdfFEYUYeVM=
=vEll
-----END PGP SIGNATURE-----

--f8cQs1nMrEqLLpHd0wgLgHCNX5DSjAfmp--

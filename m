Received: from eggs.gnu.org ([2001:4830:134:3::10]:47602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCQi-0004JO-5X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQCQf-0001rR-3F
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQCQe-0001pm-Qb
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:50:45 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
	<20170628121352.GC7538@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed8b7d78-a28b-b3df-1bd9-0ad3cd12a35c@redhat.com>
Date: Wed, 28 Jun 2017 07:50:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170628121352.GC7538@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mdojKg2bIUuE5NCNvNRjJpUNmOUxBCn5a"
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mdojKg2bIUuE5NCNvNRjJpUNmOUxBCn5a
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <ed8b7d78-a28b-b3df-1bd9-0ad3cd12a35c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
References: <20170615163813.7255-1-stefanha@redhat.com>
 <20170615163813.7255-4-stefanha@redhat.com>
 <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
 <20170628121352.GC7538@stefanha-x1.localdomain>
In-Reply-To: <20170628121352.GC7538@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:13 AM, Stefan Hajnoczi wrote:
> On Tue, Jun 27, 2017 at 06:40:04AM -0500, Eric Blake wrote:
>> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
>>> Avoid duplicating the QEMU command-line.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  tests/qemu-iotests/068 | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>
>>> +# Give qemu some time to boot before saving the VM state
>>> +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
>>
>> Are we sure that 'bash' on PATH is the same as the /bin/bash running t=
he
>> script?
>>
>> Also, while bash has more deterministic behavior for 'echo -e' (it is
>> non-portable if you are porting a script to other shells), it is still=

>> possible to set bash to a mode where it does not work (see xhopt
>> xpg_echo).  I'd much prefer you use 'printf' instead of 'set -e'.

instead of 'echo -e'

>=20
> Do you want to send a separate patch?

Sure.

>=20
> The purpose of this patch was just to move this code.

Fair enough. Besides, more than just 068 use 'echo -e' where 'printf'
would be better.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mdojKg2bIUuE5NCNvNRjJpUNmOUxBCn5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU6YeAAoJEKeha0olJ0Nq4V4H/jZOGoXtMHMQKoSbpeKYHFRD
lHvDTspDXLsmDIopCOnVHlNPfI2gtxImSZwt6KBzeX3JxepRwIGjxQHydXJOvNHA
d3lzeEZc1W8UtIg7N4sMkISOxGHMVfG3ziHsgnk8/i4I+o9t+ZVKFtDE84bpt+9u
WrlfbLYVV2Nk1YR8ibT+8zO2bqC8igOIjpWbPmefw3JgkNSKyq7IUN8rRF5HL/VZ
NauDWVF5Q7mjCC+43p5x8N3MWQxMeCpxZev78P7ZUM2g0Xz1/+eppNT4oCyzPmwH
rTDlAV20Yfo8VkmhNbXKM1cv7xb6uU8UvirGwv7Dui0xw6NsilgUeh30PwFQfAg=
=bUX6
-----END PGP SIGNATURE-----

--mdojKg2bIUuE5NCNvNRjJpUNmOUxBCn5a--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIaA2-0004af-CD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIaA1-0005LR-J1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:34:06 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-6-berrange@redhat.com>
	<1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
	<20170601084057.GD1490@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27a8a995-7350-a4ee-a6d5-72844f1e46ee@redhat.com>
Date: Wed, 7 Jun 2017 14:33:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170601084057.GD1490@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5tUSwuuMlmOnQJ4EdT1k8S6fWfXCLVCXO"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] iotests: chown LUKS device before
 qemu-io launches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5tUSwuuMlmOnQJ4EdT1k8S6fWfXCLVCXO
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <27a8a995-7350-a4ee-a6d5-72844f1e46ee@redhat.com>
Subject: Re: [PATCH v5 5/5] iotests: chown LUKS device before qemu-io launches
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-6-berrange@redhat.com>
 <1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
 <20170601084057.GD1490@redhat.com>
In-Reply-To: <20170601084057.GD1490@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-01 10:40, Daniel P. Berrange wrote:
> On Wed, May 31, 2017 at 06:15:27PM +0200, Max Reitz wrote:
>> On 2017-05-09 19:33, Daniel P. Berrange wrote:
>>> On some distros, whenever you close a block device file
>>> descriptor there is a udev rule that resets the file
>>> permissions. This can race with the test script when
>>> we run qemu-io multiple times against the same block
>>> device. Occasionally the second qemu-io invocation
>>> will find udev has reset the permissions causing failure.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  tests/qemu-iotests/149     |  13 +-
>>>  tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++-------------=
----------
>>>  2 files changed, 178 insertions(+), 179 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
>>> index 5faf585..bc628ce 100755
>>> --- a/tests/qemu-iotests/149
>>> +++ b/tests/qemu-iotests/149
>>> @@ -23,6 +23,7 @@
>>>  import subprocess
>>>  import os
>>>  import os.path
>>> +import time
>>
>> Why?
>=20
> That's left over cruft from debugging this test. I'll kill it.
>=20
>> Rest looks good.
>=20
> Does that count for "reviewed-by" if i kill the import ?

Yes, it does. :-)

Max


--5tUSwuuMlmOnQJ4EdT1k8S6fWfXCLVCXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZN/KxEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOxV
B/9jydg960xrbIBds7zcfxP8M73CWtovlHhXwCwPsQIyDdPJvHTkCQKUsprh9LFK
bzfcFu4eKnOkGGhBvjDWOC1Hi9wjJJGEbzTZP0EPpqU7h7GMeyO12ivysV0gNU0Q
pARQ43H8q4btMe4Snt9rwsiXo71wcSnQK+VOJrmxN5Lh0/M6OWI1szvdclB93pnk
UfwLVPPODnFuEDO6c7f8ACwZTmxpgsBk0ZiaUSa1tSVFEK/kN9iSqdFIIORpZxPW
X6MLVSqR6r80iT/WDZhY1TAbVg/AbH0HV9XED6NTIrVezWVFPEQqBE7Px+XGY8GR
oM5nS2irnzomCy4gUiZ+cM1B
=xm4q
-----END PGP SIGNATURE-----

--5tUSwuuMlmOnQJ4EdT1k8S6fWfXCLVCXO--

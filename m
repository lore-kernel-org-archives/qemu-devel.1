Received: from eggs.gnu.org ([2001:4830:134:3::10]:44132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga6Yt-0001ec-Kt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 17:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga6Yr-0008Ma-08
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 17:12:58 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-10-jsnow@redhat.com>
	<577432c1-bfeb-5b56-fea3-24bd50e23825@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <da77aefd-508a-b521-f127-43aa959aac5c@redhat.com>
Date: Thu, 20 Dec 2018 17:12:35 -0500
MIME-Version: 1.0
In-Reply-To: <577432c1-bfeb-5b56-fea3-24bd50e23825@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 09/11] iotests: change qmp_log filters
 to expect QMP objects only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 9:53 PM, Eric Blake wrote:
> On 12/19/18 8:29 PM, John Snow wrote:
>> As laid out in the previous commit's message:
>>
>> ```
>> Several places in iotests deal with serializing objects into JSON
>> strings, but to add pretty-printing it seems desireable to localize
>=20
> s/desireable/desirable/
>=20
>> all of those cases.
>>
>> log() seems like a good candidate for that centralized behavior.
>> log() can already serialize json objects, but when it does so,
>> it assumes filters=3D[] operates on QMP objects, not strings.
>>
>> qmp_log currently operates by dumping outgoing and incoming QMP
>> objects into strings and filtering them assuming that filters=3D[]
>> are string filters.
>> ```
>>
>> Therefore:
>>
>> Change qmp_log to treat filters as if they're always qmp object filter=
s,
>> then change the logging call to rely on log()'s ability to serialize Q=
MP
>> objects, so we're not duplicating that effort.
>>
>> Add a qmp version of filter_testfiles and adjust the only caller using
>> it for qmp_log to use the qmp version.
>>
>> Signed-off-by: John Snow=C2=A0 <jsnow@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> Odd double S-o-B differing only by space.

I fixed my auto-signer! It has rudely detected my typo and decided that
it needed a fresh SOB.

>=20
>> ---
>> =C2=A0 tests/qemu-iotests/206=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 ++--
>> =C2=A0 tests/qemu-iotests/iotests.py | 24 +++++++++++++++++++++---
>> =C2=A0 2 files changed, 23 insertions(+), 5 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
Thanks!

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fn6Sl-0004PM-As
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 14:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fn6Sg-0006r6-3d
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 14:12:07 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-20-jsnow@redhat.com>
	<83f634a8-ddab-2eb1-419a-fd2e8a6b815f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <24a6e7f3-13be-4162-8860-95805b617732@redhat.com>
Date: Tue, 7 Aug 2018 14:11:49 -0400
MIME-Version: 1.0
In-Reply-To: <83f634a8-ddab-2eb1-419a-fd2e8a6b815f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/21] qapi/block-commit: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>



On 08/07/2018 10:52 AM, Eric Blake wrote:
> On 08/06/2018 11:33 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 8 ++++++++
>> =C2=A0 qapi/block-core.json | 3 ++-
>> =C2=A0 2 files changed, 10 insertions(+), 1 deletion(-)
>>
>=20
>> +++ b/qapi/block-core.json
>> @@ -1518,7 +1518,8 @@
>> =C2=A0 { 'command': 'block-commit',
>> =C2=A0=C2=A0=C2=A0 'data': { '*job-id': 'str', 'device': 'str', '*base=
': 'str',
>> '*top': 'str',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*backing-file': 'str', '*speed': 'int',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
filter-node-name': 'str' } }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
filter-node-name': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>=20
> Missing documentation, including a 'since 3.1' tag.
>=20

OK, will fix for V2 but I won't respin until I get more feedback.

--js

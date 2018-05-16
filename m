Received: from eggs.gnu.org ([2001:4830:134:3::10]:34968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ4Iw-0001cg-6r
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJ4Iv-00016X-If
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:49:50 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-9-jsnow@redhat.com>
	<bdffad4f-8486-4953-69c7-cb9eb4087baa@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <caaa0be9-212f-1d9d-5c46-6c65badc4751@redhat.com>
Date: Wed, 16 May 2018 17:49:44 -0400
MIME-Version: 1.0
In-Reply-To: <bdffad4f-8486-4953-69c7-cb9eb4087baa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/12] qjson: allow caller to ask for
 arbitrary indent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/16/2018 05:34 PM, Eric Blake wrote:
> On 05/11/2018 08:25 PM, John Snow wrote:
>> The function already exists, just expose it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 include/qapi/qmp/qjson.h |=C2=A0 1 +
>> =C2=A0 qobject/qjson.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 21 +++++++++++----------
>> =C2=A0 2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
>> index b274ac3a86..0e8624c1fa 100644
>> --- a/include/qapi/qmp/qjson.h
>> +++ b/include/qapi/qmp/qjson.h
>> @@ -19,6 +19,7 @@ QObject *qobject_from_jsonf(const char *string, ...)
>> GCC_FMT_ATTR(1, 2);
>> =C2=A0 QObject *qobject_from_jsonv(const char *string, va_list *ap, Er=
ror
>> **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GCC_FMT_ATTR(1, 0);
>> =C2=A0 +QString *qobject_to_json_opt(const QObject *obj, int pretty, i=
nt
>> indent);
>=20
> pretty seems like it is better as a bool.=C2=A0 Even though to_json() i=
sn't
> typed correctly, that's no excuse for the public function to copy a bad
> interface (and maybe it's worth a separate cleanup patch to fix
> to_json() first).
>=20

Eh, sure, why not. Done.

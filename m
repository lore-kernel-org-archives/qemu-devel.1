Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gYySi-0007Hu-Mt
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gYySh-0008Fm-OI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 14:21:56 -0500
References: <20181214231512.5295-1-jsnow@redhat.com>
	<20181214231512.5295-7-jsnow@redhat.com>
	<0780ebaa-3e11-c197-85f9-9133dc227d65@virtuozzo.com>
	<de056aa7-d383-af0f-6059-44e008c1649e@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <009ac77d-84c2-3123-f710-755a5bcf2452@redhat.com>
Date: Mon, 17 Dec 2018 14:21:45 -0500
MIME-Version: 1.0
In-Reply-To: <de056aa7-d383-af0f-6059-44e008c1649e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] iotests: allow pretty-print for
 qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>



On 12/17/18 11:37 AM, Vladimir Sementsov-Ogievskiy wrote:
> 17.12.2018 17:26, Vladimir Sementsov-Ogievskiy wrote:
>> 15.12.2018 2:15, John Snow wrote:
>>> If iotests have lines exceeding >998 characters long, git doesn't
>>> want to send it plaintext to the list. We can solve this by allowing
>>> the iotests to use pretty printed QMP output that we can match agains=
t
>>> instead.
>>>
>>> As a bonus, it's much nicer for human eyes, too.
>>>
>>> Note that this changes the sort order for "command" and "arguments",
>>> so I restrict this reordering to occur only when the indent is specif=
ied.
>>> ---
>>> =C2=A0 tests/qemu-iotests/iotests.py | 17 +++++++++++++----
>>> =C2=A0 1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 9595429fea..ab5823c011 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -447,12 +447,21 @@ class VM(qtest.QEMUQtestMachine):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 result.append(filter_qmp_event(ev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result
>>> -=C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, filters=3D[filter_testfile=
s], **kwargs):
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logmsg =3D '{"execute": "=
%s", "arguments": %s}' % \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
cmd, json.dumps(kwargs, sort_keys=3DTrue))
>>> +=C2=A0=C2=A0=C2=A0 def qmp_log(self, cmd, indent=3DNone, filters=3D[=
filter_testfiles], **kwargs):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Python < 3.4 needs to k=
now not to add whitespace when pretty-printing:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 separators =3D (',', ': '=
) if indent is not None else (',', ': ')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if indent is not None:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ullcmd =3D { "execute": cmd,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ar=
guments": kwargs }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ogmsg =3D json.dumps(fullcmd, indent=3Dindent, separators=3Dseparators,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sort_keys=3DTrue)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ogmsg =3D '{"execute": "%s", "arguments": %s}' % \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (cmd, json.dumps(kwargs, sort_keys=3DTrue))
>>
>> definitely overlogic on None/is not None, but anyway, ',' separator le=
ads to less
>> beautiful output. So, I think it is better to do just "re.sub(r'\s+\n'=
, '\n', longmsg)"
>> on final message, here or in log(), or in both.

I can't use "if indent" because 0 is a valid indentation, and I decided
to keep the "correct" order for execute/arguments if no indentation is
requested.

How is ',' less beautiful? When pretty-printing output ',' only occurs
at the end of a line anyway. I don't understand the critique.

>=20
> find myself composing counter-proposal patch, will send soon...
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(logmsg, fi=
lters)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D sel=
f.qmp(cmd, **kwargs)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(json.dumps(result, so=
rt_keys=3DTrue), filters)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(json.dumps(result, in=
dent=3Dindent, separators=3Dseparators,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sort_keys=
=3DTrue), filters)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def run_job(self, job, auto_finalize=3D=
True, auto_dismiss=3DFalse):
>>>
>>
>>
>=20
>=20

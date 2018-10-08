Received: from eggs.gnu.org ([2001:4830:134:3::10]:34319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bgk-0004cg-9A
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bgj-0003aT-Ds
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:59:34 -0400
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
	<d3f8da86-f071-1ce0-462a-0b378f5214a9@redhat.com>
	<de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <54cf31da-009e-c1b7-49f9-7bd5596d2142@redhat.com>
Date: Mon, 8 Oct 2018 15:59:25 -0400
MIME-Version: 1.0
In-Reply-To: <de892465-6f19-defc-c726-6e1bcf2ccbba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v11 07/31] iotests.py: Add
 node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 10/08/2018 03:57 PM, Max Reitz wrote:
> On 08.10.18 21:34, John Snow wrote:
>>
>>
>> On 10/05/2018 07:39 PM, Max Reitz wrote:
>>> This function queries a node; since we cannot do that right now, it
>>> executes query-named-block-nodes and returns the matching node's obje=
ct.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  tests/qemu-iotests/iotests.py | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 5c45788dac..604f200600 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
>>>                  else:
>>>                      iotests.log(ev)
>>> =20
>>> +    def node_info(self, node_name):
>>> +        nodes =3D self.qmp('query-named-block-nodes')
>>> +        for x in nodes['return']:
>>> +            if x['node-name'] =3D=3D node_name:
>>> +                return x
>>> +        return None
>>> +
>>> =20
>>>  index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>>> =20
>>>
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> Do we ever want to revisit the idea that our API should not do any
>> pre-filtering and that it's always up to the client to do so?
>=20
> I mean we certainly want to revisit the idea that we should have a
> proper query API.
>=20
> But what exactly do you mean by pre-filtering?
>=20
> Max
>=20

i.e. applying selection criteria before responding to the query. e.g.,
by looking for matches on node-name.

(Did I use i.e. and e.g. right?)
--js

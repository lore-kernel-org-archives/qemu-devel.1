Received: from eggs.gnu.org ([2001:4830:134:3::10]:43961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWqvu-0002tY-Pm
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gWqvr-0004xj-PC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:55:17 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-4-jsnow@redhat.com>
	<99292902-c7bd-7f1f-0a5d-72894c83dd93@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1c6f42f4-2043-27ae-b3d7-e47551a11667@redhat.com>
Date: Tue, 11 Dec 2018 17:55:02 -0500
MIME-Version: 1.0
In-Reply-To: <99292902-c7bd-7f1f-0a5d-72894c83dd93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove 'x' prefix from
 experimental bitmap APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>



On 12/7/18 11:28 AM, Eric Blake wrote:
> On 12/6/18 1:25 PM, John Snow wrote:
>> The 'x' prefix was added because we were uncertain of the direction we=
'd
>> take for the libvirt API. With the general approach solidified, I feel
>> comfortable committing to this API for 4.0.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>=20
>> +++ b/tests/qemu-iotests/223
>> @@ -112,9 +112,9 @@ _send_qemu_cmd $QEMU_HANDLE
>> '{"execute":"qmp_capabilities"}' "return"
>> =C2=A0 _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
>> =C2=A0=C2=A0=C2=A0 "arguments":{"driver":"qcow2", "node-name":"n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "file":{"driver":"file", "filename":"'"=
$TEST_IMG"'"}}}' "return"
>> -_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable=
",
>> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
>> =C2=A0=C2=A0=C2=A0 "arguments":{"node":"n", "name":"b"}}' "return"
>> -_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable=
",
>> +_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
>> =C2=A0=C2=A0=C2=A0 "arguments":{"node":"n", "name":"b2"}}' "return"
>> =C2=A0 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
>> =C2=A0=C2=A0=C2=A0 "arguments":{"addr":{"type":"unix",
>=20
> No iotests coverage of block-dirty-bitmap-merge.=C2=A0 We should fix th=
at as
> part of this series; separate patch is fine.
>=20

you're not wrong :(

> I'm glad you remembered to renumber all the 'since' tags to 4.0 (as the
> new spelling is indeed new to 4.0, not when we introduced the older x-
> variant).
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks!

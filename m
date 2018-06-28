Received: from eggs.gnu.org ([2001:4830:134:3::10]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbhH-000801-VL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbhH-0001wz-4C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:31:11 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-3-jsnow@redhat.com>
	<c807689d-be3e-d343-925b-112ade12ad57@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1f1306ce-9f39-620e-69dd-c2437e086185@redhat.com>
Date: Thu, 28 Jun 2018 14:31:04 -0400
MIME-Version: 1.0
In-Reply-To: <c807689d-be3e-d343-925b-112ade12ad57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: add 222 to test basic
 fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/28/2018 02:10 PM, Eric Blake wrote:
> On 06/28/2018 01:00 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/222=C2=A0=C2=A0=C2=A0=C2=A0 | 149
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/222.out |=C2=A0 60 ++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 210 insertions(+)
>> =C2=A0 create mode 100644 tests/qemu-iotests/222
>> =C2=A0 create mode 100644 tests/qemu-iotests/222.out
>>
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Cleanup ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 #log(vm.hmp_qemu_io(srcNode, 'flush'))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('block-job-cancel', device=3DsrcNode))
>=20
> Is the commented line still worthwhile to keep?

NUTS.

>=20
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('nbd-server-stop'))
>> +=C2=A0=C2=A0=C2=A0 log(vm.qmp('blockdev-del', node_name=3DtgtNode))
>> +=C2=A0=C2=A0=C2=A0 vm.shutdown()
>> +
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +=C2=A0=C2=A0=C2=A0 log('--- Confirming writes ---')
>> +=C2=A0=C2=A0=C2=A0 log('')
>> +
>> +=C2=A0=C2=A0=C2=A0 for p in (overwrite + remainder):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D "read -P%s %s %s" =
% p
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log(cmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert qemu_io_silent(base=
_img_path, '-c', cmd) =3D=3D 0
>> +
>=20
> Thanks for the additions compared to v1 (including the previously
> missing .out file ;)
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

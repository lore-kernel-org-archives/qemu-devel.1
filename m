Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsTG-0006aD-9h
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsTC-0002zt-3z
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:15:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eLsTB-0002yb-RE
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:15:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4FF9eg033325
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 10:15:43 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2en771x1md-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:15:42 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 08:15:42 -0700
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
	<6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
	<86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
	<cfa46ea3-ab0e-d794-cebe-5a6e9fa9a626@redhat.com>
	<e1da55ab-1975-78aa-ae4d-b2ebd9455fbb@linux.vnet.ibm.com>
	<becc2c1c-732d-dc00-11e1-095c82ac0071@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 13:15:37 -0200
MIME-Version: 1.0
In-Reply-To: <becc2c1c-732d-dc00-11e1-095c82ac0071@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f6f61a7d-5cfc-3457-afc5-06d5b962ed31@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>



On 12/04/2017 01:06 PM, Max Reitz wrote:
> On 2017-12-04 16:01, Daniel Henrique Barboza wrote:
>>
>> On 12/04/2017 12:50 PM, Max Reitz wrote:
>>> On 2017-12-03 21:13, Daniel Henrique Barboza wrote:
>>>> Hi Max,
>>>>
>>>> On 12/01/2017 06:13 PM, Max Reitz wrote:
>>>>> On 2017-11-16 23:35, Daniel Henrique Barboza wrote:
>>>>>> This patch implements a test case for the scenario that was failin=
g
>>>>>> prior to the patch "migration/ram.c: do not set 'postcopy_running'=
 in
>>>>>> POSTCOPY_INCOMING_END".
>>>>>>
>>>>>> This new test file 198 was derived from the test file 181 authored
>>>>>> by Kevin Wolf.
>>>>>>
>>>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>>>> CC: Max Reitz <mreitz@redhat.com>
>>>>>> CC: Cleber Rosa <crosa@redhat.com>
>>>>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.co=
m>
>>>>>>
>>>>>> ---
>>>>>> I CCed Cleber Rosa because this patch was developed at the same
>>>>>> time his patch series "[PATCH 00/10] I/O tests cleanups" hit the
>>>>>> mailing list. Most of the cleanups/fixes he made in the series was
>>>>>> done in this new test as well.
>>>>>>
>>>>>>  =C2=A0 tests/qemu-iotests/198=C2=A0=C2=A0=C2=A0=C2=A0 | 110
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  =C2=A0 tests/qemu-iotests/198.out |=C2=A0 20 +++++++++
>>>>>>  =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>>  =C2=A0 3 files changed, 131 insertions(+)
>>>>>>  =C2=A0 create mode 100755 tests/qemu-iotests/198
>>>>>>  =C2=A0 create mode 100644 tests/qemu-iotests/198.out
>>>>> Looks good overall, just two nitpicks below.
>>>>>
>>>>>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>>>>>> new file mode 100755
>>>>>> index 0000000000..786e37fc95
>>>>>> --- /dev/null
>>>>>> +++ b/tests/qemu-iotests/198
>>>>>> @@ -0,0 +1,110 @@
>>>>>> +#!/bin/bash
>>>>>> +#
>>>>>> +# Test savevm and loadvm after live migration with postcopy flag
>>>>>> +#
>>>>>> +# Copyright (C) 2017, IBM Corporation.
>>>>>> +#
>>>>>> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
>>>>>> +#
>>>>>> +# This program is free software; you can redistribute it and/or
>>>>>> modify
>>>>>> +# it under the terms of the GNU General Public License as
>>>>>> published by
>>>>>> +# the Free Software Foundation; either version 2 of the License, =
or
>>>>>> +# (at your option) any later version.
>>>>>> +#
>>>>>> +# This program is distributed in the hope that it will be useful,
>>>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See =
the
>>>>>> +# GNU General Public License for more details.
>>>>>> +#
>>>>>> +# You should have received a copy of the GNU General Public Licen=
se
>>>>>> +# along with this program.=C2=A0 If not, see
>>>>>> <http://www.gnu.org/licenses/>.
>>>>>> +#
>>>>>> +# Creator/Owner : danielhb@linux.vnet.ibm.com
>>>>>> +
>>>>>> +seq=3D`basename $0`
>>>>>> +echo "QA output created by $seq"
>>>>>> +
>>>>>> +status=3D1=C2=A0=C2=A0=C2=A0 # failure is the default!
>>>>>> +
>>>>>> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
>>>>>> +
>>>>>> +# get standard environment, filters and checks
>>>>>> +. ./common.rc
>>>>>> +. ./common.filter
>>>>>> +. ./common.qemu
>>>>>> +
>>>>>> +_cleanup()
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 rm -f "${MIG_SOCKET}"
>>>>>> +=C2=A0=C2=A0=C2=A0 _cleanup_test_img
>>>>>> +=C2=A0=C2=A0=C2=A0 _cleanup_qemu
>>>>>> +}
>>>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>>> +
>>>>>> +_supported_fmt qcow2
>>>>>> +_supported_proto generic
>>>>>> +_supported_os Linux
>>>>>> +
>>>>>> +size=3D64M
>>>>>> +_make_test_img $size
>>>>>> +
>>>>>> +echo
>>>>>> +echo =3D=3D=3D Starting VMs =3D=3D=3D
>>>>>> +echo
>>>>>> +
>>>>>> +qemu_comm_method=3D"monitor"
>>>>>> +
>>>>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>>>>> +=C2=A0=C2=A0=C2=A0 _launch_qemu \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive "${TEST_IMG}",c=
ache=3D${CACHEMODE},id=3Ddisk
>>>>>> +else
>>>>>> +=C2=A0=C2=A0=C2=A0 _launch_qemu \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive
>>>>>> file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,id=3Ddi=
sk
>>>>>> +fi
>>>>>> +src=3D$QEMU_HANDLE
>>>>>> +
>>>>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>>>>> +=C2=A0=C2=A0=C2=A0 _launch_qemu \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive "${TEST_IMG}",c=
ache=3D${CACHEMODE},id=3Ddisk \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -incoming "unix:${MIG_=
SOCKET}"
>>>>>> +else
>>>>>> +=C2=A0=C2=A0=C2=A0 _launch_qemu \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive
>>>>>> file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,id=3Ddi=
sk \
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -incoming "unix:${MIG_=
SOCKET}"
>>>>>> +fi
>>>>>> +dest=3D$QEMU_HANDLE
>>>>>> +
>>>>>> +echo
>>>>>> +echo =3D=3D=3D Set \'migrate_set_capability postcopy-ram on\' and
>>>>>> migrate =3D=3D=3D
>>>>>> +echo
>>>>>> +
>>>>>> +silent=3Dyes
>>>>>> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on'
>>>>>> "(qemu)"
>>>>>> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qe=
mu)"
>>>>>> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
>>>>>> +
>>>>>> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
>>>>>> +=C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "completed\=
|failed"
>>>>>> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>>>>> Would it make sense to query the migration status non-silently here=
,
>>>>> too, so that the test output would verify that it has actually
>>>>> succeeded?
>>>>>
>>>>> (I suppose the savevm/loadvm coming up next would fail if the migra=
tion
>>>>> failed, but maybe if it's easy enough...)
>>>> Not exactly non-silently, but we can do something like this:
>>>>
>>>>
>>>> echo
>>>> echo =3D=3D=3D Check if migration was successful =3D=3D=3D
>>>> echo
>>>>
>>>> QEMU_COMM_TIMEOUT=3D1 silent=3Dyes \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "comple=
ted"
>>>> silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>>>>
>>>>
>>>> If migration failed, the test will fail with timeout error waiting f=
or
>>>> "completed"
>>>> prior to savevm. What do you think?
>>> Sounds good.=C2=A0 Shouldn't you keep the qemu_cmd_repeat=3D10, thoug=
h?
>> I don't think it's needed. The command prior to it was:
>>
>> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
>> +=C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "completed\|fai=
led"
>> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>>
>>
>> So it's guaranteed that the next 'info migrate' will contain the strin=
g
>> "completed" or "failed".
> Ah, right.  I thought you'd simply replace that by the other.  But
> either way works for me.
Hmmm that's a good approach too I guess. It is shorter, but has the
drawback of, in case of failure, we'll repeat the command 10 times
before failing.

I'll respin the patch with the first approach I had in mind. If anyone
has a good case to use this second approach I can respin it again.


Daniel


>
> Max
>

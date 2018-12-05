Received: from eggs.gnu.org ([2001:4830:134:3::10]:48879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUSTd-00057d-98
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUSTZ-0003ta-Dg
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:24:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUSTZ-0003rA-11
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:24:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB58IqPJ006806
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 03:24:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6apy9bmm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 03:24:04 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Dec 2018 08:24:02 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
	<20181203165810.14509-3-kwolf@redhat.com>
	<dc86835f-65d9-cada-dc9b-1f2c708521f9@de.ibm.com>
	<75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
Date: Wed, 5 Dec 2018 09:23:58 +0100
MIME-Version: 1.0
In-Reply-To: <75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
Content-Language: en-US
Message-Id: <d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 2/2] iotests: simple mirror
 test with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 04.12.2018 14:49, Christian Borntraeger wrote:
> 
> 
> On 04.12.2018 14:46, Christian Borntraeger wrote:
>> FWIW, this testcase fails with current qemu master on s390:
>>
>> QEMU          -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../../s390x-softmmu/qemu-system-s390x" -nodefaults -machine accel=qtest
>> QEMU_IMG      -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../../qemu-img" 
>> QEMU_IO       -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../../qemu-io"  --cache writeback -f qcow2
>> QEMU_NBD      -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../../qemu-nbd" 
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/s390x s38lp08 4.19.0+
>> TEST_DIR      -- /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/scratch
>> SOCKET_SCM_HELPER -- /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/socket_scm_helper
>> 235        
>>  [failed, exit status 1] - output mismatch (see 235.out.bad)
>> --- /home/cborntra/REPOS/qemu/tests/qemu-iotests/235.out	2018-12-04 14:44:27.913714608 +0100
>> +++ /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/235.out.bad	2018-12-04 14:44:51.512958864 +0100
>> @@ -1,3 +1,14 @@
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> +Traceback (most recent call last):
>> +  File "235", line 54, in <module>
>> +    vm.launch()
>> +  File "/home/cborntra/REPOS/qemu/tests/qemu-iotests/../../scripts/qemu.py", line 295, in launch
>> +    self._launch()
>> +  File "/home/cborntra/REPOS/qemu/tests/qemu-iotests/../../scripts/qemu.py", line 321, in _launch
>> +    self._post_launch()
>> +  File "/home/cborntra/REPOS/qemu/tests/qemu-iotests/../../scripts/qemu.py", line 266, in _post_launch
>> +    self._qmp.accept()
>> +  File "/home/cborntra/REPOS/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py", line 155, in accept
>> +    self.__sock, _ = self.__sock.accept()
>> +  File "/usr/lib64/python2.7/socket.py", line 206, in accept
>> +    sock, addr = self._sock.accept()
>> +socket.timeout: timed out
>> On 03.12.2018 17:58, Kevin Wolf wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> This test is broken without previous commit fixing dead-lock in mirror.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/235     | 76 ++++++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/235.out |  3 ++
>>>  tests/qemu-iotests/group   |  1 +
>>>  3 files changed, 80 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/235
>>>  create mode 100644 tests/qemu-iotests/235.out
>>>
>>> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
>>> new file mode 100755
>>> index 0000000000..da044ed34e
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/235
[...]
>>> +# prepare source image
>>> +qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
>>> +                str(size))
>>> +
>>> +vm = QEMUMachine(iotests.qemu_prog)
>>> +vm.add_args('-machine', 'pc,accel=kvm')

This (pc) clearly does not work on other architectures.
In addition to that, I also need to add -no-shutdown on s390 (see 068 for a similar case)

This hack makes it work for me.

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index da044ed34e..05aa641a74 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,8 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
                 str(size))
 
 vm = QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'pc,accel=kvm')
+vm.add_args('-machine', 'accel=kvm')
+vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=src,file=' + disk)
 vm.launch()
 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eigCN-0001zS-WE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eigCN-0000P7-6Y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:48:40 -0500
References: <20180126160411.4033-1-eblake@redhat.com>
	<20180126160411.4033-7-eblake@redhat.com>
	<20180205092443.GB30338@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <01939cdc-8d7d-19d0-4f22-c79d3fd70920@virtuozzo.com>
Date: Mon, 5 Feb 2018 15:48:26 +0300
MIME-Version: 1.0
In-Reply-To: <20180205092443.GB30338@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL 6/8] iotest 205: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

05.02.2018 12:24, Kevin Wolf wrote:
> Am 26.01.2018 um 17:04 hat Eric Blake geschrieben:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Message-Id: <20180119135719.24745-6-vsementsov@virtuozzo.com>
>> [eblake: adjust to next available test number]
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/qemu-iotests/205     | 156 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/205.out |   5 ++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 162 insertions(+)
>>   create mode 100644 tests/qemu-iotests/205
>>   create mode 100644 tests/qemu-iotests/205.out
> This test case fails for luks. Maybe it's easy enough to enable luks, or
> maybe we have to disable it. Not sure how other Python test cases handle
> this. Can you have a look, please?
>
> Kevin

Hmm.

check -luks 205
...
+qemu-img: /work/src/qemu/master/tests/qemu-iotests/scratch/disk: 
Parameter 'key-secret' is required for cipher


I've looked through (grep-ped through) tests, and found only one python 
test with key-secret: 149. And it has own qemu_img_create() function.

On the other hand, all python tests, which have "qemu_img('create'" 
pattern, do not support luks. So, it should be easier to disable luks here.
I'll send a patch.

Also, why check-block do not check luks?

-- 
Best regards,
Vladimir

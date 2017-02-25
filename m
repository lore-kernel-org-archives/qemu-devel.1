Received: from eggs.gnu.org ([2001:4830:134:3::10]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSC1-0005n0-Af
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSBy-000863-9E
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:41 -0500
Received: from [59.151.112.132] (port=48224 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSBx-000856-TM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:38 -0500
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<ce3cc3a0-1bde-fa6b-9b1d-517f8eb8a4d1@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <152e6e84-ac4b-dba5-bd64-cd689e35f2f0@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 10:34:04 +0800
MIME-Version: 1.0
In-Reply-To: <ce3cc3a0-1bde-fa6b-9b1d-517f8eb8a4d1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 0/2] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 02/25/2017 01:24 AM, Eric Blake wrote:
> On 02/24/2017 01:22 AM, Zhang Chen wrote:
>> Xen COLO depend on qemu COLO replication function.
>> So, We need new qmp commands for Xen to use qemu replication.
>>
>> Corresponding libxl patches already in xen.git.
>> Commit ID:
>>
>> ed37ef1f91c20f0ab162ce60f8c38400b917fa64
>> COLO: introduce new API to prepare/start/do/get_error/stop replication
>>
>> a0ddc0b359375b2418213966dfbdbfab593ecc6f
>> tools/libxl: introduction of libxl__qmp_restore to load qemu state
>>
> It's nice to call out what changed between v8 and v9 to focus reviewer's
> attention on those aspects.

OK, I will add the note in next version.

Thanks
Zhang Chen

>
>> Zhang Chen (2):
>>    Add a new qmp command to start/stop replication
>>    Add a new qmp command to do checkpoint, query xen replication status
>>
>>   migration/colo.c | 49 +++++++++++++++++++++++++++++++++++++
>>   qapi-schema.json | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>

-- 
Thanks
Zhang Chen

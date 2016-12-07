Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cERQN-0006ZH-Up
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cERQK-0004j3-T4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:53:36 -0500
Received: from [59.151.112.132] (port=7338 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cERQK-0004i6-G7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:53:32 -0500
References: <1480572399-10455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1612061700330.6598@sstabellini-ThinkPad-X260>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <818226b1-e042-2cb8-40d9-63ba9d4909cc@cn.fujitsu.com>
Date: Wed, 7 Dec 2016 09:53:06 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1612061700330.6598@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, xen-devel@lists.xenproject.org



On 12/07/2016 09:02 AM, Stefano Stabellini wrote:
> Hello Zhang,
>
> Are the corresponding libxl patches already in xen.git? If so, could you
> please mention the commits; if not, could you please add a link to the
> corresponding patches?

OK~~
Corresponding libxl patches already in xen.git.
Commit ID:

ed37ef1f91c20f0ab162ce60f8c38400b917fa64
COLO: introduce new API to prepare/start/do/get_error/stop replication

a0ddc0b359375b2418213966dfbdbfab593ecc6f
tools/libxl: introduction of libxl__qmp_restore to load qemu state

Thanks
Zhang Chen

> Thanks!
>
> - Stefano
>
> On Thu, 1 Dec 2016, Zhang Chen wrote:
>> Xen COLO depend on qemu COLO replication function.
>> So, We need new qmp commands for Xen to use qemu replication.
>>
>> Zhang Chen (3):
>>    Migration: Don't load vmdesc when xen is enabled
>>    Add a new qmp command to start/stop replication
>>    Add a new qmp command to do checkpoint, get replication error
>>
>>   docs/qmp-commands.txt | 41 +++++++++++++++++++++++++++++++++++++++++
>>   migration/colo.c      | 32 ++++++++++++++++++++++++++++++++
>>   migration/savevm.c    |  4 ++++
>>   qapi-schema.json      | 40 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 117 insertions(+)
>>
>> -- 
>> 2.7.4
>>
>>
>>
>>
>
> .
>

-- 
Thanks
zhangchen

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJAGe-0006mE-Dm
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 21:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJAGb-0004aN-Ba
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 21:35:04 -0500
Received: from [59.151.112.132] (port=46268 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJAGa-0004VF-RI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 21:35:01 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<alpine.DEB.2.10.1612191655320.13831@sstabellini-ThinkPad-X260>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b071a109-fccd-5f4a-5bb5-85850aed7ec6@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 10:34:53 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1612191655320.13831@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 0/2] Add new qmp commands to
 suppurt Xen COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 12/20/2016 08:56 AM, Stefano Stabellini wrote:
> I am OK with this, if the relevant maintainers (Migration, QMP) ack the
> patches.

Can you add reviewed-by for this patch set?

Thanks
Zhang Chen

> On Fri, 16 Dec 2016, Zhang Chen wrote:
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
>>
>> Zhang Chen (2):
>>    Add a new qmp command to start/stop replication
>>    Add a new qmp command to do checkpoint, get replication error
>>
>>   docs/qmp-commands.txt | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   migration/colo.c      | 33 +++++++++++++++++++++++++++++++++
>>   qapi-schema.json      | 41 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 116 insertions(+)
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
Zhang Chen

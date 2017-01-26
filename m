Received: from eggs.gnu.org ([2001:4830:134:3::10]:58443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cWaNU-0006K2-MG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cWaNQ-0002xq-GY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:05:36 -0500
Received: from [59.151.112.132] (port=11963 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cWaNP-0002v9-Rv
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:05:32 -0500
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<6a928d63-59c5-a763-0156-40e5958512c5@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <71bda662-8a14-01d4-9db6-ce96640dfee9@cn.fujitsu.com>
Date: Thu, 26 Jan 2017 11:04:47 +0800
MIME-Version: 1.0
In-Reply-To: <6a928d63-59c5-a763-0156-40e5958512c5@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 0/2] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Hi~

No news for a week.

We need comments ~~

Ping...


Thanks

Zhang Chen


On 01/19/2017 05:57 PM, Zhang Chen wrote:
> Hi~~
>
> Anyone have any comments?
>
> Ping....
>
>
> Thanks
>
> Zhang Chen
>
>
> On 01/05/2017 02:08 PM, Zhang Chen wrote:
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
>>    Add a new qmp command to do checkpoint, query xen replication status
>>
>>   docs/qmp-commands.txt | 42 +++++++++++++++++++++++++++++++
>>   migration/colo.c      | 40 +++++++++++++++++++++++++++++
>>   qapi-schema.json      | 69 
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 151 insertions(+)
>>
>

-- 
Thanks
Zhang Chen

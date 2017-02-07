Received: from eggs.gnu.org ([2001:4830:134:3::10]:43931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cav5w-0004Zu-KS
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cav5s-0005aj-Kl
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:01:24 -0500
Received: from [59.151.112.132] (port=60031 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cav5s-0005a1-7b
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:01:20 -0500
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<6a928d63-59c5-a763-0156-40e5958512c5@cn.fujitsu.com>
	<71bda662-8a14-01d4-9db6-ce96640dfee9@cn.fujitsu.com>
	<61ae330c-b431-fff3-dd58-ba24b081dc60@redhat.com>
	<20170206131352.GD2524@work-vm>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <999a7054-4229-661d-502d-9d3e79f3d197@cn.fujitsu.com>
Date: Tue, 7 Feb 2017 10:01:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170206131352.GD2524@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>, "eddie . dong" <eddie.dong@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>

Hi~ Eric.

If you have time, please give me some comments.

This series has been sent for a long time.


Thanks

Zhang Chen


On 02/06/2017 09:13 PM, Dr. David Alan Gilbert wrote:
> * Jason Wang (jasowang@redhat.com) wrote:
>>
>> On 2017年01月26日 11:04, Zhang Chen wrote:
>>> Hi~
>>>
>>> No news for a week.
>>>
>>> We need comments ~~
>>>
>>> Ping...
>>>
>> Cc David who is one of the maintainer of migration.
> My difficulty is I don't know any Xen and I don't understand
> the block replication code much either; so I hadn't really looked at it.
>
> Dave
>
>>> Thanks
>>>
>>> Zhang Chen
>>>
>>>
>>> On 01/19/2017 05:57 PM, Zhang Chen wrote:
>>>> Hi~~
>>>>
>>>> Anyone have any comments?
>>>>
>>>> Ping....
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Zhang Chen
>>>>
>>>>
>>>> On 01/05/2017 02:08 PM, Zhang Chen wrote:
>>>>> Xen COLO depend on qemu COLO replication function.
>>>>> So, We need new qmp commands for Xen to use qemu replication.
>>>>>
>>>>> Corresponding libxl patches already in xen.git.
>>>>> Commit ID:
>>>>>
>>>>> ed37ef1f91c20f0ab162ce60f8c38400b917fa64
>>>>> COLO: introduce new API to prepare/start/do/get_error/stop replication
>>>>>
>>>>> a0ddc0b359375b2418213966dfbdbfab593ecc6f
>>>>> tools/libxl: introduction of libxl__qmp_restore to load qemu state
>>>>>
>>>>>
>>>>> Zhang Chen (2):
>>>>>     Add a new qmp command to start/stop replication
>>>>>     Add a new qmp command to do checkpoint, query xen replication status
>>>>>
>>>>>    docs/qmp-commands.txt | 42 +++++++++++++++++++++++++++++++
>>>>>    migration/colo.c      | 40 +++++++++++++++++++++++++++++
>>>>>    qapi-schema.json      | 69
>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 151 insertions(+)
>>>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
> .
>

-- 
Thanks
Zhang Chen

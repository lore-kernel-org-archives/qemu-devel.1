Received: from eggs.gnu.org ([2001:4830:134:3::10]:49815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbHu7-0003bX-V1
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbHu4-0008Na-OR
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:22:43 -0500
Received: from [59.151.112.132] (port=59789 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbHu4-0008L2-Cd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:22:40 -0500
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1483596532-14552-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7fd43c21-f16c-e9ef-7a3b-90b4e2949eed@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e7a9073c-f91a-8952-fdbe-85ad81046215@cn.fujitsu.com>
Date: Wed, 8 Feb 2017 10:22:10 +0800
MIME-Version: 1.0
In-Reply-To: <7fd43c21-f16c-e9ef-7a3b-90b4e2949eed@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>



On 02/07/2017 11:50 PM, Eric Blake wrote:
> On 01/05/2017 12:08 AM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
> This file no longer exists since commit 4d8bb958; can you please rebase
> this and post a v7? (The docs now live directly in the qapi-schema.json
> file).

OK, I will send a V7.

>>   migration/colo.c      | 17 +++++++++++++++++
>>   qapi-schema.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 91 insertions(+)
> It looks like you have addressed all my concerns from earlier versions,
> though, so the API seems reasonable.


Thanks
Zhang Chen

>

-- 
Thanks
Zhang Chen

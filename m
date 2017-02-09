Received: from eggs.gnu.org ([2001:4830:134:3::10]:39670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbe5Z-0004l8-Bz
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbe5V-0002TN-Jw
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:04:01 -0500
Received: from [59.151.112.132] (port=43618 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cbe5V-0002TD-7d
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:03:57 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e42cc2e8-18bb-1a4e-bf47-266773b6c35c@cn.fujitsu.com>
Date: Thu, 9 Feb 2017 10:03:43 +0800
MIME-Version: 1.0
In-Reply-To: <9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
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
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>



On 02/09/2017 05:35 AM, Eric Blake wrote:
> On 02/07/2017 11:24 PM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   migration/colo.c | 17 ++++++++++++++++
>>   qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 77 insertions(+)
>>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thank you for your review.
By the way, who can pick up this patch? You or Jason?

Thanks
Zhang Chen



-- 
Thanks
Zhang Chen

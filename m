Received: from eggs.gnu.org ([2001:4830:134:3::10]:33687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1eDLj6-0001TJ-Re
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 21:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1eDLj3-0002vY-Nj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 21:40:56 -0500
References: <1508564040-120700-1-git-send-email-lizhengui@huawei.com>
	<20171110153345.GB17290@stefanha-x1.localdomain>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <70de4562-2fa0-7371-4858-b1b8fb3fcd65@huawei.com>
Date: Sat, 11 Nov 2017 10:37:47 +0800
MIME-Version: 1.0
In-Reply-To: <20171110153345.GB17290@stefanha-x1.localdomain>
Content-Type: multipart/mixed; boundary="------------0ADFC56B1745250AC4CE27DF"
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: all I/O should be
 completed before removing throttle timers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lina.lulina@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com, sochin.jiang@huawei.com

--------------0ADFC56B1745250AC4CE27DF
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

ok，thanks ！


On 2017/11/10 23:33, Stefan Hajnoczi wrote:
> On Sat, Oct 21, 2017 at 01:34:00PM +0800, Zhengui Li wrote:
>> From: Zhengui <lizhengui@huawei.com>
>>
>> In blk_remove_bs, all I/O should be completed before removing throttle
>> timers. If there has inflight I/O, removing throttle timers here will
>> cause the inflight I/O never return.
>> This patch add bdrv_drained_begin before throttle_timers_detach_aio_context
>> to let all I/O completed before removing throttle timers.
>>
>> Signed-off-by: Zhengui <lizhengui@huawei.com>
>> ---
>>   block/block-backend.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> Hi Zhengui,
> Sorry it took so long to get thism merged!
>
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
>
> I moved the declaration of bs as suggested by Berto when I merged the
> patch.
>
> Stefan


--------------0ADFC56B1745250AC4CE27DF
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------0ADFC56B1745250AC4CE27DF--

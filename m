Received: from eggs.gnu.org ([2001:4830:134:3::10]:44738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d944h-0000VB-5p
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d944g-0001hy-3Q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:29:15 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170511190808.GA24584@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <59155619.2090404@huawei.com>
Date: Fri, 12 May 2017 14:28:41 +0800
MIME-Version: 1.0
In-Reply-To: <20170511190808.GA24584@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 2/6] replication: add
 shared-disk and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org

On 2017/5/12 3:08, Stefan Hajnoczi wrote:
> On Wed, Apr 12, 2017 at 10:05:17PM +0800, zhanghailiang wrote:
>> We use these two options to identify which disk is
>> shared
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>> v4:
>> - Add proper comment for primary_disk (Stefan)
>> v2:
>> - Move g_free(s->shared_disk_id) to the common fail process place (Stefan)
>> - Fix comments for these two options
>> ---
>>   block/replication.c  | 43 +++++++++++++++++++++++++++++++++++++++++--
>>   qapi/block-core.json | 10 +++++++++-
>>   2 files changed, 50 insertions(+), 3 deletions(-)
> Aside from the ongoing discussion about this patch...
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,  I'll fix the related problems found by changlong.

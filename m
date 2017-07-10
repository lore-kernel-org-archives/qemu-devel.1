Received: from eggs.gnu.org ([2001:4830:134:3::10]:36872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dUZjD-0000p5-Ok
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dUZj9-0007dM-St
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:31:59 -0400
References: <20170710083553.6167-1-den@openvz.org>
	<20170710135902.GL5772@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <72c41883-a0bb-29c8-fac9-41069435597f@openvz.org>
Date: Mon, 10 Jul 2017 17:31:22 +0300
MIME-Version: 1.0
In-Reply-To: <20170710135902.GL5772@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/1] block: fix possible
 return code clobbering in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 07/10/2017 04:59 PM, Kevin Wolf wrote:
> Am 10.07.2017 um 10:35 hat Denis V. Lunev geschrieben:
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
>> CC: Fam Zheng <famz@redhat.com> (supporter:Block I/O path)
>> ---
>>  block/io.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index ed31810c0a..e5c6dc77d3 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2464,7 +2464,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
>>      assert(max_pdiscard >= bs->bl.request_alignment);
>>  
>>      while (count > 0) {
>> -        int ret;
>>          int num = count;
>>  
>>          if (head) {
> Good catch, and the fix looks fine.
>
> This needs rebasing, though (conflicts with commit f5a5ca7 'block:
> change variable names in BlockDriverState').
>
> Kevin
ok, will re-spin.

Den

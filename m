Received: from eggs.gnu.org ([2001:4830:134:3::10]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fcUAi-0008Ba-8F
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fcUAf-0003OE-1B
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:17:36 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:52896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1fcUAe-0003NF-QB
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 07:17:32 -0400
References: <1530879678-20487-1-git-send-email-ari@tuxera.com>
	<87lgakopio.fsf@dusky.pond.sub.org>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <fcebd6aa-6346-35d8-cedf-71f5677033e7@tuxera.com>
Date: Mon, 9 Jul 2018 14:17:27 +0300
MIME-Version: 1.0
In-Reply-To: <87lgakopio.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/09/2018 10:07 AM, Markus Armbruster wrote:
> Ari Sundholm <ari@tuxera.com> writes:
> 
>> This was accidentally omitted. Thanks to Eric Blake for spotting this.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>>   qapi/block-core.json | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 38b3125..62a92fa 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3057,6 +3057,8 @@
>>   # @log-sector-size: sector size used in logging writes to @file, determines
>>   #                   granularity of offsets and sizes of writes (default: 512)
>>   #
>> +# @log-append:      append to an existing log (default: false)
>> +#
>>   # @log-super-update-interval: interval of write requests after which the log
>>   #                             super block is updated to disk (default: 4096)
>>   #
> 
> Applied to qapi-next.  Thanks!
> 

Thanks. Does this mean that the patch be queued for 3.0 or should I take 
some additional steps to ensure this?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egDKX-0000bg-PT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egDKW-000789-RZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:34:53 -0500
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-2-jsnow@redhat.com>
	<20180129165929.GK6141@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <e20c83f9-4ccb-63ca-2f12-4182d3564589@redhat.com>
Date: Mon, 29 Jan 2018 12:34:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180129165929.GK6141@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 01/14] blockjobs: add manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 01/29/2018 11:59 AM, Kevin Wolf wrote:
> Am 27.01.2018 um 03:05 hat John Snow geschrieben:
>> This property will be used to opt-in to the new BlockJobs workflow
>> that allows a tighter, more explicit control over transitions from
>> one runstate to another.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
>> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
>> index 00403d9482..b94d0c9fa6 100644
>> --- a/include/block/blockjob.h
>> +++ b/include/block/blockjob.h
>> @@ -141,6 +141,11 @@ typedef struct BlockJob {
>>       */
>>      QEMUTimer sleep_timer;
>>  
>> +    /* Set to true when management API has requested 2.12+ job lifetime
>> +     * management semantics.
>> +     */
>> +    bool manual;
> 
> Wouldn't it make more sense to describe what "2.12+ job lifetime
> management semantics" actually are? Maybe then it would be easy to find
> a more specific name, too, like manual_completion.
> 

Sure. At the time I wrote it, I wasn't sure what they were. Maybe I'll
find out after the review; but I'll make a note to document it here.

> In fact, I wonder if the opposite flag wouldn't be nicer, i.e. having a
> bool auto_completion (or finalization or whatever that extra step was
> called in the final draft), defaulting to true.
> 

I could do that, if you feel it'd be more readable. In terms of style I
tend to prefer new additions default to false as that feels more
permanently reliable, but it's only a preference.

> Also, the comment style in this header is already pretty messed up, but
> I think the styles that were originally meant to be used there, are
> 
>     /** this one for single lines */
> 
>     /**
>      * and this one if things get a bit longer
>      * and you need multiple lines.
>      */
> 
> Kevin
> 

I can do a fixup and make 'em consistent.

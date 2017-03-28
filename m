Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csort-0002oo-Vg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csorq-0007DC-1H
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csorp-0007CW-SD
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B64C481235
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 11:00:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170327075450.GD11497@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 27 Mar 2017 15:54:50 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-7-quintela@redhat.com>
	<20170327075450.GD11497@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 13:00:45 +0200
Message-ID: <87shlxr7he.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/51] ram: Move start time into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:44:59PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  migration/ram.c | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f811e81..5881805 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -154,6 +154,9 @@ struct RAMState {
>>      int dirty_rate_high_cnt;
>>      /* How many times we have synchronized the bitmap */
>>      uint64_t bitmap_sync_count;
>> +    /* this variables are used for bitmap sync */
>
> s/this/These/?
>
>> +    /* last time we did a full bitmap_sync */
>> +    int64_t start_time;
>
> Not sure whether it'll be a good chance we rename this variable in
> this patch to make it a less-generic name, like: bm_sync_start? But
> again, this is nicpicking and totally optional.

I changed it to time_last_bitmap_sync.

Thanks, Juan.


>
> With the typo fixed, please add:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Thanks,
>
> -- peterx

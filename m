Received: from eggs.gnu.org ([2001:4830:134:3::10]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cv8ll-0005PH-VJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cv8ll-0001pu-36
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cv8lk-0001oU-Sy
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE72A64DB2
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 20:40:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170331144338.GK4514@work-vm> (David Alan Gilbert's message of
	"Fri, 31 Mar 2017 15:43:38 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-2-quintela@redhat.com>
	<20170324095517.GC17755@pxdev.xzpeter.org>
	<20170331144338.GK4514@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 03 Apr 2017 22:40:01 +0200
Message-ID: <87h9255iou.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/51] ram: Update all functions comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> Hi, Juan,
>> 
>> Got several nitpicks below... (along with some questions)
>> 
>> On Thu, Mar 23, 2017 at 09:44:54PM +0100, Juan Quintela wrote:
>> 
>> [...]
>
>> > @@ -1157,11 +1186,12 @@ static bool get_queued_page(MigrationState
>> > *ms, PageSearchStatus *pss,
>> >  }
>> >  
>> >  /**
>> > - * flush_page_queue: Flush any remaining pages in the ram request queue
>> > - *    it should be empty at the end anyway, but in error cases there may be
>> > - *    some left.
>> > + * flush_page_queue: flush any remaining pages in the ram request queue
>> 
>> Here the comment says (just like mentioned in function name) that we
>> will "flush any remaining pages in the ram request queue", however in
>> the implementation, we should be only freeing everything in
>> src_page_requests. The problem is "flush" let me think about "flushing
>> the rest of the pages to the other side"... while it's not.
>> 
>> Would it be nice we just rename the function into something else, like
>> migration_page_queue_free()? We can tune the comments correspondingly
>> as well.
>
> Yes that probably would be a better name.

done
>> > - * Allocate data structures etc needed by incoming migration with postcopy-ram
>> > - * postcopy-ram's similarly names postcopy_ram_incoming_init does the work
>> > +/**
>> > + * ram_postococpy_incoming_init: allocate postcopy data structures
>> > + *
>> > + * Returns 0 for success and negative if there was one error
>> > + *
>> > + * @mis: current migration incoming state
>> > + *
>> > + * Allocate data structures etc needed by incoming migration with
>> > + * postcopy-ram postcopy-ram's similarly names
>> > + * postcopy_ram_incoming_init does the work
>> 
>> This sentence is slightly hard to understand... But I think the
>> function name explained itself enough though. :)
>
> A '.' after the first 'postcopy-ram' would make it more readable.
>
> Dave

Done.  Once there, I spelled postcopy correctly O:-)

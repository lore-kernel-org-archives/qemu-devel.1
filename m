Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Ydt-0005gZ-A1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Ydp-0004oH-CQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Ydp-0004oB-5s
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 071392E6046
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:18:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170407102609.GG2138@work-vm> (David Alan Gilbert's message of
	"Fri, 7 Apr 2017 11:26:10 +0100")
References: <20170406130913.2232-1-quintela@redhat.com>
	<20170406130913.2232-49-quintela@redhat.com>
	<20170407102609.GG2138@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 21:18:18 +0200
Message-ID: <87wpahh6dh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 48/54] ram: Use page number instead of an
 address for the bitmap operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We use an unsigned long for the page number.  Notice that our bitmaps
>> already got that for the index, so we have that limit.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> see below....
>> index 7372ce2..9514044 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -63,8 +63,8 @@ put_qtailq_end(const char *name, const char *reason) "%s %s"
>>  qemu_file_fclose(void) ""
>>  
>>  # migration/ram.c
>> -get_queued_page(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr) "%s/%" PRIx64 " ram_addr=%" PRIx64
>> -get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, uint64_t ram_addr, int sent) "%s/%" PRIx64 " ram_addr=%" PRIx64 " (sent=%d)"
>> +get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/%" PRIx64 " page_abs=%lu"
>> +get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/%" PRIx64 " page_abs=%lu (sent=%d)"
>
> Yes, but if you respin, please make those %lx rather than %lu.

Done.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

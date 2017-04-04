Received: from eggs.gnu.org ([2001:4830:134:3::10]:40735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvS0S-0000Fs-K2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvS0P-000216-8o
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:12:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvS0P-00020p-30
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:12:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53A623D97C
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 17:12:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170331155155.GO4514@work-vm> (David Alan Gilbert's message of
	"Fri, 31 Mar 2017 16:51:56 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-2-quintela@redhat.com>
	<20170331155155.GO4514@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 04 Apr 2017 19:12:27 +0200
Message-ID: <87zifw3xms.fsf@secure.mitica>
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
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Added doc comments for existing functions comment and rewrite them in
>> a common style.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 348 ++++++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 227 insertions(+), 121 deletions(-)
>> 

>>   *
>>   * If this is the 1st block, it also writes the block identification
>>   *
>> - * Returns: Number of bytes written
>> + * Returns the number of bytes written
>
> Do the doc tools recognise that to pick up the explanation
> for the return value?

No clue.  Following qemu/include/exec/memory.h

>> @@ -459,8 +474,8 @@ static void xbzrle_cache_zero_page(ram_addr_t current_addr)
>>   *          -1 means that xbzrle would be longer than normal
>>   *
>>   * @f: QEMUFile where to send the data
>> - * @current_data:
>> - * @current_addr:
>> + * @current_data: contents of the page
>
> That's wrong.  The point of current_data is that it gets updated by this
> function to point to the cache page whenever the data ends up in the cache.
> It's important then that the caller uses that pointer to save the data to
> disk/network rather than the original pointer, since the data that's saved
> must exactly match the cache contents even if the guest is still writing to it.

this is the current text:

* @current_data: pointer to the address of the page contents

This was Peter suggestion.

Rest of suggestions included. 

Thanks, Juan.

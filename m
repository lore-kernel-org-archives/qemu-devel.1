Received: from eggs.gnu.org ([2001:4830:134:3::10]:59895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq369-0008Nq-9E
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq365-0006Yl-BQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cq365-0006Xe-4o
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A2897FD46
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:36:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170316120920.GA2567@work-vm> (David Alan Gilbert's message of
	"Thu, 16 Mar 2017 12:09:22 +0000")
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-2-quintela@redhat.com>
	<20170316120920.GA2567@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 20:36:00 +0100
Message-ID: <87fui7aggv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/31] ram: move more fields into RAMState
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
>> last_seen_block, last_sent_block, last_offset, last_version and
>> ram_bulk_stage are globals that are really related together.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 136 ++++++++++++++++++++++++++++++++------------------------
>>  1 file changed, 79 insertions(+), 57 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 719425b..c20a539 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -136,6 +136,23 @@ out:
>>      return ret;
>>  }
>>  
>> +/* State of RAM for migration */
>> +struct RAMState {
>> +    /* Last block that we have visited searching for dirty pages */
>> +    RAMBlock    *last_seen_block;
>> +    /* Last block from where we have sent data */
>> +    RAMBlock *last_sent_block;
>> +    /* Last offeset we have sent data from */
>                   ^
>                   One extra e
>
> Other than that (and the minor formatting things the bot found)

fixed, thanks.

>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

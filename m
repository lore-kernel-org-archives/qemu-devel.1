Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cY8rH-0007KF-UQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cY8rE-0005gd-Pz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cY8rE-0005ev-KC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:06:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FFFD4E048
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 10:06:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170127180255.GI3323@work-vm> (David Alan Gilbert's message of
	"Fri, 27 Jan 2017 18:02:56 +0000")
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-11-git-send-email-quintela@redhat.com>
	<20170127180255.GI3323@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jan 2017 11:06:30 +0100
Message-ID: <87r33k276h.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/17] migration: create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> The function still don't use multifd, but we have simplified
>> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
>> counter and a new flag for this type of pages.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -61,6 +61,7 @@ static uint64_t bitmap_sync_count;
>>  #define RAM_SAVE_FLAG_XBZRLE   0x40
>>  /* 0x80 is reserved in migration.h start with 0x100 next */
>>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
>> +#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
>
> I think a similar reminder from the last iteration of this patch;
> I think we're out of bits here - I'm not sure if 0x200 is even
> available.

In previous iteration, I used *two* bits.  As per your recomendation, I
"reused" and old one for doing the synchronization.


Later, Juan.

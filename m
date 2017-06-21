Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNdsm-0006Gj-Ch
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNdsj-0002vQ-9t
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNdsj-0002v4-4K
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EFFF7EBD6
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 11:33:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170616180058.GE19805@work-vm> (David Alan Gilbert's message of
	"Fri, 16 Jun 2017 19:00:58 +0100")
References: <20170613095338.11560-1-quintela@redhat.com>
	<20170613095338.11560-5-quintela@redhat.com>
	<20170616180058.GE19805@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 13:33:01 +0200
Message-ID: <87y3slk236.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/5] migration: Convert ram to use new
 load_setup()/load_cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Once there, I rename ram_migration_cleanup() to ram_save_cleanup().
>> Notice that this is the first pass, and I only passed XBZRLE to the
>> new scheme.  Moved decoded_buf to inside XBZRLE struct.
>> As a bonus, I don't have to export xbzrle functions from ram.c.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>>      }
>>      /* load data and decode */
>> -    qemu_get_buffer_in_place(f, &loaded_data, xh_len);
>> +    qemu_get_buffer_in_place(f, &XBZRLE.decoded_buf, xh_len);
>
> No !  Note the & - loaded_data can get changed at that point to
> point to an internal buffer rather than using that temporary.
>
> So you still need the loaded_data and use that in the rest of
> this function.

You are right.

I hate that nuances.

Thanks for the review.

Later, Juan.

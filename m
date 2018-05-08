Received: from eggs.gnu.org ([2001:4830:134:3::10]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG4JP-0005LO-6w
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG4JL-0007Hg-8u
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:13:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fG4JL-0007H9-4W
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FE4F4182D59
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 15:13:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180503173154.GL2660@work-vm> (David Alan Gilbert's message of
	"Thu, 3 May 2018 18:31:55 +0100")
References: <20180425111940.1030-1-quintela@redhat.com>
	<20180425111940.1030-4-quintela@redhat.com>
	<20180503173154.GL2660@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 17:16:06 +0200
Message-ID: <87sh726uvd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 3/8] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>

>> +
>> +    migrate_set_parameter(from, "xbzrle-cache-size", "33554432");
>
> I still worry about the cache size relative to the size of memory we're
> actually changing in the test; I don't quite understand why it's turning
> out to get lots of hits.

I planned this as a smorke test.  But what value do you have in mind?

> Also, xbzrle eats so much CPU we'll still have to watch out for the low
> end CPUs.

Any concrete suggestion?

My plan would have been to push on my next pull request:

Add migration precopy test
Add migration xbzrle test
Migration ppc now inlines its program

And put the rest of the patches with fixes for another review.


Later, Juan.

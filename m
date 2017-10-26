Received: from eggs.gnu.org ([2001:4830:134:3::10]:38113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cG2-0002v0-GW
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cFz-0002pq-Cr
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7cFz-0002pK-6P
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97EFE7D0E0
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:07:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171025172835.GD2484@work-vm> (David Alan Gilbert's message of
	"Wed, 25 Oct 2017 18:28:36 +0100")
References: <20171025054842.24883-1-quintela@redhat.com>
	<20171025054842.24883-4-quintela@redhat.com>
	<20171025172835.GD2484@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 26 Oct 2017 09:07:03 +0200
Message-ID: <87mv4emlpk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/5] migration: No need to return the
 size of the cache
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
>> After the previous commits, we make sure that the value passed is
>> right, or we just drop an error.  So now we return if there is one
>> error or we have setup correctly the value passed.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

> OK, this shares the same oddity as the original which is
>   XBZRLE.cache = NULL    is not an error.
>
> but, since that is the same as the original;

Hi

It is a normal case.  You can change the cache size in the middle of
migration or outside migration.

If we are not in the middle of migration, cache is NULL.

Later, Juan.

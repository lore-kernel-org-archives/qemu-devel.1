Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csvvD-0002ym-58
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csvvA-0007MR-3h
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csvv9-0007Lz-Tq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8650254A
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 18:32:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170326134331.GH17755@pxdev.xzpeter.org> (Peter Xu's message of
	"Sun, 26 Mar 2017 21:43:31 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-2-quintela@redhat.com>
	<20170324095517.GC17755@pxdev.xzpeter.org>
	<87mvca7vcp.fsf@secure.mitica>
	<20170326134331.GH17755@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 20:32:39 +0200
Message-ID: <87bmslqmk8.fsf@secure.mitica>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Mar 24, 2017 at 12:44:06PM +0100, Juan Quintela wrote:

>> >
>> > Here the comment says (just like mentioned in function name) that we
>> > will "flush any remaining pages in the ram request queue", however in
>> > the implementation, we should be only freeing everything in
>> > src_page_requests. The problem is "flush" let me think about "flushing
>> > the rest of the pages to the other side"... while it's not.
>> >
>> > Would it be nice we just rename the function into something else, like
>> > migration_page_queue_free()? We can tune the comments correspondingly
>> > as well.
>> 
>> I will let this one to dave to answer O:-)
>> I agree than previous name is not perfect, but not sure that the new one
>> is mucth better either.
>> 
>> migration_drop_page_queue()?
>
> This is indeed a nitpick of mine... So please feel free to ignore it.
> :)
>
> But if we will keep the function name, I would slightly prefer that at
> least we mention in the comment that, this is only freeing things up,
> not sending anything out.

Added that to the comment.

Thanks, Juan.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYHWo-0004pA-HD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYHWg-0007a2-T9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYHWg-0007Zp-NG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 14:22:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E207380476
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 19:22:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170130163622.GF2450@work-vm> (David Alan Gilbert's message of
	"Mon, 30 Jan 2017 16:36:23 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-7-dgilbert@redhat.com>
	<87inp378bb.fsf@emacs.mitica> <20170130163622.GF2450@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jan 2017 20:22:03 +0100
Message-ID: <87wpdccq04.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/15] postcopy: Record largest page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > Record the largest page size in use; we'll need it soon for allocating
>> > temporary buffers.
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> Not that I object, but .... could we store this in ram_list, and update it
>> it at RAMBlock creation time?  Why searh for the value later when we can
>> store it from the beggining.  Instead of putting it on migration_state,
>> put it on the ram_list itself?
>> 
>
> We could, but the code does get quite a bit more complicated for little gain,
> given that we currently read it exactly once.
> The update at creation time would be easier, but then you have to also
> update at deletion time and that has to run along the list just like this.
> (or cache based on the ram_list.version)

As I am so lazy, I would only update it at creation time, and never at
deletion time.  But I can see that some people could object.  Anyways it
don't matter a lot, it is used only once, and on the other hand, we
don't care a lot if we have a bit bigger than needed buffer.  Just a
case of taste I guess.

Later, Juan.

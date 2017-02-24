Received: from eggs.gnu.org ([2001:4830:134:3::10]:51988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFi9-0000Aa-6Q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1chFi7-0001r2-4b
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:15:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1chFi6-0001pt-VA
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:14:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3269A80484
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 13:14:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170206173306.20603-5-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 6 Feb 2017 17:32:54 +0000")
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-5-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 24 Feb 2017 14:14:49 +0100
Message-ID: <87tw7jk9x2.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 04/16] exec: ram_block_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Create ram_block_discard_range in exec.c to replace
> postcopy_ram_discard_range and most of ram_discard_range.
>
> Those two routines are a bit of a weird combination, and
> ram_discard_range is about to get more complex for hugepages.
> It's OS dependent code (so shouldn't be in migration/ram.c) but
> it needs quite a bit of the innards of RAMBlock so doesn't belong in
> the os*.c.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB4dK-0005tk-3s
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB4dG-0006h7-68
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB4dF-0006gt-Vi
	for qemu-devel@nongnu.org; Wed, 17 May 2017 15:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75DF1C057FA4
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 19:29:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170517165810.18164-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 17 May 2017 17:58:10 +0100")
References: <20170517165810.18164-1-dgilbert@redhat.com>
	<20170517165810.18164-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 21:29:09 +0200
Message-ID: <87bmqrb7ui.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] postcopy: Require RAMBlocks that are
 whole pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, lvivier@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> It turns out that it's legal to create a VM with RAMBlocks that aren't
> a multiple of the pagesize in use; e.g. a 1025M main memory using
> 2M host pages.  That breaks postcopy's atomic placement of pages,
> so disallow it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


>      }
>  
>      /* We don't support postcopy with shared RAM yet */
> -    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
> +    if (qemu_ram_foreach_block(test_ramblock_postcopiable, NULL)) {

When I was looking at this code, I still don't know why
qemu_ram_foreach_block() don't pass the block directly.  It needs it
almost all callers.

When I saw it I was about to change it, but got sidetracked on other
things :-p

Later, Juan.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6J7-0008Fh-L0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6J3-0008HE-KE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:00:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY6J3-0008GI-EY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:00:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 939AC8182D18
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:00:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180620152241.15772-1-david@redhat.com> (David Hildenbrand's
	message of "Wed, 20 Jun 2018 17:22:41 +0200")
References: <20180620152241.15772-1-david@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 11:03:31 +0200
Message-ID: <8736x8mwik.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1] postcopy: drop ram_pages parameter from
 postcopy_ram_incoming_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

David Hildenbrand <david@redhat.com> wrote:
> Not needed. Don't expose last_ram_page().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/exec/ram_addr.h  | 1 -
>  migration/postcopy-ram.c | 4 ++--
>  migration/postcopy-ram.h | 2 +-
>  migration/ram.c          | 4 +---
>  4 files changed, 4 insertions(+), 7 deletions(-)

You are missing:

static unsigned long last_ram_page(void)

on exec.c to fix compilation with -werror.

Once that is fixed:

Reviewed-by: Juan Quintela <quintela@redhat.com>

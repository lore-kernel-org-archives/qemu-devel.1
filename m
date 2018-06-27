Received: from eggs.gnu.org ([2001:4830:134:3::10]:42925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6K9-0000Ls-9o
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY6K3-0000d4-TE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:01:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY6K3-0000cx-Ov
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E2BE857AB
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:01:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180620202736.21399-1-david@redhat.com> (David Hildenbrand's
	message of "Wed, 20 Jun 2018 22:27:36 +0200")
References: <20180620202736.21399-1-david@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 11:04:35 +0200
Message-ID: <87y3f0lhwc.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] postcopy: drop ram_pages parameter from
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
>
> v1 -> v2:
> - Make "last_ram_page" static

And there was already an v2 of the patch ...
Reviewed-by: Juan Quintela <quintela@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3th-0004rB-5N
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3tb-0003tr-Lr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:02:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb3tb-0003t2-Hv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:02:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CA7E87928
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:02:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705031755.3254-4-peterx@redhat.com> (Peter Xu's message of
	"Thu, 5 Jul 2018 11:17:49 +0800")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-4-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:01:55 +0200
Message-ID: <87wou925vg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 3/9] migration: fix incorrect
 bitmap size calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The calculation on size of received bitmap is incorrect for postcopy
> recovery.  Here we wanted to let the size to cover all the valid bits in
> the bitmap, we should use DIV_ROUND_UP() instead of a division.
>
> For example, a RAMBlock with size=4K (which contains only one single 4K
> page) will have nbits=1, then nbits/8=0, then the real bitmap won't be
> sent to source at all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

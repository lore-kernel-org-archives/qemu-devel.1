Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi05L-0003IA-Iv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi05I-0003UI-CX
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:22:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi05I-0003TR-54
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:22:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C87A81A4EBF
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 16:22:47 +0000 (UTC)
Date: Tue, 24 Jul 2018 17:22:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724162242.GE48553@work-vm>
References: <20180723123305.24792-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723123305.24792-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/4] migration: some fixes for
 release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> The release-ram feature is broken.  Fix it up.  Meanwhile disable
> postcopy recovery when release-ram is enabled, since they cannot work
> together.  Please see the comments for more information.
> 
> This patchset is for 3.0.
> 
> Please review, thanks.

Queued 1-3 for 3.0;  I'd like to check 4 on a few architectures
when we've got a bit more time.

Dave

> Peter Xu (4):
>   migration: update recv bitmap only on dest vm
>   migration: disallow recovery for release-ram
>   tests: only update last_byte when at the edge
>   tests: torture release-ram in postcopy test
> 
>  migration/migration.c  | 19 +++++++++++++++++++
>  migration/ram.c        | 11 +++++++++--
>  tests/migration-test.c | 16 +++++++++++-----
>  3 files changed, 39 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

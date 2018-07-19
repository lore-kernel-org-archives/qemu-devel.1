Received: from eggs.gnu.org ([2001:4830:134:3::10]:53971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg5He-00068X-26
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fg5Ha-0000AR-T1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:31:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fg5Ha-0000AI-O1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55295400E9A3
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:31:34 +0000 (UTC)
Date: Thu, 19 Jul 2018 17:31:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180719093128.GI4071@xz-mi>
References: <20180719092257.12703-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719092257.12703-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migrate: Fix cancelling state warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Thu, Jul 19, 2018 at 10:22:57AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> We've been getting the warning:
> 
> migration_iteration_finish: Unknown ending state 2
> 
> on a cancel.
> 
> I think that's originally due to 39b9e17905c;  although
> I've only seen the warning, I think that in some cases
> that we could find the VM stays paused after a cancel where
> it should restart.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

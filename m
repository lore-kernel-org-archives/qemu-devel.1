Received: from eggs.gnu.org ([2001:4830:134:3::10]:57732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dYR2Q-0005sF-I1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dYR2N-0004FJ-EW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dYR2N-0004F1-8Y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02D8D804E3
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:03:42 +0000 (UTC)
Date: Fri, 21 Jul 2017 14:03:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170721060338.GA1595@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-18-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717134238.1966-18-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 17/17] migration: Flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Mon, Jul 17, 2017 at 03:42:38PM +0200, Juan Quintela wrote:
> Each time that we sync the bitmap, it is a possiblity that we receive
> a page that is being processed by a different thread.  We fix this
> problem just making sure that we wait for all receiving threads to
> finish its work before we procedeed with the next stage.
> 
> We are low on page flags, so we use a combination that is not valid to
> emit that message:  MULTIFD_PAGE and COMPRESSED.

Btw, would it be possible that we introduce a new QEMU_VM_COMMAND for
this flush operation?  Like: MIG_CMD_MULTIFD_FLUSH?

-- 
Peter Xu

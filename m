Received: from eggs.gnu.org ([2001:4830:134:3::10]:51714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsJDG-0002K0-3q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 22:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsJDA-0000ni-93
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 22:49:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fsJD6-0000kq-Uw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 22:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 388F14021CC3
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 02:49:28 +0000 (UTC)
Date: Wed, 22 Aug 2018 10:49:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180822024920.GA3324@xz-x1>
References: <153487789207.20513.6642364712339067528.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153487789207.20513.6642364712339067528.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Fix failure to close file
 descriptor on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Aug 21, 2018 at 12:58:53PM -0600, Alex Williamson wrote:
> A new error path fails to close the device file descriptor when
> triggered by a ballooning incompatibility within the group.  Fix it.
> 
> Fixes: 238e91728503 ("vfio/ccw/pci: Allow devices to opt-in for ballooning")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu

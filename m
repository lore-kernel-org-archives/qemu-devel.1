Received: from eggs.gnu.org ([2001:4830:134:3::10]:45686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVrGq-0001Mn-K4
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVrGn-0005rI-GQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:28:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVrGn-0005py-9Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:27:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 398B210C96
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:27:56 +0000 (UTC)
Date: Fri, 14 Jul 2017 11:27:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714032753.GF27284@pxdev.xzpeter.org>
References: <20170713115649.11853-1-dgilbert@redhat.com>
	<20170713115649.11853-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713115649.11853-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] migration: Close file on failed
 migration load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com

On Thu, Jul 13, 2017 at 12:56:46PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Closing the file before exit on a failure allows
> the source to cleanup better, especially with RDMA.
> 
> Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8OLh-0003cn-I1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8OLc-00029g-MK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8OLc-00029U-GX
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:55:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4158D80F8E
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 09:55:55 +0000 (UTC)
Date: Wed, 10 May 2017 17:55:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170510095550.GQ2820@pxdev.xzpeter.org>
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170425220451.6028-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170425220451.6028-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/41] migration: Create migration/blocker.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Apr 26, 2017 at 12:04:11AM +0200, Juan Quintela wrote:
> This allows us to remove lots of includes of migration/migration.h
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

If without all the "xbzrle.h" changes:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

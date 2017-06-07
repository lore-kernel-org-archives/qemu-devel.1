Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIZHF-0001FS-Ps
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIZHA-0001ED-6d
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIZHA-0001Dw-0V
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:37:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F14F437E66
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 11:37:21 +0000 (UTC)
Date: Wed, 7 Jun 2017 19:37:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170607113715.GD3847@pxdev.xzpeter.org>
References: <20170607105810.3003-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170607105810.3003-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Make info migrate output consistent
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

On Wed, Jun 07, 2017 at 12:58:08PM +0200, Juan Quintela wrote:
> Hi
> 
> Changes for v2:
> - patches 1 & 2 in previous pull requset
> - create function populate_disk_info (dave suggestion)
> 
> Please, review.
> 
> Thanks, Juan.
> 
> [v1]
> This series make the output of info migrate be printed in a single
> place for the states ACTIVE, CANCELLING and POSTCOPY_ACTIVE.
> 
> The code was duplicated, just use the same code.  Once done that, fix
> the inconsistences that were not needed.

I feel that putting cpu throttling info into populate_ram_info() is
still slightly weird, but hmm it's okay and that's trivial.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

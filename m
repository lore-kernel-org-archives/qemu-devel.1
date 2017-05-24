Received: from eggs.gnu.org ([2001:4830:134:3::10]:55694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDSn0-0004AS-0T
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDSmw-0000yN-UD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDSmw-0000yH-Mq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A363480477
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 09:41:05 +0000 (UTC)
Date: Wed, 24 May 2017 17:41:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170524094101.GI3873@pxdev.xzpeter.org>
References: <20170524085519.22856-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170524085519.22856-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Remove of loadvm handlers
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

On Wed, May 24, 2017 at 10:55:16AM +0200, Juan Quintela wrote:
> Hi
> 
> We just have a loadvm handlers that are a new list only used in a
> single place.  Just move everything to use the savevm_handlers (yes,
> it is a list, and we could have a better name).
> 
> Once there, vmstate_load() had three arguments but only needs two.  Fix that.
> 
> Please, review.
> 
> Juan Quintela (3):
>   migration: Use savevm_handlers instead of loadvm copy
>   migration: loadvm handlers are not used
>   migration: Remove section_id parameter from vmstate_load
> 
>  include/migration/migration.h |  5 ----
>  include/migration/vmstate.h   |  2 --
>  include/qemu/typedefs.h       |  1 -
>  migration/migration.c         |  2 --
>  migration/savevm.c            | 58 ++++++++++++-------------------------------
>  5 files changed, 16 insertions(+), 52 deletions(-)
> 
> -- 
> 2.9.3
> 

This series looks nice to me. :-)

Series:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

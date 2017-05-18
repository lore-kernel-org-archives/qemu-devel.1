Received: from eggs.gnu.org ([2001:4830:134:3::10]:46047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKG0-0002nA-Hx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKFw-0004PD-3Z
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBKFv-0004P5-TS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E89DE3D940
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:10:10 +0000 (UTC)
Date: Thu, 18 May 2017 20:10:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170518121006.GA15294@pxdev.xzpeter.org>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517154756.22079-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] migration: Split vmstate-types.c from
 vmstate.c
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

On Wed, May 17, 2017 at 05:47:53PM +0200, Juan Quintela wrote:
> Now one just has the interperter, and the other has the basic types.
> Once there, add copyright boilerplate.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

(Actually I would still avoid moving too many things around without
 functional reason since it'll be at least harder to trace commit
 information... but since we're here already after lots of rebases to
 track these series...)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

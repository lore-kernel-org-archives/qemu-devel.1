Received: from eggs.gnu.org ([2001:4830:134:3::10]:42258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d90p8-000860-Or
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d90p3-0000nJ-Ql
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d90p3-0000mn-KV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:00:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 394CB7F7A7
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 03:00:52 +0000 (UTC)
Date: Fri, 12 May 2017 11:00:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170512030047.GL28293@pxdev.xzpeter.org>
References: <20170511153440.6475-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511153440.6475-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Pass Error ** argument to
 {save, load}_vmstate
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

On Thu, May 11, 2017 at 05:34:40PM +0200, Juan Quintela wrote:
> This way we use the "normal" way of printing errors for hmp commands.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

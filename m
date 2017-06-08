Received: from eggs.gnu.org ([2001:4830:134:3::10]:37632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIx8G-00083W-QL
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIx8D-0006CY-4Z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dIx8C-0006Bb-V0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 071558124F
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:05:44 +0000 (UTC)
Date: Thu, 8 Jun 2017 15:05:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170608130536.GD4427@noname.redhat.com>
References: <20170601221552.30628-1-quintela@redhat.com>
	<8737bbd6qb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8737bbd6qb.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 0/5] Create setup/cleanup methods for
 migration incoming side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, dgilbert@redhat.com, peterx@redhat.com

Am 07.06.2017 um 19:53 hat Juan Quintela geschrieben:
> Juan Quintela <quintela@redhat.com> wrote:
> > Hi
> 
> Hi Kevin and Stefan, I intended to cc you on this series.
> 
> Is this what you were asking for block layer migration?
> 
> Do you need anything else?

I didn't manage to apply this to my local git tree, so my review is
based on scanning the emails.

The important part for us is probably where you call the .cleanup_load
callback. As I commented on the patch, I don't see any place in this
series that calls it. We need it before bdrv_invalidate_cache_all() is
called, I think.

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csMVE-0004eF-G6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csMV9-0004jn-Dd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csMV9-0004jh-8X
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14E97C073D55
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:43:30 +0000 (UTC)
Date: Mon, 27 Mar 2017 12:43:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170327044325.GI17755@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/51] ram: Create RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 23, 2017 at 09:44:56PM +0100, Juan Quintela wrote:
> We create a struct where to put all the ram state
> 
> Start with the following fields:
> 
> last_seen_block, last_sent_block, last_offset, last_version and
> ram_bulk_stage are globals that are really related together.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx

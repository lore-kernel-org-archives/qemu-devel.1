Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1exmdn-0003ah-FH
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1exmdk-0001Wg-Du
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:43:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1exmdk-0001Wa-90
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8487DC33F
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 04:43:16 +0000 (UTC)
Date: Mon, 19 Mar 2018 12:43:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180319044309.GE2477@xz-mi>
References: <20180316202114.32345-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316202114.32345-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix block migration flag case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Fri, Mar 16, 2018 at 08:21:14PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Fix the case where when a migration with a bad protocol is tried,
> we leave the block migration capability set.
> 
> (This is a cut down version of my 'migration: Fix block failure cases'
> where it's other case was fixed by Peter's dd0ee30caeebbd )
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

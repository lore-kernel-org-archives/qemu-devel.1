Received: from eggs.gnu.org ([2001:4830:134:3::10]:59264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsmE-0006nV-OT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsmA-0008E2-QF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVsmA-0008Di-Jn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 01:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61F2485540
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:04:25 +0000 (UTC)
Date: Fri, 14 Jul 2017 13:04:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714050423.GM27284@pxdev.xzpeter.org>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<20170712190558.GK6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712190558.GK6020@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jul 12, 2017 at 04:05:58PM -0300, Eduardo Habkost wrote:
> On Wed, Jul 12, 2017 at 02:53:40PM +0800, Peter Xu wrote:
> [...]
> > These properties should only be used for debugging/testing purpose,
> > and we should not guarantee any interface compatibility for them (just
> > like HMP).
> 
> If we don't guarantee compatibility, the property names need to
> be prefixed with "x-".

Indeed. Sorry I missed that.

But I'd say it is slightly awkward to add "x-" for all these (for me,
"x-" means more like "this is not stable and experimental, use it
carefully", while this does not suite for this series). Maybe I can
just remove this sentence in commit log (I think I am just a little
bit frightened by the compatibility problems)...

Thanks,

-- 
Peter Xu

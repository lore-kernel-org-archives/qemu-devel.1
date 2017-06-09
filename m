Received: from eggs.gnu.org ([2001:4830:134:3::10]:54404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJFSH-00006R-Bt
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJFSE-0003Ks-4e
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJFSD-0003KS-Ut
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 04:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E5C685541
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 08:39:36 +0000 (UTC)
Date: Fri, 9 Jun 2017 16:39:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170609083931.GN3628@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-7-git-send-email-peterx@redhat.com>
	<87y3t18uwy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y3t18uwy.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: move skip_section_footers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 09, 2017 at 09:47:09AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Move it into MigrationState, with a property binded to it. Same trick is
> > played like previous patches.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Same here.  Rename it to "section-footers".
> For previous one, "global-configuration"?

Let me switch, considering that we always need to keep compatibility
of old interfaces, and we'd better do it right when we started... :)

Though I'll wait for a while for other comments, especially patch 1/2
from QAPI side.

Thanks,

-- 
Peter Xu

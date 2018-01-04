Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWv7P-0002DO-AW
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWv7M-0006dO-5q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:18:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWv7M-0006bW-05
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:18:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 585497F3ED
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 02:18:49 +0000 (UTC)
Date: Thu, 4 Jan 2018 10:18:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180104021845.GP2557@xz-mi>
References: <20180103122017.14794-1-peterx@redhat.com>
	<20180103122017.14794-14-peterx@redhat.com>
	<871sj7yvi2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871sj7yvi2.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v2 13/13] migration: remove notify in
 fd_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 03, 2018 at 01:31:01PM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It should be called in migrate_fd_cleanup too.
> 
> It is *already* called in migrate_fd_cleanup.
> 
> I think we should add a comment stating that we _always_ end calling
> migrate_fd_cleanup, independently of how the migration ends.
> 
> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> I can also fix the comment when pulling if you agree with the change.

Yes.  Please modify according to your suggestions (including the other
patch comment).  Thanks for that!

-- 
Peter Xu

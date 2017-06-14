Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL34c-0001JP-Nd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dL34Y-00080p-Pj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dL34Y-0007zz-KB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 937CE37EEB
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:50:37 +0000 (UTC)
Date: Wed, 14 Jun 2017 15:50:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170614075032.GM11751@pxdev.xzpeter.org>
References: <20170613095432.11623-1-quintela@redhat.com>
	<20170613095432.11623-3-quintela@redhat.com>
	<20170614072837.GL11751@pxdev.xzpeter.org>
	<87shj3f1ud.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87shj3f1ud.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: Don't create decompression
 threads if not enabled
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

On Wed, Jun 14, 2017 at 09:46:50AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, Jun 13, 2017 at 11:54:32AM +0200, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> 
> >> --
> >> 
> >> I removed the [HACK] part because previous patch just check that
> >> compression pages are not received.
> >> ---
> >>  migration/ram.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index f2d1bce..d475cf5 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -2234,6 +2234,9 @@ static void compress_threads_load_setup(void)
> >
> > I cannot find compress_threads_load_setup() in my repo, but
> > migrate_decompress_threads_create()?
> 
> 
> Sorry, this patches are on top of load_setup/cleanup series.

Got it. After all the content of the patch looks good to me, so please
take my r-b as long as the patch can apply cleanly and correctly on
where it should be based:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

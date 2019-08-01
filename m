Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73477C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EFF2087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EFF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht93M-0000D0-EB
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 07:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1ht92t-0008C6-Aw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ht92r-0001be-VU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ht92r-0001Yh-Mq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 604F1A3B65
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2019 11:14:52 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CFAD1000335;
 Thu,  1 Aug 2019 11:14:46 +0000 (UTC)
Date: Thu, 1 Aug 2019 12:14:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190801111444.GB2773@work-vm>
References: <20190726091103.23503-1-stefanha@redhat.com>
 <20190726091103.23503-6-stefanha@redhat.com>
 <20190731174452.GL3203@work-vm>
 <20190801091527.GB15179@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801091527.GB15179@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 01 Aug 2019 11:14:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/5] virtiofsd: prevent races with
 lo_dirp_put()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Jul 31, 2019 at 06:44:52PM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > Introduce lo_dirp_put() so that FUSE_RELEASEDIR does not cause
> > > use-after-free races with other threads that are accessing lo_dirp.
> > > 
> > > Also make lo_releasedir() atomic to prevent FUSE_RELEASEDIR racing with
> > > itself.  This prevents double-frees.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  contrib/virtiofsd/passthrough_ll.c | 42 +++++++++++++++++++++++++-----
> > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> > > index ad3abdd532..f74e7d2d21 100644
> > > --- a/contrib/virtiofsd/passthrough_ll.c
> > > +++ b/contrib/virtiofsd/passthrough_ll.c
> > > @@ -1293,11 +1293,28 @@ static void lo_readlink(fuse_req_t req, fuse_ino_t ino)
> > >  }
> > >  
> > >  struct lo_dirp {
> > > +	gint refcount;
> > >  	DIR *dp;
> > >  	struct dirent *entry;
> > >  	off_t offset;
> > >  };
> > >  
> > > +static void lo_dirp_put(struct lo_dirp **dp)
> > > +{
> > > +	struct lo_dirp *d = *dp;
> > > +
> > > +	if (!d) {
> > > +		return;
> > > +	}
> > > +	*dp = NULL;
> > > +
> > > +	if (g_atomic_int_dec_and_test(&d->refcount)) {
> > > +		closedir(d->dp);
> > > +		free(d);
> > > +	}
> > > +}
> > > +
> > > +/* Call lo_dirp_put() on the return value when no longer needed */
> > >  static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi)
> > >  {
> > >  	struct lo_data *lo = lo_data(req);
> > > @@ -1305,6 +1322,9 @@ static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi)
> > >  
> > >  	pthread_mutex_lock(&lo->mutex);
> > >  	elem = lo_map_get(&lo->dirp_map, fi->fh);
> > > +	if (elem) {
> > > +		g_atomic_int_inc(&elem->dirp->refcount);
> > 
> > I don't understand what protects against reading the elem->dirp
> > here at the same time it's free'd by lo_releasedir's call to lo_dirp_put
> 
> It is lo->mutex and not the refcount that prevents the race with
> lo_releasedir().  Two cases:
> 
> 1. lo_releasedir() runs before lo_dirp().  lo_map_get() returns NULL and
>    lo_dirp() fails.

Ah that's what I was missing; it's that the lo_releasedir doesn't need
to have completed before lo_dirp runs, it's just that it's lo_map_remove
has happened.

> 2. lo_releasedir() runs after lo_dirp().  lo_map_get() succeeds and the
>    lo_dirp() caller keeps the object alive until lo_dirp_put(), when we
>    finally free it.
> 
> There is no third case since lo->mutex ensures that lo_releasedir() and
> lo_dirp() are serialized in the dirp_map lookup.

> > > +	}
> > >  	pthread_mutex_unlock(&lo->mutex);
> > >  	if (!elem)
> > >  		return NULL;
> > > @@ -1335,6 +1355,8 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi
> > >  	d->offset = 0;
> > >  	d->entry = NULL;
> > >  
> > > +	g_atomic_int_set(&d->refcount, 1); /* paired with lo_releasedir() */
> > > +
> > >  	fh = lo_add_dirp_mapping(req, d);
> > >  	if (fh == -1)
> > >  		goto out_err;
> > > @@ -1363,7 +1385,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> > >  			  off_t offset, struct fuse_file_info *fi, int plus)
> > >  {
> > >  	struct lo_data *lo = lo_data(req);
> > > -	struct lo_dirp *d;
> > > +	struct lo_dirp *d = NULL;
> > >  	struct lo_inode *dinode;
> > >  	char *buf = NULL;
> > >  	char *p;
> > > @@ -1451,6 +1473,8 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> > >  
> > >      err = 0;
> > >  error:
> > > +    lo_dirp_put(&d);
> > > +
> > >      // If there's an error, we can only signal it if we haven't stored
> > >      // any entries yet - otherwise we'd end up with wrong lookup
> > >      // counts for the entries that are already in the buffer. So we
> > > @@ -1477,22 +1501,25 @@ static void lo_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
> > >  static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
> > >  {
> > >  	struct lo_data *lo = lo_data(req);
> > > +	struct lo_map_elem *elem;
> > >  	struct lo_dirp *d;
> > >  
> > >  	(void) ino;
> > >  
> > > -	d = lo_dirp(req, fi);
> > > -	if (!d) {
> > > +	pthread_mutex_lock(&lo->mutex);
> > > +	elem = lo_map_get(&lo->dirp_map, fi->fh);
> > > +	if (!elem) {
> > > +		pthread_mutex_unlock(&lo->mutex);
> > >  		fuse_reply_err(req, EBADF);
> > >  		return;
> > >  	}
> > >  
> > > -	pthread_mutex_lock(&lo->mutex);
> > > +	d = elem->dirp;
> > >  	lo_map_remove(&lo->dirp_map, fi->fh);
> > >  	pthread_mutex_unlock(&lo->mutex);
> > >  
> > > -	closedir(d->dp);
> > > -	free(d);
> > > +	lo_dirp_put(&d); /* paired with lo_opendir() */
> > 
> > Is the &d really what's intended? That's the local stack variable, so
> > lo_dirp_put will set that local to NULL rather than the elem->dirp wont
> > it?
> 
> Yes, the put(&ptr) pattern prevents user-after-free in the caller.  It's
> slightly safer than put(ptr) since that leaves ptr initialized and the
> caller might access it later by accident.
> 
> elem has already been returned to the freelist by lo_map_remove() and we
> must not touch it anymore.

OK, thanks.

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E7C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F76C20644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F76C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht9m2-0005z0-I0
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1ht9lK-0005Yk-4x
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ht9lF-0001RI-6J
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:00:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ht9lE-0001Qq-UF
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38775C04959E;
 Thu,  1 Aug 2019 12:00:44 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83AF85D9CA;
 Thu,  1 Aug 2019 12:00:33 +0000 (UTC)
Date: Thu, 1 Aug 2019 13:00:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190801120031.GF2773@work-vm>
References: <20190731161006.9447-1-stefanha@redhat.com>
 <20190731161006.9447-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731161006.9447-4-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 01 Aug 2019 12:00:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] virtiofsd: rename inode->refcount to
 inode->nlookup
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
Cc: virtio-fs@redhat.com, Liu Bo <bo.liu@linux.alibaba.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> This reference counter plays a specific role in the FUSE protocol.  It's
> not a generic object reference counter and the FUSE kernel code calls it
> "nlookup".
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  contrib/virtiofsd/passthrough_ll.c | 36 ++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index e1d729d26b..135123366a 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -97,7 +97,19 @@ struct lo_inode {
>  	int fd;
>  	bool is_symlink;
>  	struct lo_key key;
> -	uint64_t refcount; /* protected by lo->mutex */
> +
> +	/* This counter keeps the inode alive during the FUSE session.
> +	 * Incremented when the FUSE inode number is sent in a reply
> +	 * (FUSE_LOOKUP, FUSE_READDIRPLUS, etc).  Decremented when an inode is
> +	 * released by requests like FUSE_FORGET, FUSE_RMDIR, FUSE_RENAME, etc.
> +	 *
> +	 * Note that this value is untrusted because the client can manipulate
> +	 * it arbitrarily using FUSE_FORGET requests.
> +	 *
> +	 * Protected by lo->mutex.
> +	 */
> +	uint64_t nlookup;
> +
>  	uint64_t version_offset;
>  	uint64_t ireg_refid;
>  	fuse_ino_t fuse_ino;
> @@ -485,7 +497,7 @@ retry:
>  	if (last == path) {
>  		p = &lo->root;
>  		pthread_mutex_lock(&lo->mutex);
> -		p->refcount++;
> +		p->nlookup++;
>  		pthread_mutex_unlock(&lo->mutex);
>  	} else {
>  		*last = '\0';
> @@ -688,8 +700,8 @@ static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st)
>  	pthread_mutex_lock(&lo->mutex);
>  	p = g_hash_table_lookup(lo->inodes, &key);
>  	if (p) {
> -		assert(p->refcount > 0);
> -		p->refcount++;
> +		assert(p->nlookup > 0);
> +		p->nlookup++;
>  	}
>  	pthread_mutex_unlock(&lo->mutex);
>  
> @@ -797,7 +809,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>  			goto out_err;
>  
>  		inode->is_symlink = S_ISLNK(e->attr.st_mode);
> -		inode->refcount = 1;
> +		inode->nlookup = 1;
>  		inode->fd = newfd;
>  		newfd = -1;
>  		inode->key.ino = e->attr.st_ino;
> @@ -1051,7 +1063,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
>  		goto out_err;
>  
>  	pthread_mutex_lock(&lo->mutex);
> -	inode->refcount++;
> +	inode->nlookup++;
>  	pthread_mutex_unlock(&lo->mutex);
>  	e.ino = inode->fuse_ino;
>  	update_version(lo, inode);
> @@ -1200,9 +1212,9 @@ static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64_t n)
>  		return;
>  
>  	pthread_mutex_lock(&lo->mutex);
> -	assert(inode->refcount >= n);
> -	inode->refcount -= n;
> -	if (!inode->refcount) {
> +	assert(inode->nlookup >= n);
> +	inode->nlookup -= n;
> +	if (!inode->nlookup) {
>  		lo_map_remove(&lo->ino_map, inode->fuse_ino);
>                  g_hash_table_remove(lo->inodes, &inode->key);
>  		if (g_hash_table_size(inode->posix_locks)) {
> @@ -1225,7 +1237,7 @@ static int unref_all_inodes_cb(gpointer key, gpointer value,
>  	struct lo_inode *inode  = value;
>  	struct lo_data *lo = user_data;
>  
> -	inode->refcount = 0;
> +	inode->nlookup = 0;
>  	lo_map_remove(&lo->ino_map, inode->fuse_ino);
>  	close(inode->fd);
>  
> @@ -1252,7 +1264,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
>  	if (lo_debug(req)) {
>  		fuse_debug("  forget %lli %lli -%lli\n",
>  			   (unsigned long long) ino,
> -			   (unsigned long long) inode->refcount,
> +			   (unsigned long long) inode->nlookup,
>  			   (unsigned long long) nlookup);
>  	}
>  
> @@ -2581,7 +2593,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
>  	root->fd = fd;
>  	root->key.ino = stat.st_ino;
>  	root->key.dev = stat.st_dev;
> -	root->refcount = 2;
> +	root->nlookup = 2;
>  }
>  
>  static void setup_proc_self_fd(struct lo_data *lo)
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9323C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886F22075B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXkNSG79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886F22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irsFy-000777-LY
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1irsFE-0006fV-5H
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1irsFC-0006rm-2V
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:38:39 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1irsFB-0006rI-T0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:38:38 -0500
Received: by mail-qk1-x743.google.com with SMTP id x1so17437706qkl.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3qWVGhr+VfLniqezKZGLN89NDcCh/RRBmXZBDVIFW/A=;
 b=oXkNSG79PrDWgPR3bToQJKbkLGnfKG7Y+SSV/OGkg+QQMhJ7pE0zrRHe+3FZbHiQpz
 rJZVVG7JZJ7TFV++wFZNZy8sX9HDP+lpHeC9BzuDunUOo8GKq0LZ9jI3iNcGHauio5+v
 n247SxuQv7JdepFnZVfEHLXv7VxDR7wWSntlfLOI9VR2hcQWAGWe/p1PT7exEUxYoaMw
 u4+KQvvIXKJ8ojBKBD6jwzA8A+93qcKV+yGpEOcx53fKq09alRJBgP9dn5IJiVz0aLWf
 qdrvqz+f4ri7jvXwvnP8sxYOEBZ6wpeCrtMAXdusPaiWHdHWWM6T6nQZU+Uz88jZgb85
 ymmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3qWVGhr+VfLniqezKZGLN89NDcCh/RRBmXZBDVIFW/A=;
 b=Q6MWXwGI8XU+XK0Sm+yrPd81N1mkSVnLbO0IYL7FqlYC6yfnVxdJY9fbmsXuKtT+e1
 F/sRdD0ubiJxuFMhIYk++S8GTEPxCvoaVsFpkYWSrBHMyJTWvah/pEmTZSslu5FnXuQk
 SK0fxIeyiPK9TtuFy3Cayz0SjAoOuIZRJRJK4myMhdIVO4fnBeDyvUeI7zCBwAc30Cr2
 nbZudjmdOwe7Hemh30ImQRB2k0jB66uB4MM6oibTaOH33O00g9NeYSuyIIwVc9WFS9CF
 r10P8dzFfdBkg14bhbz0vSevb1+3M8tZavFkVXqOtAiFjASMtAKhLb9CdpEoaoA1OmcJ
 Hl3g==
X-Gm-Message-State: APjAAAWYCwzVUpSTpKXk4Tj511mOVlL7lTv9fsGoJ8xrEaGx7p3fC8mM
 GXCzRqccAVa4T0rpRKrL7g==
X-Google-Smtp-Source: APXvYqw5yehomlof52ZuxoukKhiz9/rcJm12vDO5x3+GsUOBBoXo9yvei9oi3mV3jHA2gNODXu5XOQ==
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr30363236qke.297.1579131517066; 
 Wed, 15 Jan 2020 15:38:37 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id h6sm10107808qtr.33.2020.01.15.15.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Jan 2020 15:38:36 -0800 (PST)
Date: Wed, 15 Jan 2020 18:38:31 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 085/104] virtiofsd: Support remote posix locks
Message-ID: <20200115233831.mw6sttmepespg4kk@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-86-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-86-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:45PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Vivek Goyal <vgoyal@redhat.com>
> 
> Doing posix locks with-in guest kernel are not sufficient if a file/dir
> is being shared by multiple guests. So we need the notion of daemon doing
> the locks which are visible to rest of the guests.
> 
> Given posix locks are per process, one can not call posix lock API on host,
> otherwise bunch of basic posix locks properties are broken. For example,
> If two processes (A and B) in guest open the file and take locks on different
> sections of file, if one of the processes closes the fd, it will close
> fd on virtiofsd and all posix locks on file will go away. This means if
> process A closes the fd, then locks of process B will go away too.
> 
> Similar other problems exist too.
> 
> This patch set tries to emulate posix locks while using open file
> description locks provided on Linux.
> 
> Daemon provides two options (-o posix_lock, -o no_posix_lock) to enable
> or disable posix locking in daemon. By default it is enabled.
> 
> There are few issues though.
> 
> - GETLK() returns pid of process holding lock. As we are emulating locks
>   using OFD, and these locks are not per process and don't return pid
>   of process, so GETLK() in guest does not reuturn process pid.
> 
> - As of now only F_SETLK is supported and not F_SETLKW. We can't block
>   the thread in virtiofsd for arbitrary long duration as there is only
>   one thread serving the queue. That means unlock request will not make
>   it to daemon and F_SETLKW will block infinitely and bring virtio-fs
>   to a halt. This is a solvable problem though and will require significant
>   changes in virtiofsd and kernel. Left as a TODO item for now.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 190 +++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index fbcc222860..fc79d5ac43 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -68,6 +68,13 @@
>  #include "seccomp.h"
>  
>  #define HAVE_POSIX_FALLOCATE 1
> +
> +/* Keep track of inode posix locks for each owner. */
> +struct lo_inode_plock {
> +    uint64_t lock_owner;
> +    int fd; /* fd for OFD locks */
> +};
> +
>  struct lo_map_elem {
>      union {
>          struct lo_inode *inode;
> @@ -96,6 +103,8 @@ struct lo_inode {
>      struct lo_key key;
>      uint64_t refcount; /* protected by lo->mutex */
>      fuse_ino_t fuse_ino;
> +    pthread_mutex_t plock_mutex;
> +    GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
>  };
>  
>  struct lo_cred {
> @@ -115,6 +124,7 @@ struct lo_data {
>      int norace;
>      int writeback;
>      int flock;
> +    int posix_lock;
>      int xattr;
>      const char *source;
>      double timeout;
> @@ -138,6 +148,8 @@ static const struct fuse_opt lo_opts[] = {
>      { "source=%s", offsetof(struct lo_data, source), 0 },
>      { "flock", offsetof(struct lo_data, flock), 1 },
>      { "no_flock", offsetof(struct lo_data, flock), 0 },
> +    { "posix_lock", offsetof(struct lo_data, posix_lock), 1 },
> +    { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
>      { "xattr", offsetof(struct lo_data, xattr), 1 },
>      { "no_xattr", offsetof(struct lo_data, xattr), 0 },
>      { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
> @@ -486,6 +498,17 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
>          conn->want |= FUSE_CAP_FLOCK_LOCKS;
>      }
> +
> +    if (conn->capable & FUSE_CAP_POSIX_LOCKS) {
> +        if (lo->posix_lock) {
> +            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating posix locks\n");
> +            conn->want |= FUSE_CAP_POSIX_LOCKS;
> +        } else {
> +            fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling posix locks\n");
> +            conn->want &= ~FUSE_CAP_POSIX_LOCKS;
> +        }
> +    }
> +
>      if ((lo->cache == CACHE_NONE && !lo->readdirplus_set) ||
>          lo->readdirplus_clear) {
>          fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
> @@ -773,6 +796,19 @@ static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st)
>      return p;
>  }
>  
> +/* value_destroy_func for posix_locks GHashTable */
> +static void posix_locks_value_destroy(gpointer data)
> +{
> +    struct lo_inode_plock *plock = data;
> +
> +    /*
> +     * We had used open() for locks and had only one fd. So
> +     * closing this fd should release all OFD locks.
> +     */
> +    close(plock->fd);
> +    free(plock);
> +}
> +
>  static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>                          struct fuse_entry_param *e)
>  {
> @@ -826,6 +862,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
>          newfd = -1;
>          inode->key.ino = e->attr.st_ino;
>          inode->key.dev = e->attr.st_dev;
> +        pthread_mutex_init(&inode->plock_mutex, NULL);
> +        inode->posix_locks = g_hash_table_new_full(
> +            g_direct_hash, g_direct_equal, NULL, posix_locks_value_destroy);
>  
>          pthread_mutex_lock(&lo->mutex);
>          inode->fuse_ino = lo_add_inode_mapping(req, inode);
> @@ -1192,6 +1231,11 @@ static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inode,
>      if (!inode->refcount) {
>          lo_map_remove(&lo->ino_map, inode->fuse_ino);
>          g_hash_table_remove(lo->inodes, &inode->key);
> +        if (g_hash_table_size(inode->posix_locks)) {
> +            fuse_log(FUSE_LOG_WARNING, "Hash table is not empty\n");
> +        }
> +        g_hash_table_destroy(inode->posix_locks);
> +        pthread_mutex_destroy(&inode->plock_mutex);
>          pthread_mutex_unlock(&lo->mutex);
>          close(inode->fd);
>          free(inode);
> @@ -1548,6 +1592,136 @@ out:
>      }
>  }
>  
> +/* Should be called with inode->plock_mutex held */
> +static struct lo_inode_plock *lookup_create_plock_ctx(struct lo_data *lo,
> +                                                      struct lo_inode *inode,
> +                                                      uint64_t lock_owner,
> +                                                      pid_t pid, int *err)
> +{
> +    struct lo_inode_plock *plock;
> +    char procname[64];
> +    int fd;
> +
> +    plock =
> +        g_hash_table_lookup(inode->posix_locks, GUINT_TO_POINTER(lock_owner));
> +
> +    if (plock) {
> +        return plock;
> +    }
> +
> +    plock = malloc(sizeof(struct lo_inode_plock));
> +    if (!plock) {
> +        *err = ENOMEM;
> +        return NULL;
> +    }
> +
> +    /* Open another instance of file which can be used for ofd locks. */
> +    sprintf(procname, "%i", inode->fd);
> +
> +    /* TODO: What if file is not writable? */
> +    fd = openat(lo->proc_self_fd, procname, O_RDWR);
> +    if (fd == -1) {

> +        *err = -errno;

I think the errno is positive value, so the minus isn't needed?

           *err = errno;

Otherwise looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks,
Masa

> +        free(plock);
> +        return NULL;
> +    }
> +
> +    plock->lock_owner = lock_owner;
> +    plock->fd = fd;
> +    g_hash_table_insert(inode->posix_locks, GUINT_TO_POINTER(plock->lock_owner),
> +                        plock);
> +    return plock;
> +}
> +
> +static void lo_getlk(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
> +                     struct flock *lock)
> +{
> +    struct lo_data *lo = lo_data(req);
> +    struct lo_inode *inode;
> +    struct lo_inode_plock *plock;
> +    int ret, saverr = 0;
> +
> +    fuse_log(FUSE_LOG_DEBUG,
> +             "lo_getlk(ino=%" PRIu64 ", flags=%d)"
> +             " owner=0x%lx, l_type=%d l_start=0x%lx"
> +             " l_len=0x%lx\n",
> +             ino, fi->flags, fi->lock_owner, lock->l_type, lock->l_start,
> +             lock->l_len);
> +
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    pthread_mutex_lock(&inode->plock_mutex);
> +    plock =
> +        lookup_create_plock_ctx(lo, inode, fi->lock_owner, lock->l_pid, &ret);
> +    if (!plock) {
> +        pthread_mutex_unlock(&inode->plock_mutex);
> +        fuse_reply_err(req, ret);
> +        return;
> +    }
> +
> +    ret = fcntl(plock->fd, F_OFD_GETLK, lock);
> +    if (ret == -1) {
> +        saverr = errno;
> +    }
> +    pthread_mutex_unlock(&inode->plock_mutex);
> +
> +    if (saverr) {
> +        fuse_reply_err(req, saverr);
> +    } else {
> +        fuse_reply_lock(req, lock);
> +    }
> +}
> +
> +static void lo_setlk(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
> +                     struct flock *lock, int sleep)
> +{
> +    struct lo_data *lo = lo_data(req);
> +    struct lo_inode *inode;
> +    struct lo_inode_plock *plock;
> +    int ret, saverr = 0;
> +
> +    fuse_log(FUSE_LOG_DEBUG,
> +             "lo_setlk(ino=%" PRIu64 ", flags=%d)"
> +             " cmd=%d pid=%d owner=0x%lx sleep=%d l_whence=%d"
> +             " l_start=0x%lx l_len=0x%lx\n",
> +             ino, fi->flags, lock->l_type, lock->l_pid, fi->lock_owner, sleep,
> +             lock->l_whence, lock->l_start, lock->l_len);
> +
> +    if (sleep) {
> +        fuse_reply_err(req, EOPNOTSUPP);
> +        return;
> +    }
> +
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    pthread_mutex_lock(&inode->plock_mutex);
> +    plock =
> +        lookup_create_plock_ctx(lo, inode, fi->lock_owner, lock->l_pid, &ret);
> +
> +    if (!plock) {
> +        pthread_mutex_unlock(&inode->plock_mutex);
> +        fuse_reply_err(req, ret);
> +        return;
> +    }
> +
> +    /* TODO: Is it alright to modify flock? */
> +    lock->l_pid = 0;
> +    ret = fcntl(plock->fd, F_OFD_SETLK, lock);
> +    if (ret == -1) {
> +        saverr = errno;
> +    }
> +    pthread_mutex_unlock(&inode->plock_mutex);
> +    fuse_reply_err(req, saverr);
> +}
> +
>  static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
>                          struct fuse_file_info *fi)
>  {
> @@ -1649,6 +1823,19 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>  {
>      int res;
>      (void)ino;
> +    struct lo_inode *inode;
> +
> +    inode = lo_inode(req, ino);
> +    if (!inode) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    /* An fd is going away. Cleanup associated posix locks */
> +    pthread_mutex_lock(&inode->plock_mutex);
> +    g_hash_table_remove(inode->posix_locks, GUINT_TO_POINTER(fi->lock_owner));
> +    pthread_mutex_unlock(&inode->plock_mutex);
> +
>      res = close(dup(lo_fi_fd(req, fi)));
>      fuse_reply_err(req, res == -1 ? errno : 0);
>  }
> @@ -2111,6 +2298,8 @@ static struct fuse_lowlevel_ops lo_oper = {
>      .releasedir = lo_releasedir,
>      .fsyncdir = lo_fsyncdir,
>      .create = lo_create,
> +    .getlk = lo_getlk,
> +    .setlk = lo_setlk,
>      .open = lo_open,
>      .release = lo_release,
>      .flush = lo_flush,
> @@ -2466,6 +2655,7 @@ int main(int argc, char *argv[])
>      struct lo_data lo = {
>          .debug = 0,
>          .writeback = 0,
> +        .posix_lock = 1,
>          .proc_self_fd = -1,
>      };
>      struct lo_map_elem *root_elem;
> -- 
> 2.23.0
> 
> 


Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C08206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 08:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C08206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LG1-0006g4-Dg
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0LFU-0006Fc-Qz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:46:12 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:50709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0LFR-0003U8-P3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 04:46:12 -0400
Received: from player746.ha.ovh.net (unknown [10.110.208.115])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id D5447244962
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 10:46:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 0603614D33113;
 Tue, 28 Jul 2020 08:46:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00579d8711e-77c0-4ef0-a145-34bcf7956619,96196EA346850768E7E70500A314E772A5EF2CEB)
 smtp.auth=groug@kaod.org
Date: Tue, 28 Jul 2020 10:46:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v7 3/6] 9pfs: add new function v9fs_co_readdir_many()
Message-ID: <20200728104600.4552a126@bahia.lan>
In-Reply-To: <1626524.GXyn7ySoG3@silver>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
 <4035f3a28461ba21ab5e24c843556b0ec06246ab.1595166227.git.qemu_oss@crudebyte.com>
 <1626524.GXyn7ySoG3@silver>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16558328459018672448
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.251.8; envelope-from=groug@kaod.org;
 helo=13.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:46:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 10:33:42 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Sonntag, 19. Juli 2020 14:29:13 CEST Christian Schoenebeck wrote:
> > The newly added function v9fs_co_readdir_many() retrieves multiple
> > directory entries with a single fs driver request. It is intended to
> > replace uses of v9fs_co_readdir(), the latter only retrives a single
> > directory entry per fs driver request instead.
> > 
> > The reason for this planned replacement is that for every fs driver
> > request the coroutine is dispatched from main I/O thread to a
> > background I/O thread and eventually dispatched back to main I/O
> > thread. Hopping between threads adds latency. So if a 9pfs Treaddir
> > request reads a large amount of directory entries, this currently
> > sums up to huge latencies of several hundred ms or even more. So
> > using v9fs_co_readdir_many() instead of v9fs_co_readdir() will
> > provide significant performance improvements.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.h    |  22 ++++++
> >  hw/9pfs/codir.c | 196 +++++++++++++++++++++++++++++++++++++++++++++---
> >  hw/9pfs/coth.h  |   3 +
> >  3 files changed, 210 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index 561774e843..93b7030edf 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -215,6 +215,28 @@ static inline void v9fs_readdir_init(V9fsDir *dir)
> >      qemu_co_mutex_init(&dir->readdir_mutex);
> >  }
> > 
> > +/**
> > + * Type for 9p fs drivers' (a.k.a. 9p backends) result of readdir requests,
> > + * which is a chained list of directory entries.
> > + */
> > +typedef struct V9fsDirEnt {
> > +    /* mandatory (must not be NULL) information for all readdir requests */
> > +    struct dirent *dent;
> > +    /*
> > +     * optional (may be NULL): A full stat of each directory entry is just
> > +     * done if explicitly told to fs driver.
> > +     */
> > +    struct stat *st;
> > +    /*
> > +     * instead of an array, directory entries are always returned as
> > +     * chained list, that's because the amount of entries retrieved by fs
> > +     * drivers is dependent on the individual entries' name (since response
> > +     * messages are size limited), so the final amount cannot be estimated
> > +     * before hand
> > +     */
> > +    struct V9fsDirEnt *next;
> > +} V9fsDirEnt;
> > +
> >  /*
> >   * Filled by fs driver on open and other
> >   * calls.
> > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > index 73f9a751e1..07da5d8d70 100644
> > --- a/hw/9pfs/codir.c
> > +++ b/hw/9pfs/codir.c
> > @@ -18,28 +18,202 @@
> >  #include "qemu/main-loop.h"
> >  #include "coth.h"
> > 
> > +/*
> > + * This is solely executed on a background IO thread.
> > + */
> > +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent
> > **dent) +{
> > +    int err = 0;
> > +    V9fsState *s = pdu->s;
> > +    struct dirent *entry;
> > +
> > +    errno = 0;
> > +    entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > +    if (!entry && errno) {
> > +        *dent = NULL;
> > +        err = -errno;
> > +    } else {
> > +        *dent = entry;
> > +    }
> > +    return err;
> > +}
> > +
> > +/*
> > + * TODO: This will be removed for performance reasons.
> > + * Use v9fs_co_readdir_many() instead.
> > + */
> >  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
> >                                   struct dirent **dent)
> >  {
> >      int err;
> > -    V9fsState *s = pdu->s;
> > 
> >      if (v9fs_request_cancelled(pdu)) {
> >          return -EINTR;
> >      }
> > -    v9fs_co_run_in_worker(
> > -        {
> > -            struct dirent *entry;
> > +    v9fs_co_run_in_worker({
> > +        err = do_readdir(pdu, fidp, dent);
> > +    });
> > +    return err;
> > +}
> 
> Ok, this ^ part (precisely: do_readdir() and v9fs_co_readdir()) can still be 
> sliced out into a separate patch, and apparently makes sense, as it would 
> avoid cluttering this patch like ...
> 
> > +
> > +/*
> > + * This is solely executed on a background IO thread.
> > + *
> > + * See v9fs_co_readdir_many() (as its only user) below for details.
> > + */
> > +static int do_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> > +                           struct V9fsDirEnt **entries, off_t offset,
> > +                           int32_t maxsize, bool dostat)
> > +{
> > +    V9fsState *s = pdu->s;
> > +    V9fsString name;
> > +    int len, err = 0;
> > +    int32_t size = 0;
> > +    off_t saved_dir_pos;
> > +    struct dirent *dent;
> > +    struct V9fsDirEnt *e = NULL;
> > +    V9fsPath path;
> > +    struct stat stbuf;
> > +
> > +    *entries = NULL;
> > +    v9fs_path_init(&path);
> > +
> > +    /*
> > +     * TODO: Here should be a warn_report_once() if lock failed.
> > +     *
> > +     * With a good 9p client we should not get into concurrency here,
> > +     * because a good client would not use the same fid for concurrent
> > +     * requests. We do the lock here for safety reasons though. However
> > +     * the client would then suffer performance issues, so better log that
> > +     * issue here.
> > +     */
> > +    v9fs_readdir_lock(&fidp->fs.dir);
> > +
> > +    /* seek directory to requested initial position */
> > +    if (offset == 0) {
> > +        s->ops->rewinddir(&s->ctx, &fidp->fs);
> > +    } else {
> > +        s->ops->seekdir(&s->ctx, &fidp->fs, offset);
> > +    }
> > +
> > +    /* save the directory position */
> > +    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
> > +    if (saved_dir_pos < 0) {
> > +        err = saved_dir_pos;
> > +        goto out;
> > +    }
> > +
> > +    while (true) {
> > +        /* get directory entry from fs driver */
> > +        err = do_readdir(pdu, fidp, &dent);
> > +        if (err || !dent) {
> > +            break;
> > +        }
> > 
> > -            errno = 0;
> > -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > -            if (!entry && errno) {
> 
> ... here ...
> 
> > +        /*
> > +         * stop this loop as soon as it would exceed the allowed maximum
> > +         * response message size for the directory entries collected so
> > far, +         * because anything beyond that size would need to be
> > discarded by +         * 9p controller (main thread / top half) anyway
> > +         */
> > +        v9fs_string_init(&name);
> > +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> > +        len = v9fs_readdir_response_size(&name);
> > +        v9fs_string_free(&name);
> > +        if (size + len > maxsize) {
> > +            /* this is not an error case actually */
> > +            break;
> > +        }
> > +
> > +        /* append next node to result chain */
> > +        if (!e) {
> > +            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
> > +        } else {
> > +            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
> > +        }
> > +        e->dent = g_malloc0(sizeof(struct dirent));
> > +        memcpy(e->dent, dent, sizeof(struct dirent));
> > +
> > +        /* perform a full stat() for directory entry if requested by caller
> > */ +        if (dostat) {
> > +            err = s->ops->name_to_path(
> > +                &s->ctx, &fidp->path, dent->d_name, &path
> > +            );
> > +            if (err < 0) {
> >                  err = -errno;
> > -            } else {
> > -                *dent = entry;
> > -                err = 0;
> 
> ... and here.
> 
> > +                break;
> >              }
> > -        });
> > +
> > +            err = s->ops->lstat(&s->ctx, &path, &stbuf);
> > +            if (err < 0) {
> > +                err = -errno;
> > +                break;
> > +            }
> > +
> > +            e->st = g_malloc0(sizeof(struct stat));
> > +            memcpy(e->st, &stbuf, sizeof(struct stat));
> > +        }
> > +
> > +        size += len;
> > +        saved_dir_pos = dent->d_off;
> > +    }
> > +
> > +    /* restore (last) saved position */
> > +    s->ops->seekdir(&s->ctx, &fidp->fs, saved_dir_pos);
> > +
> > +out:
> > +    v9fs_readdir_unlock(&fidp->fs.dir);
> > +    v9fs_path_free(&path);
> > +    if (err < 0) {
> > +        return err;
> > +    }
> > +    return size;
> > +}
> > +
> > +/**
> > + * @brief Reads multiple directory entries in one rush.
> > + *
> > + * Retrieves the requested (max. amount of) directory entries from the fs
> > + * driver. This function must only be called by the main IO thread (top
> > half). + * Internally this function call will be dispatched to a background
> > IO thread + * (bottom half) where it is eventually executed by the fs
> > driver. + *
> > + * @discussion Acquiring multiple directory entries in one rush from the fs
> > + * driver, instead of retrieving each directory entry individually, is
> > very + * beneficial from performance point of view. Because for every fs
> > driver + * request latency is added, which in practice could lead to
> > overall + * latencies of several hundred ms for reading all entries (of
> > just a single + * directory) if every directory entry was individually
> > requested from fs + * driver.
> > + *
> > + * @note You must @b ALWAYS call @c v9fs_free_dirents(entries) after
> > calling + * v9fs_co_readdir_many(), both on success and on error cases of
> > this + * function, to avoid memory leaks once @p entries are no longer
> > needed. + *
> > + * @param pdu - the causing 9p (T_readdir) client request
> > + * @param fidp - already opened directory where readdir shall be performed
> > on + * @param entries - output for directory entries (must not be NULL) + *
> > @param offset - initial position inside the directory the function shall +
> > *                 seek to before retrieving the directory entries + *
> > @param maxsize - maximum result message body size (in bytes)
> > + * @param dostat - whether a stat() should be performed and returned for
> > + *                 each directory entry
> > + * @returns resulting response message body size (in bytes) on success,
> > + *          negative error code otherwise
> > + */
> > +int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
> > +                                      struct V9fsDirEnt **entries,
> > +                                      off_t offset, int32_t maxsize,
> > +                                      bool dostat)
> > +{
> > +    int err = 0;
> > +
> > +    if (v9fs_request_cancelled(pdu)) {
> > +        return -EINTR;
> > +    }
> > +    v9fs_co_run_in_worker({
> > +        err = do_readdir_many(pdu, fidp, entries, offset, maxsize, dostat);
> > +    });
> >      return err;
> >  }
> > 
> > diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> > index c2cdc7a9ea..fd4a45bc7c 100644
> > --- a/hw/9pfs/coth.h
> > +++ b/hw/9pfs/coth.h
> > @@ -49,6 +49,9 @@
> >  void co_run_in_worker_bh(void *);
> >  int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
> >  int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent
> > **); +int coroutine_fn v9fs_co_readdir_many(V9fsPDU *, V9fsFidState *,
> > +                                      struct V9fsDirEnt **, off_t, int32_t,
> > +                                      bool);
> >  off_t coroutine_fn v9fs_co_telldir(V9fsPDU *, V9fsFidState *);
> >  void coroutine_fn v9fs_co_seekdir(V9fsPDU *, V9fsFidState *, off_t);
> >  void coroutine_fn v9fs_co_rewinddir(V9fsPDU *, V9fsFidState *);
> 
> So I'll prepare a v8 with this patch here split into two.
> 
> But this is it. I don't see another chunk in this patch set that could be 
> split further down in an useful way.
> 
> Best regards,
> Christian Schoenebeck
> 
> 

You're in charge now so feel free to do that if the development+testing
cost is acceptable to you. You already know my take on having smaller
patches :)

Cheers,

--
Greg


Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F3C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88DC20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLsdlj8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88DC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFH3d-0000EN-OB
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFH2n-00088n-Jp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFH2l-0005Eq-G6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:46:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>)
 id 1jFH2l-0005Ec-73; Fri, 20 Mar 2020 08:46:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id h72so958173pfe.4;
 Fri, 20 Mar 2020 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ps4BVSGmE6a201JEHpb0SJIxhdbURg46khqXKcNac8k=;
 b=YLsdlj8TmW8VLsJUb6Ji5yANJCDMq+KcZkyqLxgqd1OGxKWbQOMiqoKXDqxapXWkG9
 7NS1p8uvnIEpovjdN9B9CDU5iMp0OPDn2r5lvl7Bd7nKDiJECW3paKjMu+xyTgjCdj+I
 4gtSqPRPe8pp0nPBjzJWN7SHOhMYfN3xlxAmUDKXunRooFjYfBc2v+Goe+em02JGyWMX
 5r39DEIwLVGexc4p9ElkHRYIABvchejWSh9zROoShVVgXrbcHq9ZBW6DbKTbl4r3KnOU
 k5OGvXysO+Ge+j5B386YyuaAR4NUHtnjJjtbMu4SrVypCw1IGxkzrzGHMSDz4jRu3aHC
 EniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ps4BVSGmE6a201JEHpb0SJIxhdbURg46khqXKcNac8k=;
 b=s3RAtHFNveoQseTuVwRc1PqO+Kk5lmQzbqbnnYS2QSjW7B/dMoMM3StkofOBmM1dEu
 U3ac5lCKlIb/X9NpQWDrFW+DqZMdv/KPkvaZI66JrkvNWciLPWHnYyqmcMw3bJQ1lsKv
 ikT324IbUKcuu9VoaGLU9qBF3rNvCXkK5aWLTChH2DeV2FPK05mZcWYx3Cha+4Xst4Hy
 ty4CzFiCwkxNY0M4sg5vWKWW2T+dzTjdcEFc9H0khSI7+BTOoYv++dRLxRMc2p277muy
 h9KdqVL0FinGbu6GFNc+jjNas1GGEhoAAyTlRPzpA9clvFBDnXz8PnjTp2kYr70KlrJ6
 NVrw==
X-Gm-Message-State: ANhLgQ27GgvNnGT6tuy1BWqWdesQE4J6OwYvB29x/7u2cDsB3z7TTxJl
 FmJUgn33Zb9xuEefD4zgaUIPjU0NgtpM9vf6g+Y=
X-Google-Smtp-Source: ADFU+vt4aFe/mqFvJ1MRoVJf+kjWINBBNcbRRNfp9GaKJFIKOLTEeIVIgQSouo1P1GdUu3TSGWF8gJ6S77YxEWE3Zkg=
X-Received: by 2002:aa7:8711:: with SMTP id b17mr8914417pfo.315.1584708389552; 
 Fri, 20 Mar 2020 05:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200320120456.1931482-1-dnbrdsky@gmail.com>
 <20200320120456.1931482-3-dnbrdsky@gmail.com>
 <20200320123348.GA3464@work-vm>
In-Reply-To: <20200320123348.GA3464@work-vm>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Fri, 20 Mar 2020 05:46:18 -0700
Message-ID: <CA+ZmoZVp3M0oF-qVbwkBa=OcO_Q-uTYEO8J5-hXj=G4Rnu9yNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 5:34 AM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * dnbrdsky@gmail.com (dnbrdsky@gmail.com) wrote:
> > From: Daniel Brodsky <dnbrdsky@gmail.com>
> >
> > - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> > - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> > - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
> >
> > Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
> > ---
> >  block/iscsi.c         | 11 +++-------
> >  block/nfs.c           | 51 ++++++++++++++++++++-----------------------
> >  cpus-common.c         | 13 +++++------
> >  hw/display/qxl.c      | 43 +++++++++++++++++-------------------
> >  hw/vfio/platform.c    |  5 ++---
> >  migration/migration.c |  3 +--
> >  migration/multifd.c   |  8 +++----
> >  migration/ram.c       |  3 +--
> >  monitor/misc.c        |  4 +---
> >  ui/spice-display.c    | 14 ++++++------
> >  util/log.c            |  4 ++--
> >  util/qemu-timer.c     | 17 +++++++--------
> >  util/rcu.c            |  8 +++----
> >  util/thread-pool.c    |  3 +--
> >  util/vfio-helpers.c   |  4 ++--
> >  15 files changed, 84 insertions(+), 107 deletions(-)
> >
>
> <snip>
>
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c1d88ace7f..2f0bd6d8b4 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1652,11 +1652,10 @@ static void migrate_fd_cleanup_bh(void *opaque)
> >
> >  void migrate_set_error(MigrationState *s, const Error *error)
> >  {
> > -    qemu_mutex_lock(&s->error_mutex);
> > +    QEMU_LOCK_GUARD(&s->error_mutex);
> >      if (!s->error) {
> >          s->error = error_copy(error);
> >      }
> > -    qemu_mutex_unlock(&s->error_mutex);
> >  }
>
> There are some other places in migration.c that would really benefit;
> for example, migrate_send_rp_message, if you use a LOCK_QUARD
> there, then you can remove the 'int ret', and the goto error.
> In postcopy_pause, the locks on qemu_file_lock would work well using the
> WITH_QEMU_LOCK_GUARD.

I did a basic pass through for targets and that one didn't come up. I can add
more replacements later, but there are ~300 mutex locks that might be worth
replacing and going through them manually in one go is too tedious.

> >  void migrate_fd_error(MigrationState *s, const Error *error)
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index cb6a4a3ab8..9123c111a3 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -894,11 +894,11 @@ void multifd_recv_sync_main(void)
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> >
> > -        qemu_mutex_lock(&p->mutex);
> > -        if (multifd_recv_state->packet_num < p->packet_num) {
> > -            multifd_recv_state->packet_num = p->packet_num;
> > +        WITH_QEMU_LOCK_GUARD(&p->mutex) {
> > +            if (multifd_recv_state->packet_num < p->packet_num) {
> > +                multifd_recv_state->packet_num = p->packet_num;
> > +            }
> >          }
> > -        qemu_mutex_unlock(&p->mutex);
> >          trace_multifd_recv_sync_main_signal(p->id);
> >          qemu_sem_post(&p->sem_sync);
> >      }
>
> > diff --git a/migration/ram.c b/migration/ram.c
> > index c12cfdbe26..87a670cfbf 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1368,7 +1368,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
> >          return NULL;
> >      }
> >
> > -    qemu_mutex_lock(&rs->src_page_req_mutex);
> > +    QEMU_LOCK_GUARD(&rs->src_page_req_mutex);
> >      if (!QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> >          struct RAMSrcPageRequest *entry =
> >                                  QSIMPLEQ_FIRST(&rs->src_page_requests);
> > @@ -1385,7 +1385,6 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
> >              migration_consume_urgent_request();
> >          }
> >      }
> > -    qemu_mutex_unlock(&rs->src_page_req_mutex);
> >
> >      return block;
> >  }
>
> Is there a reason you didn't do the matching pair at the bottom of
> ram_save_queue_pages ?
>
> Dave
>

According to https://wiki.qemu.org/ToDo/LockGuards cases that are trivial (no
conditional logic) shouldn't be replaced.

> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index 6c45fa490f..9723b466cd 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -1473,7 +1473,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >      MonFdsetFd *mon_fdset_fd;
> >      AddfdInfo *fdinfo;
> >
> > -    qemu_mutex_lock(&mon_fdsets_lock);
> > +    QEMU_LOCK_GUARD(&mon_fdsets_lock);
> >      if (has_fdset_id) {
> >          QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
> >              /* Break if match found or match impossible due to ordering by ID */
> > @@ -1494,7 +1494,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >              if (fdset_id < 0) {
> >                  error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "fdset-id",
> >                             "a non-negative value");
> > -                qemu_mutex_unlock(&mon_fdsets_lock);
> >                  return NULL;
> >              }
> >              /* Use specified fdset ID */
> > @@ -1545,7 +1544,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
> >      fdinfo->fdset_id = mon_fdset->id;
> >      fdinfo->fd = mon_fdset_fd->fd;
> >
> > -    qemu_mutex_unlock(&mon_fdsets_lock);
> >      return fdinfo;
> >  }
> >
> > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > index 6babe24909..19632fdf6c 100644
> > --- a/ui/spice-display.c
> > +++ b/ui/spice-display.c
> > @@ -18,6 +18,7 @@
> >  #include "qemu/osdep.h"
> >  #include "ui/qemu-spice.h"
> >  #include "qemu/timer.h"
> > +#include "qemu/lockable.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/option.h"
> >  #include "qemu/queue.h"
> > @@ -483,12 +484,12 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
> >  {
> >      graphic_hw_update(ssd->dcl.con);
> >
> > -    qemu_mutex_lock(&ssd->lock);
> > -    if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
> > -        qemu_spice_create_update(ssd);
> > -        ssd->notify++;
> > +    WITH_QEMU_LOCK_GUARD(&ssd->lock) {
> > +        if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
> > +            qemu_spice_create_update(ssd);
> > +            ssd->notify++;
> > +        }
> >      }
> > -    qemu_mutex_unlock(&ssd->lock);
> >
> >      trace_qemu_spice_display_refresh(ssd->qxl.id, ssd->notify);
> >      if (ssd->notify) {
> > @@ -580,7 +581,7 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
> >      SimpleSpiceDisplay *ssd = container_of(sin, SimpleSpiceDisplay, qxl);
> >      int ret;
> >
> > -    qemu_mutex_lock(&ssd->lock);
> > +    QEMU_LOCK_GUARD(&ssd->lock);
> >      if (ssd->ptr_define) {
> >          *ext = ssd->ptr_define->ext;
> >          ssd->ptr_define = NULL;
> > @@ -592,7 +593,6 @@ static int interface_get_cursor_command(QXLInstance *sin, QXLCommandExt *ext)
> >      } else {
> >          ret = false;
> >      }
> > -    qemu_mutex_unlock(&ssd->lock);
> >      return ret;
> >  }
> >
> > diff --git a/util/log.c b/util/log.c
> > index 2da6cb31dc..bdb3d712e8 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/cutils.h"
> >  #include "trace/control.h"
> >  #include "qemu/thread.h"
> > +#include "qemu/lockable.h"
> >
> >  static char *logfilename;
> >  static QemuMutex qemu_logfile_mutex;
> > @@ -94,7 +95,7 @@ void qemu_set_log(int log_flags)
> >      if (qemu_loglevel && (!is_daemonized() || logfilename)) {
> >          need_to_open_file = true;
> >      }
> > -    qemu_mutex_lock(&qemu_logfile_mutex);
> > +    QEMU_LOCK_GUARD(&qemu_logfile_mutex);
> >      if (qemu_logfile && !need_to_open_file) {
> >          logfile = qemu_logfile;
> >          atomic_rcu_set(&qemu_logfile, NULL);
> > @@ -136,7 +137,6 @@ void qemu_set_log(int log_flags)
> >          }
> >          atomic_rcu_set(&qemu_logfile, logfile);
> >      }
> > -    qemu_mutex_unlock(&qemu_logfile_mutex);
> >  }
> >
> >  void qemu_log_needs_buffers(void)
> > diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> > index d548d3c1ad..b6575a2cd5 100644
> > --- a/util/qemu-timer.c
> > +++ b/util/qemu-timer.c
> > @@ -459,17 +459,16 @@ void timer_mod_anticipate_ns(QEMUTimer *ts, int64_t expire_time)
> >      QEMUTimerList *timer_list = ts->timer_list;
> >      bool rearm;
> >
> > -    qemu_mutex_lock(&timer_list->active_timers_lock);
> > -    if (ts->expire_time == -1 || ts->expire_time > expire_time) {
> > -        if (ts->expire_time != -1) {
> > -            timer_del_locked(timer_list, ts);
> > +    WITH_QEMU_LOCK_GUARD(&timer_list->active_timers_lock) {
> > +        if (ts->expire_time == -1 || ts->expire_time > expire_time) {
> > +            if (ts->expire_time != -1) {
> > +                timer_del_locked(timer_list, ts);
> > +            }
> > +            rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
> > +        } else {
> > +            rearm = false;
> >          }
> > -        rearm = timer_mod_ns_locked(timer_list, ts, expire_time);
> > -    } else {
> > -        rearm = false;
> >      }
> > -    qemu_mutex_unlock(&timer_list->active_timers_lock);
> > -
> >      if (rearm) {
> >          timerlist_rearm(timer_list);
> >      }
> > diff --git a/util/rcu.c b/util/rcu.c
> > index 177a675619..60a37f72c3 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -31,6 +31,7 @@
> >  #include "qemu/atomic.h"
> >  #include "qemu/thread.h"
> >  #include "qemu/main-loop.h"
> > +#include "qemu/lockable.h"
> >  #if defined(CONFIG_MALLOC_TRIM)
> >  #include <malloc.h>
> >  #endif
> > @@ -141,14 +142,14 @@ static void wait_for_readers(void)
> >
> >  void synchronize_rcu(void)
> >  {
> > -    qemu_mutex_lock(&rcu_sync_lock);
> > +    QEMU_LOCK_GUARD(&rcu_sync_lock);
> >
> >      /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
> >       * Pairs with smp_mb_placeholder() in rcu_read_lock().
> >       */
> >      smp_mb_global();
> >
> > -    qemu_mutex_lock(&rcu_registry_lock);
> > +    QEMU_LOCK_GUARD(&rcu_registry_lock);
> >      if (!QLIST_EMPTY(&registry)) {
> >          /* In either case, the atomic_mb_set below blocks stores that free
> >           * old RCU-protected pointers.
> > @@ -169,9 +170,6 @@ void synchronize_rcu(void)
> >
> >          wait_for_readers();
> >      }
> > -
> > -    qemu_mutex_unlock(&rcu_registry_lock);
> > -    qemu_mutex_unlock(&rcu_sync_lock);
> >  }
> >
> >
> > diff --git a/util/thread-pool.c b/util/thread-pool.c
> > index 4ed9b89ab2..d763cea505 100644
> > --- a/util/thread-pool.c
> > +++ b/util/thread-pool.c
> > @@ -210,7 +210,7 @@ static void thread_pool_cancel(BlockAIOCB *acb)
> >
> >      trace_thread_pool_cancel(elem, elem->common.opaque);
> >
> > -    qemu_mutex_lock(&pool->lock);
> > +    QEMU_LOCK_GUARD(&pool->lock);
> >      if (elem->state == THREAD_QUEUED &&
> >          /* No thread has yet started working on elem. we can try to "steal"
> >           * the item from the worker if we can get a signal from the
> > @@ -225,7 +225,6 @@ static void thread_pool_cancel(BlockAIOCB *acb)
> >          elem->ret = -ECANCELED;
> >      }
> >
> > -    qemu_mutex_unlock(&pool->lock);
> >  }
> >
> >  static AioContext *thread_pool_get_aio_context(BlockAIOCB *acb)
> > diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> > index ddd9a96e76..b310b23003 100644
> > --- a/util/vfio-helpers.c
> > +++ b/util/vfio-helpers.c
> > @@ -21,6 +21,7 @@
> >  #include "standard-headers/linux/pci_regs.h"
> >  #include "qemu/event_notifier.h"
> >  #include "qemu/vfio-helpers.h"
> > +#include "qemu/lockable.h"
> >  #include "trace.h"
> >
> >  #define QEMU_VFIO_DEBUG 0
> > @@ -667,14 +668,13 @@ int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
> >          .size = QEMU_VFIO_IOVA_MAX - s->high_water_mark,
> >      };
> >      trace_qemu_vfio_dma_reset_temporary(s);
> > -    qemu_mutex_lock(&s->lock);
> > +    QEMU_LOCK_GUARD(&s->lock);
> >      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> >          error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
> >          qemu_mutex_unlock(&s->lock);
> >          return -errno;
> >      }
> >      s->high_water_mark = QEMU_VFIO_IOVA_MAX;
> > -    qemu_mutex_unlock(&s->lock);
> >      return 0;
> >  }
> >
> > --
> > 2.25.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

Daniel


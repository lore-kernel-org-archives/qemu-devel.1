Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C919AC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994072190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994072190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFJo-0005Di-KH
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqFJe-0004pH-CF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqFJd-0006kT-2d
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqFJc-0006jj-PO
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:20:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04E243092666;
 Wed, 24 Jul 2019 11:20:12 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D88ED102483E;
 Wed, 24 Jul 2019 11:20:10 +0000 (UTC)
Date: Wed, 24 Jul 2019 12:20:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <20190724112008.GE2717@work-vm>
References: <20190722150717.10564-1-dgilbert@redhat.com>
 <20190722150717.10564-4-dgilbert@redhat.com>
 <000901d5411b$1b7e1d70$527a5850$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901d5411b$1b7e1d70$527a5850$@ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 24 Jul 2019 11:20:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [for 4.2 PATCH 3/3] timer: last,
 remove last bits of last
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pavel Dovgalyuk (dovgaluk@ispras.ru) wrote:
> Hello!
> 
> > From: Dr. David Alan Gilbert (git) [mailto:dgilbert@redhat.com]
> > The reset notifiers kept a 'last' counter to notice jumps;
> > now that we've remove the notifier we don't need to keep 'last'.
> > replay used to save/restore 'last' (presumably to avoid triggering
> > the notifier);  make it store the current time instead which avoids
> > changing it's migration format.
> 
> If you are removing 'last' field, you also should drop 'host_clock_last'
> from ReplayState, because it is used only for restoring host clock
> 'last' field. And that was useful only in record/replay mode.

OK, I'll cook a v2 that removes it and bumps the version.

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/qemu/timer.h     | 13 -------------
> >  replay/replay-snapshot.c |  3 +--
> >  util/qemu-timer.c        | 22 +---------------------
> >  3 files changed, 2 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> > index 6817c78ef4..5bcab935f6 100644
> > --- a/include/qemu/timer.h
> > +++ b/include/qemu/timer.h
> > @@ -248,19 +248,6 @@ bool qemu_clock_run_timers(QEMUClockType type);
> >   */
> >  bool qemu_clock_run_all_timers(void);
> > 
> > -/**
> > - * qemu_clock_get_last:
> > - *
> > - * Returns last clock query time.
> > - */
> > -uint64_t qemu_clock_get_last(QEMUClockType type);
> > -/**
> > - * qemu_clock_set_last:
> > - *
> > - * Sets last clock query time.
> > - */
> > -void qemu_clock_set_last(QEMUClockType type, uint64_t last);
> > -
> > 
> >  /*
> >   * QEMUTimerList
> > diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> > index 756f48bc02..ca6d4adcc0 100644
> > --- a/replay/replay-snapshot.c
> > +++ b/replay/replay-snapshot.c
> > @@ -24,7 +24,7 @@ static int replay_pre_save(void *opaque)
> >  {
> >      ReplayState *state = opaque;
> >      state->file_offset = ftell(replay_file);
> > -    state->host_clock_last = qemu_clock_get_last(QEMU_CLOCK_HOST);
> > +    state->host_clock_last = get_clock_realtime();
> > 
> >      return 0;
> >  }
> > @@ -34,7 +34,6 @@ static int replay_post_load(void *opaque, int version_id)
> >      ReplayState *state = opaque;
> >      if (replay_mode == REPLAY_MODE_PLAY) {
> >          fseek(replay_file, state->file_offset, SEEK_SET);
> > -        qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
> >          /* If this was a vmstate, saved in recording mode,
> >             we need to initialize replay data fields. */
> >          replay_fetch_data_kind();
> > diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> > index 2faaaf9926..b73041df4e 100644
> > --- a/util/qemu-timer.c
> > +++ b/util/qemu-timer.c
> > @@ -48,8 +48,6 @@ typedef struct QEMUClock {
> >      /* We rely on BQL to protect the timerlists */
> >      QLIST_HEAD(, QEMUTimerList) timerlists;
> > 
> > -    int64_t last;
> > -
> >      QEMUClockType type;
> >      bool enabled;
> >  } QEMUClock;
> > @@ -130,7 +128,6 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB
> > *notify_cb
> > 
> >      clock->type = type;
> >      clock->enabled = (type == QEMU_CLOCK_VIRTUAL ? false : true);
> > -    clock->last = INT64_MIN;
> >      QLIST_INIT(&clock->timerlists);
> >      main_loop_tlg.tl[type] = timerlist_new(type, notify_cb, NULL);
> >  }
> > @@ -628,9 +625,6 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
> > 
> >  int64_t qemu_clock_get_ns(QEMUClockType type)
> >  {
> > -    int64_t now;
> > -    QEMUClock *clock = qemu_clock_ptr(type);
> > -
> >      switch (type) {
> >      case QEMU_CLOCK_REALTIME:
> >          return get_clock();
> > @@ -642,26 +636,12 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
> >              return cpu_get_clock();
> >          }
> >      case QEMU_CLOCK_HOST:
> > -        now = REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
> > -        clock->last = now;
> > -        return now;
> > +        return REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
> >      case QEMU_CLOCK_VIRTUAL_RT:
> >          return REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT, cpu_get_clock());
> >      }
> >  }
> > 
> > -uint64_t qemu_clock_get_last(QEMUClockType type)
> > -{
> > -    QEMUClock *clock = qemu_clock_ptr(type);
> > -    return clock->last;
> > -}
> > -
> > -void qemu_clock_set_last(QEMUClockType type, uint64_t last)
> > -{
> > -    QEMUClock *clock = qemu_clock_ptr(type);
> > -    clock->last = last;
> > -}
> > -
> >  void init_clocks(QEMUTimerListNotifyCB *notify_cb)
> >  {
> >      QEMUClockType type;
> > --
> > 2.21.0
> 
> 
> Pavel Dovgalyuk
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


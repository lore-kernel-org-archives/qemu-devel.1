Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDF7C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CCE214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CCE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMiN-0007sn-Qv
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1irMhN-0006Mz-Pa
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1irMhJ-00012O-7Q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:57:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46980)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1irMhI-00012D-9D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:57:33 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 24415725C0;
 Tue, 14 Jan 2020 16:57:28 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709448356.12933.1621745423878239085.stgit@pasha-Precision-3630-Tower>
 <87y2ubmemp.fsf@linaro.org>
In-Reply-To: <87y2ubmemp.fsf@linaro.org>
Subject: RE: [for-5.0 PATCH 08/11] replay: flush rr queue before loading the
 vmstate
Date: Tue, 14 Jan 2020 16:57:30 +0300
Message-ID: <000c01d5cae2$906f4a90$b14ddfb0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXKOa1++B0fjAmUQgKNbNZ5H98GmwAqMQpA
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:
>=20
> > From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > Non-empty record/replay queue prevents saving and loading the VM =
state,
> > because it includes pending bottom halves and block coroutines.
> > But when the new VM state is loaded, we don't have to preserve the =
consistency
> > of the current state anymore. Therefore this patch just flushes the =
queue
> > allowing the coroutines to finish and removes checking for empty rr =
queue
> > for load_snapshot function.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  include/sysemu/replay.h  |    2 ++
> >  migration/savevm.c       |   12 ++++++------
> >  replay/replay-internal.h |    2 --
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> > index e00ed2f4a5..239c01e7df 100644
> > --- a/include/sysemu/replay.h
> > +++ b/include/sysemu/replay.h
> > @@ -149,6 +149,8 @@ void replay_disable_events(void);
> >  void replay_enable_events(void);
> >  /*! Returns true when saving events is enabled */
> >  bool replay_events_enabled(void);
> > +/* Flushes events queue */
> > +void replay_flush_events(void);
> >  /*! Adds bottom half event to the queue */
> >  void replay_bh_schedule_event(QEMUBH *bh);
> >  /* Adds oneshot bottom half event to the queue */
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index ae84bf6ab0..0c5cac372a 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2834,12 +2834,6 @@ int load_snapshot(const char *name, Error =
**errp)
> >      AioContext *aio_context;
> >      MigrationIncomingState *mis =3D =
migration_incoming_get_current();
> >
> > -    if (!replay_can_snapshot()) {
> > -        error_setg(errp, "Record/replay does not allow loading =
snapshot "
> > -                   "right now. Try once more later.");
> > -        return -EINVAL;
> > -    }
> > -
> >      if (!bdrv_all_can_snapshot(&bs)) {
> >          error_setg(errp,
> >                     "Device '%s' is writable but does not support =
snapshots",
> > @@ -2873,6 +2867,12 @@ int load_snapshot(const char *name, Error =
**errp)
> >          return -EINVAL;
> >      }
> >
> > +    /*
> > +     * Flush the record/replay queue. Now the VM state is going
> > +     * to change. Therefore we don't need to preserve its =
consistency
> > +     */
> > +    replay_flush_events();
> > +
> <snip>
>=20
> This is the commit that introduces:
>=20
>   =
ERROR:/home/alex.bennee/lsrc/qemu.git/replay/replay-events.c:80:replay_fl=
ush_events:
>   assertion failed: (replay_mutex_locked())
>=20
> To the already failing:
>=20
>   /bin/sh -c "cd builds/all && make -j4 && cd tests/qemu-iotests && =
./check -qcow2 267"
>=20
> test case.

Please apply the following update to continue the testing:

--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -77,6 +77,10 @@ bool replay_has_events(void)
=20
 void replay_flush_events(void)
 {
+    if (replay_mode =3D=3D REPLAY_MODE_NONE) {
+        return;
+    }
+

Pavel Dovgalyuk



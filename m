Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA6C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6D52192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmfSSbIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6D52192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWl62-0006If-BL
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWl4j-0005Hm-UZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWl4h-0002bR-8Y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:44:33 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWl4g-0002aG-S5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:44:31 -0500
Received: by mail-lf1-x141.google.com with SMTP id r14so7916565lff.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cYC26/JxbQo5G8YWaxRe5oidEIV9+LzkDqyhQiTBKyA=;
 b=TmfSSbIWtAsJ3/3RuVYrV9PobuLsHebd+60NbFAtUN4zZSEL7LZOPJ5T+ppR0Jlo8E
 M6RjPJO/yNHKfMVA/H4Nve3hC6sRH1X75oZCcNqt3zz6buCuwQOj+6znjiTBtjaedF2K
 WiXt/RYSnsFfbAm1w+YlfLvGiUBIpK47nDW7PkLoxpKGgTy6RwTAwDRy8OQFb6b6HT0E
 uXcvuCe8LoB3SFb5nl/hZ2xmqKMbWGDyKO4RzdvupWVpbA81v7kZFL11KVcx9At1H2UU
 ButPzokSXl7BltuRyXPdNXtQxcbfMAL9j5xEgyf6nkQe362gnXGXyPaCxHtS9IRNQ3vE
 LTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cYC26/JxbQo5G8YWaxRe5oidEIV9+LzkDqyhQiTBKyA=;
 b=YY2JtS9J/412V9vROw0IW6c6r8DkdkTMiwP/vbjsxWLpGhpXJm5wPnPty0jHMHb6w5
 7JZzRCQRO+Cn9XMCQ+sok+HUDPHntLDhF7SdJXcyFWFwVX8tGh2lwoBVyPZgJNKBO+4M
 zZaqNXAq4ep3v3S2huHNzDAJR87KmTjnHz9UGVV3IY4MYMhAjFZLNhIg3VTHdDY56iNi
 aozrkrnmOgNPxC9ohjBq2iTivVXyGcqvtpBprtDAiongdsiFz//Nhe14OoAn2244Du/R
 gO0c3qSEFz4VgkZijSyubQuoNoxG4UghMEakLsUHHnHL1xEJ0yigxi24trwp+XMzip6p
 UZBw==
X-Gm-Message-State: APjAAAUFjWBSfsB0SLDcBF5ojUKFM6FD8ixEXZYDyuI1MMqx5EkIx2IW
 8Ss7/H5gpVbRvHjECMo19cFqwW4fszsK3bEg+EvIdg==
X-Google-Smtp-Source: APXvYqwOT3+n2Z4t4sUYS4WTsPUKrMtnIjafGsOlufD15dBTRMtJCW9fZFwXtO27wjYb/hPoYDzUli6ZwcM2C5iGg3c=
X-Received: by 2002:ac2:46d7:: with SMTP id p23mr470442lfo.104.1574099068835; 
 Mon, 18 Nov 2019 09:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20191115131040.2834-1-robert.foley@linaro.org>
 <20191115131040.2834-6-robert.foley@linaro.org> <87a78tgyr1.fsf@linaro.org>
 <CAEyhzFtAnUATVLGRfG_RkCzfjacw5m9TK4HCjvUg5YWpiV+Ajw@mail.gmail.com>
 <877e3xgvxx.fsf@linaro.org>
 <CAEyhzFtzWgREKr1tq=-myQQ_Esv15Go7UA=0MC6Ko4-9Zgnbqw@mail.gmail.com>
 <874kz1gmr9.fsf@linaro.org>
In-Reply-To: <874kz1gmr9.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 18 Nov 2019 12:44:17 -0500
Message-ID: <CAEyhzFs89bVARpLQ1jay+SsKxQ4h9sSvxS63fz+3VbWpAbX5Aw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] Add use of RCU for qemu_logfile.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Peter Puhov <peter.puhov@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 11:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> >>
> > OK, got it.
> > We will need to make one other change to target/tilegx/translate.c
> > since it conditionally unlocks depending on what qemu_log_lock()
> > returns.
>
> Hmm I'd be tempted to drop the locking all together and drop the final
> log("\n") statement. The reason being the translator can longjmp out of
> the loop if it attempts to translate an instruction in an inaccessible
> page.
>
Good point.  Makes sense to remove the locking and final log("\n").
Will make this change.

Thanks,
-Rob

On Mon, 18 Nov 2019 at 11:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > On Mon, 18 Nov 2019 at 08:23, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >>
> >> Robert Foley <robert.foley@linaro.org> writes:
> >>
> >> > On Mon, 18 Nov 2019 at 07:22, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >> >>
> >> >>
> >> >> > +    if (logfile) {
> >> >> > +        qemu_flockfile(logfile->fd);
> >> >> > +        return logfile->fd;
> >> >> > +    } else {
> >> >> > +        rcu_read_unlock();
> >> >>
> >> >> As qemu_log_lock() and unlock should be paired we can drop the unlo=
ck
> >> >> here and do an unconditional unlock bellow even if a null fd is pas=
sed.
> >> >>
> >> >> Otherwise:
> >> >>
> >> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >>
> >> > Sounds reasonable.  It sounds like we should change it to be somethi=
ng
> >> > like this.
> >> >
> >> > static inline FILE *qemu_log_lock(void)
> >> > {
> >> >     QemuLogFile *logfile;
> >> >     rcu_read_lock();
> >> >     logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >     if (logfile) {
> >> >         qemu_flockfile(logfile->fd);
> >> >         return logfile->fd;
> >> >     }
> >> >     rcu_read_unlock();
> >> >     return NULL;
> >> > }
> >> > I will make the changes.
> >>
> >> No I mean as you have to call qemu_log_unlock() you can to the unlock
> >> there. You have to hold the lock over the usage of the resource:
> >>
> > OK, got it.
> > We will need to make one other change to target/tilegx/translate.c
> > since it conditionally unlocks depending on what qemu_log_lock()
> > returns.
>
> Hmm I'd be tempted to drop the locking all together and drop the final
> log("\n") statement. The reason being the translator can longjmp out of
> the loop if it attempts to translate an instruction in an inaccessible
> page.
>
> >
> > It seems like the right thing to do since it makes all uses of
> > qemu_log_lock() homogeneous in that they will always unconditionally
> > call qemu_log_unlock().
> >
> > I will make the changes.
> >
> > Thanks,
> > -Rob
> >
> > On Mon, 18 Nov 2019 at 08:23, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >>
> >> Robert Foley <robert.foley@linaro.org> writes:
> >>
> >> > On Mon, 18 Nov 2019 at 07:22, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >> >>
> >> >>
> >> >> > +    if (logfile) {
> >> >> > +        qemu_flockfile(logfile->fd);
> >> >> > +        return logfile->fd;
> >> >> > +    } else {
> >> >> > +        rcu_read_unlock();
> >> >>
> >> >> As qemu_log_lock() and unlock should be paired we can drop the unlo=
ck
> >> >> here and do an unconditional unlock bellow even if a null fd is pas=
sed.
> >> >>
> >> >> Otherwise:
> >> >>
> >> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >>
> >> > Sounds reasonable.  It sounds like we should change it to be somethi=
ng
> >> > like this.
> >> >
> >> > static inline FILE *qemu_log_lock(void)
> >> > {
> >> >     QemuLogFile *logfile;
> >> >     rcu_read_lock();
> >> >     logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >     if (logfile) {
> >> >         qemu_flockfile(logfile->fd);
> >> >         return logfile->fd;
> >> >     }
> >> >     rcu_read_unlock();
> >> >     return NULL;
> >> > }
> >> > I will make the changes.
> >>
> >> No I mean as you have to call qemu_log_unlock() you can to the unlock
> >> there. You have to hold the lock over the usage of the resource:
> >>
> >>   static inline FILE *qemu_log_lock(void)
> >>   {
> >>       QemuLogFile *logfile;
> >>       rcu_read_lock();
> >>       logfile =3D atomic_rcu_read(&qemu_logfile);
> >>       if (logfile) {
> >>           qemu_flockfile(logfile->fd);
> >>           return logfile->fd;
> >>       } else {
> >>           return NULL;
> >>       }
> >>   }
> >>
> >>   static inline void qemu_log_unlock(FILE *fd)
> >>   {
> >>       if (fd) {
> >>           qemu_funlockfile(fd);
> >>       }
> >>       rcu_read_unlock();
> >>   }
> >>
> >>
> >> >
> >> > Thanks,
> >> > -Rob
> >> > On Mon, 18 Nov 2019 at 07:22, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
> >> >>
> >> >>
> >> >> Robert Foley <robert.foley@linaro.org> writes:
> >> >>
> >> >> > This now allows changing the logfile while logging is active,
> >> >> > and also solves the issue of a seg fault while changing the logfi=
le.
> >> >> >
> >> >> > Any read access to the qemu_logfile handle will use
> >> >> > the rcu_read_lock()/unlock() around the use of the handle.
> >> >> > To fetch the handle we will use atomic_rcu_read().
> >> >> > We also in many cases do a check for validity of the
> >> >> > logfile handle before using it to deal with the case where the
> >> >> > file is closed and set to NULL.
> >> >> >
> >> >> > The cases where we write to the qemu_logfile will use atomic_rcu_=
set().
> >> >> > Writers will also use call_rcu() with a newly added qemu_logfile_=
free
> >> >> > function for freeing/closing when readers have finished.
> >> >> >
> >> >> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> >> >> > ---
> >> >> > v2
> >> >> >     - No specific changes, just merging in cleanup changes in qem=
u_set_log().
> >> >> > ---
> >> >> > v1
> >> >> >     - Changes for review comments.
> >> >> >     - Minor changes to definition of QemuLogFile.
> >> >> >     - Changed qemu_log_separate() to fix unbalanced and
> >> >> >       remove qemu_log_enabled() check.
> >> >> >     - changed qemu_log_lock() to include else.
> >> >> >     - make qemu_logfile_free static.
> >> >> >     - use g_assert(logfile) in qemu_logfile_free.
> >> >> >     - Relocated unlock out of if/else in qemu_log_close(), and
> >> >> >       in qemu_set_log().
> >> >> > ---
> >> >> >  include/qemu/log.h | 42 +++++++++++++++++++++++----
> >> >> >  util/log.c         | 72 ++++++++++++++++++++++++++++++++--------=
------
> >> >> >  include/exec/log.h | 33 ++++++++++++++++++---
> >> >> >  tcg/tcg.c          | 12 ++++++--
> >> >> >  4 files changed, 126 insertions(+), 33 deletions(-)
> >> >> >
> >> >> > diff --git a/include/qemu/log.h b/include/qemu/log.h
> >> >> > index a7c5b01571..528e1f9dd7 100644
> >> >> > --- a/include/qemu/log.h
> >> >> > +++ b/include/qemu/log.h
> >> >> > @@ -3,9 +3,16 @@
> >> >> >
> >> >> >  /* A small part of this API is split into its own header */
> >> >> >  #include "qemu/log-for-trace.h"
> >> >> > +#include "qemu/rcu.h"
> >> >> > +
> >> >> > +typedef struct QemuLogFile {
> >> >> > +    struct rcu_head rcu;
> >> >> > +    FILE *fd;
> >> >> > +} QemuLogFile;
> >> >> >
> >> >> >  /* Private global variable, don't use */
> >> >> > -extern FILE *qemu_logfile;
> >> >> > +extern QemuLogFile *qemu_logfile;
> >> >> > +
> >> >> >
> >> >> >  /*
> >> >> >   * The new API:
> >> >> > @@ -25,7 +32,16 @@ static inline bool qemu_log_enabled(void)
> >> >> >   */
> >> >> >  static inline bool qemu_log_separate(void)
> >> >> >  {
> >> >> > -    return qemu_logfile !=3D NULL && qemu_logfile !=3D stderr;
> >> >> > +    QemuLogFile *logfile;
> >> >> > +    bool res =3D false;
> >> >> > +
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile && logfile->fd !=3D stderr) {
> >> >> > +        res =3D true;
> >> >> > +    }
> >> >> > +    rcu_read_unlock();
> >> >> > +    return res;
> >> >> >  }
> >> >> >
> >> >> >  #define CPU_LOG_TB_OUT_ASM (1 << 0)
> >> >> > @@ -55,14 +71,23 @@ static inline bool qemu_log_separate(void)
> >> >> >
> >> >> >  static inline FILE *qemu_log_lock(void)
> >> >> >  {
> >> >> > -    qemu_flockfile(qemu_logfile);
> >> >> > -    return logfile->fd;
> >> >> > +    QemuLogFile *logfile;
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        qemu_flockfile(logfile->fd);
> >> >> > +        return logfile->fd;
> >> >> > +    } else {
> >> >> > +        rcu_read_unlock();
> >> >>
> >> >> As qemu_log_lock() and unlock should be paired we can drop the unlo=
ck
> >> >> here and do an unconditional unlock bellow even if a null fd is pas=
sed.
> >> >>
> >> >> Otherwise:
> >> >>
> >> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >>
> >> >> > +        return NULL;
> >> >> > +    }
> >> >> >  }
> >> >> >
> >> >> >  static inline void qemu_log_unlock(FILE *fd)
> >> >> >  {
> >> >> >      if (fd) {
> >> >> >          qemu_funlockfile(fd);
> >> >> > +        rcu_read_unlock();
> >> >> >      }
> >> >> >  }
> >> >> >
> >> >> > @@ -73,9 +98,14 @@ static inline void qemu_log_unlock(FILE *fd)
> >> >> >  static inline void GCC_FMT_ATTR(1, 0)
> >> >> >  qemu_log_vprintf(const char *fmt, va_list va)
> >> >> >  {
> >> >> > -    if (qemu_logfile) {
> >> >> > -        vfprintf(qemu_logfile, fmt, va);
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        vfprintf(logfile->fd, fmt, va);
> >> >> >      }
> >> >> > +    rcu_read_unlock();
> >> >> >  }
> >> >> >
> >> >> >  /* log only if a bit is set on the current loglevel mask:
> >> >> > diff --git a/util/log.c b/util/log.c
> >> >> > index 91ebb5c924..9f9b6b74b7 100644
> >> >> > --- a/util/log.c
> >> >> > +++ b/util/log.c
> >> >> > @@ -28,7 +28,7 @@
> >> >> >
> >> >> >  static char *logfilename;
> >> >> >  static QemuMutex qemu_logfile_mutex;
> >> >> > -FILE *qemu_logfile;
> >> >> > +QemuLogFile *qemu_logfile;
> >> >> >  int qemu_loglevel;
> >> >> >  static int log_append =3D 0;
> >> >> >  static GArray *debug_regions;
> >> >> > @@ -37,10 +37,14 @@ static GArray *debug_regions;
> >> >> >  int qemu_log(const char *fmt, ...)
> >> >> >  {
> >> >> >      int ret =3D 0;
> >> >> > -    if (qemu_logfile) {
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> >          va_list ap;
> >> >> >          va_start(ap, fmt);
> >> >> > -        ret =3D vfprintf(qemu_logfile, fmt, ap);
> >> >> > +        ret =3D vfprintf(logfile->fd, fmt, ap);
> >> >> >          va_end(ap);
> >> >> >
> >> >> >          /* Don't pass back error results.  */
> >> >> > @@ -48,6 +52,7 @@ int qemu_log(const char *fmt, ...)
> >> >> >              ret =3D 0;
> >> >> >          }
> >> >> >      }
> >> >> > +    rcu_read_unlock();
> >> >> >      return ret;
> >> >> >  }
> >> >> >
> >> >> > @@ -56,12 +61,24 @@ static void __attribute__((__constructor__)) =
qemu_logfile_init(void)
> >> >> >      qemu_mutex_init(&qemu_logfile_mutex);
> >> >> >  }
> >> >> >
> >> >> > +static void qemu_logfile_free(QemuLogFile *logfile)
> >> >> > +{
> >> >> > +    g_assert(logfile);
> >> >> > +
> >> >> > +    if (logfile->fd !=3D stderr) {
> >> >> > +        fclose(logfile->fd);
> >> >> > +    }
> >> >> > +    g_free(logfile);
> >> >> > +}
> >> >> > +
> >> >> >  static bool log_uses_own_buffers;
> >> >> >
> >> >> >  /* enable or disable low levels log */
> >> >> >  void qemu_set_log(int log_flags)
> >> >> >  {
> >> >> >      bool need_to_open_file =3D false;
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> >      qemu_loglevel =3D log_flags;
> >> >> >  #ifdef CONFIG_TRACE_LOG
> >> >> >      qemu_loglevel |=3D LOG_TRACE;
> >> >> > @@ -80,43 +97,47 @@ void qemu_set_log(int log_flags)
> >> >> >      g_assert(qemu_logfile_mutex.initialized);
> >> >> >      qemu_mutex_lock(&qemu_logfile_mutex);
> >> >> >      if (qemu_logfile && !need_to_open_file) {
> >> >> > -        qemu_mutex_unlock(&qemu_logfile_mutex);
> >> >> > -        qemu_log_close();
> >> >> > +        logfile =3D qemu_logfile;
> >> >> > +        atomic_rcu_set(&qemu_logfile, NULL);
> >> >> > +        call_rcu(logfile, qemu_logfile_free, rcu);
> >> >> >      } else if (!qemu_logfile && need_to_open_file) {
> >> >> > +        logfile =3D g_new0(QemuLogFile, 1);
> >> >> >          if (logfilename) {
> >> >> > -            qemu_logfile =3D fopen(logfilename, log_append ? "a"=
 : "w");
> >> >> > -            if (!qemu_logfile) {
> >> >> > +            logfile->fd =3D fopen(logfilename, log_append ? "a" =
: "w");
> >> >> > +            if (!logfile->fd) {
> >> >> > +                g_free(logfile);
> >> >> >                  perror(logfilename);
> >> >> >                  _exit(1);
> >> >> >              }
> >> >> >              /* In case we are a daemon redirect stderr to logfil=
e */
> >> >> >              if (is_daemonized()) {
> >> >> > -                dup2(fileno(qemu_logfile), STDERR_FILENO);
> >> >> > -                fclose(qemu_logfile);
> >> >> > +                dup2(fileno(logfile->fd), STDERR_FILENO);
> >> >> > +                fclose(logfile->fd);
> >> >> >                  /* This will skip closing logfile in qemu_log_cl=
ose() */
> >> >> > -                qemu_logfile =3D stderr;
> >> >> > +                logfile->fd =3D stderr;
> >> >> >              }
> >> >> >          } else {
> >> >> >              /* Default to stderr if no log file specified */
> >> >> >              assert(!is_daemonized());
> >> >> > -            qemu_logfile =3D stderr;
> >> >> > +            logfile->fd =3D stderr;
> >> >> >          }
> >> >> >          /* must avoid mmap() usage of glibc by setting a buffer =
"by hand" */
> >> >> >          if (log_uses_own_buffers) {
> >> >> >              static char logfile_buf[4096];
> >> >> >
> >> >> > -            setvbuf(qemu_logfile, logfile_buf, _IOLBF, sizeof(lo=
gfile_buf));
> >> >> > +            setvbuf(logfile->fd, logfile_buf, _IOLBF, sizeof(log=
file_buf));
> >> >> >          } else {
> >> >> >  #if defined(_WIN32)
> >> >> >              /* Win32 doesn't support line-buffering, so use unbu=
ffered output. */
> >> >> > -            setvbuf(qemu_logfile, NULL, _IONBF, 0);
> >> >> > +            setvbuf(logfile->fd, NULL, _IONBF, 0);
> >> >> >  #else
> >> >> > -            setvbuf(qemu_logfile, NULL, _IOLBF, 0);
> >> >> > +            setvbuf(logfile->fd, NULL, _IOLBF, 0);
> >> >> >  #endif
> >> >> >              log_append =3D 1;
> >> >> >          }
> >> >> > -        qemu_mutex_unlock(&qemu_logfile_mutex);
> >> >> > +        atomic_rcu_set(&qemu_logfile, logfile);
> >> >> >      }
> >> >> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
> >> >> >  }
> >> >> >
> >> >> >  void qemu_log_needs_buffers(void)
> >> >> > @@ -245,19 +266,28 @@ out:
> >> >> >  /* fflush() the log file */
> >> >> >  void qemu_log_flush(void)
> >> >> >  {
> >> >> > -    fflush(qemu_logfile);
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        fflush(logfile->fd);
> >> >> > +    }
> >> >> > +    rcu_read_unlock();
> >> >> >  }
> >> >> >
> >> >> >  /* Close the log file */
> >> >> >  void qemu_log_close(void)
> >> >> >  {
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> >      g_assert(qemu_logfile_mutex.initialized);
> >> >> >      qemu_mutex_lock(&qemu_logfile_mutex);
> >> >> > -    if (qemu_logfile) {
> >> >> > -        if (qemu_logfile !=3D stderr) {
> >> >> > -            fclose(qemu_logfile);
> >> >> > -        }
> >> >> > -        qemu_logfile =3D NULL;
> >> >> > +    logfile =3D qemu_logfile;
> >> >> > +
> >> >> > +    if (logfile) {
> >> >> > +        atomic_rcu_set(&qemu_logfile, NULL);
> >> >> > +        call_rcu(logfile, qemu_logfile_free, rcu);
> >> >> >      }
> >> >> >      qemu_mutex_unlock(&qemu_logfile_mutex);
> >> >> >  }
> >> >> >  diff --git a/include/exec/log.h b/include/exec/log.h
> >> >> > index e2cfd436e6..9bd1e4aa20 100644
> >> >> > --- a/include/exec/log.h
> >> >> > +++ b/include/exec/log.h
> >> >> > @@ -15,8 +15,15 @@
> >> >> >   */
> >> >> >  static inline void log_cpu_state(CPUState *cpu, int flags)
> >> >> >  {
> >> >> > +    QemuLogFile *logfile;
> >> >> > +
> >> >> >      if (qemu_log_enabled()) {
> >> >> > -        cpu_dump_state(cpu, qemu_logfile, flags);
> >> >> > +        rcu_read_lock();
> >> >> > +        logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +        if (logfile) {
> >> >> > +            cpu_dump_state(cpu, logfile->fd, flags);
> >> >> > +        }
> >> >> > +        rcu_read_unlock();
> >> >> >      }
> >> >> >  }
> >> >> >
> >> >> > @@ -40,19 +47,37 @@ static inline void log_cpu_state_mask(int mas=
k, CPUState *cpu, int flags)
> >> >> >  static inline void log_target_disas(CPUState *cpu, target_ulong =
start,
> >> >> >                                      target_ulong len)
> >> >> >  {
> >> >> > -    target_disas(qemu_logfile, cpu, start, len);
> >> >> > +    QemuLogFile *logfile;
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        target_disas(logfile->fd, cpu, start, len);
> >> >> > +    }
> >> >> > +    rcu_read_unlock();
> >> >> >  }
> >> >> >
> >> >> >  static inline void log_disas(void *code, unsigned long size)
> >> >> >  {
> >> >> > -    disas(qemu_logfile, code, size);
> >> >> > +    QemuLogFile *logfile;
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        disas(logfile->fd, code, size);
> >> >> > +    }
> >> >> > +    rcu_read_unlock();
> >> >> >  }
> >> >> >
> >> >> >  #if defined(CONFIG_USER_ONLY)
> >> >> >  /* page_dump() output to the log file: */
> >> >> >  static inline void log_page_dump(void)
> >> >> >  {
> >> >> > -    page_dump(qemu_logfile);
> >> >> > +    QemuLogFile *logfile;
> >> >> > +    rcu_read_lock();
> >> >> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +    if (logfile) {
> >> >> > +        page_dump(logfile->fd);
> >> >> > +    }
> >> >> > +    rcu_read_unlock();
> >> >> >  }
> >> >> >  #endif
> >> >> >  #endif
> >> >> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> >> >> > index 0511266d85..4f616ba38b 100644
> >> >> > --- a/tcg/tcg.c
> >> >> > +++ b/tcg/tcg.c
> >> >> > @@ -2114,9 +2114,17 @@ static void tcg_dump_ops(TCGContext *s, bo=
ol have_prefs)
> >> >> >          }
> >> >> >
> >> >> >          if (have_prefs || op->life) {
> >> >> > -            for (; col < 40; ++col) {
> >> >> > -                putc(' ', qemu_logfile);
> >> >> > +
> >> >> > +            QemuLogFile *logfile;
> >> >> > +
> >> >> > +            rcu_read_lock();
> >> >> > +            logfile =3D atomic_rcu_read(&qemu_logfile);
> >> >> > +            if (logfile) {
> >> >> > +                for (; col < 40; ++col) {
> >> >> > +                    putc(' ', logfile->fd);
> >> >> > +                }
> >> >> >              }
> >> >> > +            rcu_read_unlock();
> >> >> >          }
> >> >> >
> >> >> >          if (op->life) {
> >> >>
> >> >>
> >> >> --
> >> >> Alex Benn=C3=A9e
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
>
>
> --
> Alex Benn=C3=A9e


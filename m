Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D872C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AA520818
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqM9qd6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AA520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUbjx-0005BT-C9
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 14:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUbiu-0004fh-JC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUbis-00082J-8p
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:21:08 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUbir-00080m-SB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 14:21:06 -0500
Received: by mail-lf1-x144.google.com with SMTP id b20so13801039lfp.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Isvv5/hE7y6zpOC1plHGuknSg88MeLjbFxPeItOVdS8=;
 b=MqM9qd6dVuihoouop9zf0ndc3ZU8gt6aLswSRfvs1XYLPJO2eYd0aqNObGVcn0AG7U
 qBvRHoafpbCtVwj8EOhETT7ApLDNOfxvUO0CrlmJVCVK3YTcky7a5Qe75Uxwrpbrox5T
 6e77kuhsveAv4uIim6/ONlA7LJTfR3bgMoMpUSgIeuRjHF4wFqCebvRRNgWGGQimoJkG
 G6pEnWlSSfVRkrI1itEm20qBA3cxTwaU8g3j0suXiffLC0vLxgKZZb1Q/W1xehT2+6/J
 Syd3DR9fhMKqC9s3SgslQhR+zU+TGIm5OxFT+38xAhRGkOuTydV1dRX57ffULJMWDt3h
 tU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Isvv5/hE7y6zpOC1plHGuknSg88MeLjbFxPeItOVdS8=;
 b=jrBTZql3S56WZi6eWC/W8MgNzOOW8roCUbgzt/cnu/Zlx5zIXyReTY1ySCxOkc+4xf
 G2aJEBCFjERjXt3Fzm4P6u4lWCM3PVo0Rv+P3exc2sPWdiX4Z0LYEGG6lck9eMKUJSf1
 gSZWdUynboVz8XkhHlgz1Aeuhyn/d39W7NF5qTyH7e7OPARvsHm/7ZUYYUppewq/UdBp
 peMSriBs/MhCCmdEszkqKPMEbXAqH8MWpySEfMvbuM0U49pfaZpQVlZ3Q2XxTYO7RbVx
 g1n4EnzTE9q6syOM4oAfUOhIx9JkgOYGN417absBJmfrxU+aMPJBUyqMhGm9wxFUT0L8
 n1Mg==
X-Gm-Message-State: APjAAAUYh/gjisgzvXdhlQ8sxpbIfmW9sqR3N+7xsajOXiBjTyfnM6lv
 lTw3ZsLfuTtay6NvAg3ujBWSZN31WVZ7Bn8tZtcqbw==
X-Google-Smtp-Source: APXvYqz+6PXoDpYT+n8u/XQtT/QCuz0zWBaYm4+jNovf061YrVI1wXbZ0f+mS2IZEIas38hzvdWIohVmVRvuM+xN0Dw=
X-Received: by 2002:a19:4f09:: with SMTP id d9mr10910181lfb.179.1573586463509; 
 Tue, 12 Nov 2019 11:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-4-robert.foley@linaro.org> <87lfsl809m.fsf@linaro.org>
In-Reply-To: <87lfsl809m.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 12 Nov 2019 14:20:52 -0500
Message-ID: <CAEyhzFtk4uewBK9dY1SpJh4UVn7g3Pd8qCvqhskJX38ci9jWSA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] Add use of RCU for qemu_logfile.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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

On Tue, 12 Nov 2019 at 12:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> >          }
> > +        atomic_rcu_set(&qemu_logfile, logfile);
> >      }
> > -    qemu_mutex_unlock(&qemu_logfile_mutex);
> > +    logfile =3D qemu_logfile;
>
> Isn't this read outside of the protection of both rcu_read_lock() and
> the mutex? Could that race?

This assignment is under the mutex.  This change moved the mutex
unlock towards the end of the function, just a few lines below the
call_rcu().

> > +
> >      if (qemu_logfile &&
> >          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) =
{
> > -        qemu_log_close();
> > +        atomic_rcu_set(&qemu_logfile, NULL);
> > +        call_rcu(logfile, qemu_logfile_free, rcu);
>
> I wonder if we can re-arrange the logic here so it's lets confusing? For
> example the NULL qemu_loglevel can be detected at the start and we
> should be able just to squash the current log and reset and go. I'm not
> sure about the damonize/stdout check.
>
> >      }
> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
> >  }
> >

Absolutely, the logic that was here originally can be improved.  We
found it confusing also.
We could move things around a bit and change it to something like this
to help clarify.

    bool need_to_open_file =3D false;
    /*
     * In all cases we only log if qemu_loglevel is set.
     * And:
     *     If not daemonized we will always log either to stderr
     *       or to a file (if there is a logfilename).
     *     If we are daemonized,
     *       we will only log if there is a logfilename.
     */
    if (qemu_loglevel && (!is_daemonized() || logfilename) {
        need_to_open_file =3D true;
    }
    g_assert(qemu_logfile_mutex.initialized);
    qemu_mutex_lock(&qemu_logfile_mutex);

    if(qemu_logfile && !need_to_open_file) {
        /* Close file. */
        QemuLogFile *logfile =3D qemu_logfile;
        atomic_rcu_set(&qemu_logfile, NULL);
        call_rcu(logfile, qemu_logfile_free, rcu);
    } else if(!qemu_logfile && need_to_open_file) {
        logfile =3D g_new0(QemuLogFile, 1);
       __snip__ existing patch logic for opening the qemu_logfile will
be inserted here.
    }
    qemu_mutex_unlock(&qemu_logfile_mutex);

> >  {
> >      char *pidstr;
> > +
> >      g_free(logfilename);
>
> nit: stray newline

Will remove the newline.

Thanks,
Rob

On Tue, 12 Nov 2019 at 12:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This now allows changing the logfile while logging is active,
> > and also solves the issue of a seg fault while changing the logfile.
> >
> > Any read access to the qemu_logfile handle will use
> > the rcu_read_lock()/unlock() around the use of the handle.
> > To fetch the handle we will use atomic_rcu_read().
> > We also in many cases do a check for validity of the
> > logfile handle before using it to deal with the case where the
> > file is closed and set to NULL.
> >
> > The cases where we write to the qemu_logfile will use atomic_rcu_set().
> > Writers will also use call_rcu() with a newly added qemu_logfile_free
> > function for freeing/closing when readers have finished.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> > v1
> >     - Changes for review comments.
> >     - Minor changes to definition of QemuLogFile.
> >     - Changed qemu_log_separate() to fix unbalanced and
> >       remove qemu_log_enabled() check.
> >     - changed qemu_log_lock() to include else.
> >     - make qemu_logfile_free static.
> >     - use g_assert(logfile) in qemu_logfile_free.
> >     - Relocated unlock out of if/else in qemu_log_close(), and
> >       in qemu_set_log().
> > ---
> >  include/qemu/log.h | 42 ++++++++++++++++++++++----
> >  util/log.c         | 73 +++++++++++++++++++++++++++++++++-------------
> >  include/exec/log.h | 33 ++++++++++++++++++---
> >  tcg/tcg.c          | 12 ++++++--
> >  4 files changed, 128 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/qemu/log.h b/include/qemu/log.h
> > index a7c5b01571..528e1f9dd7 100644
> > --- a/include/qemu/log.h
> > +++ b/include/qemu/log.h
> > @@ -3,9 +3,16 @@
> >
> >  /* A small part of this API is split into its own header */
> >  #include "qemu/log-for-trace.h"
> > +#include "qemu/rcu.h"
> > +
> > +typedef struct QemuLogFile {
> > +    struct rcu_head rcu;
> > +    FILE *fd;
> > +} QemuLogFile;
> >
> >  /* Private global variable, don't use */
> > -extern FILE *qemu_logfile;
> > +extern QemuLogFile *qemu_logfile;
> > +
> >
> >  /*
> >   * The new API:
> > @@ -25,7 +32,16 @@ static inline bool qemu_log_enabled(void)
> >   */
> >  static inline bool qemu_log_separate(void)
> >  {
> > -    return qemu_logfile !=3D NULL && qemu_logfile !=3D stderr;
> > +    QemuLogFile *logfile;
> > +    bool res =3D false;
> > +
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile && logfile->fd !=3D stderr) {
> > +        res =3D true;
> > +    }
> > +    rcu_read_unlock();
> > +    return res;
> >  }
> >
> >  #define CPU_LOG_TB_OUT_ASM (1 << 0)
> > @@ -55,14 +71,23 @@ static inline bool qemu_log_separate(void)
> >
> >  static inline FILE *qemu_log_lock(void)
> >  {
> > -    qemu_flockfile(qemu_logfile);
> > -    return logfile->fd;
> > +    QemuLogFile *logfile;
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        qemu_flockfile(logfile->fd);
> > +        return logfile->fd;
> > +    } else {
> > +        rcu_read_unlock();
> > +        return NULL;
> > +    }
> >  }
> >
> >  static inline void qemu_log_unlock(FILE *fd)
> >  {
> >      if (fd) {
> >          qemu_funlockfile(fd);
> > +        rcu_read_unlock();
> >      }
> >  }
> >
> > @@ -73,9 +98,14 @@ static inline void qemu_log_unlock(FILE *fd)
> >  static inline void GCC_FMT_ATTR(1, 0)
> >  qemu_log_vprintf(const char *fmt, va_list va)
> >  {
> > -    if (qemu_logfile) {
> > -        vfprintf(qemu_logfile, fmt, va);
> > +    QemuLogFile *logfile;
> > +
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        vfprintf(logfile->fd, fmt, va);
> >      }
> > +    rcu_read_unlock();
> >  }
> >
> >  /* log only if a bit is set on the current loglevel mask:
> > diff --git a/util/log.c b/util/log.c
> > index c25643dc99..802b8de42e 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -28,7 +28,7 @@
> >
> >  static char *logfilename;
> >  static QemuMutex qemu_logfile_mutex;
> > -FILE *qemu_logfile;
> > +QemuLogFile *qemu_logfile;
> >  int qemu_loglevel;
> >  static int log_append =3D 0;
> >  static GArray *debug_regions;
> > @@ -37,10 +37,14 @@ static GArray *debug_regions;
> >  int qemu_log(const char *fmt, ...)
> >  {
> >      int ret =3D 0;
> > -    if (qemu_logfile) {
> > +    QemuLogFile *logfile;
> > +
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> >          va_list ap;
> >          va_start(ap, fmt);
> > -        ret =3D vfprintf(qemu_logfile, fmt, ap);
> > +        ret =3D vfprintf(logfile->fd, fmt, ap);
> >          va_end(ap);
> >
> >          /* Don't pass back error results.  */
> > @@ -48,6 +52,7 @@ int qemu_log(const char *fmt, ...)
> >              ret =3D 0;
> >          }
> >      }
> > +    rcu_read_unlock();
> >      return ret;
> >  }
> >
> > @@ -56,11 +61,23 @@ static void __attribute__((__constructor__)) qemu_l=
ogfile_init(void)
> >      qemu_mutex_init(&qemu_logfile_mutex);
> >  }
> >
> > +static void qemu_logfile_free(QemuLogFile *logfile)
> > +{
> > +    g_assert(logfile);
> > +
> > +    if (logfile->fd !=3D stderr) {
> > +        fclose(logfile->fd);
> > +    }
> > +    g_free(logfile);
> > +}
> > +
> >  static bool log_uses_own_buffers;
> >
> >  /* enable or disable low levels log */
> >  void qemu_set_log(int log_flags)
> >  {
> > +    QemuLogFile *logfile;
> > +
> >      qemu_loglevel =3D log_flags;
> >  #ifdef CONFIG_TRACE_LOG
> >      qemu_loglevel |=3D LOG_TRACE;
> > @@ -70,44 +87,50 @@ void qemu_set_log(int log_flags)
> >      qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (!qemu_logfile &&
> >          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> > +        logfile =3D g_new0(QemuLogFile, 1);
> >          if (logfilename) {
> > -            qemu_logfile =3D fopen(logfilename, log_append ? "a" : "w"=
);
> > -            if (!qemu_logfile) {
> > +            logfile->fd =3D fopen(logfilename, log_append ? "a" : "w")=
;
> > +            if (!logfile->fd) {
> > +                g_free(logfile);
> >                  perror(logfilename);
> >                  _exit(1);
> >              }
> >              /* In case we are a daemon redirect stderr to logfile */
> >              if (is_daemonized()) {
> > -                dup2(fileno(qemu_logfile), STDERR_FILENO);
> > -                fclose(qemu_logfile);
> > +                dup2(fileno(logfile->fd), STDERR_FILENO);
> > +                fclose(logfile->fd);
> >                  /* This will skip closing logfile in qemu_log_close() =
*/
> > -                qemu_logfile =3D stderr;
> > +                logfile->fd =3D stderr;
> >              }
> >          } else {
> >              /* Default to stderr if no log file specified */
> >              assert(!is_daemonized());
> > -            qemu_logfile =3D stderr;
> > +            logfile->fd =3D stderr;
> >          }
> >          /* must avoid mmap() usage of glibc by setting a buffer "by ha=
nd" */
> >          if (log_uses_own_buffers) {
> >              static char logfile_buf[4096];
> >
> > -            setvbuf(qemu_logfile, logfile_buf, _IOLBF, sizeof(logfile_=
buf));
> > +            setvbuf(logfile->fd, logfile_buf, _IOLBF, sizeof(logfile_b=
uf));
> >          } else {
> >  #if defined(_WIN32)
> >              /* Win32 doesn't support line-buffering, so use unbuffered=
 output. */
> > -            setvbuf(qemu_logfile, NULL, _IONBF, 0);
> > +            setvbuf(logfile->fd, NULL, _IONBF, 0);
> >  #else
> > -            setvbuf(qemu_logfile, NULL, _IOLBF, 0);
> > +            setvbuf(logfile->fd, NULL, _IOLBF, 0);
> >  #endif
> >              log_append =3D 1;
> >          }
> > +        atomic_rcu_set(&qemu_logfile, logfile);
> >      }
> > -    qemu_mutex_unlock(&qemu_logfile_mutex);
> > +    logfile =3D qemu_logfile;
>
> Isn't this read outside of the protection of both rcu_read_lock() and
> the mutex? Could that race?
>
> > +
> >      if (qemu_logfile &&
> >          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) =
{
> > -        qemu_log_close();
> > +        atomic_rcu_set(&qemu_logfile, NULL);
> > +        call_rcu(logfile, qemu_logfile_free, rcu);
>
> I wonder if we can re-arrange the logic here so it's lets confusing? For
> example the NULL qemu_loglevel can be detected at the start and we
> should be able just to squash the current log and reset and go. I'm not
> sure about the damonize/stdout check.
>
> >      }
> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
> >  }
> >
> >  void qemu_log_needs_buffers(void)
> > @@ -123,6 +146,7 @@ void qemu_log_needs_buffers(void)
> >  void qemu_set_log_filename(const char *filename, Error **errp)
> >  {
> >      char *pidstr;
> > +
> >      g_free(logfilename);
>
> nit: stray newline
> >
> >      pidstr =3D strstr(filename, "%");
> > @@ -235,19 +259,28 @@ out:
> >  /* fflush() the log file */
> >  void qemu_log_flush(void)
> >  {
> > -    fflush(qemu_logfile);
> > +    QemuLogFile *logfile;
> > +
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        fflush(logfile->fd);
> > +    }
> > +    rcu_read_unlock();
> >  }
> >
> >  /* Close the log file */
> >  void qemu_log_close(void)
> >  {
> > +    QemuLogFile *logfile;
> > +
> >      g_assert(qemu_logfile_mutex.initialized);
> >      qemu_mutex_lock(&qemu_logfile_mutex);
> > -    if (qemu_logfile) {
> > -        if (qemu_logfile !=3D stderr) {
> > -            fclose(qemu_logfile);
> > -        }
> > -        qemu_logfile =3D NULL;
> > +    logfile =3D qemu_logfile;
> > +
> > +    if (logfile) {
> > +        atomic_rcu_set(&qemu_logfile, NULL);
> > +        call_rcu(logfile, qemu_logfile_free, rcu);
> >      }
> >      qemu_mutex_unlock(&qemu_logfile_mutex);
> >  }
> > diff --git a/include/exec/log.h b/include/exec/log.h
> > index e2cfd436e6..9bd1e4aa20 100644
> > --- a/include/exec/log.h
> > +++ b/include/exec/log.h
> > @@ -15,8 +15,15 @@
> >   */
> >  static inline void log_cpu_state(CPUState *cpu, int flags)
> >  {
> > +    QemuLogFile *logfile;
> > +
> >      if (qemu_log_enabled()) {
> > -        cpu_dump_state(cpu, qemu_logfile, flags);
> > +        rcu_read_lock();
> > +        logfile =3D atomic_rcu_read(&qemu_logfile);
> > +        if (logfile) {
> > +            cpu_dump_state(cpu, logfile->fd, flags);
> > +        }
> > +        rcu_read_unlock();
> >      }
> >  }
> >
> > @@ -40,19 +47,37 @@ static inline void log_cpu_state_mask(int mask, CPU=
State *cpu, int flags)
> >  static inline void log_target_disas(CPUState *cpu, target_ulong start,
> >                                      target_ulong len)
> >  {
> > -    target_disas(qemu_logfile, cpu, start, len);
> > +    QemuLogFile *logfile;
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        target_disas(logfile->fd, cpu, start, len);
> > +    }
> > +    rcu_read_unlock();
> >  }
> >
> >  static inline void log_disas(void *code, unsigned long size)
> >  {
> > -    disas(qemu_logfile, code, size);
> > +    QemuLogFile *logfile;
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        disas(logfile->fd, code, size);
> > +    }
> > +    rcu_read_unlock();
> >  }
> >
> >  #if defined(CONFIG_USER_ONLY)
> >  /* page_dump() output to the log file: */
> >  static inline void log_page_dump(void)
> >  {
> > -    page_dump(qemu_logfile);
> > +    QemuLogFile *logfile;
> > +    rcu_read_lock();
> > +    logfile =3D atomic_rcu_read(&qemu_logfile);
> > +    if (logfile) {
> > +        page_dump(logfile->fd);
> > +    }
> > +    rcu_read_unlock();
> >  }
> >  #endif
> >  #endif
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index 0511266d85..4f616ba38b 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -2114,9 +2114,17 @@ static void tcg_dump_ops(TCGContext *s, bool hav=
e_prefs)
> >          }
> >
> >          if (have_prefs || op->life) {
> > -            for (; col < 40; ++col) {
> > -                putc(' ', qemu_logfile);
> > +
> > +            QemuLogFile *logfile;
> > +
> > +            rcu_read_lock();
> > +            logfile =3D atomic_rcu_read(&qemu_logfile);
> > +            if (logfile) {
> > +                for (; col < 40; ++col) {
> > +                    putc(' ', logfile->fd);
> > +                }
> >              }
> > +            rcu_read_unlock();
> >          }
> >
> >          if (op->life) {
>
>
> --
> Alex Benn=C3=A9e


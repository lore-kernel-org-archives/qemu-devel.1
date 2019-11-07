Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C10BC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B9B2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAlxggJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B9B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSpld-0000W3-TD
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 16:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSpjl-00081x-EJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSpjf-0003FQ-3C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:54:36 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSpje-0003E2-Ow
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:54:34 -0500
Received: by mail-lf1-x144.google.com with SMTP id f4so2799883lfk.7
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vr1IAr+SeEX1UUQXg9a5hSKfI+D3X+5R5G9YrrzO9zM=;
 b=bAlxggJq4iXz2xGvaFjYrH++ic/OAOlGQZQ4TQBGg6O7xm9LFv6MPfioE+lkV2zcX2
 yKqJuPcts9uEr8j9LvKmrG78rbK2pnYm3U7o6H9XrLe9rMluPoTXEBzHJsb6yM5fZ8jk
 RSJa5ChG1NLWEetE5prXL+UdLzTioMylqlJvSlTc72uq2QEF6raaiXGkZFIK7Sy+J7OC
 A7rFEqPDiuoYiqOntvuy6Bx3ihJj20pYWyT3FKP7pP2TnLiUakFCiRFeTsGV0yzJKdRe
 b/s+8rRbAxNHzr/ur/ECKJwLm9xNTXww17bZEs5eoDOxsv2jpppfrOeNM64e5l0Y+SNF
 kJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vr1IAr+SeEX1UUQXg9a5hSKfI+D3X+5R5G9YrrzO9zM=;
 b=RvrF+laWLHHe6xSRKQYoo0fAN3B3Coq/ChNo7yYU8JgWkG0Q6UqLUcTCiCJ8OUfbVf
 mmO+Xi2EmHn/tYuLlFVP3/WFQHoVeu5uzXfqt7jALpAP+XAQvBGcNEJl/RvvRjhLDet4
 I0CVRDRuqgey0IVuj6QWj9qS7cvW+niVbaMZ+RKYSPcyjaQb4i+mG8Y79F8jeeFQOor7
 P9InppWBv2jAaagqZhHpV9JT3K0L6b5O2/HK7NyLR2l8vZNao7xwb14c0BnMDY8Um/PE
 W5dAo0xrurgghXI+eQGGPojnuPFiidsBGreop3nIEi2OYpSmJKLEpevu8VdUJfhlrF7T
 guNQ==
X-Gm-Message-State: APjAAAV7rLd3qt8Pytgyt5dVuiZYe9+9ZKtC2Y2wcKTcNcd65VKMs17r
 EcOmeDZuNJutqbI9wG2ztvBaUTOE+VuQUwP7c3rmiw==
X-Google-Smtp-Source: APXvYqzove4l6ZUZHtU4U91u1EoV2Bf6E1rASVQ+RclYOh5z48JAztlBqjKsh41CGX2ADfRe5+Yd8X+Az1UI+zJUkJ4=
X-Received: by 2002:a19:40cf:: with SMTP id n198mr3985171lfa.189.1573163671160; 
 Thu, 07 Nov 2019 13:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20191107142613.2379-1-robert.foley@linaro.org>
 <20191107142613.2379-2-robert.foley@linaro.org> <87o8xnhbl6.fsf@linaro.org>
In-Reply-To: <87o8xnhbl6.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 7 Nov 2019 16:54:20 -0500
Message-ID: <CAEyhzFv1Yrqm-_OjDoRv9VPDeJEJzpYwBim1RaSw=7jtqMv7YA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Add a mutex to guarantee single writer to
 qemu_logfile handle.
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

On Thu, 7 Nov 2019 at 11:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> It wouldn't be the worst thing in the world to expose:
>
>   qemu_logfile_init()
>
> and make vl.c and main.c call it before the setup. Then you can drop the
> flag or even just g_assert(qemu_log_mutex_initialised) in qemu_set_log
> and qemu_set_logfile.
>
> In fact you could just use:
>
>   static void __attribute__((__constructor__)) qemu_logfile_init(void)
>
> and make the compiler do it for you.

All good ideas.  Will make the changes.
I agree, it is much cleaner to call init this way (constructor).  We
can assert that qemu_log_mutex.initialized on use of the mutex
(qemu_set_log and qemu_set_logfile).  Taking that one step further, we
could add simple helper functions for
qemu_logfile_mutex_lock()/unlock(), which g_assert() on
mutex.initialized first before lock/unlock.

Thanks,
-Rob
On Thu, 7 Nov 2019 at 11:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This is being added in preparation for using RCU with the logfile handl=
e.
> > Also added qemu_logfile_init() for initializing the logfile mutex.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  util/log.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/util/log.c b/util/log.c
> > index 1ca13059ee..dff2f98c8c 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -24,8 +24,11 @@
> >  #include "qapi/error.h"
> >  #include "qemu/cutils.h"
> >  #include "trace/control.h"
> > +#include "qemu/thread.h"
> >
> >  static char *logfilename;
> > +static bool qemu_logfile_initialized;
> > +static QemuMutex qemu_logfile_mutex;
> >  FILE *qemu_logfile;
> >  int qemu_loglevel;
> >  static int log_append =3D 0;
> > @@ -49,6 +52,14 @@ int qemu_log(const char *fmt, ...)
> >      return ret;
> >  }
> >
> > +static void qemu_logfile_init(void)
> > +{
> > +    if (!qemu_logfile_initialized) {
> > +        qemu_mutex_init(&qemu_logfile_mutex);
> > +        qemu_logfile_initialized =3D true;
> > +    }
> > +}
> > +
> >  static bool log_uses_own_buffers;
> >
> >  /* enable or disable low levels log */
> > @@ -58,6 +69,12 @@ void qemu_set_log(int log_flags)
> >  #ifdef CONFIG_TRACE_LOG
> >      qemu_loglevel |=3D LOG_TRACE;
> >  #endif
> > +
> > +    /* Is there a better place to call this to init the logfile subsys=
tem? */
> > +    if (!qemu_logfile_initialized) {
> > +        qemu_logfile_init();
> > +    }
>
> It wouldn't be the worst thing in the world to expose:
>
>   qemu_logfile_init()
>
> and make vl.c and main.c call it before the setup. Then you can drop the
> flag or even just g_assert(qemu_log_mutex_initialised) in qemu_set_log
> and qemu_set_logfile.
>
> In fact you could just use:
>
>   static void __attribute__((__constructor__)) qemu_logfile_init(void)
>
> and make the compiler do it for you.
>
> > +    qemu_mutex_lock(&qemu_logfile_mutex);
> >      if (!qemu_logfile &&
> >          (is_daemonized() ? logfilename !=3D NULL : qemu_loglevel)) {
> >          if (logfilename) {
> > @@ -93,6 +110,7 @@ void qemu_set_log(int log_flags)
> >              log_append =3D 1;
> >          }
> >      }
> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
> >      if (qemu_logfile &&
> >          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel)) =
{
> >          qemu_log_close();
> > @@ -114,6 +132,11 @@ void qemu_set_log_filename(const char *filename, E=
rror **errp)
> >      char *pidstr;
> >      g_free(logfilename);
> >
> > +    /* Is there a better place to call this to init the logfile subsys=
tem? */
> > +    if (!qemu_logfile_initialized) {
> > +        qemu_logfile_init();
> > +    }
> > +
> >      pidstr =3D strstr(filename, "%");
> >      if (pidstr) {
> >          /* We only accept one %d, no other format strings */
>
>
> --
> Alex Benn=C3=A9e


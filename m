Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3240C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997E32054F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy5Es/Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997E32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUx7x-0000AL-Mj
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 13:40:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUx7A-0008Kp-7D
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hUx72-0002Td-VT
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:39:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hUx70-0002Om-9D
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:39:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so12895618otj.11
	for <qemu-devel@nongnu.org>; Sun, 26 May 2019 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=J1TJmIX0iG+vFa6t0vyo8Osw73WhSMm3hnfwHPu+ZJk=;
	b=Dy5Es/HmxbMK5j9qJgQoSaAY8qr/LjXoqWzNX0AC/csc1D+vVWpEmNz9rwl60izpHK
	u5zg2lcqk2g852tFC3ArbRS99vMy3v+YdtreGj8LxkOZCgE1VnhKuBVFm/fWdzcc8RCi
	MAQmHgKu8Ho/iDNKv9QsUJ9cfxWMdqrgsLm5JJ6M7ALFj/Pd4LVVX9+JJkfpl9OSbL19
	/+bbxl+lpbTgh5pwLUaAtjsgYt8DOfa5f+J8f/Isc/2rZr7phigk2SjHHlDc4T+42h2z
	PkQD1sQWAWRm/NnZ1h6/83ucmHYRv87g+9j2GS2nP9GkoE9Bo2hIBRAddVGRASePdiJH
	JAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=J1TJmIX0iG+vFa6t0vyo8Osw73WhSMm3hnfwHPu+ZJk=;
	b=t9KaQ0aSOaRFrrZf1g1NI0HyxYi+zigWj22SIOZwqGbJ6nhn0U2FRPai7gQvOGIaoM
	wlTuurbC+N8laag1tWFuFsvjAu1VKQo6LTqpJR+p0beRsVdimDSK4eW913vI9vrPza/4
	uUFzLA6yLtZYmxUShMvV3/YLIYCTK6lQh90/+kgA7KjBNl5/9ealPO69jDfiMZ56KlCO
	t0Nr2V6JoF79VPtv+C4Fc0MiRhNHqEoHU+8WmP4uh63T9NTI3zTs9+Sfd7FY0etC9TDH
	WHqklhgvrF9ABnFb4oTwH7a4wDd87lEhzKhyB3KNsVN0ampoUZc9r2xDgWXPbf/GBgCW
	KgEQ==
X-Gm-Message-State: APjAAAVXt2nhZRb9PaXDqqJICOgWDmyDiLQa54+wH7poHX+OhxHXoojN
	1BwwxneoWL0xqKQ9PKxpJKG02OHeqHDpBoGiLCQ=
X-Google-Smtp-Source: APXvYqwD7nuZGa7HxWQnmzDy4ZOwo814B6SW3zIzFeMCGu/ooGY2cGCWjv5lzFGN4RUVEJ0plQSgKK/nNGsIQlGsfZw=
X-Received: by 2002:a9d:588b:: with SMTP id x11mr211571otg.295.1558892346655; 
	Sun, 26 May 2019 10:39:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 26 May 2019 10:39:05
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 26 May 2019 10:39:05
	-0700 (PDT)
In-Reply-To: <87ef4o1fam.fsf@zen.linaroharston>
References: <20190523175413.14448-1-laurent@vivier.eu>
	<87ef4o1fam.fsf@zen.linaroharston>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 26 May 2019 19:39:05 +0200
Message-ID: <CAL1e-=j_=5biRd7O7+zecmze+1p+N2pH_wZ5AGraiSUm6fvQ3g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 24, 2019 9:29 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>
>
> Laurent Vivier <laurent@vivier.eu> writes:
>
> > In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> > defined if __NR_msgsnd is defined.
> >
> > But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> > __NR_semtimedop and it breaks the QEMU build.
> >
> > __NR_semtimedop is defined in asm-mips/unistd_n64.h and
asm-mips/unistd_n32.h
> > but not in asm-mips/unistd_o32.h.
> >
> > Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> > updated asm-mips/unistd_o32.h and added __NR_msgsnd but not
__NR_semtimedop.
> > It introduces __NR_semtimedop_time64 instead.
> >
> > This patch fixes the problem by checking for each __NR_XXX symbol
> > before defining the corresponding syscall.
> >
> > Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

This patch was applied to mips queue, sent today.

Regards,
Aleksandar

> > ---
> >  linux-user/syscall.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index e311fcda0517..d316de25c9f2 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -761,14 +761,7 @@ safe_syscall2(int, nanosleep, const struct
timespec *, req,
> >  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags=
,
> >                const struct timespec *, req, struct timespec *, rem)
> >  #endif
> > -#ifdef __NR_msgsnd
> > -safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> > -              int, flags)
> > -safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> > -              long, msgtype, int, flags)
> > -safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> > -              unsigned, nsops, const struct timespec *, timeout)
> > -#else
> > +#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) ||
!defined(__NR_semtimedop)
> >  /* This host kernel architecture uses a single ipc syscall; fake up
> >   * wrappers for the sub-operations to hide this implementation detail.
> >   * Annoyingly we can't include linux/ipc.h to get the constant
definitions
> > @@ -783,14 +776,29 @@ safe_syscall4(int, semtimedop, int, semid, struct
sembuf *, tsops,
> >
> >  safe_syscall6(int, ipc, int, call, long, first, long, second, long,
third,
> >                void *, ptr, long, fifth)
> > +#endif
> > +#ifdef __NR_msgsnd
> > +safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> > +              int, flags)
> > +#else
> >  static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int
flags)
> >  {
> >      return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void
*)msgp, 0);
> >  }
> > +#endif
> > +#ifdef __NR_msgrcv
> > +safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> > +              long, msgtype, int, flags)
> > +#else
> >  static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type,
int flags)
> >  {
> >      return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp,
type);
> >  }
> > +#endif
> > +#ifdef __NR_semtimedop
> > +safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> > +              unsigned, nsops, const struct timespec *, timeout)
> > +#else
> >  static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned
nsops,
> >                             const struct timespec *timeout)
> >  {
>
>
> --
> Alex Benn=C3=A9e

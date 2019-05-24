Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC7C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7078220868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vw3ViYC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7078220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4en-0000fD-J2
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:30:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU4dq-0008Vj-2L
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU4do-0002il-U6
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:29:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU4do-0002fx-Fr
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:29:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so8818853wrr.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=fQL703gdUEPMSCkd66lFYZphWzwrH3He/fdhcnItNbc=;
	b=vw3ViYC4bhIopqCYYUOx5cBExWY43PEN1/f7mbwXZiVpe7dHQJ9EwcY9UJf+tPIJPw
	dVGVMws3tETM1juyHwFb3Addhw04808L0mLwyhBGnKD3XG3dhNeKFK06Br/DFVfhT0pe
	kSsYa/AZDMrWcVS8bfyNY3Raj2PNCA0HSis3tn9JIrgWnbq1jc6C7ineTDYDURYIocrQ
	qowEff9r51urWct1N8fjord1/wq83h1cKoosKUe2ow96KdjQ9cqHG5rL4AZGpIp1zQNb
	fLTDlKO+Li8x5ESc5eCl30jOXhp7/XTSrwXVoogoMkdnIaM8R8Aox8gC658LaszOd6/O
	RKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=fQL703gdUEPMSCkd66lFYZphWzwrH3He/fdhcnItNbc=;
	b=ACTQyw5DMCbHhht+WOD6ap+/fL0R8tdGx4D7og+FWMAXaOzmomTS1tHKsozpIwj8gc
	DxiCvuwaE6w+17eLshRhuMS1iPrCnJPSeDRkIy3BkBVKyVr/RtYdy2h7Q2PGBNkjcOjL
	lKnhye97ombkVmEf7brdD0NHTc9HLUJEbwaAkcr/CYqha/rylfCRx59/m7boA3c0ui/F
	VZxzWFvgvDWyPG/Lk5/LigrHbTOQ5iHahXAdUiGl2nYM1pEpfP60bnJ4kneBaemMalA/
	eDVxZkuJXGufkXHQYPOU94682l0cDUasyPk8nUPtGC9feDk4BByb7V2jtui0ZV5mM7ie
	TwFw==
X-Gm-Message-State: APjAAAV/zB6SO9O3XZI4MuMgdR7YtHwEAZ+FAE5SeSxB71T3Rbu3t/se
	0EgWEThrayX0ZQ7+BXCzWLgHUQ==
X-Google-Smtp-Source: APXvYqyYMN03btzYxuy5YN4JPfUZptvHKSi0Myjy7tkbntMjESHLE93O2BUdd809EqLjqsc7nqqwgg==
X-Received: by 2002:adf:f8ce:: with SMTP id f14mr13152997wrq.110.1558682962579;
	Fri, 24 May 2019 00:29:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id q9sm3010226wmq.9.2019.05.24.00.29.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 00:29:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 987681FF87;
	Fri, 24 May 2019 08:29:21 +0100 (BST)
References: <20190523175413.14448-1-laurent@vivier.eu>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
In-reply-to: <20190523175413.14448-1-laurent@vivier.eu>
Date: Fri, 24 May 2019 08:29:21 +0100
Message-ID: <87ef4o1fam.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
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
	Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> defined if __NR_msgsnd is defined.
>
> But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> __NR_semtimedop and it breaks the QEMU build.
>
> __NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n=
32.h
> but not in asm-mips/unistd_o32.h.
>
> Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimed=
op.
> It introduces __NR_semtimedop_time64 instead.
>
> This patch fixes the problem by checking for each __NR_XXX symbol
> before defining the corresponding syscall.
>
> Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/syscall.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e311fcda0517..d316de25c9f2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -761,14 +761,7 @@ safe_syscall2(int, nanosleep, const struct timespec =
*, req,
>  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
>  #endif
> -#ifdef __NR_msgsnd
> -safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> -              int, flags)
> -safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> -              long, msgtype, int, flags)
> -safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> -              unsigned, nsops, const struct timespec *, timeout)
> -#else
> +#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semt=
imedop)
>  /* This host kernel architecture uses a single ipc syscall; fake up
>   * wrappers for the sub-operations to hide this implementation detail.
>   * Annoyingly we can't include linux/ipc.h to get the constant definitio=
ns
> @@ -783,14 +776,29 @@ safe_syscall4(int, semtimedop, int, semid, struct s=
embuf *, tsops,
>
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, thir=
d,
>                void *, ptr, long, fifth)
> +#endif
> +#ifdef __NR_msgsnd
> +safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> +              int, flags)
> +#else
>  static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
>  {
>      return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)ms=
gp, 0);
>  }
> +#endif
> +#ifdef __NR_msgrcv
> +safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> +              long, msgtype, int, flags)
> +#else
>  static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int =
flags)
>  {
>      return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type=
);
>  }
> +#endif
> +#ifdef __NR_semtimedop
> +safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> +              unsigned, nsops, const struct timespec *, timeout)
> +#else
>  static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nso=
ps,
>                             const struct timespec *timeout)
>  {


--
Alex Benn=C3=A9e


Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F77BC282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2722070D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge2r1AiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2722070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTtDO-0004s5-LP
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 15:17:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTtCQ-0004Wp-Tf
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTtCN-0003zO-I1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:16:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTtCM-0003uv-Tv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:16:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id 198so6971724wme.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ucGCfz7ycdEVn2dQiGag/RozXjKxlLvhuBNVh2ghsH8=;
	b=Ge2r1AiEj7rB3QAA2uDVFRnumHBqOmziBrsxWL3bD0T48/TnTEzWwiOmLaxF2vFRpx
	YHEEmbi695v9XhqZt2k6O3xITN/HRsc9Nwjl0xRgBXMAOn7qvI/YiW9uo91YYMJj/cjC
	hT0IigK96QsKlUNENOrQZDUMJLhZPiQ+mLJySHJ7xqpd12vAGpkn54NwX4Ku4IZNhCoV
	ONVpl38YDKqDj4hoDwRkGM7c8SzP+SHdCfphUUgFWs32rWMDW0kT31WYvV+QwRtJ1CSM
	WhAWfBKuG6AfXlHCnIHEseEivqpGUmws2EiiqBXF6OVW+FR4GXv5deNd/DDIPuIaGbSc
	f66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ucGCfz7ycdEVn2dQiGag/RozXjKxlLvhuBNVh2ghsH8=;
	b=oQzPJYXp04Za1ZA9vxBHvyXR9GsVNgHrbh3eb4mHUzPJc0stjsMW8Hc5WCG0Q2gEvX
	D78yQCmTKh6wdjlOH/D8dBrI8K//7xdF6ecDPxtWfWl371gy8T8f6VwmLqw1f99V1VDn
	nDEwf86MNqY9al9aqIGrQFKNJ5/ooY33VdppXCBfV9sCIgZhjtuVNaTyxAVL9ecB3Qkw
	h1NsDPKpoN/I6VlhzUIOlb4kB0tqoVtJdoi4iG2bcMehkziRbtnFt9lgFj/X6t5LoZom
	m18Ljpy1jFpnwwD87w95J9mYzOu9xvbrTsYiGi/kF5y0eZUOgllVmJn8hdc4DBzUmsWm
	WXYg==
X-Gm-Message-State: APjAAAWyZtcisR+gZA4SU3nKTcQW1od/TTZcJGaVbXYy5/YYna9Cd3nj
	gGDn17cvF2M1Jb1YOYb+iHbeKw==
X-Google-Smtp-Source: APXvYqwD29r6hMnR7J7zl0V8DyzxUwT7NTwy3OEcWRuW23AumxTGSA3p2h/iOK1F5NcNWgDxVaAQRA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr12373717wmj.33.1558638974352; 
	Thu, 23 May 2019 12:16:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id s20sm276138wrg.8.2019.05.23.12.16.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 12:16:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E231A1FF87;
	Thu, 23 May 2019 20:16:12 +0100 (BST)
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
	<20190523135602.4c80c959.cohuck@redhat.com>
	<e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
In-reply-to: <e01100bc-50ee-5cc2-2802-a098acc720ac@vivier.eu>
Date: Thu, 23 May 2019 20:16:12 +0100
Message-ID: <87ftp50yo3.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PULL v3 47/55] linux headers: update against
 Linux 5.2-rc1
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
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> On 23/05/2019 13:56, Cornelia Huck wrote:
>> On Wed, 22 May 2019 15:22:23 +0200
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>>
>>> The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifdef
>>> __NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of head=
ers and
>>> kernel.
>>
>> I tried to do that so that we have at least a workaround for now; but
>> this fails building on my x86 laptop (the safe_syscall6 for ipc
>> complains about missing __NR_ipc). Maybe I'm holding it wrong (should
>> that be conditional on the host?), but I think that really needs to be
>> done by the mips maintainers...
>>
>
> Perhaps a simple workaround could be:
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e311fcda0517..5b431736032c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -761,14 +761,8 @@ safe_syscall2(int, nanosleep, const struct timespec =
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
> +
> +#ifdef __NR_ipc
>  /* This host kernel architecture uses a single ipc syscall; fake up
>   * wrappers for the sub-operations to hide this implementation detail.
>   * Annoyingly we can't include linux/ipc.h to get the constant definitio=
ns
> @@ -783,14 +777,30 @@ safe_syscall4(int, semtimedop, int, semid, struct s=
embuf *, tsops,
>
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, thir=
d,
>                void *, ptr, long, fifth)
> +#endif

*sigh* almost but for arches we get complaints when the ipc syscall is
 defined but not used....

  https://app.shippable.com/github/stsquad/qemu/runs/835/summary/console

> +
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


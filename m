Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243A021019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243A021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTsUs-0007Sx-CC
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:31:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTsTX-0006l7-Jy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTsTW-0000xB-Fa
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:29:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTsTW-0000gw-9g
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:29:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so6867891wme.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cZVcHXG3UtCzukJBwEGJSKVnT3d3v6owTm/IO+/o+ec=;
	b=Ia7M0B6btJ04PQ0tEeFLK0J6kxduc0YafJm1hiOixvoQj5T0KQEf4kxgtmfGGL50an
	hg5V6NTTkE8zjj36eLc15Teqkmv4egftqW1m2gUSaTLBeQaS8uuRKsZMLrnb7Ot+vAFA
	vXWbgW3QozTXMmt/nrIbB80X2PKr1nI4kDng7bugp+Cxiai7SkTmDhki7yw47N2hXaYM
	/uWSEJ/BkhjBGEx3PO4XBbERnoL0+KgUqZAaKm0WisNY1QkFUgxfyNMulzP1j2KpnFlQ
	3QiuryZ01H7DR3riG2nZAEGnOx5U/dVZ99N1I+EUFuizG2RkAj+zLdNO2JO5L+Hc8tPs
	UVDg==
X-Gm-Message-State: APjAAAV58gM+nxywBHN8t0s63ZAFKt+mMjQlygakH9n6baZkJlKogHIo
	TCUCLufukLLL27lbP/HbWblN2A==
X-Google-Smtp-Source: APXvYqwPp044i2eOydLSQSyZZMvIy7Arr2O243LvSwc/Gn9JGFHjc1gWN+Q+hmKsdNLXU2h/X564IQ==
X-Received: by 2002:a1c:254:: with SMTP id 81mr12730608wmc.151.1558636178405; 
	Thu, 23 May 2019 11:29:38 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id v5sm3259wra.83.2019.05.23.11.29.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 11:29:37 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190523175413.14448-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <016cf4b3-d7b4-9517-e5dc-55b775945480@redhat.com>
Date: Thu, 23 May 2019 20:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523175413.14448-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 7:54 PM, Laurent Vivier wrote:
> In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> defined if __NR_msgsnd is defined.
> 
> But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> __NR_semtimedop and it breaks the QEMU build.
> 
> __NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n32.h
> but not in asm-mips/unistd_o32.h.
> 
> Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimedop.
> It introduces __NR_semtimedop_time64 instead.
> 
> This patch fixes the problem by checking for each __NR_XXX symbol
> before defining the corresponding syscall.

Thanks for the quick fix Laurent.

> 
> Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  linux-user/syscall.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e311fcda0517..d316de25c9f2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -761,14 +761,7 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
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
> +#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semtimedop)
>  /* This host kernel architecture uses a single ipc syscall; fake up
>   * wrappers for the sub-operations to hide this implementation detail.
>   * Annoyingly we can't include linux/ipc.h to get the constant definitions
> @@ -783,14 +776,29 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>  
>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>                void *, ptr, long, fifth)
> +#endif
> +#ifdef __NR_msgsnd
> +safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
> +              int, flags)
> +#else
>  static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
>  {
>      return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
>  }
> +#endif
> +#ifdef __NR_msgrcv
> +safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
> +              long, msgtype, int, flags)
> +#else
>  static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
>  {
>      return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
>  }
> +#endif
> +#ifdef __NR_semtimedop
> +safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
> +              unsigned, nsops, const struct timespec *, timeout)
> +#else
>  static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
>                             const struct timespec *timeout)
>  {
> 


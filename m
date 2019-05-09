Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD33C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6563C20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6563C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmn4-0003ub-79
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:25:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmXY-0007Lq-87
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOmXX-000286-Ec
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:09:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOmXX-00027f-4u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:09:03 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MNKuI-1h5R8r2APq-00Opy4; Thu, 09 May 2019 19:08:51 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190502092728.32727-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <93276dfb-3495-8f98-0da1-6c97962bd826@vivier.eu>
Date: Thu, 9 May 2019 19:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190502092728.32727-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8OH2y38lrXOIrDkK2lFwEUWAcFLS/HptobO3A2aynLVCjqOsRec
	z9wbbZZngG6LMnoOr5Y+NfKcJ80JLl2YpawmDcAndkvDxXC1znQKVYc8hmoVTg9c7bIHwmI
	2540rUALa/2Kax6pyUQprMiTWYx168p/P1eguS4weX26hkv7/Xb45kcKSTSeeJWwGi5l8dz
	gGXy/7kGPTL4SnXtwARlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SqrOAipiP2M=:7eQQKtttVt0ylucaxidv88
	3TdgL0v0KImSiluLY06hMtr07R8SDgt4wl1MRWEtzETzbqdfycmB13CHGRVgGKRMLl+juX1Yl
	6ZflNfncJBH9Letvn0fqMyGW1VvJFnWULxwS/ZUCkglfEotEOxOPFuuAnCpJ2t5HedI0CHsIo
	fVvVjgD4CdQoZnfSHEN4ERoL3KJD0DsWAiuj/oZnLyijhik1O90Mf2R8KptJz6xi6sTIcEVSb
	s88yEIMc82+Rj3/9MSoq8F465cZ5Vq/MgQrwLmrYNfsz9bWMo06ZHXsl7bKLB6pGjoE9VzKVY
	2aek1F2a/eK9wXd5PGKrCUkcvwfbQAzYxF+vqVGBD9BIfGcr6oVotDqrSjdUlCT/VfbdETdtl
	ukoRSdEVaJYUiCkB8v6YLQ8AEV2Qks0yx03xbxR0dDcy6jTo+TVkS075MK3G2TRjP2c80OwZq
	a1uJn/EZCdTluF6NKGyiubW4h4p9C5/EjuWamv97B0qXNkwgMLDBcMjoYXS4/iurR34DMwy0w
	wIxeXV43yCT286qnXFOH36DyDdmedsFdCfRDx8lGg6ywPOdzrOQjzM1HB1xV/UrMaT7Pe5ng2
	XiONaIaajC93aW7yzoq7Dmhy7GPyXpjSE4BDbMh4IX8M3N+Zy5Xubs9O91lm03YDpk8wJuAQV
	Q+XF2XMm4uX7DyccfahZJRxVMZAKKesgBv4d+5MQ0i+0bR43iaStlLnrFM6eQ1JcFdgwLjMfI
	ZKjnPXs/l8wePSIUPrYRB0pQlbO3LyMetcC+/lcjrgMXV7esayN4U1KB/y8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/05/2019 11:27, Alex Bennée wrote:
> When linux-user/exit was introduced we failed to move the gprof
> include at the same time. The CI didn't notice because it only builds
> system emulation. Fix it for those that still find gprof useful.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   linux-user/exit.c    | 3 +++
>   linux-user/syscall.c | 3 ---
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 14e94e28fa..bdda720553 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -18,6 +18,9 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu.h"
> +#ifdef TARGET_GPROF
> +#include <sys/gmon.h>
> +#endif
>   
>   #ifdef CONFIG_GCOV
>   extern void __gcov_dump(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf86d..f2d9883aef 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -59,9 +59,6 @@
>   #ifdef CONFIG_TIMERFD
>   #include <sys/timerfd.h>
>   #endif
> -#ifdef TARGET_GPROF
> -#include <sys/gmon.h>
> -#endif
>   #ifdef CONFIG_EVENTFD
>   #include <sys/eventfd.h>
>   #endif
> 

Applied to my linux-user branch.

Thanks,
Laurent


Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C878C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7077924655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077924655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGpu-000285-Bv
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGoH-0000r9-EG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGoE-000491-OA
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:44 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42849)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGoE-00047N-F9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:42 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MkHIV-1jIuEk3tG5-00kjpE; Wed, 22 Jan 2020 15:16:28 +0100
Subject: Re: [PATCH 11/12] linux-user: Add support for KCOV_<ENABLE|DISABLE>
 ioctls
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579214991-19602-12-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b0cfdb3f-5d75-cbe7-56b6-dbc9a07956d5@vivier.eu>
Date: Wed, 22 Jan 2020 15:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579214991-19602-12-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0Lm01ilv6Djh2tw8LX6SrWP7cLRJ2z6IUULjiEwW1JO9nNFyWyp
 aw2eUY4WuenW5dwGJxqke7JYOLqbfK9VhJ6/QGa18wfq4JXTjZ0l5q03u4E8LW3fAxnSuVY
 1kpZYnOR7sta0vvX3Qr9sYb1+EqFEUot1JQbS2HZotcXS/dJcWuaEbqVgwhIi9y113Yd3tp
 qC9iH4srkkydkB/KfyVrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8V2MxDxjh4M=:eLmMgLPx6AQdqSvWUp825D
 M1T5Wu64uTiKHpHDEGIRFkSlAlRZn+9CwmyZXMerBz8wg44yA9PPuyC0s3+R26fHT8G42emWf
 slvjoOyXCs079JE2S65T/TglIF3TLl9PWB1xf+Caiy131CLjpWC8gQoM9GnkBFFx/CjUunA/e
 ziVl0Wson5NqPzjv7u3tM2dXNHq768C5oMA6q5sZsY83on3+cAmL70czzJHNSmbx2ofVdP+5c
 RMreqe/1oPHI5ytsYcEmsyFJs1g4e94ERSqt36dueRIZ1Vs1XoU40ENS5rnT3GoIKOKa8tbGU
 MLketAD8Lfm0kwWp//CoOzxeKP8tdsIwqxvQoDnbB7F8H6aoLiqVnvaN1NO6c4gNNxfvguZ6N
 Hw6fpmCipkRmyuvxR+myzTKvwq+bGmhpGZawOfSEC7vHzDJ57t4BebyLQWwaZ5zXSqqpvX69i
 7NfsEZr2rvjt1rvOM4v4ck5NsS7SohdvwX6246GkoZH78mJZd5ATqOPGN0c7tn1lQwhtzwuAu
 VrI65u9hDaIK/lBdZrrbS0uSdL7WGWOLpdXnc/PvrxdAlLM9iJ9eHviyOivqFULTqPNYPY0II
 +91WnrnobcVyxUQ0zDggxEqzbe/OyLHPA3bKpg8+A3ub+2F2kqecKVbm+GtcgSmSWe5iIi5Yz
 l0s7ffUPu8ZVstxKvRQLNmoIzA95R4jLOMO/ASLpdIXWXpclv+QkP9paZ3m2D97bq+EzHJmO1
 Z8/s0LeWWx2It2sk6J6CZTS9b/wi+i2H5j/i7Wk5U5owOJP4PbAP2bZOBDREukBPqUlfTFX+A
 mIfuiIWn0QLk4jKG8Y8tFjUxXa3jF3CObAvCQI1hxtgND7r1fY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/01/2020 à 23:49, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> KCOV_ENABLE and KCOV_DISABLE play the role in kernel coverage
> tracing. These ioctls do not use the third argument of ioctl()
> system call and are straightforward to implement in QEMU.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 5 +++++
>  linux-user/syscall.c      | 3 +++
>  linux-user/syscall_defs.h | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index d72cd76..39b3825 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -552,3 +552,8 @@
>    IOCTL_IGNORE(TIOCSTART)
>    IOCTL_IGNORE(TIOCSTOP)
>  #endif
> +
> +#ifdef CONFIG_KCOV
> +  IOCTL(KCOV_ENABLE, 0, TYPE_NULL)
> +  IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
> +#endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 171c0ca..6edcb0d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -73,6 +73,9 @@
>  #ifdef CONFIG_SENDFILE
>  #include <sys/sendfile.h>
>  #endif
> +#ifdef CONFIG_KCOV
> +#include <sys/kcov.h>
> +#endif
>  
>  #define termios host_termios
>  #define winsize host_winsize
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 46dc565..c8999ef 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2461,6 +2461,10 @@ struct target_mtpos {
>  #define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct target_mtget)
>  #define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct target_mtpos)
>  
> +/* kcov ioctls */
> +#define TARGET_KCOV_ENABLE     TARGET_IO('c', 100)
> +#define TARGET_KCOV_DISABLE    TARGET_IO('c', 101)
> +
>  struct target_sysinfo {
>      abi_long uptime;                /* Seconds since boot */
>      abi_ulong loads[3];             /* 1, 5, and 15 minute load averages */
> 

Applied to my linux-user branch.

Thanks,
Laurent


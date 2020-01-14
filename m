Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B6C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C84B24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C84B24676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLKF-0000UR-Mq
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLJe-0008Vz-3E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLJa-0001mS-I6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:29:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLJa-0001lk-8x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:28:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mw9oq-1jgyST3jsK-00s58W; Tue, 14 Jan 2020 13:28:34 +0100
Subject: Re: [PATCH 01/12] linux-user: Add support for enabling/disabling RTC
 features using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-2-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ff630e08-f5e2-d974-39c8-8607b1ed9760@vivier.eu>
Date: Tue, 14 Jan 2020 13:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-2-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sptxdle4NQYhv6PMPi7H/TW0wyoBFEagh2NT04X+EUdCKnIO5zT
 9l+VUDb5/bQnBOYE+SmaLKNCy5MVxjfrZC0zuBSKO74ADnfYL5CQ6FwoXhENwVwWHCrLXVz
 /0SKwUmXc5uzh0StaJzDeDOjWWBXMVD4cnlorGmyN4rCeqovjoLKW+OVXWCACqrEnqm/i40
 hj02CapcsDXqPqHwcwE5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JvHAB7o375o=:tUmSqJsUGk1FzcwwN4TQv4
 ejeyyYmvajazP2BdfUPxdBAq+8GLJWKsQDsiTxU30yEe3wclaXnfF7CVuXttRDgENAHvZ7kyY
 RdFVFCOE0jul1EPpk9hffYdJhq/V+KDIVIIiOTTuB4y9Y+R3FFlxWLHTFiimZxvBHCOiHipo2
 FpTlKgylxTg5X+sIfDWnNU1JlgFZNRu2tsIbwOuXEyaKM8mvXsdhiMRidKNEOMnBamztyVBQy
 VWkqHoDJuSww6Wv4Jr9YsjfxFgvlMJJVlSko9rFMTF1EtD3wZnkmix3biPHFN3e6oaJJ+TaCy
 9E/iyMAHdoHJO5+N9rUn5vL3T3ZssjrIU0BuKpiU9HSpa9JSuNnkZ2hcPs1LysFqGdI2Vawf9
 cBstdBQ+dNJplI+2DYByBtcbFCy2RtII40bLAmdL3VPurfufTEzceJvXe2NQfZ1lIwlswsvLw
 DJ2DEeGI1+yh3Lk/P4MO8qZoutnBVdcyZXczGLX1jtmBz+4SXE6EpVOKanZkoXJXlJOgBQAz8
 TNjbbgvz4qWCA3xRyV+f4tYXNa8IrDklgwMAkHLcSSOSQoz4b91q7U4rVtuCIfT3k/P7AvDse
 P9hyR9fwzK9Wuf1VUNJ2jY7mnw/SIxjzWJqYaqycTkkpEvPxSymXKu7Zx8H8h+R2OXyPQjig6
 713uNYGEyZfXYpjhN1gPRH849kneAtjcdfuWk1LNoWGazLokmxNiHI6yVqRiBMeZhq31rvS6G
 Dfgnqv6RWyzKS3MTavFOtnvd6R13z14I/zea2XRSefJA+k6yACC32Un1mW2fwyLRFII6KhUzW
 DvZAyk6MLamiTpT3u8aSKQ2OmftsR1HzWnuWBjDT+cfD2SB3VK40Y6b1j8KMQI85Gg04cl5+b
 R61gCaGek1lTzfEqrwWQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/01/2020 à 13:59, Filip Bozuta a écrit :
> This patch implements functionalities of following ioctls:
> 
> RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enabling on/off
> 
>     Enable or disable the alarm interrupt, for RTCs that support
>     alarms.  The third ioctl's argument is ignored.
> 
> RTC_UIE_ON, RTC_UIE_OFF - Update interrupt enabling on/off
> 
>     Enable or disable the interrupt on every clock update, for
>     RTCs that support this once-per-second interrupt.  The third
>     ioctl's argument is ignored.
> 
> RTC_PIE_ON, RTC_PIE_OFF - Periodic interrupt enabling on/off
> 
>     Enable or disable the periodic interrupt, for RTCs that sup‐
>     port these periodic interrupts.  The third ioctl's argument
>     is ignored.  Only a privileged process (i.e., one having the
>     CAP_SYS_RESOURCE capability) can enable the periodic interrupt
>     if the frequency is currently set above the value specified in
>     /proc/sys/dev/rtc/max-user-freq.
> 
> RTC_WIE_ON, RTC_WIE_OFF - Watchdog interrupt enabling on/off
> 
>     Enable or disable the Watchdog interrupt, for RTCs that sup-
>     port this Watchdog interrupt. The third ioctl's argument is
>     ignored.
> 
> Implementation notes:
> 
>     Since all of involved ioctls have NULL as their third argument,
>     their implementation was straightforward.
> 
>     The line '#include <linux/rtc.h>' was added to recognize
>     preprocessor definitions for these ioctls. This needs to be
>     done only once in this series of commits. Also, the content
>     of this file (with respect to ioctl definitions) remained
>     unchanged for a long time, therefore there is no need to
>     worry about supporting older Linux kernel version.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h       |  9 +++++++++
>  linux-user/syscall.c      |  1 +
>  linux-user/syscall_defs.h | 10 ++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c6b9d6a..97741c7 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -69,6 +69,15 @@
>       IOCTL(KDSETLED, 0, TYPE_INT)
>       IOCTL_SPECIAL(KDSIGACCEPT, 0, do_ioctl_kdsigaccept, TYPE_INT)
>  
> +     IOCTL(RTC_AIE_ON, 0, TYPE_NULL)
> +     IOCTL(RTC_AIE_OFF, 0, TYPE_NULL)
> +     IOCTL(RTC_UIE_ON, 0, TYPE_NULL)
> +     IOCTL(RTC_UIE_OFF, 0, TYPE_NULL)
> +     IOCTL(RTC_PIE_ON, 0, TYPE_NULL)
> +     IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
> +     IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
> +     IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
> +
>       IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(BLKRRPART, 0, TYPE_NULL)
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ce399a5..74c3c08 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -107,6 +107,7 @@
>  #include <netpacket/packet.h>
>  #include <linux/netlink.h>
>  #include <linux/if_alg.h>
> +#include <linux/rtc.h>
>  #include "linux_loop.h"
>  #include "uname.h"
>  
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 98c2119..f91579a 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -763,6 +763,16 @@ struct target_pollfd {
>  #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
>  #define TARGET_KDSIGACCEPT     0x4B4E
>  
> +/* real time clock ioctls */
> +#define TARGET_RTC_AIE_ON           TARGET_IO('p', 0x01)
> +#define TARGET_RTC_AIE_OFF          TARGET_IO('p', 0x02)
> +#define TARGET_RTC_UIE_ON           TARGET_IO('p', 0x03)
> +#define TARGET_RTC_UIE_OFF          TARGET_IO('p', 0x04)
> +#define TARGET_RTC_PIE_ON           TARGET_IO('p', 0x05)
> +#define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
> +#define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
> +#define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
> +
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
>  #define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


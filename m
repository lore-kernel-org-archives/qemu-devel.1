Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B759521734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B759521734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGse-0005Nr-O8
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGqu-0003j6-VY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGqt-0005yb-KF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:19:28 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:34571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGqt-0005y9-B3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:19:27 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVubb-1j4PiY0kZp-00RuNb; Wed, 22 Jan 2020 15:19:07 +0100
Subject: Re: [PATCH v8 02/13] linux-user: Add support for getting/setting RTC
 time and alarm using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579117007-7565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579117007-7565-3-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <24d8110d-5a7a-626d-4ad6-d005a3ec7c84@vivier.eu>
Date: Wed, 22 Jan 2020 15:19:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579117007-7565-3-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CrTomKNQtcmJNYZ87LsKWLQL+2di9D7cj7GZ7E5dl5vX/7MT8VQ
 KTToCGJuEyzcdyXyC7kX+dEyDKLQiiNvu/aiqxnF9F5m7SU56C3Xnhk3HOoKgrCXM770IuJ
 ZNP6zUDHdiSbPvlxqyIrGFlzm7GSXn+OdypcOOUAfxzdDVRTWMsKGfPaIxao4wXqz5K+hAf
 kj8hvl+AFOPqAknUg1WUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kl7/TFrl/hA=:F66/G06qNwbXLoU6J8gGbe
 y5ZzWBF+lcCOO4085zVlxrGh6hl6fOmqubYm2qcITg900djWkRkYeuGaX8uxexr3uH5H6rIBl
 spSddsqK3Fz46Ig51vzMTTQdLC9QPoXu/9wBqZ59FAAieQCM3ePZSGpopeXNUjejNv5jVXG/1
 hQnPQ7Gg1Nll1wdsTf91AGNz73gtPVMG/e8Lb2XVrHXnlpI3cPPexVyUSuhJgeel54ltC9WPT
 APKqny9sdallHxQzq8b9hdndLNrIzj8W2NJNhIQWYEzB8fOu/YLnqtGkg20BE2KmC3GfFdLYi
 LcK1EPeUCUW+kFelXFrB13WMSxvjfZaTFv2+DAhN5Ifi6ty30UM4uoJq8qyGxU37uDE4SPrVx
 sb4lJ8cIFyPyxp7WDguTBrx1us/yLtx+mLDPbsvMgaHswgTFc484a0nWH2GtDHFoKDf1UcbW9
 UL3DM8xtZ3yNMLf7encQxQ/ErpwVxhTNR0M0vaxJwo997Qi3C1wJCd/GQJ28j6PQUWVwzZOtH
 dUr74djuEC3QWyLUV4vg+pYo2rzvcNmwm/6nW3Pv0HtBPIfHEvwP7EMHGNEKsiEZoojdwkdRk
 RwqdUfg8jS7dbF7EoGzfpnUC5i49sFVzAN2kU2WSbcAQJ2coJUhcuUXaAozkFy5Yy72OX7S7U
 HozW9f50Jw4KcGIPL2vHNEVpgzqAhs8iMeRkOKTe5vexq9Nx14nKguuqIpNLFeLXMhh7rgYvZ
 notH5GfJpLPXOCZn2aiOmZfPjmD1bT5RacWBxsUYTZt8qxI0yYyU7X/KM+BA0CZzSZFn3Hq2E
 aZq2LK5qpNR9cT3xebSrN5MOMYS8kajF0E0tts4/KsEIMv3FRxGhVvgrNTRorJ7xH8TkoL/
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 20:36, Filip Bozuta a écrit :
> This patch implements functionalities of following ioctls:
> 
> RTC_RD_TIME - Getting RTC time
> 
>     Returns this RTC's time in the following structure:
> 
>         struct rtc_time {
>             int tm_sec;
>             int tm_min;
>             int tm_hour;
>             int tm_mday;
>             int tm_mon;
>             int tm_year;
>             int tm_wday;     /* unused */
>             int tm_yday;     /* unused */
>             int tm_isdst;    /* unused */
>         };
> 
>     The fields in this structure have the same meaning and ranges
>     as the tm structure described in gmtime man page. A pointer
>     to this structure should be passed as the third ioctl's argument.
> 
> RTC_SET_TIME - Setting RTC time
> 
>     Sets this RTC's time to the time specified by the rtc_time
>     structure pointed to by the third ioctl's argument. To set
>     the RTC's time the process must be privileged (i.e., have the
>     CAP_SYS_TIME capability).
> 
> RTC_ALM_READ, RTC_ALM_SET - Getting/Setting alarm time
> 
>     Read and set the alarm time, for RTCs that support alarms.
>     The alarm interrupt must be separately enabled or disabled
>     using the RTC_AIE_ON, RTC_AIE_OFF requests. The third
>     ioctl's argument is a pointer to a rtc_time structure. Only
>     the tm_sec, tm_min, and tm_hour fields of this structure are
>     used.
> 
> Implementation notes:
> 
>     All ioctls in this patch have pointer to a structure rtc_time
>     as their third argument. That is the reason why corresponding
>     definition is added in linux-user/syscall_types.h. Since all
>     elements of this structure are of type 'int', the rest of the
>     implementation is straightforward.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h        |  4 ++++
>  linux-user/syscall_defs.h  |  4 ++++
>  linux-user/syscall_types.h | 11 +++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 97741c7..f472794 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -77,6 +77,10 @@
>       IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
>       IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
>       IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
> +     IOCTL(RTC_ALM_READ, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
> +     IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
> +     IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
> +     IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
>  
>       IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index f91579a..f0bf09d 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -772,6 +772,10 @@ struct target_pollfd {
>  #define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
>  #define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
>  #define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
> +#define TARGET_RTC_ALM_READ         TARGET_IOR('p', 0x08, struct rtc_time)
> +#define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_time)
> +#define TARGET_RTC_RD_TIME          TARGET_IOR('p', 0x09, struct rtc_time)
> +#define TARGET_RTC_SET_TIME         TARGET_IOW('p', 0x0a, struct rtc_time)
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4e36983..a35072a 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -255,6 +255,17 @@ STRUCT(blkpg_partition,
>         MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
>         MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
>  
> +STRUCT(rtc_time,
> +       TYPE_INT, /* tm_sec */
> +       TYPE_INT, /* tm_min */
> +       TYPE_INT, /* tm_hour */
> +       TYPE_INT, /* tm_mday */
> +       TYPE_INT, /* tm_mon */
> +       TYPE_INT, /* tm_year */
> +       TYPE_INT, /* tm_wday */
> +       TYPE_INT, /* tm_yday */
> +       TYPE_INT) /* tm_isdst */
> +
>  STRUCT(blkpg_ioctl_arg,
>         TYPE_INT, /* op */
>         TYPE_INT, /* flags */
> 

Applied to my linux-user branch.

Thanks,
Laurent


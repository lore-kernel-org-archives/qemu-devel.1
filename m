Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7747C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9CE2465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9CE2465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGuJ-00086B-IR
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGsl-00062F-8D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGsj-0007T3-PR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:21:23 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGsj-0007Rc-GD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:21:21 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ml6i2-1jJjnt2V5A-00lYa1; Wed, 22 Jan 2020 15:21:01 +0100
Subject: Re: [PATCH v8 05/13] linux-user: Add support for getting/setting RTC
 PLL correction using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579117007-7565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579117007-7565-6-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0353e31c-c6a7-4a50-82e6-96d62a23adc6@vivier.eu>
Date: Wed, 22 Jan 2020 15:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579117007-7565-6-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nYxymjUWI0Pndwe//K5cqqV7P/evieyX88kMOL+gX9Hem05X+T7
 ixOmzNHF+BWWnECH3PGEHAVkrMdW/rdM2soYgz6ozEBuDlySefB6WymdJ6wSoLkTDIwAECi
 UymJTefrzpyA7a1dgPycv5w1kouXRtYvCLj9MP5TmD+prjS7NWwydfqZlEeehY3s3dlbDtF
 o/H6GBYx9SibPpVcslM6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQeW2y6FtJs=:N8zuEGgaxiygOTRYeGCDPA
 VNTkx3a9AKBAucuwL4eE2YrTuiLMctFPMT/Gn0p45bvW3olp6HNgrixQAdPNn/TfeKGaCls+U
 hWu13slqGhBtHTUxyXey/tk9/LhWSU+Z8zEoKsFlPpr7A/XRucbMxpGLlHYAAX2fzGscj4YRB
 C9T2GUw/Bvjxs9qkrZYroccbpEuc9io+olYV4uox4qfyY2PfaORrPvPh6j7nDPDPp1c/er+vb
 /LLMULDGMd40vPH+A23FlTJm4j/87BOD7ezr6uemiyO6VwEW5YL4MFZpcNP9SNVxivANi+0Yq
 mfxSTYQToV84cQfBNrcF9VUmSa/iJLXy439P1qFv3vcHh682czXfB+jAjnw82VfMx2KnSrSXa
 zwkselSxHjFPzZo0hE95Wa3FxA3xhdyTz4hsPnr1bm1h5mqP+htjldusYL6U4CPsJJv5sMyAr
 WwyaS0O5BhrnVYxmCHNM0Y489vAKpfnotz9wa+LtyVwh2YXegCO3W9LghVJUPjTw/fclgPiZB
 66x5IuV7HRYc9VgypdcyoRrEeHcOtsahUkFVnmMwQhH49uekuO5IRKo35IiL/qCLONC++kvTW
 HzCWxGnI9MGqKV6VUPdSnDdMNM/RXVCzFwLZXYtXllQbObkfS+Doqf+ZnHgUM6nGXvXd55RZU
 EJBjlayr7MQLAWh09OIcDg4RnHHPtuFbfoNSTjJTbux6rewJlJotvn7o3kWqPnd1zNC+PFP8r
 5I3CRXtkuQfWxrZmgDdiYj8IbgA0KwqmgD1YxOEe2T8uSbS1XcYeheT+7S5gxg25r2BauC7My
 9rL0yFJP9zheQ76di4HSZvTTytOdq7GHnYC9BCZJsh2lnV72oo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
> RTC_PLL_GET - Getting PLL correction
> 
>     Read the PLL correction for RTCs that support PLL. The PLL correction
>     is returned in the following structure:
> 
>         struct rtc_pll_info {
>             int pll_ctrl;        /* placeholder for fancier control */
>             int pll_value;       /* get/set correction value */
>             int pll_max;         /* max +ve (faster) adjustment value */
>             int pll_min;         /* max -ve (slower) adjustment value */
>             int pll_posmult;     /* factor for +ve correction */
>             int pll_negmult;     /* factor for -ve correction */
>             long pll_clock;      /* base PLL frequency */
>         };
> 
>     A pointer to this structure should be passed as the third
>     ioctl's argument.
> 
> RTC_PLL_SET - Setting PLL correction
> 
>     Sets the PLL correction for RTCs that support PLL. The PLL correction
>     that is set is specified by the rtc_pll_info structure pointed to by
>     the third ioctl's' argument.
> 
> Implementation notes:
> 
>     All ioctls in this patch have a pointer to a structure rtc_pll_info
>     as their third argument. All elements of this structure are of
>     type 'int', except the last one that is of type 'long'. That is
>     the reason why a separate target structure (target_rtc_pll_info)
>     is defined in linux-user/syscall_defs. The rest of the
>     implementation is straightforward.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h        |  2 ++
>  linux-user/syscall_defs.h  | 14 ++++++++++++++
>  linux-user/syscall_types.h |  9 +++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index b09396e..0a4e3f1 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -87,6 +87,8 @@
>       IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
>       IOCTL(RTC_WKALM_RD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
>       IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
> +     IOCTL(RTC_PLL_GET, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
> +     IOCTL(RTC_PLL_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
>  
>       IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 37504a2..8370f41 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -763,6 +763,16 @@ struct target_pollfd {
>  #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
>  #define TARGET_KDSIGACCEPT     0x4B4E
>  
> +struct target_rtc_pll_info {
> +    int pll_ctrl;
> +    int pll_value;
> +    int pll_max;
> +    int pll_min;
> +    int pll_posmult;
> +    int pll_negmult;
> +    abi_long pll_clock;
> +};
> +
>  /* real time clock ioctls */
>  #define TARGET_RTC_AIE_ON           TARGET_IO('p', 0x01)
>  #define TARGET_RTC_AIE_OFF          TARGET_IO('p', 0x02)
> @@ -782,6 +792,10 @@ struct target_pollfd {
>  #define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
>  #define TARGET_RTC_WKALM_RD         TARGET_IOR('p', 0x10, struct rtc_wkalrm)
>  #define TARGET_RTC_WKALM_SET        TARGET_IOW('p', 0x0f, struct rtc_wkalrm)
> +#define TARGET_RTC_PLL_GET          TARGET_IOR('p', 0x11,                      \
> +                                               struct target_rtc_pll_info)
> +#define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
> +                                               struct target_rtc_pll_info)
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 820bc8e..4027272 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -271,6 +271,15 @@ STRUCT(rtc_wkalrm,
>         TYPE_CHAR, /* pending */
>         MK_STRUCT(STRUCT_rtc_time)) /* time */
>  
> +STRUCT(rtc_pll_info,
> +       TYPE_INT, /* pll_ctrl */
> +       TYPE_INT, /* pll_value */
> +       TYPE_INT, /* pll_max */
> +       TYPE_INT, /* pll_min */
> +       TYPE_INT, /* pll_posmult */
> +       TYPE_INT, /* pll_negmult */
> +       TYPE_LONG) /* pll_clock */
> +
>  STRUCT(blkpg_ioctl_arg,
>         TYPE_INT, /* op */
>         TYPE_INT, /* flags */
> 

Applied to my linux-user branch.

Thanks,
Laurent


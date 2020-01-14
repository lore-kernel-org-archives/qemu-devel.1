Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F1C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602DE2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602DE2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLWH-0008VQ-Jo
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLVG-0007Fy-3Z
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLVC-0005sj-7l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:41:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLVB-0005s2-V8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:40:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYLqs-1jDuQz1E5C-00VN7P; Tue, 14 Jan 2020 13:40:35 +0100
Subject: Re: [PATCH 06/12] linux-user: Add support for read/clear RTC voltage
 low detector using ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1578574763-8327-7-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <977ced94-674e-1873-562e-9de9dbee402e@vivier.eu>
Date: Tue, 14 Jan 2020 13:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578574763-8327-7-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NkHevvlvpQgn9lfEqlLDKMKbPQLn/HIR3l+N9nYovddzdV8B5cG
 FsUQTiEhyiW7ptEfrv2o56oC6cIVip9xdDhxUZ1FhiOCSRZqr8cWXLAw5FxjFGiEsfD1og9
 IlMdPgw0iBOVcHGUP+9AzX+1SGELOcj/K5z458ey/8uBZedypsH5qO9R+0z6rQ5HH3Dtgyi
 LEuyiYxHGm4I6hGJSc7tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0NTO8gtEZg=:QIi6jhL/mQVS+BDCutzhCD
 Weyn3t3lydv6L39C7IvsfYC2Ut0JkCBR95zZAxLSrlbXLAkDe5b+3oJHQX/wueWiGNJhSWVzL
 NZ05xk/6Wfyf2ODK80e3vq/ZV9qQa/25ZEODIB3IRgkLiHJutd0VLOCSFrIEoSFMH7totgw88
 gCimrYCrUWgN51lUbafC7pFK0FDnZwIUkF2ESOZ6QqwRL/TwrRZ+zSWG815WXKpiw3G+bRTry
 IPUyzBeaBUnE3/7ZCdgFhXCGdY/B0FPyOHkAunjytXbvSOakNwjeYoUY/g1bXdCUIFnXSvWvg
 HE5nzKDZJvX4oj0x3mEXqniZssaoLI2Wx39ZG5T5eWx2/kd/X5DMLThNtvKGnmhS8qJYCE73a
 igZr5wY6gKnQfAtq+JSwppGR44QmKuzbm47jmz4fg0cR1L9UCP/18TBcK4DHXbh5cSm8oD9j3
 sd5Nq+tdRRYS9XbgRr/30omnjV/+m9hSbcChZkrb+onriUwO1UNqm9dcTrDhwp4S+f31nnmU/
 v+RraoYM1Vd1Nbe3oTBxPtTbh0+xz8pDfzhhnTcSIrXs8oy1qHeCfCfIzPZQ29uxHX9BTLqtH
 eq4VW/fIKTWmzrfy0k1nS1C81HexlURSkhlNmlXLHI5YH1b0/OeotEsDQJFR112k6Hl0DMGNs
 lKw9C/Dhd5o1ONSDib2elpw/EifkixA6Wz8KNjokIRzxqIrWHkC9U0igsPRxSmyQdINQ3hkc0
 32j2wmktW/tryn6WlkZtK58madMzSI8L/tQvIoJmUbnD2bANZ24KlY+kbh933i6X2SE5NdBSz
 F7rqSFs75B0aIbNi6a4WfTJUB1XJIQhu5ztH+bSX6GDFDYgv2MPupzc08JgPjYoI4uRYK8jGs
 QAtPzb1qGt0xLUmKAEwTA9WNCejbGDmVqLc6LjnQk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
> RTC_VL_READ - Read voltage low detection information
> 
>     Read the voltage low for RTCs that support voltage low.
>     The third ioctl's' argument points to an int in which
>     the voltage low is returned.
> 
> RTC_VL_CLR - Clear voltage low information
> 
>     Clear the information about voltage low for RTCs that
>     support voltage low. The third ioctl(2) argument is
>     ignored.
> 
> Implementation notes:
> 
>     Since one ioctl has a pointer to 'int' as its third agrument,
>     and another ioctl has NULL as its third argument, their
>     implementation was straightforward.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall_defs.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0a4e3f1..1f1f3e6 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -89,6 +89,8 @@
>       IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
>       IOCTL(RTC_PLL_GET, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
>       IOCTL(RTC_PLL_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
> +     IOCTL(RTC_VL_READ, IOC_R, MK_PTR(TYPE_INT))
> +     IOCTL(RTC_VL_CLR, 0, TYPE_NULL)
>  
>       IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 8370f41..af4f366 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -796,6 +796,8 @@ struct target_rtc_pll_info {
>                                                 struct target_rtc_pll_info)
>  #define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
>                                                 struct target_rtc_pll_info)
> +#define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, int)
> +#define TARGET_RTC_VL_CLR           TARGET_IO('p', 0x14)
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


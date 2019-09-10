Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249FBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE269208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE269208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bdN-0004uI-Uj
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bcQ-00045x-ER
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bcP-0001YO-A0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:35:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bcP-0001Xr-0g
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:35:21 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPooN-1hkjZP1q6N-00Mtrb; Tue, 10 Sep 2019 10:35:00 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <08c834fe-2b04-9ca3-56b0-4774d5bca739@vivier.eu>
Date: Tue, 10 Sep 2019 10:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SzlVe+L1hKgHb504iJcbRHUeMhsRuwcsjfMeVRqcJn1SzXOb1zH
 wySwwZ49wEwW/lMHpO7kHKFUJM6pCcU/rSoC49LW5XxsFkNrcIpUOic9aWPHveJZjwdfU70
 4ZwW7NobqMnrrO+iVYfTQcIKEnkb7mL0qO4cBrLXUfzNXFbd+D8bX6Rbfqu8Zh5eISkchCM
 1Is0Bh5bDfwcbh4uRcfSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/VEoMPBzZbo=:F+gIPsXNvY6gpZmDfKmxWq
 XY5d17WXC65LjC90Q1bI9ZiyTSM7Xgj3OZ5yfQCeSfNuL1afhqHp9eKbp6IG+fkOTtszbSy0R
 XqVbrjdMlFlFIyHwdyoUCxVIRGUnot7lku/UcC0HDix6JRQbvvNqgHdHt98VRd495bG8PqBRq
 uuppnJp2LEUJBwSGRdLDEQ6YBgA4WTPzxLrPbig1HhciALYCk4l2CuNpGrovba1L9M6GrTCJj
 tkXJIXnUSbWewIBQCIdWUcy8qN5hhvtTClw9+NoILts0+5M8HBkjgRNNuAf22qLGxpXs4SHJ4
 T+1SQSWn5Q0NtLPCA45P90kZWPkjCPffdBDOEbxEdacqyOJyJ/7+yHL6lrrjoY5Y3A98jQf89
 5eV986bnJvxTDoJCIUufngD1SHHDp7SE6lUOwQMOxRySIc5qPKhrh53Vqbn8czx/B7Ww9mihC
 efXAUIo3+/m8CF8TcscEXsf36hUOXsOWrOYq3lzdRfZ/WEyE8jFukAVVpBrvdAp/ydeu/3xIC
 nJ5Hn5zyZ9q7d32UtO55YcuD1AC/vireyLg46I1dWJqF037OBd000e5bzb4gmbLmawUQlXwIV
 BNnnGuMCclrnqS6H8h2jPj8nF/Vi3lZ+GGpyJLEeubu0Vsn/sxcVuOzJBrtrl+XHBNJVSG8oa
 IAR0b2cSyenmmM8yNUZ8yY4R0JMgyhiKLBMsNDa1qPR6S9ZRmYTj3W6To2goC6uKveBRQmK0c
 EJBO1zMov+K/lAzd/vxQdeDe0wKOlRm2k2QVMXQHEktU8sQGb/h4c1dVJQMD/c8AFUerrbK/V
 2QL51xmydsEWLpqhFzZroOXamsk5KhGy+fhqfbWYlK2W9IOXk4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH v6 3/8] linux-user: Add support for
 FIOGETOWN and FIOSETOWN ioctls
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FIOGETOWN and FIOSETOWN ioctls have platform-specific definitions,
> hence non-standard definition in QEMU too.
> 
> Other than that, they both have a single integer argument, and their
> functionality is emulated in a straightforward way.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index cd9b6f9..1830de9 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -177,6 +177,8 @@
>  #endif
>  #endif /* CONFIG_USBFS */
>  
> +  IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
>    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
>    IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 19a1d39..498223b 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -758,10 +758,14 @@ struct target_pollfd {
>  
>  #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
>         defined(TARGET_XTENSA)
> +#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
> +#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
>  #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
>  #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
>  #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
>  #else
> +#define TARGET_FIOGETOWN       0x8903
> +#define TARGET_FIOSETOWN       0x8901
>  #define TARGET_SIOCATMARK      0x8905
>  #define TARGET_SIOCSPGRP       0x8902
>  #define TARGET_SIOCGPGRP       0x8904
> 

Applied to my linux-user branch.

Thanks,
Laurent


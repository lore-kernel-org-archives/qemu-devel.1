Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33962C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050BC20896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050BC20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUa7-0005ws-Qo
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbSeI-0004Oy-Gl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbSVf-0005KV-F6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:23:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbSVf-0005EB-5y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:23:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mv2l4-1iSK920Cy8-00qx9d; Thu, 13 Jun 2019 18:23:28 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-5-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <938e1083-b068-9eaf-8c34-a8f64da48557@vivier.eu>
Date: Thu, 13 Jun 2019 18:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GZxHllOzK47FEJiXTAL/KSAS+lY9JTMfffLeZpMaJMx8g7c6dhj
 Vj7rKp8b/90MlSXSN3UzJoa/FUJx0S8Vj9NIx8DvCsQ+f4F9cwW0V2bAiObg4mUKrfCms5r
 YJWgAGwW6WvqzbK5gPf9M5CFsTu9QyJ8HmuAGni+FvsBNAHF6Gra0tAhRbD3tY9798JSYQH
 Zv2EL3akN4qi4nnWpHC0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AwAJpt5v9IQ=:z3SoZiiAWYaFm9o/GNBmg+
 /RJ7A9ug5naDZZoXcdbixkxbLbnvUMN27dRDVV7XvKIooVnFQ5FR8BwwQkbPal3Q25V4XfMj/
 M5jWRx345XGb3UW2YSNrX/00w8EItJZuKq4A71uRp3smccXQgx7eKxkqdN8/CenUzYYhrBBul
 LQKfFjoESYdZfPopmAQowVDdP2V/9FpaYQDyePhPSIIp99/rA2ZLKheBHy3QQxbc4ocVlRJCK
 dpoeVuclmBtrPYv4BByv1gBLf744UKndGourR+qJ0P/HSQEBR+R+e0//bahobAITjNS+wOXSP
 b5uMjiKxs92dHhZp+Mx7JlxuAb196kGOieEwv3OqUd/WMGFA5AceFPioUhsimGPK2RKSsLuKK
 ZZX1xXo51rNDNd4sTs6EjMWa+FAR5ZgXtEmqq2DiFUtPoUuMlAi1WPmSlvPIWzAxn7FXBpwii
 t0iVBoJc69pHV76HhY7SjtePl4FV59VakaE5it+4VUB/Z+o3TqJhoeZ3r+l2xyQhFVeXnDmG0
 57xM21pKGl1woGGCf7lLT48qnRvdSyzEKEdkWlMJeB3kNuQKn9DpbkYMJCnBAeR/rkO0faxh7
 qa7XH65DZijKKuMUfvMdvCKrTSJ2z4WPUYTxJPJe2gad7/qud6vSYE64JYHATX9uTXjJmuJUI
 q7L+Xk5ITJA1jWnDZVWCYihUsCfyYxdQf9ESHm5KlO1L/2tqN3smlB2pBG2gnWhLX5LYmhqeq
 3SRR4LPggMrDnxOauSue4IUcWyvLZ3h5/0QHLY19UEFJy2AzRiazSygyw1s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH 04/13] linux-user/alpha: Set r20 secondary
 return value
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/05/2019 à 22:19, Richard Henderson a écrit :
> This value is not, as far as I know, used by any linux software,
> but it is set by the kernel and is part of the ABI.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/alpha/target_cpu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index 140a459f73..caadb54372 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -26,10 +26,12 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp)
>      }
>      env->ir[IR_V0] = 0;
>      env->ir[IR_A3] = 0;
> +    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
>  }
>  
>  static inline void cpu_clone_regs_parent(CPUAlphaState *env)
>  {
> +    env->ir[IR_A4] = 0;  /* OSF/1 secondary return: parent */

In the kernel, r20 is only set to 0 if !(clone_flags & CLONE_SETTLS), is
this a problem here to set it unconditionally?

Thanks,
Laurent


Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EA6C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D555A23134
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfhSLHUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D555A23134
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jporf-0006xa-5r
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpor4-0006Wj-G3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:09:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpor3-0000wB-49
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:09:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id j4so13092298wrp.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=21YY6mcVE1Q9ACw3WFPSrpuPAIp4AVawbHvAvTLe93M=;
 b=QfhSLHUEGdifIbI2NFkiDD1mKy7la6dDgpgP3JYZwTWkxOcsXfCaw6+9WilacoeIm+
 DY/MM1YihGeFUTUIdTrpI3m4vRmTbIY0reV4c5HTKopS23578kU0AbGUewejbbKLuyFG
 AxKsEqVmK6Pkwa/MSw2GUe4rlCLDiYbqjtLg4ugEXNzoxVxpje3CjvgFXF1D9ecu1mRP
 7+1sx7I3PEwpZhNAmJBNsfH3ZflrgvVfL0PGRkLZrXBk+Dqndrx/1s8GtiTCQZC4Z5uB
 nhn8qauGSO4p/8Fe3jPzse9F1e79r6wAcNKS9romDnKw5dobZNMe9Pqb+TYtTijRQ137
 sEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=21YY6mcVE1Q9ACw3WFPSrpuPAIp4AVawbHvAvTLe93M=;
 b=PFG6bWnqMDnNjr7uX7sfJyMXSHJECJOzyDogv5jK3P8y1Uo14/pgLCbPNn9Yj5hBit
 NjH/d1aQm5HwYvpPm2hMguEBr8L8NakUUeYgdXJbC9PTCH6Vn61VVSEiFpXI1F8RevFB
 I6WbCXsegKDx97QSMeqUxjqg6pA1LP8hbhKiLsQBZnE008OXXL3u4cTdRoHt2TfDLLdS
 O/Yr6TzwY9s8hGI02umYvB3CJ9HuuxuxRbA0XxMMXIjdLsKIpk2n+5w9FJHpp+0rOac5
 Vwmy44gSY8pzLH+PJ8Qr0NcEbKQ4Sc4JUFbr5WKRE3ETjQEqlka9ub+BG2CYZFnv4wBL
 UxuA==
X-Gm-Message-State: AOAM530YNSKDNcoXN4i8vcb5S3LU1Wr/1l9zj9XT9JWd1tpRucBCaXAW
 gZcPgS5rX5SqPaRv4Lna2Rw=
X-Google-Smtp-Source: ABdhPJwV00Yj889+hTh7/pscTNo5styXeoY8mhIfKSLV8CT4XpNeTUpX2gcAYJRE9C0e8Me29dbcag==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr16056303wrp.421.1593418167532; 
 Mon, 29 Jun 2020 01:09:27 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b184sm22169271wmc.20.2020.06.29.01.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:09:26 -0700 (PDT)
Subject: Re: [PULL 3/6] MAINTAINERS: Add Loongson-3 maintainer and reviewer
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-4-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <362d8118-93c9-d020-90ba-7ddbd8ad446d@amsat.org>
Date: Mon, 29 Jun 2020 10:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593287503-25197-4-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
> From: Huacai Chen <zltjiangshi@gmail.com>
> 
> Add myself as the maintainer for Loongson-3 virtual platforms, and
> also add Jiaxun Yang as the reviewer.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Message-Id: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b40446..fe925ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1096,6 +1096,13 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>  
> +Loongson-3 Virtual Platform
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S: Maintained
> +F: hw/mips/loongson3_virt.c

This file has not been commited, is this pull request incomplete?

> +F: hw/intc/loongson_liointc.c

How can we test this device?

> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> 



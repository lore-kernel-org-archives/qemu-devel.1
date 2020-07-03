Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60DD206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH4EjStA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60DD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGNZ-0004NZ-1P
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrGMy-0003sc-PY; Fri, 03 Jul 2020 03:44:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrGMx-0003G8-Ax; Fri, 03 Jul 2020 03:44:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id f139so32983136wmf.5;
 Fri, 03 Jul 2020 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bC3y8xuWMjKwlYSblWjX+R8WL/YDRTwWUNZjvgX8OCc=;
 b=cH4EjStABVU1I8Q/dSXFprkaReN8ipxni3V+0B6dqdvxRjOw8HnaRx9gGU8swNr9om
 nRCqYHDEim9TSM6yflyk4BJhhMVajxkYKX1z8E0MkgXHiYOnSn4xtmK9jrOFALEeMGyG
 +bHOVZH45czloHi/Md/eYfgYhDADyz2dAyWspRNG/sHFvCfDG7TyTW/V8yRlCuJMapLV
 gdt7sYd60+H3BajjPRv2Vj+sxreM88GkJkpEjWlMud6DuV29g8/474x7NFOXXPkYDo2f
 gPsOgRBox2u/i6wiYQgFEFGk9aI7ppz9Zp4c2rBm33asxuCp3w0nMAbvfWHR1c/K87xh
 8MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bC3y8xuWMjKwlYSblWjX+R8WL/YDRTwWUNZjvgX8OCc=;
 b=j39518IE+hl2XWTEjB8sCJmLNqUkH3yZmkyHFRmXQRxaNLBffkwZJQZw9+kcXMOua/
 GqizgYxJTQKszMrw2i9pjdWsXe/z5RfAj66oUf3adloSDakbnFtfduTDIdtkGHceOGsc
 TLsow2YW3slOfAoO1W/5v557sCJoyV/Nb5nBs7o3wLU/nUgpdrv/YzmJ2uG8d57XUjSm
 akbRY38ngrsxl+aGMEGBBsQJ+CuShazkSIpqAuSTh+kWbX91DuI9iGchIJtUCPQTv7Mz
 NwmI8NbldCAKM3j9iUDI6qKwqpMEmD0RyAyU1vFujLXOXDIirB53QSSLxVuI+BgAkHch
 h5rg==
X-Gm-Message-State: AOAM531c4macnjaT507jsZGr776Nutta+Wq49YdDhn6OwOXIdxuILW4P
 Y9oBcIBjWbCBlPCAX0iuSnVPIPkywPQ=
X-Google-Smtp-Source: ABdhPJwG1ScTmWnKNidu77ncCMFJlU5+giG9jaBdHBzuHUYsmD96NltmPh7h04Kk0BChLFoKtzn/JA==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr34274229wmh.41.1593762261795; 
 Fri, 03 Jul 2020 00:44:21 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm767397wrr.85.2020.07.03.00.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 00:44:21 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] hw/riscv: Allow 64 bit access to SiFive CLINT
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3f29be7-d6cc-f40a-02a2-c3a1ff681a5a@amsat.org>
Date: Fri, 3 Jul 2020 09:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 10:12 PM, Alistair Francis wrote:
> Commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> "memory: Revert "memory: accept mismatching sizes in
> memory_region_access_valid"" broke most RISC-V boards as they do 64 bit
> accesses to the CLINT and QEMU would trigger a fault. Fix this failure
> by allowing 8 byte accesses.
> 

Fixes: 5d971f9e67 (Revert "accept mismatching sizes in access_valid")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_clint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index b11ffa0edc..669c21adc2 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -181,7 +181,7 @@ static const MemoryRegionOps sifive_clint_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> -        .max_access_size = 4
> +        .max_access_size = 8
>      }
>  };
>  
> 



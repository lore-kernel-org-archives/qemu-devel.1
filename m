Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB7C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47642083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47642083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguYX-0005zu-1M
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguWO-0004WW-SX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hguWM-0005i2-OM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:18:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguWM-0005hL-JK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:18:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so2850827pgr.13
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=cdnW3vBpIbBthg3lp9UrlXXEDiqP6W4bvRzXc/KCoAQ=;
 b=lMgE24nOHqoLhRo4MtBUz1Nk3K4cNkq0hXAfOb15iDo1Ku3hXCiTgJ9Ut0JXcN8gtx
 /0zp14qTuKNwOr7EkL0SQVv0GHfKAuEZwvhfMVtTVqp/zlPOeTSrqe2FOlfPj1wOcCkt
 9P0AnID5WHm7iRrF62dPHt89+CtUvyUboUUncBkt9MUX5yzUX5iNn7jAC13oxJSl32V0
 YrzPW33rZQMBA7LXkcBIf/I3oDIbstuinG+o4XWaTjIdn+CMvZKccBt2pDCy//SBYhK4
 ALbrToqO1MMBXMGGv8MAOakd3d3wwUVEa8VPq2dNzdWCZC5CxEciofzWtAZEqXHrafK7
 OvfQ==
X-Gm-Message-State: APjAAAVESMXLSlkuXmEcBKR0+y1O+4cQuM0iaZP02z9zF8aaXZkG8LH4
 Lw23rMNL1rvynvd8hFV5eIp68ej4jMs6tQ==
X-Google-Smtp-Source: APXvYqz/y1f7RaRvvCeV4tC302CsTfhW8sWmJjS4C3G0peTDovfDfADSN4H81JhirFllqg8f2lWB1g==
X-Received: by 2002:a63:b243:: with SMTP id t3mr10321160pgo.223.1561742324220; 
 Fri, 28 Jun 2019 10:18:44 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id d26sm3485485pfn.29.2019.06.28.10.18.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:18:43 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:18:43 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Jun 2019 10:13:14 PDT (-0700)
In-Reply-To: <20190628161503.16760-1-alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-c58538a5-2727-4a7a-bae0-3e1ec2d34706@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH] fixup! roms: Add OpenSBI version 0.3
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 09:15:03 PDT (-0700), Alistair Francis wrote:
> ---
>  roms/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index 562ed726fd..dc70fb5aea 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -179,7 +179,7 @@ opensbi64-virt:
>  		PLATFORM="qemu/virt"
>  	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> -opensbi64-virt:
> +opensbi64-sifive_u:
>  	$(MAKE) -C opensbi \
>  		CROSS_COMPILE=$(riscv64_cross_prefix) \
>  		PLATFORM="qemu/sifive_u"

Thanks!


Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224DCECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED32121721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED32121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHw4z-0003Mi-4T
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHw4H-0002q2-Ll
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHw4G-00049B-CA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:26:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHw4G-00048y-6L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:26:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so61526pfw.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=kQc89uftmwa+HzRPnyPSuM5Jq7S/nmCRSuOBGRsogm4=;
 b=r6AMAprHEvllI5S+04GH5AQ1eNP3r6bZzeaca2Bw8mnDU1qnIQUebrCa9dXGRcQ4st
 rSEFZaFfz5Dvrg1iWyIx/odW8pVod3nqSFmIkJcpMoTwG8it9cab/qQTXr5M+s9dNfBT
 XSwqLZO8aoqo/1H1lGFwbQpKMJj1kebBYdUbtIC5c5Ylh/cahL9eaJfUqtiBrPUWySxI
 j1cCZUXn0wExYWXhec8JpHBoVLc4fy7h7tbgin2paA5W65IX5ZvgGW05ILBs9nsBDmy2
 P2xLuo/kyY1kJ9MrfhvZu0BYMaYDqWAqqJqenc9cYI96pXMb0yDee/m2nGBf0vRxzAE7
 2Fhw==
X-Gm-Message-State: APjAAAWtDVvzOXn63df1l4uNqG13A66TC3pWIs1mQoXe3mEsa48VoKGv
 8jjlpNV9U0JEqBsPmO3U5DgQVQ==
X-Google-Smtp-Source: APXvYqygQrQrxipwBSmo7JicVOTCEPcsUJpDbD6xpeoTB4ZVcqDiZOojaFV3pQ39zQYDvyOdmYTfNg==
X-Received: by 2002:a62:cb:: with SMTP id 194mr42573892pfa.130.1570566406794; 
 Tue, 08 Oct 2019 13:26:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id u194sm57947pgc.30.2019.10.08.13.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 13:26:46 -0700 (PDT)
Date: Tue, 08 Oct 2019 13:26:46 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 13:26:42 PDT (-0700)
Subject: Re: [PATCH 2/2] riscv: sifive_u: Add ethernet0 to the aliases node
In-Reply-To: <1568971142-27979-2-git-send-email-bmeng.cn@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-be9f6302-4920-4a48-bf8a-0fe7a560545b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 02:19:02 PDT (-0700), bmeng.cn@gmail.com wrote:
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
>
> This is to keep in sync with Linux kernel commit below:
> https://patchwork.kernel.org/patch/11133033/
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_u.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 02dd761..1ac51e3 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -270,6 +270,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          s->soc.gem.conf.macaddr.a, ETH_ALEN);
>      qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
> +
> +    qemu_fdt_add_subnode(fdt, "/aliases");
> +    qemu_fdt_setprop_string(fdt, "/aliases", "ethernet0", nodename);
> +
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
> @@ -297,7 +301,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>
> -    qemu_fdt_add_subnode(fdt, "/aliases");
>      qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
>
>      g_free(nodename);

Thanks.  These two are in the patch queue.


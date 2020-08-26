Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49831C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A65207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="WsH0N28S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A65207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzSp-0003Vx-DK
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAzRd-0002oC-U5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:42:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAzRb-0001LZ-Bc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:42:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id o4so2702080wrn.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3qb9iRO/PwSV9NFhKNd1ED2pxLCZVEdGyUkv49j5+x4=;
 b=WsH0N28SkEPk9DBooqvPuEz1x0Luu8vrvJgiaMhFOL7xrREyyERULBQ9c/OSZfzbn5
 FZkET/gJCqNJbX5FQULCdNyCNv6CI0Hni701heMycDK+aZ7I1coSie3OmGdemoS64B/M
 YyeiEBGKn9R9Q0WK/GJp5QYjA6SJu3LnXZTdNf01sq6pDFIeRnM8hyAWpvj0NOd5c+Dp
 yXWwt1GnovU1ogkyxWtJleEev0c2KfP/wzlr+HvBPVIRr83glm4Vau+zJ6qtFKZ2t8om
 WHLph7OK1cFMe6y7t8VaeB4lHRKHyEnoQav0EVbm6oBsAccyo5mzBWj2y1H1txiDE6dw
 5ASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3qb9iRO/PwSV9NFhKNd1ED2pxLCZVEdGyUkv49j5+x4=;
 b=ZCRwOiksP0zS0dc2j5LcUiwmuA6EXM5J7hlThL7DNCr64R/6MVXj3RaxMvgLop3HVb
 malVjZ3td9wIHTHNHKpmZIoKyfZqJSGqWxC6feFwGTgzrEmnAxOSQf/9qBEajFoUc8T1
 R7Weu3cmeOHrI+Qa17En7y6+lgDy+kGdxmNmJguzxMnekoVoTBdqIdlL8tsAH3cqQ6EV
 eQIPqMac1uQb4u/eoa7j4OGQ1OnuKqs/WMFnyWb5vh6r13Ajk55aa5MySE1CN4lgOeKE
 Imy1TtfR7hd54PVYWbnonDZdfwcqEar+jqI+IwWGR1wrddqvhHBNDlfbLClAy9rkR3OR
 r+cA==
X-Gm-Message-State: AOAM531NrKa8XR78A8+Gh+I/MPHMTVFLTnOytvCG6gRb9gOckBZ5unNi
 pmbTm4ZUd7jomdRoAu+nDvJ26A==
X-Google-Smtp-Source: ABdhPJypbUKRBl7GMtJSvNmO571VEQYb2Y5WMCW9FL7mluQDiJOVDdeYY8Gy88A4Qkh1GJeroNkFgg==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr11678817wrn.60.1598463761421; 
 Wed, 26 Aug 2020 10:42:41 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id j5sm8587452wma.45.2020.08.26.10.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 10:42:40 -0700 (PDT)
Date: Wed, 26 Aug 2020 18:42:39 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Leif Lindholm <leif@nuviainc.com>
Subject: Re: [PATCH] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
Message-ID: <20200826174239.us5etrvktv7m77sa@xora-monster>
References: <20200825165217.7379-1-leif@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825165217.7379-1-leif@nuviainc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 05:52:17PM +0100, Leif Lindholm wrote:
> The sbsa-ref platform uses a minimal device tree to pass amount of memory
> as well as number of cpus to the firmware. However, when dumping that
> minimal dtb (with -M sbsa-virt,dumpdtb=<file>), the resulting blob
> generates a warning when decompiled by dtc due to lack of reg property.
> 
> Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.
> 
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>
> ---
>  hw/arm/sbsa-ref.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index f030a416fd..167c57a08b 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -183,7 +183,22 @@ static void create_fdt(SBSAMachineState *sms)
>          g_free(matrix);
>      }
>  
> +    /*
> +     * From Documentation/devicetree/bindings/arm/cpus.yaml
> +     *  On ARM v8 64-bit systems this property is required
> +     *    and matches the MPIDR_EL1 register affinity bits.
> +     *
> +     *    * If cpus node's #address-cells property is set to 2
> +     *
> +     *      The first reg cell bits [7:0] must be set to
> +     *      bits [39:32] of MPIDR_EL1.
> +     *
> +     *      The second reg cell bits [23:0] must be set to
> +     *      bits [23:0] of MPIDR_EL1.
> +     */
>      qemu_fdt_add_subnode(sms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#address-cells", 2);
> +    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#size-cells", 0x0);
>  
>      for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
>          char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> @@ -191,6 +206,7 @@ static void create_fdt(SBSAMachineState *sms)
>          CPUState *cs = CPU(armcpu);
>  
>          qemu_fdt_add_subnode(sms->fdt, nodename);
> +        qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", cpu);

To obey the statement earlier shouldnt this be taken from the mp_affinity
variable in armcpu?

Graeme

>  
>          if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
>              qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
> -- 
> 2.20.1
> 


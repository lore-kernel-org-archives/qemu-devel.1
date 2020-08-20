Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C492C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569D72075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwVbpJHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569D72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nG5-00088H-IX
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k8nF6-0007Ma-0g; Thu, 20 Aug 2020 12:16:44 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k8nF4-0008LV-5p; Thu, 20 Aug 2020 12:16:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id x24so1913154otp.3;
 Thu, 20 Aug 2020 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=zd5pZKrDvk9CE+YKdSqm89psJf8YR/wO2E1MRyP0kYY=;
 b=TwVbpJHh/ozDLgnuU67vWc6F9JCaZKdwXGaRzlVeDM0QsYxqK3zsR+WAXzbHEA/K44
 g1UjrtwBeAa4VMUrA/2buF5yn4PE8XjfbST+Ai/jjtC4FVCyrIVzZQDkS2mP57sj7asp
 rePY4lpuJGNjKBdqsLmDRbOsravqLw5WWqSIZMrH3OuYV/ggQ25Cf7BGONxD9hltrgNn
 3RbjYQ7lNz2hzsaTGo739j9wnaYOHDY+TzI79e3MmmR3bcN0d2tFXa0TAoFUQcP1VCHn
 Td7x//dKiBcs9ZU/WKTYpmXntdnUkCSzBgIKHJFCiaLl8+NPqbsRGj3HZEOSCUwjdTaB
 BSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=zd5pZKrDvk9CE+YKdSqm89psJf8YR/wO2E1MRyP0kYY=;
 b=EBVTiN6N76LTp8veakKbvaJiVFjARazffINs+ACaCdZcakrtOcz8yjLdkDxEwsdKiI
 GtmTpnBz5SUoU0uDJ+xxSzreJl48ECVgpKfKTBwIz1YjC3+IasY6UzJxiBcM542B4/D7
 LmYu6UBYsHujMq1thmRFRlrTUL0Dfw0P4GWI18pWGqlrfrJgdr8kkohenTSznK4Ah9Ob
 V/L4NVpOoroi+N5TFa1GllbFEaWtFxv339f6IvMmBTWUe/Met/ZdS1u7CJSqnhN6ZEIO
 DSHVmxlSXRGjnRYOpiRp0qgwowoE3sjwLIv23GC64DzZG8neLkRQQ9V/u0zIuGS9al25
 Viyg==
X-Gm-Message-State: AOAM532q8Dp9ynD6MNoAE6CdVL4urjQyTDQGfk43qOUfGyf9dpc2Cw68
 uhcJ4U9iXgOBUs3c64cbVw==
X-Google-Smtp-Source: ABdhPJzJ84smPsRqKHSvaRI7v7z6dpE4riLNznl6DbcvdXKTQj9kl57ttaQx2sGZwZl179/tqT4cLA==
X-Received: by 2002:a05:6830:1e91:: with SMTP id
 n17mr2755125otr.172.1597940200045; 
 Thu, 20 Aug 2020 09:16:40 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id m19sm549556otj.29.2020.08.20.09.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:16:38 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
 by serve.minyard.net (Postfix) with ESMTPSA id CC38A180037;
 Thu, 20 Aug 2020 16:16:37 +0000 (UTC)
Date: Thu, 20 Aug 2020 11:16:36 -0500
From: Corey Minyard <minyard@acm.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Add a HIOMAP erase command
Message-ID: <20200820161636.GM2842@minyard.net>
References: <20200820073650.2315095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820073650.2315095-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 09:36:50AM +0200, Cédric Le Goater wrote:
> The OPAL test suite runs a read-erase-write test on the PNOR :
> 
>   https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.py
> 
> which revealed that the IPMI HIOMAP handlers didn't support
> HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
> the PNOR memory region.
> 
> Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv_bmc.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 2e1a03daa45a..0fb082fcb8ee 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -140,6 +140,29 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
>      return bytes >> BLOCK_SHIFT;
>  }
>  
> +static uint32_t blocks_to_bytes(uint16_t blocks)
> +{
> +    return blocks << BLOCK_SHIFT;
> +}
> +
> +#define IPMI_ERR_UNSPECIFIED            0xff

Wouldn't it be better for this to be in include/hw/ipmi/ipmi.h and
be named IPMI_CC_UNSPECIFIED to match the other completion codes?

-corey

> +
> +static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
> +{
> +    MemTxResult result;
> +    int i;
> +
> +    for (i = 0; i < size / 4; i++) {
> +        result = memory_region_dispatch_write(&pnor->mmio, offset + i * 4,
> +                                              0xFFFFFFFF, MO_32,
> +                                              MEMTXATTRS_UNSPECIFIED);
> +        if (result != MEMTX_OK) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
>                         RspBuffer *rsp)
>  {
> @@ -155,10 +178,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
>      switch (cmd[2]) {
>      case HIOMAP_C_MARK_DIRTY:
>      case HIOMAP_C_FLUSH:
> -    case HIOMAP_C_ERASE:
>      case HIOMAP_C_ACK:
>          break;
>  
> +    case HIOMAP_C_ERASE:
> +        if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
> +                        blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
> +            rsp_buffer_set_error(rsp, IPMI_ERR_UNSPECIFIED);
> +        }
> +        break;
> +
>      case HIOMAP_C_GET_INFO:
>          rsp_buffer_push(rsp, 2);  /* Version 2 */
>          rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
> -- 
> 2.25.4
> 
> 


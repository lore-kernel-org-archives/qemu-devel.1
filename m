Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E3AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB73206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiiDTHEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB73206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8q5Z-0008HN-OT
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k8q4v-0007WR-EV; Thu, 20 Aug 2020 15:18:25 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:35944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k8q4t-0008Bj-Iy; Thu, 20 Aug 2020 15:18:25 -0400
Received: by mail-oo1-xc44.google.com with SMTP id y30so673564ooj.3;
 Thu, 20 Aug 2020 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Vnax+/8kwca/FWLC/KOpQm5pBzhgxuk0x/K/b4Ynn+8=;
 b=EiiDTHECxhwrwVPJbmCwxheO63u9eIGtJmFS5Mv7vwJ7lkbsLx0vx5ap10wi8LCWlW
 Q3RiwWdY5VtdxF4Xuu7dPfBc3jekg+/tJiMbXDOQKws+lJp2inl4JTncavLE2cwIdQLD
 pVGAeh87xvqA/CTHXqC9Dhdf8TbP0komfDAnHjvk7Yn5hxi0MZCCm4nd0I0iGfdWK8gS
 ByS4ofbVlxHQKPm9cYtoRlGS/lyRKAasiwUS+7gzsfZlQiCVwUJ29SUjkUtxKY7P1O6X
 cHZDIhJPMJlcCYYAZwcrBD5gRZ3+hX32SHUxgrtOHifYl7O+Q9YKWBP4pDDiaNQ6kWbL
 uZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=Vnax+/8kwca/FWLC/KOpQm5pBzhgxuk0x/K/b4Ynn+8=;
 b=aOZfhso9T0Gcx6q9RUM3V+GC82T03XWhrQjpvJ580Uen1hlEF8Z8oV5iITP4L+A1CL
 qrGOkKrgkUARUBUXTC70R+aAyJLdalzFnj6a3dETQrJHwghPGmyQ0/9tx0nILrJGg4Qi
 ihAp9TQFdRe4rILiprsIiYmTOVH8zydkhOjvpHgyUzxMKVzJ6skOxncdT6iXSuBN8bgv
 eTNMQ2e1Uv1OoXTjV9E5T+Bqi9GM66P6peLzUZTGPGLkNF/YRebb4pP+tVHfJMekJldA
 vEatFs3lifA+mR2ATuO0eVkY7qS3wsx2YMl7h6PiVxpQofjAkuAEIUiqEkonzl6QA+Fz
 QYhw==
X-Gm-Message-State: AOAM531JFPmsu94ZtXVXuuru+9lnD27TNv22034rbqUpg2CAwnyeCZ0g
 rvITiNvkKOBN5p7wxmjH+A==
X-Google-Smtp-Source: ABdhPJzWUvLIiqM7atr0Bl7TOX+385i+yud5Kj/UbmLWQizHXx4rfQvW1UIXm/ik2w/l1Z1lxrHw5A==
X-Received: by 2002:a4a:a80d:: with SMTP id o13mr85711oom.12.1597951101955;
 Thu, 20 Aug 2020 12:18:21 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id a14sm644267otf.41.2020.08.20.12.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 12:18:20 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
 by serve.minyard.net (Postfix) with ESMTPSA id AD9F11801D9;
 Thu, 20 Aug 2020 19:18:19 +0000 (UTC)
Date: Thu, 20 Aug 2020 14:18:18 -0500
From: Corey Minyard <minyard@acm.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Add a HIOMAP erase command
Message-ID: <20200820191818.GN2842@minyard.net>
References: <20200820164638.2515681-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820164638.2515681-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 06:46:38PM +0200, Cédric Le Goater wrote:
> The OPAL test suite runs a read-erase-write test on the PNOR :
> 
>   https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.py
> 
> which revealed that the IPMI HIOMAP handlers didn't support
> HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
> the PNOR memory region.
> 
> Cc: Corey Minyard <cminyard@mvista.com>
> Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Thanks a bunch.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
> 
>  Changes in v2:
> 
>  - Introduced IPMI_CC_UNSPECIFIED as suggested by Corey.
>  
>  include/hw/ipmi/ipmi.h |  1 +
>  hw/ppc/pnv_bmc.c       | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 8a99d958bbc3..c1efdaa4cb42 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -53,6 +53,7 @@ enum ipmi_op {
>  #define IPMI_CC_INVALID_DATA_FIELD                       0xcc
>  #define IPMI_CC_BMC_INIT_IN_PROGRESS                     0xd2
>  #define IPMI_CC_COMMAND_NOT_SUPPORTED                    0xd5
> +#define IPMI_CC_UNSPECIFIED                              0xff
>  
>  #define IPMI_NETFN_APP                0x06
>  #define IPMI_NETFN_OEM                0x3a
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 2e1a03daa45a..67ebb16c4d5f 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -140,6 +140,27 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
>      return bytes >> BLOCK_SHIFT;
>  }
>  
> +static uint32_t blocks_to_bytes(uint16_t blocks)
> +{
> +    return blocks << BLOCK_SHIFT;
> +}
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
> @@ -155,10 +176,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
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
> +            rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
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


Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ACDC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A149B2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgiuCOPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A149B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOge-00045W-Nn
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jLOZQ-0003Zc-BS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jLOZP-0001ez-7i
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:01:32 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jLOZP-0001e2-0G; Mon, 06 Apr 2020 06:01:31 -0400
Received: by mail-lj1-x241.google.com with SMTP id r24so13971353ljd.4;
 Mon, 06 Apr 2020 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cFvR39LrJejlyXEicAvpk6riu/od5qgMWNd/mQ8Q/IA=;
 b=HgiuCOPnC2uMTIAKa61hLev+yh/4i4zU7/9TWNEyH2pUDfion3cG0pwW/k+8lEe3QN
 0902V5faWgjBNen4ZWbeoLUAaZ48pbyJiBdW8umDR/I+y2uN733D/uW/57eAPm12ShZi
 j2dk4QlOZOBd4IIIgKnaN/I19BqIJfOzDTwtMkqM+48VfIziOBdWAspKfxcUKcM236CE
 Xxup5zEA5XnZjxNecYpGLmEiHE6nfqtX662fEQhCjLsPIY0PEK1NEMxkLsI/8uqI7qi0
 hN/N4CKTl5hGCsDsMBK6TwlMy7hcqRawggHgbNnvI6f7mOCWwUf3q8NL/Ib8/BPmhMWP
 lK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cFvR39LrJejlyXEicAvpk6riu/od5qgMWNd/mQ8Q/IA=;
 b=ACJKa4G3QIaLUJaJU16LaNFqlfCJ8EDNIkeaQNLrTgfKKaVQtk+woFif6g6hjz40qA
 jl40AWf78VfYH5w2d/Vl8BapD0rxsTL5JqTM/zCutsV0Dp4gqxLjzHfcRoULWybqJpRs
 +r8Eudpqtc+70SSIZINmp9qARMDpzjSBpvIqGBvJrsGdH8G3wNWde/rxSlmD/die0j0Q
 HHzke15xU4XCmCEu8kwLvmeMQCOTmyeLSAjuGQTKVv3ObQ2xwhW5qTEYWGCgxrvZXF3N
 kHyeFMny7QSdLkNgp49EXdpRwdOZPQjAOnowMQs455whgA5ycZLCHKoPzQJoAbsOX2kx
 KZng==
X-Gm-Message-State: AGi0PuYrELwyHp7krsYoJznsM/ZOYB8h0nN+Q5GL9xCwtr5Y/nhNixnQ
 vq859D2jG/0hmCabkV7cxn8=
X-Google-Smtp-Source: APiQypLUhKrR1vPFtC0CCtzPENK6geGrPdJgM79NTQMRehz9FkuiTr4aa3MaWO9w44S44bZgepyaJg==
X-Received: by 2002:a2e:3a19:: with SMTP id h25mr12062672lja.133.1586167289273; 
 Mon, 06 Apr 2020 03:01:29 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 6sm11185546lft.83.2020.04.06.03.01.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Apr 2020 03:01:29 -0700 (PDT)
Date: Mon, 6 Apr 2020 12:01:26 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 1/2] dma/xlnx-zdma: Fix descriptor loading (MEM) wrt
 endianness
Message-ID: <20200406100126.umprjykxky3oxfur@fralle-msi>
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
 <20200404122718.25111-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404122718.25111-2-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 04] Sat 14:27:17, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Fix descriptor loading from memory wrt host endianness.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/dma/xlnx-zdma.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 1c45367f3c..5f4775f663 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -299,19 +299,22 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
>      s->regs[basereg + 1] = addr >> 32;
>  }
>  
> -static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
> +static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
> +                                 XlnxZDMADescr *descr)
>  {
>      /* ZDMA descriptors must be aligned to their own size.  */
>      if (addr % sizeof(XlnxZDMADescr)) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "zdma: unaligned descriptor at %" PRIx64,
>                        addr);
> -        memset(buf, 0x0, sizeof(XlnxZDMADescr));
> +        memset(descr, 0x0, sizeof(XlnxZDMADescr));
>          s->error = true;
>          return false;
>      }
>  
> -    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
> +    descr->addr = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
> +    descr->size = address_space_ldl_le(s->dma_as, addr + 8, s->attr, NULL);
> +    descr->attr = address_space_ldl_le(s->dma_as, addr + 12, s->attr, NULL);
>      return true;
>  }
>  
> @@ -344,7 +347,7 @@ static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
>      } else {
>          addr = zdma_get_regaddr64(s, basereg);
>          addr += sizeof(s->dsc_dst);
> -        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
> +        next = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
>      }
>  
>      zdma_put_regaddr64(s, basereg, next);
> -- 
> 2.20.1
> 


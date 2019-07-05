Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F6C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678E920659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibIK3ttG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678E920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjX5E-00049H-Mx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjWg7-0002Pf-JC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjWg6-0004FV-GS
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:27:39 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:32801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hjWg6-0004Ek-86; Fri, 05 Jul 2019 18:27:38 -0400
Received: by mail-lj1-x241.google.com with SMTP id h10so10559645ljg.0;
 Fri, 05 Jul 2019 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=EuO3SQ1JkM9Sd0A/U/2k2/nifapET8PHFaQtDL31u1I=;
 b=ibIK3ttGn3y6OwHghSKS4CWfwU2hlW5hCVVf1qlvKSggOTE6xh9i9ERDm6QmSVXNT3
 4oGf5fraHkS12ccn0dr5MBgNHe8srC5WadCTZsrqsc/3yZLxO20MqmKO+vN2Sy499Ik7
 jHjUPBiwToAmAS77npBS2rk63lYHKGGb81p7pBeNTcP6asMdqIsiaCC/WhD9r/9QdPTb
 8bAWpE6pDrO451+cp2feCGmo2teoC5GFWnPBjRSmidKJ+yZAeZc14Xavc+ORvDRF8E3T
 CjzkufJuj2P0tTxTUZam+3U5oRkaSxnulqQskbo6sRwl2sBXpiUMSWdXVfhfTg9zni8O
 NJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=EuO3SQ1JkM9Sd0A/U/2k2/nifapET8PHFaQtDL31u1I=;
 b=RcE5M96lcpUrA0wBne+K1sBcmUjpPbF/NccmkPoVdrjyLy2DmSfJRj689UP6bkkLj1
 FXOlmxKONzkhB0+56w/q40dIyOtHneamDomNH6rfx6NSm1jLUU5D1pE0+GHZlPpzQhir
 F0V/51Hwupr7meePor/vILPo3uTNXXSln0piIBDaw5g6VgkooIx2aliIikJPcH2zq3BE
 T21F8KoFab+zJ1NskhOVSEuNtHOtQPJoPdBciuLn25BBoNa5fv2pjaPOwK2gyn5zhQ1q
 Rk2ky+tuyO+aZE7N5IdP09gBFdMSeJAd7bo1cQYYOn9KveC7Edu438H3FoCDc3uhsrXD
 2MHQ==
X-Gm-Message-State: APjAAAUCBnAPdiBNcY+g9QrXriysg5M87d7QqocftmBl78NfjreWpM/S
 Tya1OVWJoR2gyJSjf3sqp7E=
X-Google-Smtp-Source: APXvYqwISrK/ObJxxZqaJCQQKctuBubUmguSy9iqdU9S3E0S+ViQCKDRkXOmpCKWtAJv+Y0Co4p8IQ==
X-Received: by 2002:a2e:864d:: with SMTP id i13mr3297723ljj.92.1562365656593; 
 Fri, 05 Jul 2019 15:27:36 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 z17sm2027186ljc.37.2019.07.05.15.27.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Jul 2019 15:27:36 -0700 (PDT)
Date: Sat, 6 Jul 2019 00:27:34 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190705222733.csufstr4iua5wfle@fralle-msi>
References: <20190705202500.18853-1-philmd@redhat.com>
 <20190705202500.18853-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705202500.18853-2-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 1/3] hw/ssi/xilinx_spips:
 Convert lqspi_read() to read_with_attrs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2019 Jul 05] Fri 22:24:58, Philippe Mathieu-Daudé wrote:
> In the next commit we will implement the write_with_attrs()
> handler. To avoid using different APIs, convert the read()
> handler first.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
> v4: Do not ignore lqspi_read() return value (Francisco)
> ---
>  hw/ssi/xilinx_spips.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8115bb6d46..b7c7275dbe 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1202,27 +1202,26 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>      }
>  }
>  
> -static uint64_t
> -lqspi_read(void *opaque, hwaddr addr, unsigned int size)
> +static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
> +                              unsigned size, MemTxAttrs attrs)
>  {
> -    XilinxQSPIPS *q = opaque;
> -    uint32_t ret;
> +    XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
>  
>      if (addr >= q->lqspi_cached_addr &&
>              addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
>          uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
> -        ret = cpu_to_le32(*(uint32_t *)retp);
> -        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
> -                   (unsigned)ret);
> -        return ret;
> -    } else {
> -        lqspi_load_cache(opaque, addr);
> -        return lqspi_read(opaque, addr, size);
> +        *value = cpu_to_le32(*(uint32_t *)retp);
> +        DB_PRINT_L(1, "addr: %08" HWADDR_PRIx ", data: %08" PRIx64 "\n",
> +                   addr, *value);
> +        return MEMTX_OK;
>      }
> +
> +    lqspi_load_cache(opaque, addr);
> +    return lqspi_read(opaque, addr, value, size, attrs);
>  }
>  
>  static const MemoryRegionOps lqspi_ops = {
> -    .read = lqspi_read,
> +    .read_with_attrs = lqspi_read,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> -- 
> 2.20.1
> 


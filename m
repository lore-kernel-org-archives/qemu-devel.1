Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD88206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdXWyvbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD88206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd7r-0004XR-PV
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd2F-0003vd-TF; Mon, 04 May 2020 11:29:35 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd2F-0003sU-2j; Mon, 04 May 2020 11:29:35 -0400
Received: by mail-lj1-x243.google.com with SMTP id h4so10077707ljg.12;
 Mon, 04 May 2020 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OCxln7r9CtY3KwMZIPpbOtordTxgRoQdjtUPMOchYF8=;
 b=bdXWyvblRI2zWFXu09VP0vIXcF9pUtprKN9kxGW+KuPPuMNRUOVFdfHgqhAPT+9jYu
 iiJ504v6ajs8uYMdiqlDShu+3oiYfWnTiVj4ie+5O/+F48BDgPFjUA65WcG5PVWy+WNo
 HCGaohD4POSt3ofE+H/MVA9GTw7AXNn9ZSOEtCMhPfOtQUifD9tyYhbAaITW2gw6r/Mw
 AGnrmpLEv4jFFy1m1l73h4230aaD5gFNLUtYYoakHmt5h9mY8+9L/7MPS2g3MoUFxsVa
 wmWj2E/P4Gt0Aaxj98WpvZqz2jP1qegPmA/WA+QMFlQTwhCxLk4J3JMrac/xjHV532SD
 JZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OCxln7r9CtY3KwMZIPpbOtordTxgRoQdjtUPMOchYF8=;
 b=Tls1+Kp0q9izJ6+T7VJkUUGjBSpsbZ1+UfogFoYxREWVd1aY/I4LdfhXePbybg58S4
 +3JatKg3oBbcQnFtqWQ4kvfp2LZhM03zLQiemZmlLw9QZh3qxnH8Kn1kJMWYtzzGodqV
 PSHz4KO+6gFfz+Et0mGSLtHu2c5+lGVhSvU0yAFKzcmc3f8cspGVOB6XsbictkiTh7WU
 HUkuj3+r2V2y8QmLrbGxCFXTPdc186uRRF6ckiUjrmwwnYo6nAjhdG1zOpUCjUYLH3El
 l4yVQjvdPlzia98YWVAdb1tVy+Cg3bJLPphDCFvQV/xo80nI4gACEqqkRqW8GQL7+vZR
 okUg==
X-Gm-Message-State: AGi0PuY1aMkqEBySCFx8O5btkZpypkAW00374aY3FYwVeVl2hZFADxpR
 1RHUcK1FprWBx+gpc5lD3mM=
X-Google-Smtp-Source: APiQypLN2p4tzVmFydbjk/5jI0P5LVdD5KwtsusZJnaj2sBX0ZecZ8QfrD6/WLqLoBMVSPC1W5KGFw==
X-Received: by 2002:a2e:a58d:: with SMTP id m13mr10847069ljp.164.1588606172617; 
 Mon, 04 May 2020 08:29:32 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 j22sm8482690ljh.107.2020.05.04.08.29.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 May 2020 08:29:32 -0700 (PDT)
Date: Mon, 4 May 2020 17:29:30 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 1/9] hw/net/xilinx_axienet: Auto-clear PHY Autoneg
Message-ID: <20200504152929.la2w7qapvf2b752t@fralle-msi>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-2-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_WHITELIST=-100 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 jasowang@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 30] Thu 18:24:31, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Auto-clear PHY CR Autoneg bits. This makes this model
> work with recent Linux kernels.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/net/xilinx_axienet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 704788811a..0f97510d8a 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -149,8 +149,8 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
>              break;
>      }
>  
> -    /* Unconditionally clear regs[BMCR][BMCR_RESET] */
> -    phy->regs[0] &= ~0x8000;
> +    /* Unconditionally clear regs[BMCR][BMCR_RESET] and auto-neg */
> +    phy->regs[0] &= ~0x8200;
>  }
>  
>  static void
> -- 
> 2.20.1
> 


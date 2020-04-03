Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A78C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BF220787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB644px9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BF220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKG8M-0007FD-Kp
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 02:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jKG7g-0006iT-JR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jKG7f-00011I-IT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:48:12 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jKG7f-00010i-9J; Fri, 03 Apr 2020 02:48:11 -0400
Received: by mail-lj1-x244.google.com with SMTP id k21so5880469ljh.2;
 Thu, 02 Apr 2020 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KpN8FN8Gh2TEnC1CcN5yIM656FSZeo9lJZDBNNHpy+Q=;
 b=VB644px9pQvSo5oR5F3OF15iQ9ZTILTyNIe6ajIAJoyGnDTj3Y0TVOhEgpKibrt5ud
 dI0XL1tXRCapsq9rkHlhpqvcqgyYF430VwxvqoMKyMo06Kl1nFoBhthaKtncmilTcrEp
 HsHnRNNlmwmcu/WI6i4WE0xzAV3fu6PSdIRNhZHGljxte3jFgk98+8uUcrZgaDu6lsAS
 XOVuOZpvS5OlqrLmu0S3GnsbuLL3qwCxdoz9wWfFfOugwuMt/6o9GkUiqudHK+lGTBfg
 hfEcl1BuRhwLiVrgivioMiKnHaS3XYN28XwRUe5fAt/K18a6fTp61rn1qkieW6hkEBAF
 AXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KpN8FN8Gh2TEnC1CcN5yIM656FSZeo9lJZDBNNHpy+Q=;
 b=LyQXdB6lY7IwDsZNTbZGrqZWdsF7l7bHwiCBmrvC1PLLRt3Y4WUybtSG+/trzLnF+H
 u3z4+Kz5UeYOc3RjC3kQR8+DyJZwNLPoQ+XFhz6UEK1rnVQu21r+RbqV9LvxTYGprGQM
 t291oTdiU7rSHvo2scINRLVo0gyx5viO9pipK1DJICbtWI5DFIgJGjWWqqAMaeXSPcMl
 sH1zGPlCKcWuk8G5SpqKCnjQehxRih36yqwJaAEf+w6q03VTACSPnd02c5KWP7u9wIje
 rsK+0OdJFMEEGJr5BNJGyODju3ikCuV2By1vbgN8InvzZicDeoFTO298PFxZy+hXz9TS
 7q/g==
X-Gm-Message-State: AGi0Pua+I8itEdEejXFo5bEfZ30Vi/DEzdDjABjG+SoZKnWSvs5ULe2b
 1sAOdPjCP+k1ZDe6l3q3434=
X-Google-Smtp-Source: APiQypKQfAosSTw40QAqbEP4Yb1U1/CxHzrCUmpWKnaUdBCrtnAW5OcbULi1HUNiDf8MqxaBaOoSsg==
X-Received: by 2002:a05:651c:1132:: with SMTP id
 e18mr4006061ljo.149.1585896489549; 
 Thu, 02 Apr 2020 23:48:09 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 b16sm4435729ljh.20.2020.04.02.23.48.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 02 Apr 2020 23:48:08 -0700 (PDT)
Date: Fri, 3 Apr 2020 08:48:06 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 1/5] dma/xlnx-zdma: Remove comment
Message-ID: <20200403064805.aqbdwocgk2ds46hh@fralle-msi>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402134721.27863-2-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On [2020 Apr 02] Thu 15:47:17, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Remove comment.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/dma/xlnx-zdma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 2d9c0a0d5e..a6c5b2304a 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -511,7 +511,6 @@ static void zdma_process_descr(XlnxZDMA *s)
>          zdma_src_done(s);
>      }
>  
> -    /* Load next descriptor.  */
>      if (ptype == PT_REG || src_cmd == CMD_STOP) {
>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_CTRL2, EN, 0);
>          zdma_set_state(s, DISABLED);
> -- 
> 2.20.1
> 


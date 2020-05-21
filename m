Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645EAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D08F20823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRQ4Ki5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D08F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqHO-0005pL-CC
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 14:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jbqGG-0004vP-FP; Thu, 21 May 2020 14:49:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jbqGF-00008f-JA; Thu, 21 May 2020 14:49:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id z4so6454259wmi.2;
 Thu, 21 May 2020 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vg+43JhF462N0nwHUjxtwXluWT7aGYu/k17D/8knOpY=;
 b=tRQ4Ki5SKHdqbeJZ0S67QSYStq8Z/eTzINOJpHD10h/OiAlPXnXzYfYLOrhPiK6Vvw
 DBD4Wd9XaLzuuZceeUBbFdRzqoDma5HpuTXpDv38Q/C82Ch1PY9SzVp8OG0TDPBkBV00
 1daUVnQ+8AGTY2soRxgi0c2CLtyT8hosxUzEV5uBHb1CNvowWUHpQlqQ9t3UIib4clI9
 XZrLlJTlNgegXZfwpLJum1nlRZl8iGwg1KLb/pYgRl6zFHlWLDqud9Mr+p0ydLwhzy0M
 Ufd3/l9bngW7FCE2ZjABhIW8pPOT+A2OFxTap15TqjzROMBYKqROfDwSk1Tyd5wYGCeu
 DvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vg+43JhF462N0nwHUjxtwXluWT7aGYu/k17D/8knOpY=;
 b=sKw1c+yyfXJaIR8aS0AQQ4KugNXWKh8/IDZXlgQ8GvynaCyQ40Pg+NqUp5W1QCnXyf
 NfwHPtniMPpXsvYuZkrFv/hOuD0zweTd+HSzxU1hvd2JLuHsT9IJ/N1nBOS3nxDSVy6T
 biwQi0nMLJtzeNqzXddS/ZGbBECurB8sYbcn6/MG46vV551cuN0bU7AnLDFlmooRxmVe
 R5qGSbZTUbYr7u9+LDgtPjbglbNQJXJYI+6mAY59cuuUxz7wSsbjyUi1BomXp/JKYCM9
 TYtYfnsjzQLocbDcEpfOQ0vIrMu4CKkeR5Yxa6vGcZA2nUE/ydTLo4eREjYT5pHpq5Gi
 +OQw==
X-Gm-Message-State: AOAM530vEJDf+7QQXE1632PeveW5AfCleTkuSi1IzFPeKUK+kic9pcyz
 pmMwNnakjG2oJnX7TTcEzFY=
X-Google-Smtp-Source: ABdhPJzNO9S3K14LwEp1ubXc5FGKgyjWGsGAdkCqi6YV5++fuonNBaSw0rlKteJu+GLPLzRmJuzlFQ==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr9829829wmf.103.1590086981015; 
 Thu, 21 May 2020 11:49:41 -0700 (PDT)
Received: from eden-linux.lan (bzq-109-66-59-205.red.bezeqint.net.
 [109.66.59.205])
 by smtp.gmail.com with ESMTPSA id g69sm2590022wmg.15.2020.05.21.11.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 11:49:40 -0700 (PDT)
From: Eden Mikitas <e.mikitas@gmail.com>
To: peter.maydell@linaro.org
Subject: Re: [PATCH] ssi/imx_spi: Removed unnecessary cast and fixed condition
 in while statement
Date: Thu, 21 May 2020 21:49:23 +0300
Message-Id: <20200521184923.19360-1-e.mikitas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFEAcA_i=HsBtpJh_o4+NWNeUihvNTccfB67gs0WrXttYdTc2A@mail.gmail.com>
References: <CAFEAcA_i=HsBtpJh_o4+NWNeUihvNTccfB67gs0WrXttYdTc2A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=e.mikitas@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org,
 jcd@tribudubois.net, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 e.mikitas@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ecspi controller is supposed to support burst length of 1 to 4096 bits,
meaning it is possible to configure it to use a value that isn't a multiple
of 8 (to my understanding). In that case, since tx_burst is always
decremented by 8, it will underflow. Sorry I didn't include an explanation.
Should I resubmit the patch?

>
> >              DPRINTF("writing 0x%02x\n", (uint32_t)byte);
> > @@ -206,7 +206,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
> >          if (fifo32_is_full(&s->rx_fifo)) {
> >              s->regs[ECSPI_STATREG] |= ECSPI_STATREG_RO;
> >          } else {
> > -            fifo32_push(&s->rx_fifo, (uint8_t)rx);
> > +            fifo32_push(&s->rx_fifo, rx);
> >          }
> >
> >          if (s->burst_length <= 0) {
>
> This seems like a separate change to the first one;
> in general unrelated changes should be each in their
> own patch, rather than combined into a single patch.

Should I resubmit this as a patch?

>
> The fifo32_push() part of this change looks correct to me.
>
> thanks
> -- PMM
>


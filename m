Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6849C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292362085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC94X1gM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292362085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Oi-0000Uk-2d
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HT-0000Ax-3R
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:11 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HM-0003lN-QQ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id g4so6730168wrs.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BQ2HYlkFRvbptmqlMrFxBt3vI0MTw53Fkp63PNsOdso=;
 b=tC94X1gM9bqOBAe1QTyuhuYCYcTNB7+BOstdaEl16ESSaJjV7V+5qMR8deeR0KDvOy
 ncJA943zbJcQ6WewtlMCUewk4e/tvcdwGKyWdxBckjT9zozNRuX9PeWU/O2KaCBiBkw2
 E0Np3mYAeSAulcSV9aysMMZVyvxN0emQVh2BVfgeXAwO2L+d6U/Eg7vPEokBPiKTjwy/
 Ic2metiQEGUCILGBJYpDlc/ZZ9/St7B9bmA7G4rRU3dw877o03hAYlHPu0PUQ4GarxN2
 vjLeZcfFEDGdXu+LeV8qAePXR/B386TzBID2bsSAIm3Miw9Gipn0QkPzIjiLXqzhBArb
 CSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BQ2HYlkFRvbptmqlMrFxBt3vI0MTw53Fkp63PNsOdso=;
 b=DFzwI3hRzTi5MvUfvNSYH8po8m50sZcPKAsR5g3kvEUMBTkBqZIb2VPNauvXfjDRN0
 2gjewMEDPDqO4eXNRBdnCg29SjkoGlNXz+VHvWmsN2jwRe1nUj9GBRn88XPawYfHlfsX
 12ZVNkz9A/PY7SkcdJzTHZtnry/KfPPlnyQlmuDmbgOMdP/NV6F5LnlGVueSeeo/7rV8
 LmHPc1zNgaSDLFim43uV4tpgdmuVojMfyzMKW/5KC2sSbPpmZqJF51wQMLKIyx9YIoZt
 5v7quv/hhl9pZdqzXWsMTjSejG9tylX6ZYtQ6NjGNGbNctPDmFA4tcc2raMb8lqjKbTS
 AbbA==
X-Gm-Message-State: AOAM533lxJiHfukTLTaaIdJn3ixiocowoP7IYYkMKTHO4LkcAyW8pdao
 bq4DUX6SVrhXVkGMxFCjMWNzdyxoIyk=
X-Google-Smtp-Source: ABdhPJytAqyjG/UjlOqNwfkfYgT9aNIZsYDCWwAxhJglP6ylSTxwL/m0wkbFvGQzmP2tVFp0+iHjgw==
X-Received: by 2002:a5d:574a:: with SMTP id q10mr10050678wrw.127.1601572923035; 
 Thu, 01 Oct 2020 10:22:03 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm9719625wrw.68.2020.10.01.10.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:22:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] docs/devel/loads-stores: Add regexp for DMA functions
Date: Thu,  1 Oct 2020 19:21:45 +0200
Message-Id: <20201001172159.1619456-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172159.1619456-1-f4bug@amsat.org>
References: <20201001172159.1619456-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/devel/loads-stores.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9a944ef1af..5b20f907e4 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -477,6 +477,8 @@ make sure our existing code is doing things correctly.
 
 Regexes for git grep
  - ``\<dma_memory_\(read\|write\|rw\)\>``
+ - ``\<ldu\?[bwlq]\(_[bl]e\)\?_dma\>``
+ - ``\<st[bwlq]\(_[bl]e\)\?_dma\>``
 
 ``pci_dma_*`` and ``{ld,st}*_pci_dma``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.26.2



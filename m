Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4975C47258
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3ECF206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjwssfgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ECF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFPs-0001XT-OL
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMo-0004ij-PF; Wed, 06 May 2020 04:25:22 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMn-0006vQ-Fo; Wed, 06 May 2020 04:25:22 -0400
Received: by mail-lj1-x244.google.com with SMTP id f11so1422109ljp.1;
 Wed, 06 May 2020 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y6buqfMJYMI/cf1Ukwfi7suddb3Zc6wj8gq1bw/kljE=;
 b=AjwssfgGM8Ei3yM1JXyLMdaVaRphB4ilRARiPbQFXAet8IIDIFtLmp+9+YsBSNo2XR
 d6fIkgjZ9wqVi4L6Bxcz50HPixGzhQHayKFE0QR7LC8A5Weiw5NdDFKJ6j7Nftqi1JGr
 kqCT9KyZrJ4jWISc+jFtzRx+yNkP2j02UL5ToVMvjkB0JKadBmBtHIkPVXc7IFIZyeuc
 RZIkmQ/RSxy2ErSbDhUe797vhbwjm3F86CHEPxHRNEiwH0Yq6r6PMzpZAMSBPTKnjeME
 Ikme3rMrr3ZwxFo+NQjrN19o/+wu/PwBY7fCLHWUjxm3k+JZiokFtQLamVsry43YdXV/
 Qa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y6buqfMJYMI/cf1Ukwfi7suddb3Zc6wj8gq1bw/kljE=;
 b=RZSPY13TgiOm0/FtmxbWLMJ+p3WNpn6lFxuIjlUvYPAh5pOCeXEoWJCKS/YpNAo/Ot
 +Dyq7eqZoqEsuMFsshXAOTSBwRiUJfv6Hd+jlBx0ZCwmaTmuv/LQ6C4ZLeYKcUN51LPo
 k65RM/eT7EDg5+CgKPYJdqHpU9lGy+QRBB66ti+juHZ4RQRncm3DhUN1+rpqy6pCKBxg
 KzLvpNWr0h/6HyPCV0bs2MhCcl8il2CcVQrW837XrQC5M1zH6Et8Mj+Trt//uOWbHGb0
 QsCfwAAKLfdsmzAUJPn/HLtfWr4ZZpVYVSK5tjrjUz370zTtZasw5kjwhgsebdKHG/Ld
 4nIQ==
X-Gm-Message-State: AGi0PuZzE1pvYXbU8ddGL1Do9ezmXeAr1O55JadvDYD+UwYjwrK5h9LP
 1471f7f/eX1yP7aevqZKeFngrLLoDnA=
X-Google-Smtp-Source: APiQypKNPzSHD7JdYtx4NeO8WYBopRDwU3ayw0szR6F3OuIyUbGDbEf1gAhDXP/4YYN6w1DlxBSwcg==
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr4194488ljj.115.1588753519270; 
 Wed, 06 May 2020 01:25:19 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r1sm806828ljg.50.2020.05.06.01.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] hw/net/xilinx_axienet: Remove unncessary cast
Date: Wed,  6 May 2020 10:25:07 +0200
Message-Id: <20200506082513.18751-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove unncessary cast, buf is already uint8_t *.
No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 84073753d7..c8dfcda3ee 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -918,7 +918,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
         uint16_t csum;
 
         tmp_csum = net_checksum_add(size - start_off,
-                                    (uint8_t *)buf + start_off);
+                                    buf + start_off);
         /* Accumulate the seed.  */
         tmp_csum += s->hdr[2] & 0xffff;
 
-- 
2.20.1



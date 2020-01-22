Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715CC33CAA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1E124673
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dfo8MH76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1E124673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5rE-0002Ym-D8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pQ-0000nK-33
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pP-0001mo-0D
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:11 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:38986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pO-0001mJ-RR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:10 -0500
Received: by mail-pg1-x532.google.com with SMTP id 4so2606967pgd.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jodrDJhZqqiGfDZYDnDeQ3K2xn0Ue4/C+awk7SofH44=;
 b=Dfo8MH76ETvlwU+bFouJ3gRsB+V8370jA8NQlpCl6JCrvMBIH2SiMMU+U0oyPXmH+X
 OeeOb9aN5gVRSsxVwQWDMHhbuVbI2XCC5zRhakpNq2OhrtqyY4IsnejNvlFWQ4NhnO9d
 Pn+Uzqcu/rAJZmDgIHCuYRZEYjPISveXl8NFA6X27K9Mr4Uak7ogI2azLv4VQqnchHVW
 w77utKzgmUWryOK4vL6Mg7rc9TzAA+pEyAvkMlvGFAwwVEfxJ51YzLRoG+eJpd7WAGyQ
 G1CPiXHMGL3Fs0uKTHjOcRsTVeIT/NHm9SQNTWzUdJsgDgZomAdzIi5AF4grNZC111Ct
 RS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jodrDJhZqqiGfDZYDnDeQ3K2xn0Ue4/C+awk7SofH44=;
 b=uf4pUzvZg9LqcaFMenRQ+8PLkcrD8XJUH670uw/Zk+bm2pXw0x0lW86L6bdeqLVhL0
 xIFqtbR6Jnrt8MLBlp1xxpDG+6DIkBvHJewEd/CLDjZTC5x66EKaEeJfRYP8h/6Yq/ak
 FbSQUgy3AfPlvbnXasOe0q+qG6ChMTUNcOUzpnUobfVHsmuiXVObynCOp0YCsQVGnK5I
 YDmjGnyab0IH1bA8QXxnoE7l7pB8uwhguZLRftp0db0G+sB5y7eNr+YT0xqGQU0Y+Aci
 BoBU1+44XXmGmqYV9VoMdF85SvSFUzOaKI8WjteqZMcdsHRsL5ZkikCdU7VTOoR14V8X
 eBRQ==
X-Gm-Message-State: APjAAAVBco3pKW+s28W8UMGRqey7sgjpAVV8FDQuGOWfZW8N/S7v/gq/
 aVX+9dmn/CgrYaVstDr9o9k9tq8dGTY=
X-Google-Smtp-Source: APXvYqxrvNil2KgQPdmCIrGZkgGdN/8XrqrjBD5jtLwtXpAsAsYPIjhnQsjqwGeQ+yLOayYs6uSWQQ==
X-Received: by 2002:a62:5c43:: with SMTP id q64mr555778pfb.194.1579660389427; 
 Tue, 21 Jan 2020 18:33:09 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] hppa: Switch to tulip NIC by default
Date: Tue, 21 Jan 2020 16:32:50 -1000
Message-Id: <20200122023256.27556-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Most HP PA-RISC machines have a Digital DS21142/43 Tulip network card,
only some very latest generation machines have an e1000 NIC.
Since qemu now provides an emulated tulip card, use that one instead.

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20191221222530.GB27803@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 33e3769d0b..c8b1830f88 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -127,10 +127,10 @@ static void machine_hppa_init(MachineState *machine)
     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);
 
-    /* Network setup.  e1000 is good enough, failing Tulip support.  */
+    /* Network setup. */
     for (i = 0; i < nb_nics; i++) {
         if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "tulip", NULL);
         }
     }
 
-- 
2.20.1



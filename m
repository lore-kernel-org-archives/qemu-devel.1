Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F51C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218722067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beAAmzYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218722067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1GS-0004N9-Pr
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FG-0007sU-VV
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FF-0006BH-NU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FF-00069z-Gr
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id x4so17141142wrt.6
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Lkg7H1NRSw1xymZWFmnKrvzweUJjE5TzOTqnyXYm+p0=;
 b=beAAmzYmHgMu4mw9foyEgPO/LTAocGSdXuDkBTbB2NcOTLZuK0k6hnfAFO/+3vdmZy
 W/kGAg/CktB/772KsVN4pXD9/bQuvTX+gbPMA6HNpyd65sbQ9sQp3UO3yTz/g95DVZXL
 WKytwXYSPqbogTs0Z0T2wEGKME8nRDL5b6TwYcrdx13pL9HYm2OnUs1Qotq4Oji9FLOL
 4QQPomFiGijzU3LEAD9C0PxOhg+X37PTZpITqJxUk/J/rVAjk16ohjGmvxMHt+MOJSgw
 Sy4j5v98ZnDVpT6wKvgYJZ1OPLc9bBn2jbT/dC5/lLM+7l2yM2QqD3NUR+B4ciM8W9NX
 LDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lkg7H1NRSw1xymZWFmnKrvzweUJjE5TzOTqnyXYm+p0=;
 b=iSA8T1xkahG1Ht5rFa+UVIxpz123sl2T+X3/jCnLZy590B9ao8avy1KrQBxS9vZUDE
 kBURyuPr8yC08fSdPXP9ZuauWWPEjy7f+SWuJQxoc3Zw6Jz94DxyObF9dQYe3cZmxOG5
 Wh8PS9kHIUFxmbIEAuNOd2VVKq9dZylv6AFeNxa9zZKwUDBAJkZGxOoA8mpsxwLSL5XJ
 9CJzfp0ElT684OzCo87KgjqbBo3Jsh6VLfDqCMtubgG5CkPASHV8upwy5ehFUj8RcuLg
 CfRNC0n7iUN9GLpvfMKfa0j5ov946LaMgp6/y6LRlCuHmJHVfr1Xw+CM5QO0tty2Nivs
 OIQg==
X-Gm-Message-State: APjAAAULJJHYOXOgw3TMrnP1wHQCpTX0swA+7GRnCnn2S3n1ajzsJT6I
 8In5KACVFxQGVcqgnEXH2FlNnwOvtte/oQ==
X-Google-Smtp-Source: APXvYqyiu+KISngMkfNELdbRmmyVoYuPkMAg+WC4Xcas2ZY1g7OTuHHAX0OkQn2yotys+XdYAOd6ZQ==
X-Received: by 2002:adf:f646:: with SMTP id x6mr31177839wrp.18.1563198139863; 
 Mon, 15 Jul 2019 06:42:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:08 +0100
Message-Id: <20190715134211.23063-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 07/10] hw/arm/virt: Fix non-secure flash mode
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Engraf <david.engraf@sysgo.com>

Using the whole 128 MiB flash in non-secure mode is not working because
virt_flash_fdt() expects the same address for secure_sysmem and sysmem.
This is not correctly handled by caller because it forwards NULL for
secure_sysmem in non-secure flash mode.

Fixed by using sysmem when secure_sysmem is NULL.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Message-id: 20190712075002.14326-1-david.engraf@sysgo.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b5138cb22c..d9496c93634 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1674,7 +1674,7 @@ static void machvirt_init(MachineState *machine)
                                     &machine->device_memory->mr);
     }
 
-    virt_flash_fdt(vms, sysmem, secure_sysmem);
+    virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, pic);
 
-- 
2.20.1



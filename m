Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 17:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE9C206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQgtkA3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfo3n-0007zU-LB
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 13:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>)
 id 1jfo36-0007Yw-8C; Mon, 01 Jun 2020 13:16:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>)
 id 1jfo35-0006z6-HW; Mon, 01 Jun 2020 13:16:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id d128so304107wmc.1;
 Mon, 01 Jun 2020 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vwMcGbn4VMVX4fL4DOaU5fLjB0F3M4FChwZGaT/JMNk=;
 b=HQgtkA3INVURVp3HOaXwoKBptirpCtwDiTP0WjeL2sK6a8zaBIx00rat0me27PcfhM
 XzswENTZhY5XmPZijqmAPplnxndKlzbpW9PEPX94FxHLjoYzph4d7m72FaThM1QhVcl0
 tc+0h+iUlDtaUbqvXWVWEg6A9EsAKVop1XRWYqakDJ3cfNPHwW5kTmx6ITWT7EA6nJIh
 ycjeYacYAJ7l8wCyWBKdIv4cVxUHAgV6FIjQAMd+Y+VW8J3GLBO9UzkhKdtMuhHSgaJy
 SgdNfvobJCD8l/HbfsOXJR4llH3gu1vyJfVVbUa4p+3GJYa2WXM4z6UlFYaFWJ9+inKO
 4chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vwMcGbn4VMVX4fL4DOaU5fLjB0F3M4FChwZGaT/JMNk=;
 b=Ss1yS934i0KWJIYMDFUxSXhMgNTW49iFA0kJ038Y+0mAuLiUUUFNjyKC9EOblkPd1o
 s+QczXdVLkvG9Iiqi+CiTGiGtvuoIjbjfh825ooin4VYAIsw1ekJrLoOLSFk0vpobe5E
 0STkPVl3XeN7jQqi/z92eb1Y9PhC2pJ4T35FeTjZlqMoillGZOSK/z6+jaJvvQiTOKYe
 XbbNVc3iOIn13Zb7Es68hAassc7y9znzHAUyOSB6fBLt2bkQFG70KHsu4RNQMO+DoIPu
 MnvPp5s3LbX7g5UmIAMvYTadYARQ7gt22vdab1uw9n66x++N+UkNkr5D9MjFRVAjZEsg
 otNQ==
X-Gm-Message-State: AOAM5337ElQLkdePU31WfMmJv0FnhZueJVQdzy61fgrFNlCprsRjjlG7
 euae5Iel/7ZJbTVkiYmc9TFu81Vn
X-Google-Smtp-Source: ABdhPJzbRjvhpcuiZ5309uOKrbHZAlhWR1ExbTXwV723QeNdUYpcmN0FCREQHGs+cayuig2w3fq/AA==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr351056wme.26.1591031788592; 
 Mon, 01 Jun 2020 10:16:28 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 d18sm108282wrn.34.2020.06.01.10.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 10:16:28 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [v1] docs: Add to gdbstub documentation the PhyMemMode
Date: Mon,  1 Jun 2020 20:16:09 +0300
Message-Id: <20200601171609.1665397-1-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PhyMemMode gdb extension command was missing from the gdb.rst
document.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 docs/system/gdb.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index a40145fcf8..abda961e2b 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -87,3 +87,23 @@ three commands you can query and set the single step behavior:
       (gdb) maintenance packet Qqemu.sstep=0x5
       sending: "qemu.sstep=0x5"
       received: "OK"
+
+
+Another feature that QEMU gdbstub provides is to toggle the memory GDB
+works with, by default GDB will show the current process memory respecting
+the virtual address translation.
+
+If you want to examine/change the physical memory you can set the gdbstub
+to work with the physical memory rather with the virtual one.
+
+The memory mode can be checked by sending the following command:
+
+``maintenance packet qqemu.PhyMemMode``
+    This will return either 0 or 1, 1 indicates you are currently in the
+    physical memory mode.
+
+``maintenance packet Qqemu.PhyMemMode:1``
+    This will change the memory mode to physical memory.
+
+``maintenance packet Qqemu.PhyMemMode:0``
+    This will change it back to normal memory mode.
-- 
2.25.1



Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C27CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED2D2075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlENyWeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED2D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0rTt-0005Ml-EF
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 15:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0rT9-0004iN-1V
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:10:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0rT6-0002eR-Pr
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:10:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id f18so22665265wrs.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcorSBZXkBkW1mp/hqFvB6M1vX2DnTHEzjvxS98edmI=;
 b=wlENyWeHgHiUB4DWUx43bNSL3Vl4iY2Rmg56cpb9dwy9I15o/ZFdjQdFkP0+f0b0lM
 JlRod+y7Gx5sUBKz+sUfcdnd4vUvBIo+P8ndaPlER2IkQWGayfmFNDnaa60PySGVEoav
 ClxLZ7B/6LQ7XMv+4EWGYhbCkflp3V0lmmwyxeXAs9RmyBH2dBNAQK83yXPFSEc25gA9
 ElhexjnZC+3283yw7Zb85fU7vTcnQOiK4pu80cjIxy7V9cQWBfTMRp4j6wWxzOzEGzbN
 aFwD1vvk2opc+f9H7BkwoUPsQkK3yCdVwIU48/78SJyLONHIoC89ukz8D5sPuMo7L5cj
 48sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcorSBZXkBkW1mp/hqFvB6M1vX2DnTHEzjvxS98edmI=;
 b=oJ7GShg/QzXl1MK04AbOkG9Z+VxSh3bCuwYZpO0s9bS6+PYf6QFgn8oCDSixOY2i1T
 snQMx1fmmeAc/3fFN9JKNFOWU8ZMHR/A0Ob/Tpw6hxX7GpKruWqJZyzE/EflrwSI1aM/
 amLOoTytGNscyiUTf8fGIZybrETKmnWlybzUnFEh6c0oPbwc/mUqEiA3G7wpS3V5tlA0
 QxHWVmC4B8LYiunPfvZ2LphqkPR7ZM9YePZPPoVHUd3qoPtrvW/3aDFRaV1QQtPGcxDO
 CfLedf1PgzK3HPxqAqUMQT/Re3lyFErIRcQh+qM/i1QXP1wgl9xKXU7HwDG9UXx2NDEu
 EW2g==
X-Gm-Message-State: AOAM533TQjx8fGZQUjLWYo1CXDs72hR3Ixu2yDHYOSTydLJNzBmJdCE5
 MHJNYw36YFHQRyf/A8NarZiHwilrCe4jWg==
X-Google-Smtp-Source: ABdhPJyqdHt4BtNmQkn0cKztOaFpyCIMlRGBIaqfczgWn+6l5Pg0pUIcXlVC1fgC7necV2hHosU+Zg==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr31851747wrw.2.1596049822252;
 Wed, 29 Jul 2020 12:10:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t202sm6023473wmt.20.2020.07.29.12.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 12:10:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] qapi/machine.json: Fix missing newline in doc comment
Date: Wed, 29 Jul 2020 20:10:19 +0100
Message-Id: <20200729191019.19168-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 176d2cda0dee9f4 we added the @die-id field
to the CpuInstanceProperties struct, but in the process
accidentally removed the newline between the doc-comment
lines for @core-id and @thread-id.

Put the newline back in; this fixes a misformatting in the
generated HTML QMP reference manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not very important but I've suggested for-5.1 as it's a safe
docs fix. You can see the misrendered doc at
https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#index-CpuInstanceProperties

 qapi/machine.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index f59144023ca..daede5ab149 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -825,7 +825,8 @@
 # @node-id: NUMA node ID the CPU belongs to
 # @socket-id: socket number within node/board the CPU belongs to
 # @die-id: die number within node/board the CPU belongs to (Since 4.1)
-# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
+# @core-id: core number within die the CPU belongs to
+# @thread-id: thread number within core the CPU belongs to
 #
 # Note: currently there are 5 properties that could be present
 #       but management should be prepared to pass through other
-- 
2.20.1



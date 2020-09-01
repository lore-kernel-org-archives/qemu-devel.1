Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F844C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2A0206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="xpg0nfHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2A0206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7za-000279-6y
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7ur-0004Fb-3W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:09:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7ul-0004Y9-Oc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:09:44 -0400
Received: by mail-pf1-x444.google.com with SMTP id m8so953515pfh.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=xpg0nfHs3vBBqOclx5PpIQYvtk+nMAubfDzrHsDfOydLerfc1Io9M12Zr+grjqWbW4
 /VhA7emac9RPaHt5Bp/IKJQUATgVHANNGF+FMgL7st1mb+9ki3ipJaoplGIaabvGKqih
 p06DOvafBkmEEOs7/VOSzrh9fv79iDd7N34l7E3gJkFyppiPS6FtlLqZXuRxni54xwIa
 qyLrc7eJV1Yp61ensP7i3x+LOl4NyheWYzkXdsmDqIqp2W62SmhqBNws1wki41/3v5vC
 9bPFaC3QYYcqwNin8nXc0I+7LI4i3qiFCFvCF9YcWYEACx57CyqednFX80qaSdiaX3qO
 kI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=BgqsxiBreBIBZHpbiNdmtUwrSH5WsR0NNfLlDtejnotjstM5fosAw1FsEhF/yohOXa
 nndzLFb22QP8+9TN52bc52bD1AFmyrZe9xQkL31n9dDxg7GtDCaIVkE6UMDQvHeDl8TI
 l2WxW4reuR2qF1GTpryo6oCnR+BD9PxXRgGC5TLKtER9LT77Px2LBhNRAqmaolVJsy2Z
 f5C8xH06cNxvgRgKtE5iYuEShX3zjTMf9qkRp7qYhca3gQad4m/CiKwOndbB+CMNTdVj
 ZU0eiGfJd7P2/1nCuT9SYwnpLEXHHdHNnpkAFZiqBUhsOAZjqFK+YLsN0wVNrw0/kQ2w
 FnSg==
X-Gm-Message-State: AOAM532ldEnqfy0qUHKRCiVlfDpC7izoLej1giQeQVoCSdC4UDxFVqfu
 LQTMcYRG1q4m8giJU9Sfsc29/OsBBh1XmFNg
X-Google-Smtp-Source: ABdhPJxX1Kzq3BgulFXnCEHB31L0TNx3sK+u7zcjW7f/Kmn4ahfu6ckpX+Jw+u3ajvsad/Q3xI9zvQ==
X-Received: by 2002:a63:d62:: with SMTP id 34mr1851524pgn.179.1598972977087;
 Tue, 01 Sep 2020 08:09:37 -0700 (PDT)
Received: from localhost.localdomain ([203.163.237.89])
 by smtp.googlemail.com with ESMTPSA id gk19sm3315777pjb.2.2020.09.01.08.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:09:36 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] tests/acpi: document addition of table DSDT.roothp for
 unit testing root pci hotplug on/off
Date: Tue,  1 Sep 2020 20:39:26 +0530
Message-Id: <20200901150928.12428-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to unit test
the feature flag that can disable/enable root pci bus hotplug on i440fx. This feature was
added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change documents the fact that this new file addition was made as a part of the
unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1



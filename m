Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA53C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDBF20759
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="aH4dMvWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDBF20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEoU-00068r-2g
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNEmB-0005CH-0r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNEm2-0007io-RQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id d6so4350327pfn.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=ndH88ZGOzkjCavpbivHp7fS2irQGBSIlGVGvg5woECM=;
 b=aH4dMvWPeJ19CIsvDdhrpmnXLVfJ+Vh9z41m/DAYCd55Dlu4HR2YsShpyQr/0jR7uk
 JVL+NION/eA+Up/VM8X0xfE8RLvTy7YSQ8++IT/KuUEkAgdusN8Ikwzyc3PrzbAh1fnq
 f7PJIRXP/sSB5UF2FmiE3F6pXoMcmmQ5hY/0QYAoO3nDCAgdGpaKmFxXa4CV8+55vtvP
 ZiuWyv5ia35zHm/g2PGKs11FtY4JJBwspHv62d9vl4I2GPzMaCO3V85+m9NWU2j/NK6Q
 5zNpiKNQfvKs8EmBsU6VTHlPUJdllVLMNBz9jQgJ1hVjLmjpIIl3d3bkMGKwBEgZPXIZ
 4GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ndH88ZGOzkjCavpbivHp7fS2irQGBSIlGVGvg5woECM=;
 b=p5epm6awHfPRei/e9ZShy0FKytiGIy63Q3tkeorlUkmAhPHUw5OO+nuunlMAyRr63U
 NVk7zimCdAuy5LwSRiXsWdY1FQOHNJakPnLcWhUFFiMLDRdw1HZ5oCCwJNCWt4nEnj7c
 bw7W+kTMgSywwl4f5LUpPezx75TyHNbGtIsHJiPJ7r0kXoW4YCWUloXE3eFNF5b19jfs
 91jtA4fKwFx93dpPBwU8Ek3aZUlEaKrPw5c7PYd45/dXaIUja2hW0fbJt8q7aTCwoltb
 xhWXKPuTSBSauXXTArvcC04ntH9f36GGsA1CnGhkY8z5/4IqFbUNplU0S53XXbb9KDAD
 UjiA==
X-Gm-Message-State: AOAM531MUdWUVMg2J54/PBovdDGB/PtdFQabnPxtuu4vVlTC4JidgLB/
 EGcvbg0OIk4CN/52WWRjSujVGg==
X-Google-Smtp-Source: ABdhPJyyO3Zq3LmQ4v30pebUjESDhF8u94sG3xz99HaZf/MSUF89m5/skGPga8ItETe1mbfWep3jdQ==
X-Received: by 2002:a17:902:9a09:b029:d2:4ef:a209 with SMTP id
 v9-20020a1709029a09b02900d204efa209mr4286881plp.46.1601382622070; 
 Tue, 29 Sep 2020 05:30:22 -0700 (PDT)
Received: from localhost.localdomain ([115.96.125.11])
 by smtp.googlemail.com with ESMTPSA id 16sm4359035pjl.27.2020.09.29.05.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 05:30:21 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Regenerated DSDT.hpbrroot to match with other ACPI blobs
Date: Tue, 29 Sep 2020 18:00:09 +0530
Message-Id: <20200929123011.31836-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x443.google.com
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
 jusual@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the last unit test, all was needed to be done was to regenrate the blob DSDT.hpbrroot.
Upon diffing with DSDT.hpbridge it now shows the correct diff. The updated diff is also 
attached with the commit log.


Ani Sinha (2):
  tests/acpi: unit test exercising global pci hotplug off for i440fx
  tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx
    hotplug

 tests/data/acpi/pc/DSDT.hpbrroot | Bin 0 -> 3079 bytes
 tests/qtest/bios-tables-test.c   |  17 +++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot

-- 
2.17.1



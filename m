Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A78207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPa0CHuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A78207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBI9k-0002QA-Nj
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8d-0000bV-OB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8b-0006Hx-Ec
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjeaXNVvmYuhlTP1mAa20WdTCtslkJfq6YEOWW1YjGU=;
 b=iPa0CHuqIRiaDAwUKBznQj17sF+9iWFVLYzbkAjlRBR7l1LcpzaP7dBsF4r+SYC4XeXyaJ
 KJuA6tlbXleZ5CA9LjckIQqXUKSYkcEthw2QLI4Q3GFqa1/b9Edv9/Vl3sQVGoRBS4LuY1
 Tbawo1CJxHJepxYV/JcX9v+9xnJ+LFM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-D-pa-TN5Nfu5XotyH8B23w-1; Thu, 27 Aug 2020 09:40:17 -0400
X-MC-Unique: D-pa-TN5Nfu5XotyH8B23w-1
Received: by mail-wm1-f72.google.com with SMTP id a5so2066948wmj.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UjeaXNVvmYuhlTP1mAa20WdTCtslkJfq6YEOWW1YjGU=;
 b=mYkpbeS+GRfRPw9f4kuk8xLnsfezt00l2iC4WTWcxX8VL3qsqj7xOOWRMB/EvPIMcn
 kU7v85xrDSzk0aYNfs9JjdliOYuHKdBsBERPnqfaHsR8lrLXToYEoLHDHK1+uxURTrtV
 TH0y802f1XjmC+qIJZCN3F2LkZe3quz8aCJLbacZTxjLUvxNV1RRBQhURL8jP9VWa7t/
 FLIAW575KaLpCRfLQRf3iXMk5BvF91SUEdSqCffBe/U0lHimUfD2HIgucvn1pto4apgG
 6NEvAxfkJj9hnEY27cgf4NkfETfRIf/dl2okxB6kahKxLHGnUm65/vPfIrI06Tebl28s
 m/tQ==
X-Gm-Message-State: AOAM5305aFua+p33XcbCkRpbL5wC2sbnVVGgzbBk1Vbxa4yIpC/WDwYC
 /GT6GRsQoBofkmQja+SS1naAOmr8AWac0oufy8nNY8d6JiAq38TzpVBKOQ3lpz3mEipjrE3F8mY
 vsgJavBwxDDkLsI4=
X-Received: by 2002:a05:6000:1082:: with SMTP id
 y2mr1957833wrw.222.1598535616490; 
 Thu, 27 Aug 2020 06:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVlUI38VXt7I+jkKAjEL3QG6KUquWhPKMA6QBeyxH8ufxkFDb9tyFAjsg8WElW2pA1QeJmKw==
X-Received: by 2002:a05:6000:1082:: with SMTP id
 y2mr1957820wrw.222.1598535616272; 
 Thu, 27 Aug 2020 06:40:16 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id b131sm5707539wmc.8.2020.08.27.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:15 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] acpi: allow DSDT changes
Message-ID: <20200827133954.2118749-2-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are updating all DSDTs with UID 0 for PCI Root.
Allow changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ea46c3399e 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,22 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.tis",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/pc/DSDT.memhp",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/pc/DSDT.bridge",
+"tests/data/acpi/pc/DSDT.numamem",
+"tests/data/acpi/pc/DSDT.ipmikcs",
+"tests/data/acpi/pc/DSDT.dimmpxm",
+"tests/data/acpi/pc/DSDT.cphp",
+"tests/data/acpi/pc/DSDT",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/DSDT.numamem",
+"tests/data/acpi/virt/DSDT",
-- 
MST



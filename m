Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF1F206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tox6xcq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF1F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzLki-0006Vb-To
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 11:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLiB-0002pG-3Y
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLi9-00088o-0F
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id w2so6974345pgg.10
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4QaCAi9itYTAEWQbQQ1orCya0omL343c9jLTjKapu5Y=;
 b=Tox6xcq+2y9PgheBWJL4mk9bIPp0g3H4V8lbWcjKyx2MIZL/wZrii5uCeeCVFlruyb
 WkI+YJzHdYMqihv+24SBRv+mhD7vYlWW2LuM1tyaXbmc+dNF8/M4gPamHz58bwNnZncS
 xF3hlzrx0/wGBFIj3y3T82kUXbxZf81dUSE24c28wtI3ihrIljsuj7etH0YKS2JVVH0x
 19dzmvGZSKDqLHV6lkoL9tBRC4eO/FLK9fYR5op5ZMQjGitky2yq0OEiwEISU2jnp0ve
 5dGh0c0bXcqZitWn92AGyfGqp2iqEfL8oBMtXweDmH+dEvck81ntfSsdUYOOCTZhtYJq
 zFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QaCAi9itYTAEWQbQQ1orCya0omL343c9jLTjKapu5Y=;
 b=mhXxHeNDQ9S5UOXYYvwZEe6kYwYchpPSzOpbiYgtXKri+8hbV/WPh0Ry6okqOKNkc9
 OqYhYvs5JViWeLuWD227InzxkCdsLXF6/rAlggtjdvgbnEbXmWG2H8dJpDgxgtHH1yfb
 Wdl+NfYv2PxHs5X0y2uzQTDqptM5orMDJo/kJbRdU9Ojqm8o6DVCGqW6W8/8htOzKrM2
 p6t+NqXWAPAgimUOpiCWy4+xqp3FweCVSgdNfvIn9c+Blyz3dmo64pLqF5RyibyIY/o+
 icVA4QtDtbK6kQ4cycC2gXkooyLgo/62Tmwj1XI8g45OD1ajgMuMWXbBNsKBt2znpfGp
 zzLg==
X-Gm-Message-State: AOAM532DlyfMBWkWluBO5U7OrCLLKnuI0kMEYKgkoqHfSl2sxzhSI1so
 a1NWzrbfqM47gyG2iV3IHzsTtA==
X-Google-Smtp-Source: ABdhPJzWdntjR9EXFrAPIk5gI98/3q6RKbuRJo+C6AHM7ZRK/b3+1o7JR467NxFxikngnhgGRjFADA==
X-Received: by 2002:a65:4549:: with SMTP id x9mr12417643pgr.415.1595689419741; 
 Sat, 25 Jul 2020 08:03:39 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id g22sm9059783pgb.82.2020.07.25.08.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 08:03:39 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v5 3/4] target/riscv: Fix the translation of physical address
Date: Sat, 25 Jul 2020 23:03:26 +0800
Message-Id: <a3b3b05f429a50b5ea061f4e8385d4f8d6d77d58.1595689201.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595689201.git.zong.li@sifive.com>
References: <cover.1595689201.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=zong.li@sifive.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The real physical address should add the 12 bits page offset. It also
causes the PMP wrong checking due to the minimum granularity of PMP is
4 byte, but we always get the physical address which is 4KB alignment,
that means, we always use the start address of the page to check PMP for
all addresses which in the same page.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 75d2ae3434..08b069f0c9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -543,7 +543,8 @@ restart:
             /* for superpage mappings, make a fake leaf PTE for the TLB's
                benefit. */
             target_ulong vpn = addr >> PGSHIFT;
-            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
+            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
+                        (addr & ~TARGET_PAGE_MASK);
 
             /* set permissions on the TLB entry */
             if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
-- 
2.27.0



Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABBA207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dqz1SJfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABBA207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKxd-0004EM-IW
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwR-0002Qy-J1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:38854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwK-0001ha-Qf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id u3so3176074pjr.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eJkF95S++8ts21B9MX1R8zk9iQWf6ozpEqOweVzBcy8=;
 b=dqz1SJfadJs6YftjEXdB65L05AUPjCGwogY59sLYsTC1NJnumydIAc5u7faiBP5k+B
 As+Dn23w96+9hxhLfprHwV/ffvrKRoPKbwuk0of/HDdrVzJS7LCfdVJpt4h77AhpPE39
 0mpgCb4PL46YPMNwvqoes1KRSLIJ0dcaPW7zYW4/KeaMkrrulCf48aVSWNIpgsa6No8i
 cpmYLTNye6zXNiTe50MSU9Ww80AAkaa2xGlJZpA49c8O6r7KHyn2gJQoZgFokAnbjENw
 icaIPOMHyiE9zUqmsgT6rMca9rWPibECyPvYjOrHKOy0n2mVU7LVC9MJX5h1xHJJev6l
 Au+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eJkF95S++8ts21B9MX1R8zk9iQWf6ozpEqOweVzBcy8=;
 b=sVuEFJgfn+/fgjcX4MwjTEsODjm1gi9DoY1KeyL9FbC9H/yQ/XL9INQ8MA84R8ojax
 1Aq7QU1Frxce4HrZgcSbPmtJfdRsZPaNvLlHK2zsol207Q28czJacGDHigdkKqyyRIbL
 JtPB9wC1VjCaToJfcZAS0KxGaUts2FGgeRYQe+BwHVxkIfViB8qiW5Qv/KqEGEum6GDd
 9723lEqgWbqL7aNqFdoTUbqXsSutXrOas0r3d8SwdT6XZeGM5HRDwEi3VGEAx+UyEWBi
 67Il1ghE9++6f/ARAqRd+0mM4hIzrL9pLWile/n7/0jQZe5cWKU8LgIlgsJTrkbcnDw2
 Hi3Q==
X-Gm-Message-State: AOAM533+EDRAuYxIKyg30nMPdHrLHf55+x6Uf4Ak7RB9Jq/JJhNKWbyF
 IqQcF4j0CafCZCjZR8Hv0CM5NkgHtsSA+w==
X-Google-Smtp-Source: ABdhPJyxgSZ5EBFFM6e/fXQwCGdglWu5N/HIJWrKRxEEYZUNTr1lFZUGbArHJYe/fsSKFwazPlskzw==
X-Received: by 2002:a17:90a:9708:: with SMTP id
 x8mr5305276pjo.213.1601406325008; 
 Tue, 29 Sep 2020 12:05:25 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 04/68] target/riscv: rvv-1.0: add sstatus VS field
Date: Wed, 30 Sep 2020 03:03:39 +0800
Message-Id: <20200929190448.31116-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a65d3ab2b3..d77f790dec 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -425,6 +425,7 @@
 #define SSTATUS_UPIE        0x00000010
 #define SSTATUS_SPIE        0x00000020
 #define SSTATUS_SPP         0x00000100
+#define SSTATUS_VS          0x00000600
 #define SSTATUS_FS          0x00006000
 #define SSTATUS_XS          0x00018000
 #define SSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ca04b44aea..05aca3243b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -423,7 +423,7 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
-    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD | SSTATUS_VS;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 static const target_ulong vsip_writable_mask = MIP_VSSIP;
-- 
2.17.1



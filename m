Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2726DC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F2E20709
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHQhRMPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F2E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajnK-0000HX-4l
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajWs-0003hH-2v
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:58:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajWq-0005gJ-7X
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:58:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id a65so2128784wme.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e1CT0XOx8Vvy8O4jAkV/r0nsAlwbNsoMSDp0qZ+mwlI=;
 b=IHQhRMPbEglYB1FwSKkG+NGlzWF9RwV19ldmzO/oohRLPXz1nJLWx5YunHxGWGRPxo
 /Aqz0lTJ/nD7arDBcf0sbMwranwxpNdfVLle85fnpiHqG1927kcijKhgq1httip10pAa
 KdTz6HLhjzWm0b0qNDlogU0/nN1mAGqhYE2bd3V5QGsXt52QdnSO9PaAy82oAt43TSN+
 IX8ENd//l1b1wJ2d9sbQ3iK8byU9/O/Q37z6PNy87kYYDQnEJtW9ygaJU0DTlRjf22vW
 toaG/0eERqixQ/tBJ3vBkMO1QSBse5bEngAD3ByWZ3P4n9rTt9XiI6N7lU+jtJE3csbr
 9Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e1CT0XOx8Vvy8O4jAkV/r0nsAlwbNsoMSDp0qZ+mwlI=;
 b=HhF12VIGoHe4JA+aNwIs1Vs0FggyfvACoLQFw1dwkipb4eLJADmq+xtDqNFWOHNaiw
 9ptjVUxb40NuT9wt1xPiGCcAupG1/Z2RC9Yp7bbUPAnlWtc/xrRaH6TE/Tlipn/BpeN7
 efi6RG4y9bQysfjOBmnxVndbDtLD3ZDWDSPY9ZZo0oxGIGo/M1JMXHOtx5B2FY41d2MU
 MelyXpepfGS73HEsHc9kMwSClk8IEnQdzcDYN51k14XTLVDOyKqD7pzPb5ioYZktsgyb
 NoZBc2C1WoiCgMF0dDJsKUN4mWUsGWuyvjrtBWMXKy1gqiWo9hXr1IJF6pOiAoUeGRUX
 pcCg==
X-Gm-Message-State: AOAM533PltJDR5SBXRfuXzjyCt5fLkmRXUDVwSr7KYhEr72tnMMjZ047
 4ut+m+5v8TRAvMu2sHPvhPN7SA==
X-Google-Smtp-Source: ABdhPJzeGNAWfHzipdSqUYwax9p+jCiQ9HF7pckIJMTgj1GksFvaLT2Ts2O4bY3gUQ2QwqxRyqJ0jg==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr3981235wme.171.1604599110309; 
 Thu, 05 Nov 2020 09:58:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l16sm3421423wrr.83.2020.11.05.09.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:58:29 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDA3B1FF9A;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  11/15] include/hw/xen.h: drop superfluous struct
Date: Thu,  5 Nov 2020 17:51:49 +0000
Message-Id: <20201105175153.30489-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chardev is already a typedef'ed struct.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/xen/xen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 1406648ca5..0f9962b1c1 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -28,7 +28,7 @@ int xen_is_pirq_msi(uint32_t msi_data);
 
 qemu_irq *xen_interrupt_controller_init(void);
 
-void xenstore_store_pv_console_info(int i, struct Chardev *chr);
+void xenstore_store_pv_console_info(int i, Chardev *chr);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
-- 
2.20.1



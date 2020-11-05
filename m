Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA37C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D24F2087D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8VYfJKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D24F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajeH-0000w9-3a
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR3-0004Xt-Uv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:34 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR2-0004t8-8q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id x12so2780636wrm.8
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S2GIs58/W24s0fp90d9pmy8FUWIlpMCzYhDdwe9s8Gc=;
 b=y8VYfJKIVgovo9dlAt6OJzV2fWsBxN2k3Qtrdb4hD1XgOw6zMwhgc41Dig59hy8yaH
 O1kh16ITKRkR907lC8Js4Ia8jgKPNg5sUs0krQPcEwDAT3Z2C5HTiuetC+S36lkiAVZx
 bofeE7M1HpcodfKTdRNYMmbUyAPkKzHAI6Ed7yK0gieBk6E84RYpJpRJTVzlnKDN04D8
 qCxKR2hB3CbQkoutSoQqNta1PJIj1EpW8SSRQAaCqvWCSV3wgJ0heclI8x2ItRF6Wbwj
 9iR7hjEF4+AEsU0s00PT1p1dLSfHDo0bEiAnjgxIl+uKkXsN91x13BMkXwgi4KWwluWx
 j0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S2GIs58/W24s0fp90d9pmy8FUWIlpMCzYhDdwe9s8Gc=;
 b=P7gR26+FNcJNW+rjszal3V07/aNRGnzTG66LeEPPb2qrLZfNHJsC5CD6sDyu45JKlJ
 ilsMo6zNwepTk/Dwc/GTK98ciwLmf/aTQP+s8/55ZyP3jVGMZF/kVmyXqkdAEJ+o/0qw
 TSYAIaR4X+UiMORfTid8/42T/pQ6eszi/p2M6o1MAC4Uy7MScAl8RsO4yPfJxe/cBoie
 TCm3nlMolXMQGKNmgbq+TH8EoEsskKXKEsnFefCWxkOonDu3zatjEl16om1zr8UkynzH
 QbdqUxAZOO18UmSvdscsVMZgjeLfCun78JJRcGYXMkc2pOVXEyhJUXg+giX3g5hq3bw5
 8sjQ==
X-Gm-Message-State: AOAM530ElV2N7FAJGOmbENIYB/SLtBlFGG+Tp1xNp59I9bJZT7ngt3X4
 A3SoW7ZDuuejQHuXr+xNkD7y9A==
X-Google-Smtp-Source: ABdhPJxUNz66xbbtM4Jjtwf6tt59B2TjgPZjQafK+I+tj512i1f7vkBJ0d6klAGbXLkJQvMTFOkFIg==
X-Received: by 2002:adf:e443:: with SMTP id t3mr4398348wrm.14.1604598750991;
 Thu, 05 Nov 2020 09:52:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm3707860wrs.7.2020.11.05.09.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D505B1FF9B;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/15] stubs/xen-hw-stub: drop
 xenstore_store_pv_console_info stub
Date: Thu,  5 Nov 2020 17:51:50 +0000
Message-Id: <20201105175153.30489-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
 takahiro.akashi@linaro.org,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should never build something that calls this without having it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 stubs/xen-hw-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 2ea8190921..15f3921a76 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -10,10 +10,6 @@
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-x86.h"
 
-void xenstore_store_pv_console_info(int i, Chardev *chr)
-{
-}
-
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
     return -1;
-- 
2.20.1



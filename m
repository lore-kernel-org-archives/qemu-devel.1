Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E55C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F120872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE9RbhQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBck8-00017n-Vp
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBcjK-0000Pa-6R; Fri, 28 Aug 2020 07:39:38 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBcjI-0004Pt-NK; Fri, 28 Aug 2020 07:39:37 -0400
Received: by mail-lj1-x243.google.com with SMTP id f26so923076ljc.8;
 Fri, 28 Aug 2020 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1liowIeh8qRn8OyOxyKrs4dtyG7Kz6toJuQh/KfzfqE=;
 b=FE9RbhQz5ZBTryzyZnUeq8PruNmt0QGjrkBdOqvUR+znd1emFK0lcrOvcaU740aSEz
 AgVWOQw4wnUGVU9XuDQG+QbbiQctO4bjigMbFEWkrpSlGeLeWGdPTDSJfubRUjxK7s55
 I+wd32EVKqI8G1lTjWtvlioe/N20v7TPrKxP+Honuk7znwYQ0w/JmdgrShRx/Yp17UbB
 vNzC8M9I2B7AGTdYl4n0vf8u1yPcoQ2Rxh6/erM79T58O6CEoAdY8S3a/VBQVN9+rsSf
 NH7bGyh99QDcsZQJJ6FKlODF1Ek8OzkGvgVh740JvaHq0Z2rIgZD/OU+Y6EYcT0rDwbl
 jTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1liowIeh8qRn8OyOxyKrs4dtyG7Kz6toJuQh/KfzfqE=;
 b=GEgKmV81p2h7kqZqQCF0rvC/2PaEwYmDlgoI4IEu4tPv6NV02FUjk7XQYSodkFA/A4
 PuWC8T8PVri/bDF81hqG51jwDW1hJWiyYXiT+FrnXbaENUt2BXfPBPsK27OiKiYRQieG
 FQWDWrfZhKRG7feDfrtWzNsrzPlswFUQudzy/QebYBz1Z2oXGy7kXWhoHMihLSyyiykP
 MTkLovRWij9/eJfW4v9H2PIn9egPHA/zhazSU2t4lHnUMB+fQW72B1sB7aGXd2Tx95J+
 7bAmxTSyNeAFkckITPS1Emt82yCrUp7sKSgASQzKLtIigdlS+y/PemQlNSmxlVOYB+K3
 VrkA==
X-Gm-Message-State: AOAM530KR99fz7RtixsiR0qOqQy5tnzR/9sxw8JnZE3AfWtz0zkBqWzX
 NvSb0e1cjzMV8wResB3wnumCwMhQNAg=
X-Google-Smtp-Source: ABdhPJwsRM5G4CK2XQs8gpgy/qtgE3kq0QwMvM+1zB6kVpNLkJaUVy1D7vvp8jy8v/9/HdE1qeRzSQ==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr642845ljp.247.1598614772368; 
 Fri, 28 Aug 2020 04:39:32 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id k4sm151927ljc.50.2020.08.28.04.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 04:39:31 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/2] target/microblaze: Improve bus fault handling
Date: Fri, 28 Aug 2020 13:39:29 +0200
Message-Id: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.425, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Richards recent MicroBlaze patches exposed a bug in
the MB ports bus fault handling. If the core is not
setup for exceptions, we clobber the CPU state when
preparing to raise one. This fixes the bug.

Best regards,
Edgar

Edgar E. Iglesias (2):
  target/microblaze: Use CPU properties to conditionalize bus exceptions
  target/microblaze: Improve transaction failure handling

 target/microblaze/op_helper.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

-- 
2.25.1



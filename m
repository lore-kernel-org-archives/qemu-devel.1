Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E4C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1802084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRFlpi2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1802084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNpL-0006vK-Mc
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoP-0005EQ-2i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNoN-0001gj-Ki
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CbYixINhpQModzpfyZXayzanTCK/bGB3UBj1WchAysQ=;
 b=BRFlpi2eWLQbT84Zp3si96Zk3IsCaFXFnGomCBwkIrYg5jt3JBcDphcXUlTg3+YO7/HOk1
 tt48/5qFY14899JdJ0kBzUIAXZ71senTu9TnD8jHaKnlW7jkVShBpPzhzbRDYREKup1Stf
 QpSqj17WAG77nk7ozO5Vczej7HXkf98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-yEJs8YH4M_qavK73mTo4GA-1; Wed, 02 Sep 2020 04:08:05 -0400
X-MC-Unique: yEJs8YH4M_qavK73mTo4GA-1
Received: by mail-wr1-f72.google.com with SMTP id 3so1652190wrm.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CbYixINhpQModzpfyZXayzanTCK/bGB3UBj1WchAysQ=;
 b=pC0YOWpaE54byEvZ6B51EwxTtkDY5qN8zuzD+rA4Zc62NVAl/k8GIMQE4W+kJZOQaX
 GUKyMY5gQpHZewRIlKeSXS8dmyZ4JXeGUeHBWq2x5xlsWfFuZAJndQB6jtUKG/jxrWQr
 u6gmhQHnBL+eG+o1KEu2s4UGizyszzCgb3gIftiNpiyVMcVhmsEvKtxLSXMXswnWEj1m
 aVQ3H+TigdOt1zSuTEdWZ0gcFMyLUaY79EVqAfv9nQ288Mk2Kn3m8t8o5Hp5k5eB8WqQ
 BeqIFyLvW6QcgJBJPkjFV3rEbNJOorM7BMsbU2zEs5r9Md3DGlThkx7LpqsUc4cN39Cr
 RrWA==
X-Gm-Message-State: AOAM532H3zGiTSnc2hvXAP7bu6DBvosM2BTbeOZQj/2G5vLTmqzsiugt
 +szIsrflhHm3IUS7+CmzpHftlG5radax+xzpb88TbUu9cq08EOaX1nA4BzgcOGtRKAy7ZY7QuRA
 ZuP7iNO3I2VVSzmI=
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr5644645wrw.87.1599034084237;
 Wed, 02 Sep 2020 01:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0hnTmjf6TyPZSDic3rqSM/zVRo8gg6Pg9xJwOuEUnahBeEP++Lc5CrrB+7/xZ1WzO1k66rA==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr5644628wrw.87.1599034084046;
 Wed, 02 Sep 2020 01:08:04 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c4sm6054281wrp.85.2020.09.02.01.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] misc: Reduce assert side-effects
Date: Wed,  2 Sep 2020 10:07:56 +0200
Message-Id: <20200902080801.160652-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a Coverity warning in qtest,
do not declare local variable only used for assertions
(use them directly).

Philippe Mathieu-Daudé (5):
  tests/qtest/ipmi-kcs: Fix assert side-effect
  hw/pci-bridge: Do not declare local variable only used for assertion
  hw/ppc/spapr: Do not declare local variable only used for assertion
  tcg/tcg: Do not declare local variable only used for assertion
  util/qsp: Do not declare local variable only used for assertion

 hw/pci-bridge/pci_bridge_dev.c | 4 +---
 hw/ppc/spapr.c                 | 3 +--
 tcg/tcg.c                      | 3 +--
 tests/qtest/ipmi-kcs-test.c    | 3 ++-
 util/qsp.c                     | 4 +---
 5 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.26.2



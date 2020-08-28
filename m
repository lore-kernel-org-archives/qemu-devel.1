Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D61C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD7F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFkgZ2bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD7F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbuh-0002mR-Id
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpQ-0003fM-Ah
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpO-0005jD-C2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so831313wrt.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ocs60WDznaDScA/gvXj53ZTFJX4+fFayK+ZVchaf5to=;
 b=sFkgZ2boQgWhq4eXz6d09Ypkx8IqsyVoGLyWlG08+NeYR0k2QrTXXwqqVN0smG09Sb
 o89f2Vs0Upy7/Gm/+odj5QYCMICXmj2m8tTkvLXpIORj8cmv/QRO/oor7daXMgMiZw56
 JJZZS4tH9NQNzGc4AA6GtJhkVWwwKexihmyv512GrORDoe6+r/rf8EwwDjhEyziNpvh7
 L0rX+mp0WG+zTMyhuC+X8WWoGEwb8Ua6SqwwVz/GrndNXBQqmuweQgeeLcF2p45HQcL1
 Jq5Ra5zk7uAabEvpMUSrCOQzWqN2ryd+2SoIRJRS3h30PI5qdJ4FIdLMgNVSlmEiw23W
 V0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ocs60WDznaDScA/gvXj53ZTFJX4+fFayK+ZVchaf5to=;
 b=UB2qNRDP9qKTfrFddQHDOrYSim/mODDD1PeGAxY5aHZhCZYV0HePEYX/8LHbKtXyUl
 +Fq0ENfkHVicElI7PJyVHtwJxI+mEXWlG2p0flchXNxBrZXJazd+1HW3sZHQ5LHCM70F
 1LATI/Dl/kEgAzHzgX5Ez+Ki3xL/43A0NsPxmZdySNHMdDX4lHmagGDUC1puBTlTDu7A
 yh54kCT3xnb0IxXOqqjdHAH/H+9R4rCF00QrbnWdpxTNRm+J4KuVVs4PBkZIIU8KGLwp
 KCaT9//7YImOngue6Lcm16QiMTxuzuHLJus148gsa/AtKPdCiqn0tfgfMu0QyfZPnzwi
 Vyag==
X-Gm-Message-State: AOAM530uDkDY6fCqjdBtQoJuiL4dPemHSEZ9qIwHjmye6JQUfiXn9xXI
 iF9Z9QeR+cMQx0JC75vO/XY0VY+WW493Xg==
X-Google-Smtp-Source: ABdhPJzC+ez05Uou+atjjrhL2u5gcFrd8SM0IZ3ReNieo/RoGnrU8Gt8HLHuFj2S1Aw6BCQL6c88KA==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr890586wrw.325.1598611308896; 
 Fri, 28 Aug 2020 03:41:48 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:48 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 8/9] MAINTAINERS: Add 'tests/performance' to 'Performance
 Tools and Tests' subsection
Date: Fri, 28 Aug 2020 12:41:01 +0200
Message-Id: <20200828104102.4490-9-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new 'tests/performance' directory under the 'Performance Tools
and Tests' subsection.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a22c8be42..8923307642 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3124,3 +3124,4 @@ Performance Tools and Tests
 M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
 S: Maintained
 F: scripts/performance/
+F: tests/performance/
-- 
2.17.1



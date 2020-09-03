Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97840C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA57206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEioXK8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA57206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwQ6-0002QO-JA
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL1-0003U2-J5; Thu, 03 Sep 2020 17:00:07 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKz-0007PS-Qf; Thu, 03 Sep 2020 17:00:07 -0400
Received: by mail-oi1-x235.google.com with SMTP id x14so4501482oic.9;
 Thu, 03 Sep 2020 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D++uhEYw+d3KQcavq6f/g9akX1hQgOj/ppCWcFXbXE0=;
 b=tEioXK8PcEKWmWlZq6SMEoBFp32xOy7HNKitz9kQZhX9Hl4bHE232eErZc0H9TTyf2
 k0dDfEF9R6jS6dNraWcZaMoPdMgrSEt57xl8xkzxcYPDd4XEuqcUgAq86cfQCIe2Fsmr
 KMuvgYvCai3kKkzHvY4tCsB6rqCSOErgj9+Xb6S60fFIMzDLaCLQTGLQNLcZ9M4zBdtR
 xk7d3k86F+8DvWTydwMmzVQKvT/E6A9au2bME1TTy1D4jotNNVXPBa2ndXKT6BqzSsEE
 HRuVtwuPcod52+ld+fFIbqQ4euIGa9Xx7WYQFow6CIRmpBxD0orq14/zoVtr9hH0f5JZ
 2yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=D++uhEYw+d3KQcavq6f/g9akX1hQgOj/ppCWcFXbXE0=;
 b=jAZGBzjiua1+A057HMStpEtTOUpi/SlC5kaCo3JgHRZiRPtUKy1TLwuvy6tWZog9k7
 qT3P1Wq2N9t7zUro4CQJpZkDzY8UhxF5CB3q6oVikjbSsADUMTS0iATA+1AwG3TyZnQp
 +dLOQRSiJW5vKqRZ/QInyfak3K8q2jwleB1i4iSMj2jd/RWMeY1j7uQYnfgSi5S6YJLj
 BlUcj4+kYQdujEjKmQrXHLYzt0UZcFu18+2cwoPDKTQIE5024JI1CCh12Lt9dYEnDChC
 6dteRSNXnQMEk2h2s+yfjKNctHxY8WYsyiXsAOlfEMmaKZM6mX+XBY4r3jx+FOux+Dn4
 Y95w==
X-Gm-Message-State: AOAM530vXvtjG/XwdB/uPYqRLzUYa2AeQDQzz/7amiTPAN1zs6kP7FPs
 zHdLngApypmaxHfLYRjxgG5+N9f7TSY=
X-Google-Smtp-Source: ABdhPJzHHlvnzQofJnh1MA2OabWvcu6UShqEGNSjCQmpzuMSaPQyKTrxPXbcQv66nXRFjABwRz0nxw==
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr3403819oih.9.1599166803887;
 Thu, 03 Sep 2020 14:00:03 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id d83sm703620oib.43.2020.09.03.14.00.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:03 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/77] iotests/283: Use consistent size for source and target
Date: Thu,  3 Sep 2020 15:58:37 -0500
Message-Id: <20200903205935.27832-20-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

The test case forgot to specify the null-co size for the target node.
When adding a check to backup that both sizes match, this would fail
because of the size mismatch and not the behaviour that the test really
wanted to test.

Fixes: a541fcc27c98b96da187c7d4573f3270f3ddd283
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200430142755.315494-2-kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 813cc2545b82409fd504509f0ba2e96fab6edb9e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/283     | 6 +++++-
 tests/qemu-iotests/283.out | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 55b7cff953..44de76effe 100644
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -72,7 +72,11 @@ to check that crash is fixed :)
 vm = iotests.VM()
 vm.launch()
 
-vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null-co'})
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'target',
+    'driver': 'null-co',
+    'size': size,
+})
 
 vm.qmp_log('blockdev-add', **{
     'node-name': 'source',
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
index daaf5828c1..d8cff22cc1 100644
--- a/tests/qemu-iotests/283.out
+++ b/tests/qemu-iotests/283.out
@@ -1,4 +1,4 @@
-{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "target"}}
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "target", "size": 1048576}}
 {"return": {}}
 {"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": {"driver": "null-co", "node-name": "base", "size": 1048576}, "node-name": "source"}}
 {"return": {}}
-- 
2.17.1



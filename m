Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81631C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E92320771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWnLDyE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E92320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsowz-0000sK-KR
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsowM-0000Px-UL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:51:22 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsowK-0008VI-CD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:51:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id z13so45464338wrw.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sWCopq0wJhsPdyzdLb6co0u7Vt8uY1KEfQN6MVG4XyA=;
 b=EWnLDyE5y4W969b7qe/d5Gl7qK/vrxX7Gvr9rYBSUqBawkKT5e76Ai0VWDwYjmo7ev
 kTIo2HJfPx444xwUeeNtZ6svY+3IQchHO3tgP0pbZh2lM7qmqPBR5ouQkcZFOqaHTGxB
 AW+yV/Csg1CDImCtHMZIyW+68GU+dcXRfSccNwKI5nK1l4XBvsgwZqCzolkWF7ARn8Oc
 Pi0cjKAMrs7KH1ldFuLoyZURLm0TXeCdPIJQJfuY6oVotSXWy7ETFV+9MFXiROa+zko5
 +MD8sMeaOrD8LRxMdD1Dp7+XB/kU51+eR9X0DGOSqQixMc4QbRbHy8QwM2EqipKX39lq
 yeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sWCopq0wJhsPdyzdLb6co0u7Vt8uY1KEfQN6MVG4XyA=;
 b=c5z6AdlziKej0IRkCUSe7zzw6/ec/ZXq7E9TWHHgu8dH1KGkYl3oq7cEJJ5iTIdB6k
 JFqEunDX4NjeZKiK8/2LA4qkjfmyWw1jj54h0wYB1LBOsNoAvw7B2UAow/BaslybzThG
 vbzs1ZeKZzVWQDYlZ7aDe9WmcKawxRsp4aB2fOEuet9Mbl5Sreg58B32pTxAgjwg7war
 CQjeLhHHK7gI++L0eegDFEKJL+vZy9UTVrVIu9Trnwg/Ben7g08x00Pa59gGeq857UbI
 RTDo2rUtM4D5qH0iid+2MD/KWcvsxQ3O6zDxDcTTdqC9aeLn2Aw9nz9o7wK3N0OgDKvw
 SMmQ==
X-Gm-Message-State: AOAM530S97KhK0zSiG+19S7Ri0/qIvNDCIdSAUu3hqx6t011iEl/Y6nb
 Ls7X9c/f0WMiJX64oJyQNLj0OA==
X-Google-Smtp-Source: ABdhPJzy4uxEeVI8HDaiAHZQPlf/RGJYSJljGp5i1Um//b2AVVh28CMjyWeA1qR9oCbReI/QhdjlsQ==
X-Received: by 2002:adf:fa89:: with SMTP id h9mr53249747wrr.120.1594133478644; 
 Tue, 07 Jul 2020 07:51:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v3sm1264048wrq.57.2020.07.07.07.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:51:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E0AE1FF7E;
 Tue,  7 Jul 2020 15:51:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] new page: conservancy.md
Date: Tue,  7 Jul 2020 15:51:10 +0100
Message-Id: <20200707145110.10906-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is intended to replace the wiki
page (https://wiki.qemu.org/Conservancy) with a slightly more formal
page with the same information. I've also added the private list
address for governance issues that might want to be raised privately.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 conservancy.md | 32 ++++++++++++++++++++++++++++++++
 index.html     |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 conservancy.md

diff --git a/conservancy.md b/conservancy.md
new file mode 100644
index 0000000..4d3c39c
--- /dev/null
+++ b/conservancy.md
@@ -0,0 +1,32 @@
+---
+title: Conservancy
+permalink: /conservancy/
+---
+
+QEMU is a member of [Software Freedom Conservancy](https://sfconservancy.org/), 
+a not-for-profit organization that provides legal and administrative assistance
+to open source projects.
+
+The Software Freedom Conservancy holds assets on behalf of the
+project, including domain names and project funds/donations.
+
+QEMU interacts with Conservancy through a Leadership Committee,
+currently composed of the following members:
+
+* Alex Bennée
+* Paolo Bonzini
+* Andreas Färber
+* Alexander Graf
+* Stefan Hajnoczi
+* Peter Maydell
+
+The committee votes via simple majority. There cannot be more than two
+members employed by the same company at once.
+
+If you would like to raise an issue to the Leadership Committee,
+please email [qemu-devel@nongnu.org](mailto:qemu-devel@nongnu.org) and
+CC at least one of the members so they can bring the issue forward.
+For private emails you can send an email
+[qemu@sfconservancy.org](mailto:qemu@sfconservancy.org) which is a
+private list that all the leadership committee are subscribed to.
+
diff --git a/index.html b/index.html
index 37a0fbd..1de3fe3 100644
--- a/index.html
+++ b/index.html
@@ -62,7 +62,7 @@ $('.colorbox').on("click.random-namespace", function() {
 
 		</div>
 		<hr>
-		<p>QEMU is a member of <a href="https://wiki.qemu.org/Conservancy">Software Freedom Conservancy</a>.</p>
+		<p>QEMU is a member of <a href="/conservancy/">Software Freedom Conservancy</a>.</p>
 	</div>
 </div>
 
-- 
2.20.1



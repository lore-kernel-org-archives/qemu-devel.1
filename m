Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D22C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898F21707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCzSxEkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898F21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP9Q-0003jE-0e
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuo-00044u-55
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOum-0006FM-5f
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/Ms1577D2v1IRw6R+TW657pY0Sv2JnNydR0vOI1dUU=;
 b=NCzSxEknNUp6JegEHxiGm8RYmjh120TJXrM6zcFcIFNBxzn/3r1eunZ7lLRqqfEZ1DL8lR
 c+k3imu7rKhOwVrXhzoOxaOfTAPQlQTxTJJFI73i9SYPR8j21EFhGOfuIeW4vV94pc9HS7
 QVcxAuI6U8ZoL+qMBxfR+EC65hnMvT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-FvbAcROiOU24_QaI5tfh3A-1; Tue, 27 Oct 2020 09:21:24 -0400
X-MC-Unique: FvbAcROiOU24_QaI5tfh3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C581101F7A0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B2FE1972B;
 Tue, 27 Oct 2020 13:21:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 16/16] Add a CONTRIBUTING.md file as guidance for
 contributors
Date: Tue, 27 Oct 2020 13:20:15 +0000
Message-Id: <20201027132015.621733-17-berrange@redhat.com>
In-Reply-To: <20201027132015.621733-1-berrange@redhat.com>
References: <20201027132015.621733-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 CONTRIBUTING.md | 32 ++++++++++++++++++++++++++++++++
 _config.yml     |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 CONTRIBUTING.md

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
new file mode 100644
index 0000000..b5209ac
--- /dev/null
+++ b/CONTRIBUTING.md
@@ -0,0 +1,32 @@
+# Contributing to qemu-web
+
+The QEMU project accepts code contributions to the website as patches sent to
+the the developer mailing list:
+
+https://lists.nongnu.org/mailman/listinfo/qemu-devel
+
+For further guidance on sending patches consult:
+
+https://wiki.qemu.org/Contribute/SubmitAPatch
+
+It is expected that contributors check the rendered website before submitting
+patches. This is possible by either running jekyll locally, or by using the
+GitLab CI and Pages infrastructure.
+
+Any branch that is pushed to a GitLab fork will result in a CI job being run
+visible at
+
+https://gitlab.com/yourusername/qemu-web/-/pipelines
+
+The rendered result can be then viewed at
+
+https://yourusername.gitlab.io/qemu-web
+
+Contributions submitted to the project must be in compliance with the
+Developer Certificate of Origin Version 1.1. This is documented at:
+
+https://developercertificate.org/
+
+To indicate compliance, each commit in a series must have a "Signed-off-by"
+tag with the submitter's name and email address. This can be added by passing
+the ``-s`` flag to ``git commit`` when creating the patches.
diff --git a/_config.yml b/_config.yml
index d0473c1..7d34779 100644
--- a/_config.yml
+++ b/_config.yml
@@ -40,3 +40,4 @@ exclude:
   - Gemfile.lock
   - vendor/
   - README
+  - CONTRIBUTING.md
-- 
2.26.2



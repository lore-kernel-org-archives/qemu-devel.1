Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5ECC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B95207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgrGKbIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B95207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcLN-0007cv-Ls
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcG5-00051x-8l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcG3-0000Zl-Gp
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRd0J17TL3EKWjtslK7HZu1toRTuXcADnLWsSeDYb0Y=;
 b=MgrGKbIW8pUdlrcrba5Z4GPG3khTSNTdve8Q/Ykm3QuKJIKow/ciMFM55g5J6rUXOHp7yF
 poRfuONxbhUMCj1HCXZpTuV+42C3gKPXhXQXWFgbfNJg4Sjt8XKe9mQeL1zeyKVa+h1TP/
 2HXE+JZ0jS+aJJ5+R3bHyxDRp2dnrKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Mff-Y03tOWGDB5ioY-4YmQ-1; Fri, 28 Aug 2020 07:09:21 -0400
X-MC-Unique: Mff-Y03tOWGDB5ioY-4YmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26AAA100746C
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:09:20 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 634385C1C2;
 Fri, 28 Aug 2020 11:09:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] tests/Makefile.include: update check-build
Date: Fri, 28 Aug 2020 15:07:29 +0400
Message-Id: <20200828110734.1638685-12-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 30de192567..9fb61ff900 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -23,7 +23,7 @@ endif
 	@echo " $(MAKE) check-clean          Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
-	@echo " $(MAKE) check-build          Build most test binaris"
+	@echo " $(MAKE) check-build          Build most test binaries"
 	@echo " $(MAKE) get-vm-images        Downloads all images used by acceptance tests, according to configured targets (~350 MB each, 1.5 GB max)"
 	@echo
 	@echo
@@ -195,7 +195,6 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
 .PHONY: check-block check check-clean get-vm-images
 check-block:
-check-build:
 
 check-clean:
 	rm -rf tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
-- 
2.26.2



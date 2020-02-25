Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75892C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F83720CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL2b0iRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F83720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZOJ-0008F7-Ej
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlD-0001b6-45
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlC-0000zg-7Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlC-0000yO-0f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id q9so2667847wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4vmp7Ik2Ty/GsDRbd5YaNqN8aD/hfUDWlirfLWtK1uk=;
 b=SL2b0iRKR+uJktTD0kUh3Nawl2dH7a/IZ96DgQ2AWv4n1rCPIYPzXVC6qqUXOJ+EVj
 m6zwxbE1v5BbDa2LHbpcnosH8mS5sFIu0W4380hyLu7XE3PisG5OGTSI6RYXzzObcblr
 4e55G5yRZg5KtKuAJZAqT9R2L8jG9sgfK7aXoBFIVccolCcr8RkLqPKUytCMsThovII/
 C6sZ91aqz6xYzzJLztDELm7/yKFDs3yDev9fY3usRkAsjhDVgkCVbf36+fPmvLG7MTWN
 ro8L8s6EPQQ+Rhxax6+w7HrnbDUaXnAwdVWuicCTG+FeaPIVDlvbvBCr2kHARuV9o72T
 qkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4vmp7Ik2Ty/GsDRbd5YaNqN8aD/hfUDWlirfLWtK1uk=;
 b=G84j6fxBEvL/n8yesR1FiQa+RNgQA4g/9JD9jbaX3coNwn5mg9gi8roTLD+tYA8k6C
 mqo60yUT7t7u6wCABOnm5aMcQQFQF/uampqiDttUbatiPjU/r7Uw0SVJRibLOPVBEnYS
 VKpMHe0uKoDV1VDXKckeusGINwUA4Y8gY7ucphGF0Mu0qCjSW0kUhefYdqbn6WRF50zF
 coWeUUhOCwSnLLtGTzF1Q3wMmGHeqVn+Lm5fcX3RpSG/J2iORgxSmFQJfbD7lWk3TBlY
 +eS136SLEfILqTyw0tWqm3Svvb2Iin2/TVBxedmNfhEfCB/wdIoPnmeYSrp1/RTAmwZT
 hTDw==
X-Gm-Message-State: APjAAAXnKS8ycwE+YQzgFUdXS53tcQG7a0EpKwKLg1q00JgUz1sR3Uu3
 pl5PzZjJvLzkE26v5HGytDa1XTNX
X-Google-Smtp-Source: APXvYqzmQiOK+nF39VHlztdXYgsg8x3t8rHp58Rls5yE94mh1roSH+78QYGgBreHj1t3iWFVZnaGQw==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr4835418wme.41.1582631540774; 
 Tue, 25 Feb 2020 03:52:20 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 080/136] scripts/git.orderfile: Display Cocci scripts before
 code modifications
Date: Tue, 25 Feb 2020 12:50:10 +0100
Message-Id: <1582631466-13880-80-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When we use a Coccinelle semantic script to do automatic
code modifications, it makes sense to look at the semantic
patch first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/git.orderfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 1f747b5..7cf22e0 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -22,6 +22,9 @@ Makefile*
 qapi/*.json
 qga/*.json
 
+# semantic patches
+*.cocci
+
 # headers
 *.h
 
-- 
1.8.3.1




Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE5C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D952084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwnkAAhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D952084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0g7-0006SJ-TU
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0ev-0004zd-V9
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0eu-0001br-SG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iz0eu-0001Xb-MW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:02:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id z7so23666009wrl.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T4X+/Krl6/hHVrly66vwhxCB4xeVAs9xWsBmhu7DFmM=;
 b=CwnkAAhiBwhNofl6QwPFtnGAZDvFlxYEEgEepyGWKJW/VtuP8UQPBuNqIOLfZ0/xsY
 LdpopUCPHr2lYLkzHkqs8YXD5Ghee+k2i7rrlPVze9I8gR/TaGc0vqsusWHvZ30QyhsM
 6IgWfbxe+9Mnp16M5yiweCsxcC7Y9gviRV8zXs3HZBV+Zo2j/I7YGsmYUjY0El2RuUqH
 CuV40ByIWVw9+U0/07J8IdX9apYRVfo0iXAwp6ojtehsfu8lDnpaKKYLxCM01E+XzoDP
 rxdKykb2W3zykXUOtHaQGqJllspts0vcPrDoUB1wAy6JkBiWY9gu1mE2WntO1BgZqDyk
 xEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=T4X+/Krl6/hHVrly66vwhxCB4xeVAs9xWsBmhu7DFmM=;
 b=FgoyR2BdYt11JpG3pzvtNHb/eWwi0dvlW5nluL9PtUgmFjuvbIvvYXYTlVZVue3ChX
 fasI38TiNkd1bus6R7kyxN0qEAHACqW4guwV3CNtnRTnRb3ilNEYgCRKpi3fKddrTiu1
 d++a+q9PDNscPWsYVatQHJQiwpSLD9T++EHU8YCHlblX5a6Xa84neGqwaN7aM6RWNuNV
 bAfN6e4cfs9GnWhKytEKEsPTeaiXNJCJhd2deHKG9HMvlPcZM/hmMsEOyM46c+je25gp
 HV1lopWy+sUrOUHovvzwuc7ZXHN0jnJo+uiHUdbiTRIWJy/Z4tEvP4kmQD4BPrG0M4pv
 VN4Q==
X-Gm-Message-State: APjAAAWBcMGVwgwD23BqW49UXILlnMH9BCj6ZhvdHpqkn0qFzw8f+5hL
 23gOB9kylLqhzyybS53lndKoLnJ+
X-Google-Smtp-Source: APXvYqy6EzzpZYWc+eKwOk2taV3MpfwqR0UFZHnfEDHPqC+5z0GcnCpSYY7x1xVQ6O+oH4UQGGRZfQ==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr24535096wrm.219.1580832159384; 
 Tue, 04 Feb 2020 08:02:39 -0800 (PST)
Received: from donizetti.redhat.com ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id j5sm21363272wrb.33.2020.02.04.08.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:02:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] make all Python scripts executable
Date: Tue,  4 Feb 2020 17:02:37 +0100
Message-Id: <20200204160237.16889-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Scripts that have a Python shebang are meant to be executed directly from the
shell; give them 755 permissions.

Based-on: <20200204160028.16211-1-pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py   | 0
 scripts/signrom.py     | 0
 tests/qemu-iotests/222 | 0
 tests/qemu-iotests/245 | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/minikconf.py
 mode change 100644 => 100755 scripts/signrom.py
 mode change 100644 => 100755 tests/qemu-iotests/222
 mode change 100644 => 100755 tests/qemu-iotests/245

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
old mode 100644
new mode 100755
diff --git a/scripts/signrom.py b/scripts/signrom.py
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
old mode 100644
new mode 100755
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
old mode 100644
new mode 100755
-- 
2.21.0



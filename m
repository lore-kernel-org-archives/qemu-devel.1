Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E8C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8E82133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khcit/JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8E82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfldu-0005L1-Bo
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hflLA-0001XJ-KU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hflL9-0007L0-NW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hflL9-0007KM-E5
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id f21so8979543pgi.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=+mvwjYgLWyjKWcLHV58N51syiwUJURFH8odBAzC6P7A=;
 b=Khcit/JWtVqPgIL7U/OmHbD1Ommr9BU/LbEpnXiIhcUdKVGQm4fy4TgLQ0iccYlzjc
 mmQndH6AMhzjltszJ5UQo/t3sESnxIlYP/LMMDMMQpCIioerEzA4LNtDxAQPeP1esI2E
 WehwmVIGB9Y2YTafZMsYdcCfbXPPOWy5DM3c5MgYwWKo8qzxuIwdVV1Fzw9pi7IU5onD
 2N18cUfk6HgkkxrYVXQuQ4A7F+5CDfkuW5KaQ9R1vWsxdAqzjxDNuOUwURLjm16EIIgx
 wrM8k1J+hKtH3236WC8Y4s7m+bZ25i8eFQBLqTe4jKm8juumynGPzPdWRHkKmYvDKvBb
 HT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+mvwjYgLWyjKWcLHV58N51syiwUJURFH8odBAzC6P7A=;
 b=n5xf4cWtptfoZ2tF2f2XqyD9WjXumevcd9UN4f52N6hI9rFjrLcePGsLRS/INlveBh
 5KlaLOmnCXtmzF9tjl65s86t6TiiCTvmOs5GdNX/Wg0h6z3SUFnJeU7rwq0zfIicVa2n
 apmG1jnQC+kms+9amPIH/ZQAKvtEAR6WJWYNJJ7ZJ/isMxolMQ4NxIn0l2UJitZSTYFv
 3P+HifJkAZedvXNCYaPxqASsQapore4pXZHPvjLsjmEluz+eVmTGqtVYgG9JCRvccYn0
 ECiUr89TyzcKU6thldmy3AlW61pCJtwxZ58a1mQn9EZApm9Z1sUi0//lQ/AmOLF9855j
 zxpQ==
X-Gm-Message-State: APjAAAV5vE8cbw9h9JrXITSS7nRrZvfD3i16lNBn6owsdGrzCdJ6P+ir
 pSE9v7nXOuZDfvq0fvOnqi/oyF57pbGOVA1N
X-Google-Smtp-Source: APXvYqy/fGjJX8IN7A5m0eNAkjhP9TkKtW1CMGrrQK9Mncok+202Lls7et1YrZy7jyPvjcZ2dfMkvA==
X-Received: by 2002:a17:90a:e397:: with SMTP id
 b23mr32081243pjz.117.1561468705779; 
 Tue, 25 Jun 2019 06:18:25 -0700 (PDT)
Received: from VM_64_241_centos.localdomain ([129.226.57.92])
 by smtp.gmail.com with ESMTPSA id f186sm15675814pfb.5.2019.06.25.06.18.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 06:18:25 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 25 Jun 2019 21:18:16 +0800
Message-Id: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 0/3] migration: fix migrate_cancel problems of
 multifd
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patches fix the problems encountered in multifd migration when try
to cancel the migration by migrate_cancel.

Ivan Ren (3):
  migration: fix migrate_cancel leads live_migration thread endless loop
  migration: fix migrate_cancel leads live_migration thread hung forever
  migration: fix migrate_cancel multifd migration leads destination hung
    forever

 migration/ram.c | 62 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 11 deletions(-)

-- 
2.17.2 (Apple Git-113)



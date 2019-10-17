Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0C02067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="jbvv2C6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0C02067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL519-0006Gq-6b
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1iL4zS-000482-T1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1iL4zQ-0005wB-0s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1iL4zP-0005v3-Kf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:34:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id o15so1728304wru.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=3HJ90ie8W1c78kG7KWf3fbMnbNn5ysDud+rhDiGC2vw=;
 b=jbvv2C6q0+o6yr9NAsmgqgpRSHR/HOh79x3XPpnEafC2J9MKHoY0WCdQerb8p9vzAv
 9VFektxkEsOdcElfQVZjKEiejp3oBNHhJT063nZEuYS+VA0yq6iP0N8znoXLvGrD2azc
 3wdkOEBNWNmWqgYQ0/wNJoWbSZA0gRaOFioPPZkuhbWXulODxCHDJGd2Gbwk3+OsuKI2
 oMR4tRNV1wynqVFMqkCBvIo7hlMHTwXMa6CAbZXg/Qf4DMlpIDWtJ6ZVM55kx8bmyOwY
 hARhf4Zpb4h1m7/7r6iWlJaIeS6oN9KufFAA39EV/nDXQcxqfa0bL9V6mAhFcXIf/uPS
 uDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3HJ90ie8W1c78kG7KWf3fbMnbNn5ysDud+rhDiGC2vw=;
 b=bpzt/1S34p+AGtFEOhQo6/dYSpXJmjheagEXiSInzlyxkwbcHaVBfLQE3Ja/tmHYle
 tu76X46mPxJz1KBKwv/dh7x3aw+xDp9MvOAY/5D0z39WFb5+ZiyWB+dAcDSecAtYr/BU
 n9bAYYv/hmCzwnNRZauHP08s3TM3n7BGjfEQYuUzSi1GP/0FklIPljog9ruzJ1IVIYcd
 lPUolOz+9MO4fopGO1OSUU0xXLFC5HRuk9yf1EujTzzJh863wciwvRY6PYyY+ysioiYY
 LQipbxS8ixn28SZC0Qz5fGebQ1BaswpZy6W1sk5KvwkgKBya/nVH+x44Uv6r7JhfcNR8
 s8wg==
X-Gm-Message-State: APjAAAWDQkUpdiWK1rtr61MuAbO2X/VRXErnUj0EpZNmU+bjRJq3iixk
 4fckIKbSLSw52Dy1udNXeogb5V2Y8w4=
X-Google-Smtp-Source: APXvYqycdkyLEj2rsttCqYAHfiojdRczcd88YX6V5Yg6DxxwWJCYUbz1AF360t3zBaAVxX1HR5f9fA==
X-Received: by 2002:adf:ab5b:: with SMTP id r27mr2938273wrc.13.1571315683615; 
 Thu, 17 Oct 2019 05:34:43 -0700 (PDT)
Received: from bark.daynix ([141.226.163.173])
 by smtp.gmail.com with ESMTPSA id r2sm2077576wrm.3.2019.10.17.05.34.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 05:34:43 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH 0/1] BZ#1751431:guest-get-memory-block-info is not supported
Date: Thu, 17 Oct 2019 15:34:37 +0300
Message-Id: <20191017123438.87703-1-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <bsalman@redhat.com>

"guest-get-memory-block-info" is enabled according to "get-info" output,
while the command is only supported for linux with sysfs.

"guest-get-memory-block-info" command was added to blacklist.

Basil Salman (1):
  qga: Add "guest-get-memory-block-info" to blacklist

 qga/commands-posix.c | 3 ++-
 qga/commands-win32.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.2



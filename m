Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2EFC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DFD20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZffSq/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DFD20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Jm-0001bP-Hd
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IT-00089V-O3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IM-000121-De
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:01 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:35433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IM-0000tj-1S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:19:54 -0400
Received: by mail-lj1-x22b.google.com with SMTP id g4so5899944ljl.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J1+YZDcHmXz/UGOZ6Lct5kgtEJ8OfqbYJV+/OeHw5+k=;
 b=ZZffSq/EDwLJJZj4lE8ls8tMs9ZAmMBbaSASl52zW32fhd+upADop8hNvd7qH4b8mw
 Ipx/PTMzy9xgnS7tvAmeKaPAlqyQ/krw4tcsPXYP/qlMiVGsbfU8gHBQNefPSnyrCsHQ
 MhiCUnQkyi/aOGxfAwajggzGbWu4nj2DoemErSu1XKADDwUyzh5UNwltYRjUM6hxSKZq
 CzwzkpC4ABJm9VRuGTYVBDKTlN+SRud0Xg9T6lY0P3sTLIw+x36GZsE8uQ842zqNX7ki
 pX4BRP8Tl727a4beySHwlIkji19qy8NyRTkBW7khQAZ0bHlqGkA2T1bKTntJUj3DLOIr
 Tojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J1+YZDcHmXz/UGOZ6Lct5kgtEJ8OfqbYJV+/OeHw5+k=;
 b=bHHBvoDW3I3VW0SyWXYn01oJcW4v5ycJpyIxi4YnjKDXqep1ykGhIH0at+K62A5YPl
 0tVoRuPwyLwzNG8uv7RYVc3FXP1bamjJo7/GbeRJZw8lIxNOtMfZci36KG3rcJR7QoA5
 UA0lbLYUKl+Bcj4AGN7ImG9/UIbRnPJt5W8wOLRwg/pj7A589vWYDrb8HmFFbBC1CZpS
 mQFSghafLhU2pEorHwLzu0fBnD6kXa2sYWlCCm/62TZztAxzL3O6xye3nlPV7CXAM5+J
 TZm2q2biY2oEsrVLRQ33KaKo/PD4+OkXc3qhuRe8uaXZHRY5aFi8XT2dpj63m6AckXZ5
 Yg7Q==
X-Gm-Message-State: AGi0PuawCDH3RqRl5T0+hijqA0T5UvDXTx0ASr2m52TlHBzUUVGp9hXm
 PBlaJE0ntaeUvS4jy69e7qGOBNdofUY=
X-Google-Smtp-Source: APiQypJWRE+PyfzCbHM7Fvw68W006vHQTyI+9fBuO6RmsPXLpawk9KL0odgEkoUzzMy8KN4M4UZYpA==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr1757422ljy.282.1588241991537; 
 Thu, 30 Apr 2020 03:19:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 16sm4007795ljr.55.2020.04.30.03.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 0/6] Xilinx queue 2020-04-30
Date: Thu, 30 Apr 2020 12:19:43 +0200
Message-Id: <20200430101949.7754-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22b
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)

are available in the Git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-04-30.for-upstream

for you to fetch changes up to 3ed43b5031ed2d7ef501bb81b87caed960218461:

  target/microblaze: Add the pvr-user2 property (2020-04-30 12:11:03 +0200)

----------------------------------------------------------------
For upstream

----------------------------------------------------------------
Edgar E. Iglesias (6):
      target/microblaze: Add the opcode-0x0-illegal CPU property
      target/microblaze: Add the ill-opcode-exception property
      target/microblaze: Add the div-zero-exception property
      target/microblaze: Add the unaligned-exceptions property
      target/microblaze: Add the pvr-user1 property
      target/microblaze: Add the pvr-user2 property

 target/microblaze/cpu.h       |  6 ++++++
 target/microblaze/cpu.c       | 24 ++++++++++++++++++++++--
 target/microblaze/op_helper.c |  5 +++--
 target/microblaze/translate.c |  8 ++++----
 4 files changed, 35 insertions(+), 8 deletions(-)

Edgar E. Iglesias (6):
  target/microblaze: Add the opcode-0x0-illegal CPU property
  target/microblaze: Add the ill-opcode-exception property
  target/microblaze: Add the div-zero-exception property
  target/microblaze: Add the unaligned-exceptions property
  target/microblaze: Add the pvr-user1 property
  target/microblaze: Add the pvr-user2 property

 target/microblaze/cpu.h       |  6 ++++++
 target/microblaze/cpu.c       | 24 ++++++++++++++++++++++--
 target/microblaze/op_helper.c |  5 +++--
 target/microblaze/translate.c |  8 ++++----
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.20.1



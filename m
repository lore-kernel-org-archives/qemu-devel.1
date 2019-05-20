Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4535DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AE5206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkdGSm6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AE5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSma0-0004vC-8n
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:00:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hSmYp-0004Az-H7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hSmYo-0005Zn-2V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:58:55 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:45011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hSmYn-0005YO-LA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:58:54 -0400
Received: by mail-lf1-x12a.google.com with SMTP id n134so10966513lfn.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qRwUurolprRKP/X/J1iGJKrcp2YtMyO7x8Il5r2/m3U=;
	b=MkdGSm6eeqEZZcNv2jJJQU66X/klxauM2ycXhhHqMJ6GDVoN6eVU6FGdUGSNUjiKZ3
	Z9IQJsS+Ul6u2eGdZkiZibNdWevAItsZ7ns7hPyDDC59hoqUUWKpK9zwtNyjblG+99bX
	9XOE0fS0UT7i3j0tHdsqlI7eE4LSB0csTigrOM6gUY74XkdJYsxWwdAH2SFDfAaN24QN
	HixomhpatuNre3PqSQ6CbUQypUXD5+ajsqGqoPfJ0eBhFLjFB1F10585rQBhn1AhI3q0
	ACykfFj8snSwFGelgZBf+knisKHPvUsJTbquYBRyARk8p4WsokDC32wnLlkEQRwJtWDs
	2QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qRwUurolprRKP/X/J1iGJKrcp2YtMyO7x8Il5r2/m3U=;
	b=GKDeGDtB/9SNVdx4Q7XVi2WpyLgSvmBTfieaP9P0DArymRs+RZU/jkHxnEdNLEVk/S
	BxBHELKzR2H7fYWKNASy0DqTvEttELCDUAYXFCzCjevnsffYKGVG+bIAg8tRH2FCz45L
	mRrD571Y0Za4hL/oek0/K3jvQ/Qu2Xcnkd7sjMmTj/x7yG28Qmsn17M2uj4YSMUpfZOG
	y917VkDwZZs08HSvgwp+Fv51FaWUzna1hCS2WsteQpkThLLq5UNKLkPxfdAzLdOlWanB
	OH1Vj6Q9gimfiBV+hBdzS/dhl0dbLgcVykEermZZBwsjHydF8mfG3Jr0F5yjGcT4auL8
	bE1g==
X-Gm-Message-State: APjAAAUohh8rXV8J3LVi8gC0qFLXR9skDqX3/ho2DO+Ftat1WErOoDYr
	HJS2f25NKM6kGEygVnKrci+v9CMW
X-Google-Smtp-Source: APXvYqxqP5SkGtPxCw3PGg75DpWkuXk/kFJRV1bsEca9EMTBttotYxS5TlCynFy/Tsx1nG0Nlvvk2g==
X-Received: by 2002:ac2:4471:: with SMTP id y17mr10901552lfl.23.1558375129429; 
	Mon, 20 May 2019 10:58:49 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id l15sm3942002ljh.0.2019.05.20.10.58.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 10:58:48 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 10:58:37 -0700
Message-Id: <20190520175837.4561-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::12a
Subject: [Qemu-devel] [PULL 0/9] target/xtensa queue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

please pull the following batch of updates to target/xtensa:

The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20190520-xtensa

for you to fetch changes up to b345e140534ea17814b02bdf8798f18db6295304:

  target/xtensa: implement exclusive access option (2019-05-15 10:31:52 -0700)

----------------------------------------------------------------
target/xtensa: SR reorganization and options for modern cores

Reorganize special register handling to support configurations with
conflicting SR definitions.

Implement options used by the modern xtensa cores:
- memory protection unit;
- block prefetch;
- exclusive access

Add special register definitions and IRQ types for ECC/parity,
gather/scatter and IDMA.

----------------------------------------------------------------
Max Filippov (9):
      target/xtensa: get rid of centralized SR properties
      target/xtensa: make internal MMU functions static
      target/xtensa: define IDMA and gather/scatter IRQ types
      target/xtensa: add parity/ECC option SRs
      target/xtensa: implement MPU option
      target/xtensa: implement DIWBUI.P opcode
      target/xtensa: implement block prefetch option opcodes
      target/xtensa: update list of exception causes
      target/xtensa: implement exclusive access option

 target/xtensa/cpu.c               |    2 +-
 target/xtensa/cpu.h               |   58 +-
 target/xtensa/helper.c            |    1 +
 target/xtensa/helper.h            |    6 +
 target/xtensa/mmu_helper.c        |  532 ++++++-
 target/xtensa/op_helper.c         |   42 +
 target/xtensa/overlay_tool.h      |   43 +-
 target/xtensa/translate.c         | 2951 ++++++++++++++++++++++++-------------
 tests/tcg/xtensa/test_exclusive.S |   48 +
 9 files changed, 2574 insertions(+), 1109 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_exclusive.S

-- 
Thanks.
-- Max


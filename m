Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325CB2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXoBbZj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325CB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXWW-00050g-OE
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV4-0003Nj-Fv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV3-00032a-0i
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXV2-000322-OT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so18870053wrx.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NclHrW8jvApCLb2RoneAblxmOJEEdg/dA8hXiVZ2hN4=;
 b=eXoBbZj8txS6KYbiUPOIgXDicd4MPbZSQvvkS+M8mC4cAs3BHps9751JecGOF0iAkd
 xuYmpagp/cu4iKQhY7JNVT17uXh9REPQuLQt36/frxVqO662SpPAmPU8JaAplzlXbWsl
 fqgctTR+z3YmNq0UT8yyJvZ4rubj+s5ahKemS2jbjLdc9LOiGqBN3EXE9OwSb5s1xPkR
 rWAWw04tQAGx4e2nWc3Kd+/W3QQbMnW6depShW3EtfrQkPNr/q44hI6a52vy7rCxe/89
 jZbhpseKxGM4HHvoFqRSJQ6A0dN9KMvQ2tBHZXl/siocFz1o3psl5y4lDcHHW9ojJMfM
 Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NclHrW8jvApCLb2RoneAblxmOJEEdg/dA8hXiVZ2hN4=;
 b=JZdhbbJo+wGeCvzkgWfmjoR9N9vYJx6opJKxASkaF2IMQ8Go+ZSTr5NYTjEVA3ZQbj
 eROTTD6r520TGeAms5nFcTlM4jn15VakvDGOu8AMLiife9ucXO0YBXcu5XlZUL9sKc3e
 dco511SWvGVhv5vbZEOfeTHr/AwjmYQBUlsvDVP/6W4SJonn5xQehUcgqPR41Uy+yW3V
 FxuwaPzbjcPAufydzhxicYX9yMziYkx+/c45SzQq6Qrv7f5ywWSNXnFG5/HBj1hXzQtZ
 JNHMlro6V3ERQ55aLWJiX+zBfCV/sWwP0Ffu0GZOpc42OXC+2KIsNKqqxmQOe6V7kJyU
 rT4g==
X-Gm-Message-State: APjAAAXekYw39X8Fk0hgI/+c6jqPbLZ0z1T9x53WwJxOl6CqAiuVLPTS
 0tMtv0IX8igSAAvG2dK96WMXxg==
X-Google-Smtp-Source: APXvYqzh9EzqwFvFQ4z4ASUCi8L7FeMOob5chSO3Eu0RiGUE8Ucxs2/xAK5nZUWDNLm1WLMffhvc5w==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr6498412wrp.71.1573570231088; 
 Tue, 12 Nov 2019 06:50:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j10sm15036528wrx.30.2019.11.12.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:29 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0B47E1FF87;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/8] testing and tcg plugin api ver
Date: Tue, 12 Nov 2019 14:50:20 +0000
Message-Id: <20191112145028.26386-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 039e285e095c20a88e623b927654b161aaf9d914:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-11-12 12:09:19 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-tcg-121119-1

for you to fetch changes up to 3fb356cc86461a14450802e14fa79e8436dbbf31:

  tcg plugins: expose an API version concept (2019-11-12 14:32:55 +0000)

----------------------------------------------------------------
Testing and plugins for rc1

  - add plugin API versioning
  - tests/vm add netbsd autoinstall
  - disable ipmi-bt-test for non-Linux
  - single-thread make check

----------------------------------------------------------------
Alex Bennée (4):
      tests: only run ipmi-bt-test if CONFIG_LINUX
      tests/vm: support sites with sha512 checksums
      .travis.yml: don't run make check with multiple jobs
      tcg plugins: expose an API version concept

Gerd Hoffmann (4):
      tests/vm: netbsd autoinstall, using serial console
      tests/vm: add console_consume helper
      tests/vm: use console_consume for netbsd
      tests/vm: update netbsd to version 8.1

 .travis.yml                |   2 +-
 include/qemu/qemu-plugin.h |  19 +++++
 plugins/loader.c           |  21 +++++
 plugins/plugin.h           |   2 +
 tests/Makefile.include     |   2 +
 tests/plugin/bb.c          |   2 +
 tests/plugin/empty.c       |   2 +
 tests/plugin/hotblocks.c   |   2 +
 tests/plugin/hotpages.c    |   2 +
 tests/plugin/howvec.c      |   2 +
 tests/plugin/insn.c        |   2 +
 tests/plugin/mem.c         |   2 +
 tests/vm/basevm.py         |  29 ++++++-
 tests/vm/netbsd            | 188 ++++++++++++++++++++++++++++++++++++++++++---
 14 files changed, 264 insertions(+), 13 deletions(-)

-- 
2.20.1



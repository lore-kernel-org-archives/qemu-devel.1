Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB81BC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B595121D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ts3wwwZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B595121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rKy-0005ZJ-SW
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI8-0000IH-Qk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI7-0002LK-LX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rI7-0002JW-F5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id z3so1682884wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RP+S7+hYGK81s1glUYrfVIpzjqrmvm+wgud3aRU2B1U=;
 b=Ts3wwwZQYMbe4RtKGeNg9SF3gzPfxB4bYboClFbvYer7CF0MhINVpPIpHUG98O8owr
 DppBNjtASKH/6SJbh3TVxL2KLgAB6VUglhPyUQ+ibDUM+UYKdLdHzQiiXEJ+6QlnflD3
 Wxmk3kL+Qyr426fMsHuf+0PYKknnkPohG6z0c/KLOE+eDAQVbqhdQipGWvAdz9+FEbEK
 OyllH4oZHIMpDbECtbf+D3oQC5pjkr9A9/B3X8C9v3HirklVG5XNsbKl/y77sRlH2VjR
 p9e/iz74ED3Idliem1aKPTSQcNvt5ZmfB9TbV04NcoWLHuX4tyA6kmVUwBuHQ1kdIiqt
 G24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RP+S7+hYGK81s1glUYrfVIpzjqrmvm+wgud3aRU2B1U=;
 b=F4Ov2zrAlVX/+Dpy6y2oQ8PVPfcksiVWB/5LKJOWCwttTkXlvne0+XTUzZGAg+st3h
 4IkIEZopKTFJhaRiaNdHckIDsN3KmsmFg27qX0Hym33+3osEIAQghte+GaC75NLWIQTn
 k2QbHIFKDzOB6r70KbvyO8Q29Hf6U1Di8hQZ9w7FKuBoMQpCF7jZQOsGTFcxbPzwlPo9
 0PkdxhWAV64VkGJI641BdalANZuphN1xGhdyNEMyck22SDRge9Sqp7R0sKhoxAGdLuiu
 1kOXo71j440t1k2qyP64azNvUnVB3iZ+rlN42ukIMXhTqzpSmSJs09uNWYxHVgA+hfhs
 TlJQ==
X-Gm-Message-State: APjAAAUqcD+6T8+iUfl17WJFRaElKlpsv0HlGJ4ueRQGBsKUl7xrw4Xz
 8zlUWv4M3adoYPK1EMzpLdnfQw==
X-Google-Smtp-Source: APXvYqwqfb8N3cDyRM1Q9PGRHG27afURWKEhQbbypAy6aN5SHY+X5qcKwkSRSAZ9pg1ryOTlkxTK8A==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr3866401wrv.426.1582702774352; 
 Tue, 25 Feb 2020 23:39:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b21sm1779296wmd.37.2020.02.25.23.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:30 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 44D7F1FF87;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/19] testing and plugin updates
Date: Wed, 26 Feb 2020 07:39:10 +0000
Message-Id: <20200226073929.28237-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-02-25 13:31:16 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-plugins-250220-1

for you to fetch changes up to bc97f9f64f8a4a84d0d06949749e9dbec143b9f5:

  tests/tcg: take into account expected clashes pauth-4 (2020-02-25 20:20:23 +0000)

----------------------------------------------------------------
Testing and plugin updates:

 - fix pauth TCG tests
 - tweak away rcutorture failures
 - various Travis updates
 - relax iotest size check a little
 - fix for -trace/-D clash
 - fix cross compile detection for tcg tests
 - document plugin query lifetime
 - fix missing break in plugin core
 - fix some plugin warnings
 - better progressive instruction decode
 - avoid trampling vaddr in plugins

----------------------------------------------------------------
Alex Bennée (14):
      tests/tcg: include a skip runner for pauth3 with plugins
      tests/rcutorture: update usage hint
      tests/rcutorture: better document locking of stats
      tests/rcutorture: mild documenting refactor of update thread
      travis.yml: single-thread build-tcg stages
      tests/iotests: be a little more forgiving on the size test
      tracing: only allow -trace to override -D if set
      docs/devel: document query handle lifetimes
      target/riscv: progressively load the instruction during decode
      tests/plugins: make howvec clean-up after itself.
      tests/tcg: give debug builds a little bit longer
      tcg: save vaddr temp for plugin usage
      tests/tcg: fix typo in configure.sh test for v8.3
      tests/tcg: take into account expected clashes pauth-4

Chen Qun (1):
      tests/plugin: prevent uninitialized warning

Emilio G. Cota (1):
      plugins/core: add missing break in cb_to_tcg_flags

Thomas Huth (1):
      travis.yml: Test the s390-ccw build, too

Wainer dos Santos Moschetta (1):
      travis.yml: Fix Travis YAML configuration warnings

Yoshinori Sato (1):
      qemu/bitops.h: Add extract8 and extract16

 docs/devel/tcg-plugins.rst                | 13 +++++-
 include/qemu/bitops.h                     | 38 ++++++++++++++++
 target/riscv/instmap.h                    |  8 ++--
 plugins/core.c                            |  1 +
 target/riscv/translate.c                  | 40 +++++++++--------
 tcg/tcg-op.c                              | 23 ++++++++--
 tests/plugin/bb.c                         |  6 +--
 tests/plugin/howvec.c                     | 26 +++++++----
 tests/plugin/insn.c                       |  3 +-
 tests/rcutorture.c                        | 74 +++++++++++++++++++++----------
 tests/tcg/aarch64/pauth-4.c               | 54 +++++++++++++++-------
 trace/control.c                           | 11 +++--
 .travis.yml                               | 23 +++++++---
 tests/qemu-iotests/214                    |  4 +-
 tests/tcg/Makefile.target                 |  4 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +
 tests/tcg/configure.sh                    |  2 +-
 17 files changed, 235 insertions(+), 97 deletions(-)

-- 
2.20.1



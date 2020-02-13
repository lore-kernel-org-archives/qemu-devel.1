Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F32AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5B620873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiXbccLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NLb-0006cZ-AS
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKE-0004b0-OJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKD-0003YX-CY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:14 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKD-0003WK-54
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:13 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z3so8778831wru.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=laSM3HZXwplL6XfOd/sM7CxCKbzr6u+s3QkgdUGnKFA=;
 b=yiXbccLZbiBzX10hP3xI+e+vS6ueaWKHK+fx0CdxUZJvZ+f8551KK64GGBblhMUkbm
 roVt/5YCvB1q5FeUpTHT03xLaHBNXVI51F5BJ4UKCbUY6AGrDhIyEZh6OQTxjr7HguvA
 I/bjJjOr1R8snZYjKHOaQczDKA0wPkqZRZKgpkp475VQIYcyhfQKAti2ORelxNJtcMBj
 W6P3s66rJZm19ey66SGmnS1c0P9yii20cOuRnWigqeyAl750x/2MrljbHjWKt0+2n8WJ
 1V3N+Z3Jq4stw3//TzNdXiCS+50s8IGJPRoW2c44pTWyDrf1MFeYzRd4yhj0LF+GPmVr
 zcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=laSM3HZXwplL6XfOd/sM7CxCKbzr6u+s3QkgdUGnKFA=;
 b=IMSuYZzGErr61NEb5SgMz9iT4ytBO+5/SHhaBcc+xGamKpYeKJnLnaLgTIbwSVTZQZ
 61+H1jxHEKvW1VimHNF25zOr3ySFYh4YkptOQFbmpITdok4nDJ9QN/Ey2uoexGUINkOG
 fq6rIliDtSq6kRDAZP5H3S8F1EeQ7c3wHn7HxYhNwKFXNis+BHV7DBtW6XuLEzVOyvn8
 IHFa3W5fd7LpdARmhpnSn/Zy3Ac+E4h+Qzn0LSGNfBCfyn89ZIY3dggRTpT7n4adwTHX
 m0penmpXMxiTCqOySTobZI1Jn+89gn4Pf023CTZGTMf3dtvy0e76o9s+uY6Vwbb1zGkM
 8UIw==
X-Gm-Message-State: APjAAAU/s6q7sfprqJPMZmhreIBN3lpj19aSWmYztVQhpHFXx2gav+Sr
 KX0AS31t2yRAHdvnbiPjmk4wGA==
X-Google-Smtp-Source: APXvYqwk2dJhsLMOKBgbHKVeG8JgdibIpFjX5sjPnmPUMlawQGt/1e94Kg1D14m2ln7xw/hF0w3uJw==
X-Received: by 2002:a05:6000:124b:: with SMTP id
 j11mr22157053wrx.285.1581634271652; 
 Thu, 13 Feb 2020 14:51:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm4680376wmb.37.2020.02.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FAC81FF87;
 Thu, 13 Feb 2020 22:51:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/19] testing and plugin updates
Date: Thu, 13 Feb 2020 22:50:50 +0000
Message-Id: <20200213225109.13120-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I've ended up combining my accumulated testing fixes with the plugin
fixes as there is some cross-over between the two. On the testing side
I still haven't seen rcutorture trip up on my branches but the final
patch that light re-factors it needs to be reviewed. I've also added
some fixes for pauth - both ensuring they compiler and tweaking
pauth-4 to take into account the occasional authentication clashes.

Plugin wise I have cleaned up the riscv parser to use extract16 where
appropriate. We also managed to diagnose a bug in the address passing
of the memory instrumentation which only showed up under alpha. The
relevant patches have been Cc'ed to qemu-stable.

The following patches need review:

  tests/tcg: take into account expected clashes pauth-4
  tests/tcg: fix typo in configure.sh test for v8.3
  tcg: save vaddr temp for plugin usage
  tests/tcg: give debug builds a little bit longer
  tracing: only allow -trace to override -D if set
  tests/iotests: be a little more forgiving on the size test
  travis.yml: single-thread build-tcg stages
  travis.yml: Fix Travis YAML configuration warnings
  tests/rcutorture: mild documenting refactor of update thread
  tests/tcg: include a skip runner for pauth3 with plugins

Alex Bennée (13):
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
  tests/tcg: fix typo in configure.sh test for v8.3
  tests/tcg: take into account expected clashes pauth-4

Chen Qun (1):
  tests/plugin: prevent uninitialized warning

Emilio G. Cota (1):
  plugins/core: add missing break in cb_to_tcg_flags

Richard Henderson (1):
  tcg: save vaddr temp for plugin usage

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
 tests/rcutorture.c                        | 55 +++++++++++++++++------
 tests/tcg/aarch64/pauth-4.c               | 54 +++++++++++++++-------
 trace/control.c                           | 11 +++--
 .travis.yml                               | 23 +++++++---
 tests/qemu-iotests/214                    |  4 +-
 tests/tcg/Makefile.target                 |  4 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +
 tests/tcg/configure.sh                    |  2 +-
 17 files changed, 225 insertions(+), 88 deletions(-)

-- 
2.20.1



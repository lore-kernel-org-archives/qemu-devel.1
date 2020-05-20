Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4220C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924662065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAZ/tnxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924662065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPVB-0007fv-PD
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM2-0008Sz-H8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:54 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:34964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM0-0001ur-OJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:54 -0400
Received: by mail-ej1-x633.google.com with SMTP id s21so3982651ejd.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+eYBUW9i9LEqNAlwNOSXlSk7O/CmGupV0lmi1g2GZD4=;
 b=qAZ/tnxvhbwE8lF4CoUEsT1QfzJvxKEy9Zn159AoIUQFUH7eqeycSQj3fFG+5HXHOa
 +g5HgxBGl8VQyekidzHCF1O1r6M0dpW4356a0wfYPY4GtfbfFG9bst8QFZZzCio7AXdy
 YPPE5V7eTHgBcQe1KFzPywxQWKVj7GXUf85dn57eV/0Fyc5EzmSAe6dJUBLfe5WnfnOy
 l8g16uFzwvnS5r6bDDoD4eDEMSwGSy2p6TAeIJibgy3XQdFWXUJUtiO5nJMdC38rrTb3
 cUUuK/JZuEEU4tYA9kqQCCKYAG2Ba8ZGoID7qlyrg+5to8+B1M7uX8ly5aSfELA7wb08
 8kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+eYBUW9i9LEqNAlwNOSXlSk7O/CmGupV0lmi1g2GZD4=;
 b=f+IU06eHs4+sJ/x95WV+XUG9WaXSDz0U6izjT5svpwm647m4/ZipkYSS9G1E3rXGyg
 FGT+zErnb5kPiS/2yS1HkkZEFrY3FefwDMHP6vWbF1i5X8ljUDLASL7EmPiFhCOeM0kl
 SdnXubb99KD4cIc0Ptd8wex+FzLEqAD3e4KsVQCBaCd6Rsd2Y9+9Nv/YFbGpylTJHdkv
 iZwf62xMV89U2pENBFZEbLZPP3+5Pn6U+huMGRMAvmfHYvUuvpGpMuADregQ2D4ZSvck
 ky2mJ8l8k7k1Ns3qViY2S4jJi/2dvO8WOgkeMtMuCKNK2/7oV7LOFsDQVZgdQu+9wUFC
 fshg==
X-Gm-Message-State: AOAM533nt9+KFzQXjcpuMtKZ/rRZrU8JEyf8Ox3gIQuZ0NRg9RQO7bFX
 wQu3OT3WfCEY90656XBnAXhQjA==
X-Google-Smtp-Source: ABdhPJzzfwD/nEoTUOfwmj4n8I+Zm3Z4wz+xUrNImqfYoOHdmgRUXKCBOdtg7n3zayQZT2/v6MfaaA==
X-Received: by 2002:a17:906:2610:: with SMTP id
 h16mr3994006ejc.423.1589983544544; 
 Wed, 20 May 2020 07:05:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id lr21sm2026808ejb.117.2020.05.20.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 357221FF7E;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/15] testing and plugin updates
Date: Wed, 20 May 2020 15:05:26 +0100
Message-Id: <20200520140541.30256-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here is the current status of various testing and plugin related
patches. Most of the patches should be uncontroversial although I
would draw attention to the cpu and linux-user QOM object lifetime
patches. I think properly de-referencing the vCPU object associated
with the linux-user thread is the cleaner solution but it does involve
also changing some assumptions about the cpu indexing.

The following patches need review:
  - plugins: new lockstep plugin for debugging TCG changes
  - linux-user: properly "unrealize" vCPU object
  - cpus-common: ensure auto-assigned cpu_indexes don't clash
  - tests/docker: use a gcc-10 based image for arm64 tests
  - tests/docker: add debian11 base image
  - tests/docker: bump fedora to 32
  - tests/tcg: better detect confused gdb which can't connect
  - tests/fp: split and audit the conversion tests
  - tests/fp: enable extf80_le_quite tests
  - configure: add alternate binary for genisoimage

Alex Bennée (13):
  configure: add alternate binary for genisoimage
  tests/vm: pass --genisoimage to basevm script
  tests/tcg: fix invocation of the memory record/replay tests
  tests/fp: enable extf80_le_quite tests
  tests/fp: split and audit the conversion tests
  tests/tcg: better detect confused gdb which can't connect
  tests/docker: bump fedora to 32
  tests/docker: add debian11 base image
  tests/docker: use a gcc-10 based image for arm64 tests
  cpus-common: ensure auto-assigned cpu_indexes don't clash
  linux-user: properly "unrealize" vCPU object
  tests/tcg: add new threadcount test
  plugins: new lockstep plugin for debugging TCG changes

Richard Henderson (1):
  tests/tcg/aarch64: Add bti smoke test

Thomas Huth (1):
  travis.yml: Use clang++ in the Clang tests

 configure                                     |   2 +-
 cpus-common.c                                 |  10 +-
 linux-user/syscall.c                          |  19 +-
 tests/plugin/lockstep.c                       | 340 ++++++++++++++++++
 tests/tcg/aarch64/bti-1.c                     |  62 ++++
 tests/tcg/aarch64/bti-crt.inc.c               |  51 +++
 tests/tcg/multiarch/threadcount.c             |  64 ++++
 .travis.yml                                   |   8 +-
 tests/Makefile.include                        |  44 ++-
 tests/docker/Makefile.include                 |   4 +-
 .../debian-arm64-test-cross.docker            |  13 +
 tests/docker/dockerfiles/debian11.docker      |  18 +
 tests/docker/dockerfiles/fedora.docker        |   2 +-
 tests/plugin/Makefile                         |   1 +
 tests/tcg/Makefile.target                     |   2 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |   2 +-
 tests/tcg/aarch64/Makefile.target             |   9 +
 tests/tcg/configure.sh                        |   8 +-
 tests/tcg/multiarch/Makefile.target           |   2 +
 tests/tcg/multiarch/gdbstub/sha1.py           |   4 +
 tests/vm/Makefile.include                     |   1 +
 tests/vm/basevm.py                            |  16 +-
 22 files changed, 641 insertions(+), 41 deletions(-)
 create mode 100644 tests/plugin/lockstep.c
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c
 create mode 100644 tests/tcg/multiarch/threadcount.c
 create mode 100644 tests/docker/dockerfiles/debian-arm64-test-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian11.docker

-- 
2.20.1



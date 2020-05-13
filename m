Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CF5205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9Zc0kLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CF5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvHf-0000vn-7I
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEw-0004x4-08
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEv-0007ny-23
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so27420938wmj.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HR4jMOF852+AiagIFivRxvoRxaO2U/uZiy0Wy938QuE=;
 b=F9Zc0kLnz+STQJWNl5ZwJBq7YwwWOywcBrwjvBrrzZzzVoeA4LM+PDjwPlnWkgOCmf
 3YAIsr4mb60IcSRfLP1IuNA89Me1yvY2Vxr5qON+EFu9lxtpN+6L62BDMfH1JZUYdVh1
 zTvCMXbMejlgkcZZXtTgiVUgIvUq7dWdktCuaJ/xLsAbipHuB+dn2kgvgBFkd61OwjH0
 XMR7DpObxqXb8d6K0BoEBoVS5gb6RsUWqmy7ZcZN7uPoILKrk/sf0N6sR1kRMBV32HlJ
 iZ1EFWrMIgXL0zj6ncvIIrsBf2sui5yImANSbzILbBaroaebX0uC0GzFmgQwzmLAzoPE
 G0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HR4jMOF852+AiagIFivRxvoRxaO2U/uZiy0Wy938QuE=;
 b=FuR4LcCKycVKqZ5Q2HuXBUtGI7AECq6ojhR/PJyjpbf/Aaw1GYaauI18IiT0deWZnC
 TjDhH+2cammMhHn24iH3tZxfBdSidgAwY9IbOeJQguPq51aNk8NMjn+NWvJfyA2ySNav
 SKjg0aIMzKe2dQTqwKgsSS35KXtjfek8hf4bXXAaT/HK/aS5TSIS/FzfjHqv3h7w6Mgc
 hGB/uJPBvqUdrJvDmWnEF3IFEi73hXYteXf/QaBIJi8Ee9LRLCzSISzEI7x+uiMFdjZ4
 YVWD5E9FhjkcXL5zsz2xpd8Ev0wAG/b/rwj2fHydUhosO0EJ234ATOJD+GlJH1UFDd0+
 52fw==
X-Gm-Message-State: AGi0PuaglHzELgkn1tazObi7aHr6OeztbEVLVaWQkaBN0E4lleQTjTx9
 1078odnINdCeYASP8qLZHlFk9Q==
X-Google-Smtp-Source: APiQypL26KAZo56m5lj0oAw9IV9BUioo7BfdmSQawKuxxhsp7Vxln2DjbRA9JwUYOX5BPKteHnc01Q==
X-Received: by 2002:a1c:acc8:: with SMTP id
 v191mr39029728wme.128.1589391135718; 
 Wed, 13 May 2020 10:32:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 1sm37544685wmi.0.2020.05.13.10.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDB711FF7E;
 Wed, 13 May 2020 18:32:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/8] plugins/next (cleanup, cpu_index and lockstep)
Date: Wed, 13 May 2020 18:31:52 +0100
Message-Id: <20200513173200.11830-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

This is the current state of my plugins/next tree. It contains 3 bits
of work. 

First some minor clean-ups from Phillipe to help with his other
re-factoring work.

Next are some fixes for a crash reported by Nikolay on the list. The
root cause was a re-use of cpu_index although I've also tried to clean
up the handling of pthread termination.

Finally there is another iteration of my lockstep plugin which has had
a little more tinkering to better detect divergence between two
QEMU's. It's no Rehoboam but it will hopefully be helpful.

The following patches need review:

 - plugins: new lockstep plugin for debugging TCG changes
 - tests/tcg: add new threadcount test
 - linux-user: properly "unrealize" vCPU object
 - cpus-common: ensure auto-assigned cpu_indexes don't clash
 - MAINTAINERS: update the orphaned cpus-common.c file

Alex Bennée (5):
  MAINTAINERS: update the orphaned cpus-common.c file
  cpus-common: ensure auto-assigned cpu_indexes don't clash
  linux-user: properly "unrealize" vCPU object
  tests/tcg: add new threadcount test
  plugins: new lockstep plugin for debugging TCG changes

Philippe Mathieu-Daudé (3):
  qemu/plugin: Trivial code movement
  qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
  qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument
    const

 include/qemu/plugin.h               |  65 +++---
 include/qemu/qemu-plugin.h          |   2 +-
 cpus-common.c                       |   9 +-
 linux-user/syscall.c                |  19 +-
 plugins/api.c                       |   4 +-
 tests/plugin/lockstep.c             | 345 ++++++++++++++++++++++++++++
 tests/tcg/multiarch/threadcount.c   |  62 +++++
 MAINTAINERS                         |   1 +
 tests/plugin/Makefile               |   1 +
 tests/tcg/Makefile.target           |   2 +-
 tests/tcg/multiarch/Makefile.target |   2 +
 11 files changed, 461 insertions(+), 51 deletions(-)
 create mode 100644 tests/plugin/lockstep.c
 create mode 100644 tests/tcg/multiarch/threadcount.c

-- 
2.20.1



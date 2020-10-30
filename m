Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6528AC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA52F2151B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYwAPcLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYVG-0006gb-OE
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUU-0005pA-T9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYYUS-0002c5-SK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:47:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id l8so3698726wmg.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pM8j+uQaBnEdVDuMOQ5/GF9lY6Ou7utHXU/JGkgWHKw=;
 b=xYwAPcLXo7nHUyHUnOSMiSGXsYReJdK7ciMxYsB3q0xkNIuQl+XajXO75tDO1mrfAf
 p5UORhxojEeqIPCaLRwT1l61lJ8DPStDFHZ60j4D5rM1fgsbR9Va4qh89c1lV06YDi1Z
 3aabvu+NgA9QArxsPU8qLRqtH/A95LnMRzbfL84/zPN8MZzTQQAaan4RWfR629MyCPdB
 uVMJ6Qulh5c5RK+6FzBw77e/tFsc9jIby23qJcs7Aw+BhoCXECejbP+d3YdGvoLXQXJF
 oKg6aJNfWcWwEsVW6aIHl4ReSoxTunuVu8D/phOFyiIAZxQ7DSEYp2EmMV0g8U2cQEUL
 VwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pM8j+uQaBnEdVDuMOQ5/GF9lY6Ou7utHXU/JGkgWHKw=;
 b=LYNKpUceSk/zIkSIv/JYl4SvBsuyAv79ZNIv8atkcfp0wSRQhDtheVB9euuwepa1H3
 JCH0Nmg769RablXO6HJlf84Z4P8VCrswenUUJ5G34h9EePCnMGaCZPvZsOEb4JJGQNgu
 /jawGS4XlDQuiBiWPSdc198sPAW8bfcCGWethjVaTg5yGMMUO8TVT7MrSYSMJKZRr/mr
 ukoAEbmTiuL736itwBhtEWtERO6lDzNXcu6I6XfJyrRtlAjMislm1ZFeddUjd+Vl50X7
 2wTZcpe20QNIGE4UERnpKpAV8SgN/L8pvwSiA4GgBDt1Ew473mNDPkauqE4OmDb92AtB
 AScg==
X-Gm-Message-State: AOAM5300iG573D147jMGqudwYXFIxkq1KjFxgnP8ejv6HC9LHNDGOADf
 glYowF2Mz765oNIBl0rKK4YV8lKSJT3H6w==
X-Google-Smtp-Source: ABdhPJzWL3gDMFk+xQ1jgF1Y1C96iCBCgNezCNQp64fqZVim9OhbKB/NtVafmCdiyK3GCqW2EyQv7Q==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr4187658wmi.133.1604080022858; 
 Fri, 30 Oct 2020 10:47:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 1sm12522655wre.61.2020.10.30.10.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 10:47:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] docs: Fix building with Sphinx 3.2
Date: Fri, 30 Oct 2020 17:46:58 +0000
Message-Id: <20201030174700.7204-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries fixes some issues with building our docs
with Sphinx 3.2:
 * kerneldoc was using the 'c:function' directive for both
   functions and macros, but Sphinx 3.2 wants 'c:macro' for
   macros and complains if the argument to 'c:function' isn't
   parseable as a function declaration
 * qemu-option-trace.rst.inc's use of option:: provokes a
   warning in Sphinx 3.2

We fix the first by making kerneldoc output the right directive
depending on the Sphinx version it's working with, and fix
the second by just dropping our usage of option:: in favour
of a simple definition-list markup.

This does mean our kernel-doc gets another patch that makes
it diverge a little from the kernel's version, but we already
have one of those (commit 152d1967f650f67b7e). I do want to
try to upstream these to the kernel, but that will require
more work I suspect since the kernel makes much more extensive
use of kernel-doc and probably also has other issues when
building with newer Sphinxes. For the moment I would like us
to release QEMU 5.2 with docs that build with all the Sphinxes
we know about.

Tested by building with Sphinx 1.6.1, 2.0, 2.4, 3.0 and 3.2.

thanks
-- PMM

Peter Maydell (2):
  scripts/kerneldoc: For Sphinx 3 use c:macro for macros with arguments
  qemu-option-trace.rst.inc: Don't use option:: markup

 docs/qemu-option-trace.rst.inc |  6 +++---
 scripts/kernel-doc             | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.20.1



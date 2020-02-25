Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF3C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A4321D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahs0et/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A4321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Y1j-0000FX-3F
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyl-0004to-IA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Xyg-00076v-DP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Xyc-00075M-Ch
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:02:10 -0500
Received: by mail-wr1-x436.google.com with SMTP id e8so14193446wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nKtK8/OVH29uRWIRemlt2gsuGtKPQ5MYkxwjfEB5eC8=;
 b=ahs0et/9QeEBsE9tmaXKdtEx6qtJXF/0KgZ84hmbDpje+eN3/2z5EeBbcKZsDkHPcx
 R3iB/zGRPdj+/FhPwbhIgXm2QRuM7MEv6prZA61Z3Zqhh67ijayuXFHa+tIgl1Ts5Yjz
 TTRO8xnFMqcpRkdLkbYGHWTf/S1xrjRxjpCRT4wIbVfQAx/oNPwzENJgSnhSBUu879so
 djKWtHCNeRFglxy34wYROzCNh51XXHLZ8Umd0ypHIiGGPGBDGvmCY+xAalNFFOniiq0k
 OaJrPIJbV4y4e802UBbECfIqW8NULmsBT35BmqzNuzhQzUQEwBhMC6SrXv89GkhX1mSd
 Vm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nKtK8/OVH29uRWIRemlt2gsuGtKPQ5MYkxwjfEB5eC8=;
 b=kwCzCA6T1g2Pwromzwh7plDBMZhqbTIxCJDSx9WUWjJaK1IcUP+jUriCfDTlzTF9Yq
 pw928ifu3sLiJ5/OX838Z642uXV9yIPY1o2vuK3eUbmyTOJILCiD5wycGp609p3MLyPe
 Phr3Ig2mCN+jbqd0kPW+8h1B6iiwx0QQaTWl8lWaAOtWcj4c4c8o4AOKsPinLLu9kscW
 q5ReByoVNx+EqEYS0LVm/A78O8Z3UFtsSTHOlJlx96tEWk3k2MeeW5AD3WXNShyHavml
 hnSap5s8wE0tEIW0HphRzJYbZiMDjgT6R8oQV1Pl+jS2MmJoIF4+TOjzJ4gOZaRU4tGN
 4XHQ==
X-Gm-Message-State: APjAAAX/U3q4EZm1rHD4wfJAPyDywM0OgxIHbIOXo7NMU9749YezpSyj
 McNYrB/tcoUGJuY4K8JsR7bhGElXEqHBDw==
X-Google-Smtp-Source: APXvYqzAERoC0xsP4NIvXZs7tgj9DCA5QtQcIEY1vTOtCm18OqJWBQwZ0bZfQwjKQcA50/9pI7QGGw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr74408602wru.398.1582628527643; 
 Tue, 25 Feb 2020 03:02:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n8sm22483092wrx.42.2020.02.25.03.02.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 03:02:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] docs queue
Date: Tue, 25 Feb 2020 11:02:01 +0000
Message-Id: <20200225110204.30662-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Just the "create the tools manual" patches; I'd like to
get this into master because it'll be a dependency for
some other stuff (even if only textually due to Makefile
changes).

thanks
-- PMM

The following changes since commit c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-02-24 11:38:54 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200225

for you to fetch changes up to a08b4a9fe6cb3c23755db764c9a40510a40a8731:

  docs: Move tools documentation to tools manual (2020-02-25 10:48:06 +0000)

----------------------------------------------------------------
 * create a new 'tools' manual, and move the documentation for
   qemu-img, qemu-nbd, virtfs-proxy-helper, qemu-trace-stap and
   virtiofsd to it

----------------------------------------------------------------
Peter Maydell (3):
      docs: Create new 'tools' manual
      docs: Move qemu-option-trace.rst.inc to docs/
      docs: Move tools documentation to tools manual

 Makefile                                        | 41 +++++++++++++++----------
 docs/index.html.in                              |  1 +
 docs/index.rst                                  |  1 +
 docs/interop/conf.py                            | 12 --------
 docs/interop/index.rst                          |  5 ---
 docs/{interop => }/qemu-option-trace.rst.inc    |  0
 docs/tools/conf.py                              | 33 ++++++++++++++++++++
 docs/tools/index.rst                            | 17 ++++++++++
 docs/{interop => tools}/qemu-img.rst            |  2 +-
 docs/{interop => tools}/qemu-nbd.rst            |  2 +-
 docs/{interop => tools}/qemu-trace-stap.rst     |  0
 docs/{interop => tools}/virtfs-proxy-helper.rst |  0
 docs/{interop => tools}/virtiofsd.rst           |  0
 13 files changed, 78 insertions(+), 36 deletions(-)
 rename docs/{interop => }/qemu-option-trace.rst.inc (100%)
 create mode 100644 docs/tools/conf.py
 create mode 100644 docs/tools/index.rst
 rename docs/{interop => tools}/qemu-img.rst (99%)
 rename docs/{interop => tools}/qemu-nbd.rst (99%)
 rename docs/{interop => tools}/qemu-trace-stap.rst (100%)
 rename docs/{interop => tools}/virtfs-proxy-helper.rst (100%)
 rename docs/{interop => tools}/virtiofsd.rst (100%)


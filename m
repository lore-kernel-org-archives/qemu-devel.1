Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F96820DD4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FobloFup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F96820DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEByU-0007bh-NF
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBwr-0004rE-9y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEBwp-0005ey-76
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so7561009wme.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q8Rhj9JUzG0EgmZ+9C+Ft6vc0SbALOVjYYmjsYdvL/c=;
 b=FobloFuphBzXcOMp18OUwiK2nlxz729qWYUoYizmXhxoOJlkXattcCSkxutXq6Rb+f
 vDDBVPQHrdFLWMQ4g7PK1Vj4eYgT3pRzDK7vhyCTh+ht5hIjLKKQ0rdQGxDNu44UFZs+
 LNJAX3Om/SvzEmngSkKQy67/KWuqlQErVy5gTR7wF6mjFEBZyJ6uBj5SVstW64DR6YXp
 thD73/VvsTJo0J1B62He1yBsRDUZvJSU+ctOdX1etReTKVL4xFInvlhz2ZyHou37+dHX
 N9yV+SYAwEGk0vPse+Hl862vtYitvmTzeCcxm343XP/MA3PQvKKS6RhSOg9X/F1TGg4y
 8r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q8Rhj9JUzG0EgmZ+9C+Ft6vc0SbALOVjYYmjsYdvL/c=;
 b=lutAONRCPS98OtWL3EUxClYpACg3jpacqLlq//271UcxGALX5nj2O9vPsbySis5JyV
 ztmPBlM2hKpO0BoQOexA7q2uY2ma3pHgTzp8UlYKMwq80SdB4FZDlXCvxKHSKYS4GmTH
 XeB9eKIQEOQY6/4jyHXGmgWcMXvwshkQLinSJYjG52L1EQAhY66L7N5TSw9Zi0D3TQ0A
 obA54t9MrcVo6WCS4a1XBX680Hqm85itfW4FSuGg4V9FNX6BgOcA6OJEjxyeOOlmdRYb
 Fi0EktBPSEVsTiTXkY5BdZORiqlclE9qP64Y+HIFPouu8a90qEzpHzTrDkgLfbPzABWl
 nqkA==
X-Gm-Message-State: AOAM5329CGH76iwWVZvwBRg0jHlIX+ECEhs03sYYc630gSZwTp9z9d3D
 +xASI8DkoBWmsjYOx8SiN07cBw==
X-Google-Smtp-Source: ABdhPJw6bjq5SAn6IEhHOnjb+zHdNkhLRPMTKFUyuRut9bCMKjQRHsQR4XQsxbKDqV07Cx9b6meoUA==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr7564272wma.158.1599226809574; 
 Fri, 04 Sep 2020 06:40:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 124sm11666682wmd.31.2020.09.04.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:40:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C21871FF7E;
 Fri,  4 Sep 2020 14:40:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/4] current plugins/next (reorg + hwprofile)
Date: Fri,  4 Sep 2020 14:40:03 +0100
Message-Id: <20200904134007.4175-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my plugin tree. The biggest change is a
re-organisation moving a bunch of the more complex plugins into
contrib and just concentrating on the basic plugins for running the
tests. In the process I've updated the docs to describe what they do
in more detail. Finally the hwprofile plugin is a new plugin for
tracking HW access patterns.

Alex Bennée (4):
  hw/virtio/pci: include vdev name in registered PCI sections
  plugins: add API to return a name for a IO device
  plugins: move the more involved plugins to contrib
  plugins: new hwprofile plugin

 docs/devel/tcg-plugins.rst                    | 176 ++++++++++
 configure                                     |   2 +
 Makefile                                      |  11 +
 include/qemu/qemu-plugin.h                    |   6 +
 {tests/plugin => contrib/plugins}/hotblocks.c |   0
 {tests/plugin => contrib/plugins}/hotpages.c  |   0
 {tests/plugin => contrib/plugins}/howvec.c    |   0
 contrib/plugins/hwprofile.c                   | 305 ++++++++++++++++++
 {tests/plugin => contrib/plugins}/lockstep.c  |   0
 hw/virtio/virtio-pci.c                        |  22 +-
 plugins/api.c                                 |  20 ++
 MAINTAINERS                                   |   1 +
 contrib/plugins/Makefile                      |  43 +++
 tests/Makefile.include                        |   2 +-
 tests/plugin/meson.build                      |   4 +-
 tests/tcg/Makefile.target                     |   3 +-
 16 files changed, 582 insertions(+), 13 deletions(-)
 rename {tests/plugin => contrib/plugins}/hotblocks.c (100%)
 rename {tests/plugin => contrib/plugins}/hotpages.c (100%)
 rename {tests/plugin => contrib/plugins}/howvec.c (100%)
 create mode 100644 contrib/plugins/hwprofile.c
 rename {tests/plugin => contrib/plugins}/lockstep.c (100%)
 create mode 100644 contrib/plugins/Makefile

-- 
2.20.1



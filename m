Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A1020772
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlSCMVEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A1020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg98u-00059Z-Iv
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97V-0003VQ-LW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97U-0007cG-Hz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id r7so3929900wro.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wUc7KzosaqpYazILM0pVzftN3xHyA5K9bdQHHd2wtss=;
 b=QlSCMVEtFsr+u1dBHYE6jSLXWXDNOSH+0v5QSldew6xZu45A8obXk1oyhCIxzNBTfu
 BySoZ9iOK1VhcWDkwf06p7pvsIAz5Rhk/8HZNaHimwdGme4ZfTxO9L+AQMlB/ZgCW3wd
 1LrhhbB1JzNiuLjv2pHPwpeCxHiaGfTENwqIAfZqnwOJ7MK6o4DEQjKDVyQmZLq5HE1y
 jkMr77JcUx5yHjkBU4hu2XPHFc/R2Ncr8+H1D8QcUGaZWhkOuiIIILGlVCvHlvyIA1gx
 5Vj7KJaFvn+8UP2f2tbgAFZDPZoYAftwm6qIwSvIymkYkTw4yYXOCT+jD4gD2gJFtrdk
 zcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wUc7KzosaqpYazILM0pVzftN3xHyA5K9bdQHHd2wtss=;
 b=nTbyr602FI9K6iKxSKK1EyS10aHA9Rj02rdtzW9WhPm5iSrG3rBZNzDdVL0oj6tNuF
 qcdTn+33Dh8620vou3/7cyBknLZcs8NDHpQhLFzHJ5RhLgooDaQhbr14isdhvI7/vo7b
 uhr9oYOS8oi5qntRoVFUHSs/PBtdZ1vFXTvhbL10Xu9/8gmpeme6bslcqRE3ALQ2zYPm
 FwSPStGahjSOzyGSlwEK1j3HrK+wPqB6TexnSfv6vsHtPK4YZp6fQc6Vt1XFXQGZIlf4
 5gn6w6V9ydHNtyWBc6y3ufei+e21ixBbejevtToHkKm/rskQu6x1uu8n1zXzgMOSBXm2
 tiNQ==
X-Gm-Message-State: AOAM531b5m5hhRcyvFKRjDrMlYysIfdtyLMg+StGZV9SoAadJcFoFapD
 jS4GXY0LhxQC/BlCwI9HrJGlHw==
X-Google-Smtp-Source: ABdhPJwSvU9P45e3oA9SDCgaRxzs+8NHkRi3uFb0EdpIw8H/z3xjEwRAMcwnSzUx3VNHzBzO006Obw==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr26213521wrs.127.1591112786626; 
 Tue, 02 Jun 2020 08:46:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm4216207wrm.70.2020.06.02.08.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A5401FF7E;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/9] plugins/next (bug fixes, hwprofile, lockstep)
Date: Tue,  2 Jun 2020 16:46:15 +0100
Message-Id: <20200602154624.4460-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my plugins tree. It has a few minor fixes
to the headers as well as a bug I found in the cputlb which was
triggered when a pci_config write via io_writex causes the memory
regions to be reset and as a result a flush and potential re-sizing of
the TLB entries. This meant when a plugin looked up details of the
address later there was no TLB entry with the information which got
flagged as an error on the plugins part.

I found the bug while I was looking around trying to figure out what
was going wrong with my virtio code so I implemented a "hwprofile"
plugin to track exactly what devices where seeing writes. There are
some minor associated tweaks to the virtio PCI code to better name the
MemoryRegions and a new helper API which exposes the region names to
the plugin.

The lockstep plugin is essentially unchanged from previous postings
but hasn't seen any review. I'm minded to include it in the next PR
anyway just so it isn't lost next time I need to do an A-B comparison
on something that only diverges in behaviour several million
instructions into an execution.

The following need review:

 - .travis.yml: allow failure for unreliable hosts
 - plugins: new hwprofile plugin
 - plugins: add API to return a name for a IO device
 - hw/virtio/pci: include vdev name in registered PCI sections
 - cputlb: ensure we re-fill the TLB if it has reset
 - tests/plugin: correctly honour io_count
 - plugins: new lockstep plugin for debugging TCG changes

Alex Bennée (7):
  plugins: new lockstep plugin for debugging TCG changes
  tests/plugin: correctly honour io_count
  cputlb: ensure we re-fill the TLB if it has reset
  hw/virtio/pci: include vdev name in registered PCI sections
  plugins: add API to return a name for a IO device
  plugins: new hwprofile plugin
  .travis.yml: allow failure for unreliable hosts

Emilio G. Cota (1):
  qemu-plugin.h: add missing include <stddef.h> to define size_t

Philippe Mathieu-Daudé (1):
  scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special header

 include/qemu/qemu-plugin.h |   6 +
 accel/tcg/cputlb.c         |  14 ++
 hw/virtio/virtio-pci.c     |  21 ++-
 plugins/api.c              |  18 ++
 tests/plugin/hwprofile.c   | 248 +++++++++++++++++++++++++++
 tests/plugin/lockstep.c    | 340 +++++++++++++++++++++++++++++++++++++
 tests/plugin/mem.c         |   2 +-
 .travis.yml                |   5 +
 scripts/clean-includes     |   1 +
 tests/plugin/Makefile      |   2 +
 tests/tcg/Makefile.target  |   2 +-
 11 files changed, 649 insertions(+), 10 deletions(-)
 create mode 100644 tests/plugin/hwprofile.c
 create mode 100644 tests/plugin/lockstep.c

-- 
2.20.1



Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83CC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3112A24A5F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foxXm7oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3112A24A5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqVy-0008NH-WC
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:12:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTz-0006qM-08
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqTw-0003ka-Sg
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqTv-0003gt-UD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id w9so375119wmd.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ZT3/vpwPJ71Zz9LJvEB6C1GfZYvSozg8uRtzVi+3yRk=;
	b=foxXm7oLT+uxKHwEfxkO0t6aMpWDe+x+ZNBlQOGlrfwlx2PQHOwW5e8i+JDfNWgj30
	GutisKJOhpYc7KBmKFpR9/jO9UAsnX3ViuAVNi4yi22DxlkFU9CuKfw6uRmHfyFk7MJE
	6KvyUdj8KEm3J6Jcy4Sup1YOGM11+Y8CVyhIXi34hxrA+Fnkj83xVtrhWuMWpqTEjhVX
	pipzr3wiGuPTtYOM/5PEYK4M6RlQwWADA6gmXiJHqXLKjDqIuQQH1D1rd+7L++p4nUGa
	eQ8CmX4kOvmPhXFI2EZ+kri/dKnsljLTDhZlRytckxp6Hamj/vvCZJI/9EntQ3moC0hE
	S9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=ZT3/vpwPJ71Zz9LJvEB6C1GfZYvSozg8uRtzVi+3yRk=;
	b=gLQExv4iKW6inMqVSZT9hCaA3DpVPU3cA/Aer9d7DB/9/4ScFWXnOXyMjk/OM0yAP3
	/+iJV8voCI/qNRbw5ya0nQMhaVMQUuE5EnIilxhdOr+6y08EDwSRGTwgBMnb1ISYPVjf
	huo+KIjlgUCyn1VfRMXNlD01UsIzQAt8PMMJX/2YaIqWh0kQWQ30bycaUv/Wxq8LiTPT
	Li3vWPILrPvB9O6LeBLxtbruHmXtgPsrGV4AIxHp5WINZ2r1bFfVUd7PNdfuyD1k1A0I
	WS03VwJb95X+SUymVC55vRr+NpbQvjsGJ4rgVqYchboRXKUPoQ1+0qozMJr5V0Zzy0Vz
	vzfw==
X-Gm-Message-State: APjAAAWmtR59Eiecz7BnVlQXhyBAx16sypFKFWjgwPq0u1AZiRLGqtN5
	A81Quc1IyFw9S13d4pjNzN/gsA4M
X-Google-Smtp-Source: APXvYqxvtNrEdvx8VArT/p1yPyBcFfibMl5SD10DtAj9oHvmXAWNOOL8Y9SlYb3Mq+JSLNxl6yzBjQ==
X-Received: by 2002:a1c:c011:: with SMTP id q17mr3232787wmf.105.1559581845672; 
	Mon, 03 Jun 2019 10:10:45 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:19 +0200
Message-Id: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 00/24] Misc patches for 2019-06-03
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ad88e4252f09c2956b99c90de39e95bab2e8e7af:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-1-2019' into staging (2019-06-03 10:25:12 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to c87759ce876a7a0b17c2bf4f0b964bd51f0ee871:

  q35: Revert to kernel irqchip (2019-06-03 14:03:03 +0200)

----------------------------------------------------------------
* Revert q35 to kernel irqchip (Alex)
* edu device fixes (Li Qiang)
* cleanups (Marc-André, Peter)
* Improvements to -accel help
* Better support for IA32_MISC_ENABLE MSR (Wanpeng)
* I2C test conversion to qgraph (Paolo)

----------------------------------------------------------------
Alex Williamson (1):
      q35: Revert to kernel irqchip

Li Qiang (3):
      edu: mmio: allow 64-bit access
      edu: mmio: allow 64-bit access in read dispatch
      edu: uses uint64_t in dma operation

Marc-André Lureau (1):
      configure: remove tpm_passthrough & tpm_emulator

Paolo Bonzini (15):
      test-thread-pool: be more reliable
      qgraph: allow extra_device_opts on contains nodes
      qgraph: fix qos_node_contains with options
      libqos: move common i2c code to libqos
      libqos: fix omap-i2c receiving more than 4 bytes
      pca9552-test: do not rely on state across tests
      imx25-pdk: create ds1338 for qtest inside the test
      libqos: split I2CAdapter initialization and allocation
      libqos: convert I2C to qgraph
      libqos: add ARM n800 machine object
      libqos: add ARM imx25-pdk machine object
      tests: convert OMAP i2c tests to qgraph
      tests: convert ds1338-test to qtest
      libqos: i2c: move address into QI2CDevice
      ci: store Patchew configuration in the tree

Peter Xu (2):
      checkpatch: allow SPDX-License-Identifier
      memory: Remove memory_region_get_dirty()

Wainer dos Santos Moschetta (1):
      vl: make -accel help to list enabled accelerators only

Wanpeng Li (1):
      i386: Enable IA32_MISC_ENABLE MWAIT bit when exposing mwait/monitor

 .patchew.yml                         | 302 +++++++++++++++++++++++++++++++++++
 configure                            |  10 --
 hw/arm/imx25_pdk.c                   |   9 --
 hw/core/machine.c                    |   3 +
 hw/i386/pc.c                         |   3 +
 hw/i386/pc_q35.c                     |  16 +-
 hw/misc/edu.c                        |  32 ++--
 include/exec/memory.h                |  17 --
 include/hw/boards.h                  |   3 +
 include/hw/i386/pc.h                 |   3 +
 memory.c                             |   8 -
 scripts/checkpatch.pl                |   3 +-
 target/i386/cpu.c                    |   3 +
 target/i386/cpu.h                    |   1 +
 tests/Makefile.include               |  18 +--
 tests/ds1338-test.c                  |  45 ++----
 tests/libqos/arm-imx25-pdk-machine.c |  92 +++++++++++
 tests/libqos/arm-n800-machine.c      |  92 +++++++++++
 tests/libqos/i2c-imx.c               |  40 +++--
 tests/libqos/i2c-omap.c              |  70 +++++---
 tests/libqos/i2c.c                   |  74 ++++++++-
 tests/libqos/i2c.h                   |  63 ++++++--
 tests/libqos/qgraph.c                |  12 +-
 tests/libqos/qgraph.h                |  15 +-
 tests/pca9552-test.c                 |  91 ++++-------
 tests/qos-test.c                     |  17 +-
 tests/test-thread-pool.c             |  32 ++--
 tests/tmp105-test.c                  | 112 ++++---------
 vl.c                                 |  18 ++-
 29 files changed, 889 insertions(+), 315 deletions(-)
 create mode 100644 .patchew.yml
 create mode 100644 tests/libqos/arm-imx25-pdk-machine.c
 create mode 100644 tests/libqos/arm-n800-machine.c
-- 
1.8.3.1



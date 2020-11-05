Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D8C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBA42065E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjvK7wvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBA42065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajUp-0008Gf-EL
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQi-000421-0Z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQV-0004ov-Po
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id c9so2444216wml.5
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aCdNQuOu1zzxY5qOLd2Gw49Fa90dfcQ1gien40zDfHs=;
 b=gjvK7wvTUU9vVQv+LXzG71pIUtrHqjDoQpNuE7UFyrJHPETi4LZjHIGnzFXw4bYe6o
 0HvkdBC/GUywxz6ImrHgAQL96SIoTiZp3ObKGrF+DEzuPeQjPpGAh7coDwGpt3uM5BjS
 dKXtfFLtzzo6jJxf7A0L97TrGuElh9QHtZNDzTvmsJIJzbGEMTazoyt9R/ChuVDCqTgg
 r10AfXChdGXeVK55rlsRt2OY4GSce7NAJq6+duZ3BDJvlxVYjptOHrZ1UijwhdoPrd9w
 Wn2wdL3YnHAnYJu27heOH1sIXbZHB4Z8dncIs4v+PXryZ0spP286RwhWUJEzNPqwwUen
 kf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aCdNQuOu1zzxY5qOLd2Gw49Fa90dfcQ1gien40zDfHs=;
 b=lKvUL1HBfWF4sYcvHO1Q/X2Q13aj5HSx2t+MLtANRAKpKVxYRV3gXcE8ow54tkxlpR
 BLw23w6Cdcb6qAXwvD5Ciml17Sh4Io7AXrvgCOSxHRHR4VHoEho/vPP/QJoYtY04bDBR
 IPNPYFTS+HDYhaIjm2FTN4F0o4o7W/OMvKQf/xuDkbCQXspa9uMvDsk21k7th+OhPOHe
 URjYoQTLGqrQgO0pZJ712TB+DWgIjRxCeYQC+sh2x8gWEsN/UCahJnlCZ8vSf/ZnbgE8
 zf10KBUTfNgfywuc6oIQd38p3GNjJn+Xy+SZlqKESqYjlpN6A9VjzXFoyQoj8/BtuYXF
 6ALQ==
X-Gm-Message-State: AOAM531yidT106k8LJIz1QjNkMnEaw91TPaS98qPN8VAlK9J5ixWA7BE
 GPskX6Eg+ZeY17BSm6oQcYA41g==
X-Google-Smtp-Source: ABdhPJxuA9N8eBQQson9ZpqEdYO6mKqC3BGQpy9RnGSD+wUDEjaLSJaFKpC1Ay3sYbnPZzbGBGxvHA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr4191518wmh.26.1604598716137; 
 Thu, 05 Nov 2020 09:51:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm3336423wmj.3.2020.11.05.09.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:51:54 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8C5E1FF7E;
 Thu,  5 Nov 2020 17:51:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/15] Xen guest-loader and arm64 build fixes/enhancements
Date: Thu,  5 Nov 2020 17:51:38 +0000
Message-Id: <20201105175153.30489-1-alex.bennee@linaro.org>
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

There are two parts to this series, broadly related because they are
all to do with Xen. The first half is a re-spin of the guest-loader
patches from a few weeks ago. The only changes are to move the
generic-loader documentation into the manual and then add some words
about the guest-loader.

The second half of the series is an attempt to fix and then clean up
the handling of Xen enabled builds. Recent changes to the build system
broke the ability to build qemu-system-i386 on arm64 hosts with Xen
support enabled. The actual fix for that:

  meson.build: fix building of Xen support for aarch64

should probably be rolled into the current release as it fixes a
regression. The rest can wait until the tree re-opens. The patches
broadly try to:

  - clean-up detection and reporting
  - be more explicit about linking stubs for accel
  - add an explicit CONFIG_XEN_HVM for x86

and finally allow you to build a qemu-system-aarch64 with Xen support.

This is my first major foray into tweaking meson builds and it seems
to occasionally come unstuck and requires a distclean and re-configure
to un-wedge itself. The following need review:

  - meson.build: build a Xen aware qemu-aarch64-system
  - xen: only build HVM support under CONFIG_XEN_HVM
  - accel/stubs: drop unused cpu.h include
  - stubs/xen-hw-stub: drop xenstore_store_pv_console_info stub
  - include/hw/xen.h: drop superfluous struct
  - meson.build: clean-up summary reporting of XEN and it's features
  - meson.build: introduce CONFIG_XEN_HVM flag
  - meson.build: fix building of Xen support for aarch64
  - accel/meson: you only need accelerator stubs for softmmu builds
  - docs: add some documentation for the guest-loader
  - docs: move generic-loader documentation into the main manual


Alex Bennée (15):
  hw/board: promote fdt from ARM VirtMachineState to MachineState
  hw/riscv: migrate fdt field to generic MachineState
  device_tree: add qemu_fdt_setprop_string_array helper
  hw/core: implement a guest-loader to support static hypervisor guests
  docs: move generic-loader documentation into the main manual
  docs: add some documentation for the guest-loader
  accel/meson: you only need accelerator stubs for softmmu builds
  meson.build: fix building of Xen support for aarch64
  meson.build: introduce CONFIG_XEN_HVM flag
  meson.build: clean-up summary reporting of XEN and it's features
  include/hw/xen.h: drop superfluous struct
  stubs/xen-hw-stub: drop xenstore_store_pv_console_info stub
  accel/stubs: drop unused cpu.h include
  xen: only build HVM support under CONFIG_XEN_HVM
  meson.build: build a Xen aware qemu-aarch64-system

 docs/generic-loader.txt        |  92 ----------
 docs/system/generic-loader.rst | 117 ++++++++++++
 docs/system/guest-loader.rst   |  54 ++++++
 docs/system/index.rst          |   2 +
 meson.build                    |  24 ++-
 hw/core/guest-loader.h         |  34 ++++
 include/hw/arm/virt.h          |   1 -
 include/hw/boards.h            |   1 +
 include/hw/riscv/virt.h        |   1 -
 include/hw/xen/xen.h           |   2 +-
 include/sysemu/device_tree.h   |  17 ++
 include/sysemu/xen-mapcache.h  |   2 +-
 include/sysemu/xen.h           |   9 +-
 accel/stubs/hax-stub.c         |   1 -
 accel/stubs/xen-all-stub.c     |  11 ++
 accel/stubs/xen-stub.c         |   2 -
 hw/arm/virt.c                  | 322 +++++++++++++++++----------------
 hw/core/guest-loader.c         | 140 ++++++++++++++
 hw/riscv/virt.c                |  20 +-
 softmmu/device_tree.c          |  26 +++
 stubs/xen-hw-stub.c            |   4 -
 accel/Kconfig                  |   3 +
 accel/meson.build              |   4 +-
 accel/stubs/meson.build        |  13 +-
 hw/core/meson.build            |   2 +
 hw/i386/xen/meson.build        |   2 +-
 26 files changed, 627 insertions(+), 279 deletions(-)
 delete mode 100644 docs/generic-loader.txt
 create mode 100644 docs/system/generic-loader.rst
 create mode 100644 docs/system/guest-loader.rst
 create mode 100644 hw/core/guest-loader.h
 create mode 100644 accel/stubs/xen-all-stub.c
 create mode 100644 hw/core/guest-loader.c

-- 
2.20.1



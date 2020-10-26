Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964B4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E367322400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgVsf6wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E367322400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzSW-0007X0-OQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOo-0002PR-KR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOl-0006ZT-DS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h28I8XlaAusrISsoc5ViqK5BtVxZulQPI31/JqrxM/Q=;
 b=OgVsf6wLuIgiWNfmTlTG9LMXJoxHfqQABKgdMAq5yFgM0AK2xk8fm5OlDOosV6ODgiU+PT
 rxGNRup6D1OvaM7hi/1y5e4HBI7Wq00sBheh2nij12/dLmtb1vd9W7+99YmALkZMhfA0MN
 DggWE0OH1nSKle7sMwfQBb7dl4v7pHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ENbA6xnrOoiC56gngQievg-1; Mon, 26 Oct 2020 06:06:37 -0400
X-MC-Unique: ENbA6xnrOoiC56gngQievg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0905C1007B00;
 Mon, 26 Oct 2020 10:06:36 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D57DC8B849;
 Mon, 26 Oct 2020 10:06:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/31] qtests and gitlab-CI/acceptance patches
Date: Mon, 26 Oct 2020 11:06:01 +0100
Message-Id: <20201026100632.212530-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:

  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-10-26

for you to fetch changes up to 28bbe20ce281659e317b807f34f568bde6d99760:

  tests/acceptance: Use .ppm extention for Portable PixMap files (2020-10-26 09:54:16 +0100)

----------------------------------------------------------------
* qtest fixes (e.g. memory leaks)
* Fix for Xen dummy cpu loop (which happened due to qtest accel rework)
* Introduction of the generic device fuzzer
* Run more check-acceptance tests in the gitlab-CI
----------------------------------------------------------------

Alexander Bulekov (17):
      memory: Add FlatView foreach function
      fuzz: Add generic virtual-device fuzzer
      fuzz: Add PCI features to the generic fuzzer
      fuzz: Add DMA support to the generic-fuzzer
      fuzz: Declare DMA Read callback function
      fuzz: Add fuzzer callbacks to DMA-read functions
      fuzz: Add support for custom crossover functions
      fuzz: add a DISABLE_PCI op to generic-fuzzer
      fuzz: add a crossover function to generic-fuzzer
      scripts/oss-fuzz: Add script to reorder a generic-fuzzer trace
      scripts/oss-fuzz: Add crash trace minimization script
      fuzz: Add instructions for using generic-fuzz
      fuzz: add an "opaque" to the FuzzTarget struct
      fuzz: add generic-fuzz configs for oss-fuzz
      fuzz: register predefined generic-fuzz configs
      scripts/oss-fuzz: use hardlinks instead of copying
      scripts/oss-fuzz: ignore the generic-fuzz target

Chen Qun (1):
      tests/migration: fix memleak in wait_command/wait_command_fd

Havard Skinnemoen (1):
      tests/qtest: Make npcm7xx_timer-test conditional on CONFIG_NPCM7XX

Jason Andryuk (3):
      accel: Remove _WIN32 ifdef from qtest-cpus.c
      accel: move qtest CpusAccel functions to a common location
      accel: Add xen CpusAccel using dummy-cpus

Maxim Levitsky (2):
      libqtest: fix the order of buffered events
      libqtest: fix memory leak in the qtest_qmp_event_ref

Philippe Mathieu-Daudé (2):
      tests/acceptance: Remove unused import
      tests/acceptance: Use .ppm extention for Portable PixMap files

Thomas Huth (5):
      tests/qtest/libqtest: Fix detection of architecture for binaries without path
      tests/acceptance/ppc_prep_40p: Fix the URL to the NetBSD-4.0 archive
      test/acceptance: Remove the CONTINUOUS_INTEGRATION tags
      tests/acceptance: Enable AVOCADO_ALLOW_UNTRUSTED_CODE in the gitlab-CI
      test/docker/dockerfiles: Add missing packages for acceptance tests

 .gitlab-ci.yml                                 |   1 +
 accel/{qtest/qtest-cpus.c => dummy-cpus.c}     |  27 +-
 accel/meson.build                              |   8 +
 accel/qtest/meson.build                        |   1 -
 accel/qtest/qtest-cpus.h                       |  17 -
 accel/qtest/qtest.c                            |   5 +-
 accel/xen/xen-all.c                            |   8 +
 docs/devel/fuzzing.txt                         |  39 +
 include/exec/memory.h                          |  21 +
 include/exec/memory_ldst_cached.h.inc          |   3 +
 include/sysemu/cpus.h                          |   3 +
 memory_ldst.c.inc                              |   4 +
 scripts/oss-fuzz/build.sh                      |  14 +-
 scripts/oss-fuzz/minimize_qtest_trace.py       | 157 ++++
 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py | 103 +++
 softmmu/memory.c                               |  27 +
 softmmu/physmem.c                              |   2 +
 tests/acceptance/machine_m68k_nextcube.py      |   7 +-
 tests/acceptance/ppc_prep_40p.py               |   4 +-
 tests/docker/dockerfiles/centos8.docker        |   1 +
 tests/docker/dockerfiles/debian-amd64.docker   |   3 +
 tests/docker/dockerfiles/fedora.docker         |   1 +
 tests/docker/dockerfiles/ubuntu2004.docker     |   1 +
 tests/qtest/fuzz/fuzz.c                        |  13 +
 tests/qtest/fuzz/fuzz.h                        |  28 +
 tests/qtest/fuzz/generic_fuzz.c                | 954 +++++++++++++++++++++++++
 tests/qtest/fuzz/generic_fuzz_configs.h        | 121 ++++
 tests/qtest/fuzz/meson.build                   |   1 +
 tests/qtest/libqtest.c                         |  22 +-
 tests/qtest/meson.build                        |   3 +-
 tests/qtest/migration-helpers.c                |  16 +-
 31 files changed, 1550 insertions(+), 65 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
 delete mode 100644 accel/qtest/qtest-cpus.h
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
 create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
 create mode 100644 tests/qtest/fuzz/generic_fuzz.c
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h



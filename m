Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC6C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0276320739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qa/WQrc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0276320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKJi-0004Z2-VU
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIV-0002vJ-OV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIS-00061M-Cd
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XRRFdIMpXxSyI66/2is5rHYmKRRFgdPD8wC42nhiKBQ=;
 b=Qa/WQrc6PeolWfcgWLPDrjoSQr9iZbRoDeC9R+MtSX/uBdXicrHaceQEXG6TrcpwYLkLdl
 DruJy2a15vzwhzVlwAWusNeZtd6jii4ibf1+Rx84slBECzwmGfuRaCEcLKPdRfiqMxm62L
 vpZlHsTbsflYvxax/CutdsTLL0r2z4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-hBYbPqvaNpGgCbigldHvZg-1; Wed, 04 Nov 2020 10:01:55 -0500
X-MC-Unique: hBYbPqvaNpGgCbigldHvZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58576408E
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:01:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 783DE100750B
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:01:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] Misc patches for QEMU 5.2-rc1
Date: Wed,  4 Nov 2020 10:01:33 -0500
Message-Id: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 83851c7c60c90e9fb6a23ff48076387a77bc33cd:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-10-27-v3-tag' into staging (2020-11-03 12:47:58 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 46fe962264f91946ca75d23667015d9ba081d6ef:

  qtest: escape device name in device-introspect-test (2020-11-04 07:29:56 -0500)

----------------------------------------------------------------
Doc and bug fixes

----------------------------------------------------------------
AlexChen (1):
      tests/qtest: Fix potential NULL pointer dereference in qos_build_main_args()

Alexander Bulekov (5):
      scripts/oss-fuzz: rename bin/qemu-fuzz-i386
      qtest: add a reproducer for LP#1878642
      fuzz: fix writing DMA patterns
      fuzz: check the MR in the DMA callback
      fuzz: fuzz offsets within pio/mmio regions

Bruce Rogers (1):
      configure: fix gio_libs reference

Marc Hartmayer (1):
      meson: vhost-user-gpu/virtiofsd: use absolute path

Paolo Bonzini (8):
      cutils: replace strdup with g_strdup
      docs: expand sourceset documentation
      meson: use b_staticpic=false for meson >=0.56.0
      meson: fix warning for bad sphinx-build
      semihosting: fix order of initialization functions
      qapi, qemu-options: make all parsing visitors parse boolean options the same
      ivshmem-test: do not use short-form boolean option
      qtest: escape device name in device-introspect-test

Peter Maydell (2):
      tests/qtest/libqtest.c: Check for setsockopt() failure
      tests/qtest/libqos/ahci.c: Avoid NULL dereference in ahci_exec()

Philippe Mathieu-Daudé (2):
      exec: Remove dead code (CID 1432876)
      hw/isa/lpc_ich9: Ignore reserved/invalid SCI IRQ

 configure                            |   8 +-
 contrib/vhost-user-gpu/meson.build   |   2 +-
 docs/devel/build-system.rst          | 158 +++++++++++++++++++++++------------
 docs/devel/kconfig.rst               |   2 +
 docs/meson.build                     |   3 +-
 hw/isa/lpc_ich9.c                    |  14 +++-
 include/hw/i386/ich9.h               |   1 +
 include/qapi/util.h                  |   2 +
 include/qemu/cutils.h                |   1 +
 meson.build                          |   4 +-
 qapi/opts-visitor.c                  |  14 +---
 qapi/qapi-util.c                     |  23 +++++
 qapi/qobject-input-visitor.c         |   6 +-
 qapi/string-input-visitor.c          |  17 +---
 scripts/oss-fuzz/build.sh            |   4 +-
 softmmu/physmem.c                    |  10 +--
 softmmu/vl.c                         |   4 +-
 tests/qemu-iotests/051.out           |   6 +-
 tests/qemu-iotests/051.pc.out        |   6 +-
 tests/qemu-iotests/133.out           |   8 +-
 tests/qemu-iotests/137.out           |   4 +-
 tests/qtest/device-introspect-test.c |  10 ++-
 tests/qtest/fuzz-test.c              |  15 ++++
 tests/qtest/fuzz/generic_fuzz.c      |  44 +++++-----
 tests/qtest/fuzz/qos_fuzz.c          |   3 +-
 tests/qtest/ivshmem-test.c           |   2 +-
 tests/qtest/libqos/ahci.c            |   5 +-
 tests/qtest/libqtest.c               |   9 +-
 tools/virtiofsd/meson.build          |   2 +-
 util/cutils.c                        |   2 +-
 util/qemu-option.c                   |  20 +----
 31 files changed, 239 insertions(+), 170 deletions(-)
-- 
2.26.2



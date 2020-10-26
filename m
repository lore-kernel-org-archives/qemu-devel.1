Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20082242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz/nuu/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20082242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX36n-0002vP-Mh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2us-0005rx-4B
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uo-0001mM-8b
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QNFG76g5YqT18tTGZ2Q6f9ulawRvNuC4N0n3jEsX0Kk=;
 b=Oz/nuu/K2HoHbSrKPkawQq2zaIgqhN9ciFnx8dS4S08EpLXxe/ujs5l9eB7SYgfAXgdVEM
 xh8xqH8iETVVA/hCdBuXDoLQvIpnyQSraMjRg6KKQc2g9Ext+a+i+Z0s22HtiQTrVC40+4
 W/hRrIoIAQr1sd2QoaQhBgUC6plYB9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-zqWBr5zTPGGqsxm6Y0lZXw-1; Mon, 26 Oct 2020 09:51:32 -0400
X-MC-Unique: zqWBr5zTPGGqsxm6Y0lZXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B2DEC1A3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF8C6EF78
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Build system changes and misc fixes for QEMU 5.2 soft
 freeze
Date: Mon, 26 Oct 2020 09:51:14 -0400
Message-Id: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:

  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 8b0e484c8bf82e07bb0439bff04e248c63cdc86a:

  machine: move SMP initialization from vl.c (2020-10-26 07:08:40 -0400)

----------------------------------------------------------------
* fix --disable-tcg builds (Claudio)
* Fixes for macOS --enable-modules build and OpenBSD curses/iconv detection (myself)
* Start preparing for meson 0.56 (myself)
* Move directory configuration to meson (myself)
* Start untangling qemu_init (myself)
* Windows fixes (Sunil)
* Remove -no-kbm (Thomas)

----------------------------------------------------------------
Claudio Fontana (2):
      qtest: unbreak non-TCG builds in bios-tables-test
      replay: do not build if TCG is not available

Luc Michel (1):
      hw/core/qdev-clock: add a reference on aliased clocks

Paolo Bonzini (11):
      build: fix macOS --enable-modules build
      meson: rewrite curses/iconv test
      do not use colons in test names
      Makefile: separate meson rerun from the rest of the ninja invocation
      configure: allow configuring localedir
      configure: move directory options from config-host.mak to meson
      configure: remove unused variable from config-host.mak
      configure: move install_blobs from configure to meson
      machine: remove deprecated -machine enforce-config-section option
      machine: move UP defaults to class_base_init
      machine: move SMP initialization from vl.c

Sunil Muthuswamy (2):
      WHPX: Fix WHPX build break
      win32: boot broken when bind & data dir are the same

Thomas Huth (1):
      Remove deprecated -no-kvm option

 .cirrus.yml                        |   2 +-
 Makefile                           |  44 ++++++---
 block/meson.build                  |   3 +-
 configure                          |  64 +++----------
 contrib/vhost-user-gpu/meson.build |   2 +-
 docs/system/deprecated.rst         |  23 ++---
 hw/core/machine.c                  |  36 +++-----
 hw/core/qdev-clock.c               |   8 ++
 include/hw/boards.h                |   1 -
 meson.build                        | 178 ++++++++++++++++++++++---------------
 meson_options.txt                  |   4 +
 migration/migration.c              |  10 ---
 net/meson.build                    |   3 +-
 pc-bios/descriptors/meson.build    |   4 +-
 pc-bios/meson.build                |  15 ++--
 qemu-options.hx                    |  11 ---
 replay/meson.build                 |   4 +-
 replay/stubs-system.c              |  96 ++++++++++++++++++++
 scripts/undefsym.py                |  11 ++-
 softmmu/vl.c                       |  16 ----
 stubs/meson.build                  |   4 +-
 stubs/replay-tools.c               |  83 +++++++++++++++++
 stubs/replay-user.c                |   9 --
 stubs/replay.c                     |  78 ----------------
 tests/fp/meson.build               |   6 +-
 tests/ptimer-test-stubs.c          |   5 --
 tests/qtest/bios-tables-test.c     |  10 +++
 tests/qtest/meson.build            |   2 +-
 tests/qtest/qmp-cmd-test.c         |   3 +
 tools/virtiofsd/meson.build        |   2 +-
 ui/icons/meson.build               |   6 +-
 ui/meson.build                     |   2 +-
 util/cutils.c                      |   2 +-
 version.texi.in                    |   2 -
 34 files changed, 416 insertions(+), 333 deletions(-)
 create mode 100644 replay/stubs-system.c
 create mode 100644 stubs/replay-tools.c
 delete mode 100644 stubs/replay-user.c
 delete mode 100644 version.texi.in
-- 
2.26.2



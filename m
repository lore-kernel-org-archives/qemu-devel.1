Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7037C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9FA2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkT4kofW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9FA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoeB-0008Hm-Nl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDoP0-0004Zr-HN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:31:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDoOy-0008H6-FM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9PSwcJp2QBAo6B4P53WE3bBPUMy4X2R0mIpnI+CHDvU=;
 b=LkT4kofWQOqrHm9MRnTHh/0/Rnxky4Q6OgJ9Hxqs3taQwi1RVB9lXZcvJgvHvGXvIttpx6
 VY0RWPnwEgamsKczGd8ERnoXrzVySKRC0dVuEOE8tQvsKsMUMgK8WQ34nPcUiT11v4LGHC
 6Pi+o9b2dCk21FHJE+3CnnYLwfq8Abg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-A0_gOC8TMbWyDl7BnC9ecA-1; Thu, 03 Sep 2020 08:31:37 -0400
X-MC-Unique: A0_gOC8TMbWyDl7BnC9ecA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE3A801AB6;
 Thu,  3 Sep 2020 12:31:36 +0000 (UTC)
Received: from thuth.com (ovpn-114-10.ams2.redhat.com [10.36.114.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF1C160C0F;
 Thu,  3 Sep 2020 12:31:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 00/15] Cirrus-CI improvements, and other CI-related fixes,
 m68k
Date: Thu,  3 Sep 2020 14:31:29 +0200
Message-Id: <20200903123130.451577-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter!

The following changes since commit ed215cec0fcaeaece064b0fdf37fe3bceb06d76c:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-09-02 15:26:38 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-03

for you to fetch changes up to 0a796d63bcd4e840bb94fbe894ae2ad77b9ee2f7:

  gitlab-ci.yml: Set artifacts expiration time (2020-09-03 12:47:33 +0200)

----------------------------------------------------------------
* Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
* Two build system fixes to fix some failures the CI
* One m68k QOMification patch
* Some trivial qtest patches
* Some small improvements for the Gitlab CI
----------------------------------------------------------------

v3: Added the UNLINK fix to Gerd's patch

Gerd Hoffmann (1):
      meson: fix keymaps without qemu-keymap

Markus Armbruster (1):
      libqtest: Rename qmp_assert_error_class() to qmp_expect_error_and_unref()

Philippe Mathieu-Daudé (3):
      tests/qtest/ahci: Improve error handling (NEGATIVE_RETURNS)
      tests/qtest/tpm: Declare input buffers const and static
      tests/qtest/ipmi-kcs: Fix assert side-effect

Thomas Huth (10):
      configure: Fix atomic64 test for --enable-werror on macOS
      cirrus.yml: Compile FreeBSD with -Werror
      cirrus.yml: Compile macOS with -Werror
      cirrus.yml: Update the macOS jobs to Catalina
      cirrus.yml: Split FreeBSD job into two parts
      configure: Add system = 'linux' for meson when cross-compiling
      hw/m68k: QOMify the mcf5206 system integration module
      gitlab/travis: Rework the disabled features tests
      gitlab-ci.yml: Run check-qtest and check-unit at the end of the fuzzer job
      gitlab-ci.yml: Set artifacts expiration time

 .cirrus.yml                   | 43 ++++++++++++++++++++++++++++++++----------
 .gitlab-ci.yml                | 36 ++++++++++++++++++++++++++---------
 .travis.yml                   |  6 ------
 configure                     | 22 +++++++++++++++++-----
 hw/m68k/an5206.c              | 14 ++++++++++++--
 hw/m68k/mcf5206.c             | 44 ++++++++++++++++++++++++++++++++++---------
 include/hw/m68k/mcf.h         |  3 +--
 pc-bios/keymaps/meson.build   | 28 ++++++++++++++++++---------
 tests/qtest/ahci-test.c       |  1 +
 tests/qtest/drive_del-test.c  |  2 +-
 tests/qtest/ipmi-kcs-test.c   |  3 ++-
 tests/qtest/libqos/libqtest.h |  4 ++--
 tests/qtest/libqtest.c        |  2 +-
 tests/qtest/qmp-cmd-test.c    | 16 ++++++++--------
 tests/qtest/qmp-test.c        | 32 +++++++++++++++----------------
 tests/qtest/tpm-tests.c       |  4 ++--
 tests/qtest/tpm-util.c        | 10 +++++-----
 tests/test-qga.c              |  2 +-
 18 files changed, 183 insertions(+), 89 deletions(-)



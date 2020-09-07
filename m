Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D30C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938E92137B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFJoccOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938E92137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG0a-0005QL-GU
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzm-0003nY-W3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzk-0007tN-DT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4f0+Cu9DY/KKMUVJWSoedX897xJh99e7iu9S7Vp+6oM=;
 b=NFJoccOKkKHAfh9cQtmHKX5HQvsFNDggVowUHA939A5IfnQ5rXLzSMT89LAWU0jlUUo04v
 e3ETNZhPBxuwTJ7GWoE8NIOpgtHHFsou9Xj9JPyxTM6BNoE6Vivs1CKuscRRGYScXkX1Eu
 eCPh0t4CPgs4ndSUe8mjYut7AXPS+jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-1hxOD-KeP56A1SxJWjk8tg-1; Mon, 07 Sep 2020 08:11:31 -0400
X-MC-Unique: 1hxOD-KeP56A1SxJWjk8tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48A72802B56;
 Mon,  7 Sep 2020 12:11:30 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCFF5C26B;
 Mon,  7 Sep 2020 12:11:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/14] Gitlab-CI improvements and related fixes
Date: Mon,  7 Sep 2020 14:11:13 +0200
Message-Id: <20200907121127.136243-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-07

for you to fetch changes up to 88e74b6122bb40852b1c98befd47a572f0c06930:

  target/microblaze: Collected fixes for env->iflags (2020-09-07 12:34:17 +0200)

----------------------------------------------------------------
* Fixes for cross-compiling with MinGW / compiling with MSYS2
* Enable cross-compiler builds in the Gitlab CI
* Improvements / fixes for the crypto tests in the Gitlab CI
* Fix for the "make check-acceptance" microblaze failure
  (required to get the Gitlab CI green again)
----------------------------------------------------------------

Alex Bennée (1):
      tests/docker: add python3-setuptools the docker images

Daniel P. Berrangé (2):
      crypto: fix build with gcrypt enabled
      gitlab: expand test coverage for crypto builds

Paolo Bonzini (1):
      tests/qtest: do not list ahci-test twice

Richard Henderson (1):
      target/microblaze: Collected fixes for env->iflags

Thomas Huth (6):
      tests/Makefile: test-image-locking needs CONFIG_POSIX
      dockerfiles/debian-win64-cross: Download WHPX MinGW headers
      configure: Allow automatic WHPX detection
      stubs: Move qemu_timer_notify_cb() and remove qemu_notify_event() stub
      stubs: Move qemu_fd_register stub to util/main-loop.c
      gitlab-ci: Add cross-compiling build tests

Yonggang Luo (3):
      tests: handling signal on win32 properly
      tests: fixes test-vmstate.c compile error on msys2
      tests: Fixes building test-util-filemonitor.c on msys2/mingw

 .gitlab-ci.d/crossbuilds.yml                       | 113 +++++++++++++++++++++
 .gitlab-ci.yml                                     |  69 +++++++++++++
 MAINTAINERS                                        |   1 +
 configure                                          |   3 +
 crypto/meson.build                                 |  42 ++++++--
 meson.build                                        |   5 +
 stubs/cpu-get-icount.c                             |   5 -
 stubs/fd-register.c                                |   6 --
 stubs/meson.build                                  |   3 +-
 stubs/notify-event.c                               |   6 --
 stubs/qemu-timer-notify-cb.c                       |   8 ++
 target/microblaze/cpu.c                            |  11 ++
 target/microblaze/cpu.h                            |   3 +-
 target/microblaze/helper.c                         |  17 ++--
 target/microblaze/translate.c                      |   4 +-
 tests/Makefile.include                             |   2 +
 tests/docker/dockerfiles/centos7.docker            |   2 +
 tests/docker/dockerfiles/centos8.docker            |   1 +
 tests/docker/dockerfiles/debian-win64-cross.docker |   9 +-
 tests/docker/dockerfiles/debian10.docker           |   1 +
 tests/docker/dockerfiles/debian9.docker            |   1 +
 tests/qtest/meson.build                            |   1 -
 tests/test-replication.c                           |   4 +
 tests/test-util-filemonitor.c                      |   4 +-
 tests/test-vmstate.c                               |   4 +-
 util/main-loop.c                                   |   4 +
 26 files changed, 285 insertions(+), 44 deletions(-)
 create mode 100644 .gitlab-ci.d/crossbuilds.yml
 delete mode 100644 stubs/fd-register.c
 delete mode 100644 stubs/notify-event.c
 create mode 100644 stubs/qemu-timer-notify-cb.c



Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD75C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A9B2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJDyVVHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHzl-0006h7-Eq
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHy2-00059i-Cs
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHy0-00065n-A0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g74PJIqcXw/QuziEtYCwV4kbvnrzpXD7Y/2qN1kyeEM=;
 b=KJDyVVHgtefpG2oU24uWoAOaI7A9GmjM/vgfXlT4r/M5oXpPcVMLHafs4Mvmc1792dnsIx
 ljVQFVD6zlexDDNsHudLHZVe8lBm5bd/KZWhMzpAfAO8pEBdo382rjSiZltDY2mQb62wx1
 T6W6rLG3w+CDyX/fdsXmlkfkLzQMDGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-SqzMvCvONR-jbRbaOFsE0Q-1; Tue, 13 Oct 2020 06:55:35 -0400
X-MC-Unique: SqzMvCvONR-jbRbaOFsE0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99BA7107464F;
 Tue, 13 Oct 2020 10:55:34 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE5296EF45;
 Tue, 13 Oct 2020 10:55:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/23] qtests, gitlab-CI and misc patches
Date: Tue, 13 Oct 2020 12:55:04 +0200
Message-Id: <20201013105527.20088-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,
 
the following changes since commit a0bdf866873467271eff9a92f179ab0f77d735cb:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201012a' into staging (2020-10-12 13:12:04 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-10-13

for you to fetch changes up to ea8bf1e514d2f442dd1a008794eb1563e2ee1c48:

  scripts/ci/gitlab-pipeline-status: wait for pipeline creation (2020-10-13 12:48:17 +0200)

----------------------------------------------------------------
* qtest improvements (test for crash found with the fuzzer, increase
  downtime in migration test, less verbose output when running w/o KVM)
* Improve handling of acceptance tests in the Gitlab-CI
* Run checkpatch.pl in the Gitlab-CI
* Improve the gitlab-pipeline-status script
* Misc patches (mark 'moxie' as deprecated, remove stale .gitignore files, ...)
----------------------------------------------------------------

Alexander Bulekov (1):
      gitlab-ci.yml: Only run one test-case per fuzzer

Ani Sinha (1):
      Add a comment in bios-tables-test.c to clarify the reason behind approach

Cleber Rosa (10):
      Acceptance tests: bump pycdlib version for easier installation
      Acceptance tests: do not show canceled test logs on GitLab CI
      Acceptance tests: show test report on GitLab CI
      scripts/ci/gitlab-pipeline-status: make branch name configurable
      scripts/ci/gitlab-pipeline-status: improve message regarding timeout
      scripts/ci/gitlab-pipeline-status: give early feedback on running pipelines
      scripts/ci/gitlab-pipeline-status: refactor parser creation
      scripts/ci/gitlab-pipeline-status: handle keyboard interrupts
      scripts/ci/gitlab-pipeline-status: use more descriptive exceptions
      scripts/ci/gitlab-pipeline-status: wait for pipeline creation

Daniel P. Berrangé (3):
      gitlab: add a CI job for running checkpatch.pl
      gitlab: add a CI job to validate the DCO sign off
      gitlab: assign python helper files to GitLab maintainers section

Dr. David Alan Gilbert (1):
      tests/migration: Allow longer timeouts

Li Qiang (1):
      qtest: add fuzz test case

Philippe Mathieu-Daudé (1):
      tests/qtest: Replace magic value by NANOSECONDS_PER_SECOND definition

Thomas Huth (4):
      softmmu/vl: Be less verbose about missing KVM when running the qtests
      MAINTAINERS: Ignore bios-tables-test in the qtest section
      Remove superfluous .gitignore files
      docs/system/deprecated: Mark the 'moxie' CPU as deprecated

Yonggang Luo (1):
      configure: fixes indent of $meson setup

 .gitlab-ci.d/check-dco.py         | 94 +++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/check-patch.py       | 48 ++++++++++++++++++++
 .gitlab-ci.yml                    | 31 ++++++++++++-
 MAINTAINERS                       |  3 +-
 configure                         | 14 +++---
 docs/system/deprecated.rst        |  8 ++++
 pc-bios/keymaps/.gitignore        |  1 -
 plugins/.gitignore                |  2 -
 scripts/ci/gitlab-pipeline-status | 63 ++++++++++++++++++--------
 softmmu/vl.c                      | 19 +++++---
 tests/.gitignore                  | 32 -------------
 tests/fp/.gitignore               |  2 -
 tests/migration/.gitignore        |  2 -
 tests/multiboot/.gitignore        |  3 --
 tests/qemu-iotests/.gitignore     |  9 ----
 tests/qtest/bios-tables-test.c    |  7 ++-
 tests/qtest/fuzz-test.c           | 49 ++++++++++++++++++++
 tests/qtest/meson.build           |  1 +
 tests/qtest/migration-test.c      | 21 ++++-----
 tests/qtest/rtc-test.c            |  2 +-
 tests/requirements.txt            |  2 +-
 tests/tcg/.gitignore              |  5 ---
 tests/uefi-test-tools/.gitignore  |  3 --
 23 files changed, 313 insertions(+), 108 deletions(-)
 create mode 100755 .gitlab-ci.d/check-dco.py
 create mode 100755 .gitlab-ci.d/check-patch.py
 delete mode 100644 pc-bios/keymaps/.gitignore
 delete mode 100644 plugins/.gitignore
 delete mode 100644 tests/.gitignore
 delete mode 100644 tests/fp/.gitignore
 delete mode 100644 tests/migration/.gitignore
 delete mode 100644 tests/multiboot/.gitignore
 delete mode 100644 tests/qemu-iotests/.gitignore
 create mode 100644 tests/qtest/fuzz-test.c
 delete mode 100644 tests/tcg/.gitignore
 delete mode 100644 tests/uefi-test-tools/.gitignore



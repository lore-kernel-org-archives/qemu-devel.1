Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30AFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED93206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICArAoZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED93206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLa3-0004jE-0Y
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYU-0003OS-RM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYR-0004IR-4J
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594020521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yvqgp8xuzmALfl/SBy4is/51fsokPWpQliEvgr4DM9s=;
 b=ICArAoZYMrzIxmNgYmp48D/XITS4Y9v7SBPvWz9Rz/llqKPQAqt8UveqH1d+lGES5+Bokx
 Jlido2eNb4wcXPwOJbKntDGg35nNUQwjYuw7CD2Z8LiCLVJwOzcvy1mgunU68X3SOCUpSO
 18+34KmN+bN8G8uyWsTi/vffHo+Fpdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-69pbZmT2N5CVhv7lsylxig-1; Mon, 06 Jul 2020 03:28:39 -0400
X-MC-Unique: 69pbZmT2N5CVhv7lsylxig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0A2800C64;
 Mon,  6 Jul 2020 07:28:38 +0000 (UTC)
Received: from thuth.com (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BEC15D9CC;
 Mon,  6 Jul 2020 07:28:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] qtest and misc patches
Date: Mon,  6 Jul 2020 09:28:29 +0200
Message-Id: <20200706072835.23582-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-06

for you to fetch changes up to 70f909b4eec6fa92a9e33a8d23e185cad7abd533:

  tests/acceptance: Add a test for the sun4u sparc64 machine (2020-07-06 07:37:02 +0200)

----------------------------------------------------------------
* Fuzzer fixes from Alexander
* Clean-up patches for qtests, configure and mcf5206
* Sparc64 sun4u acceptance test
----------------------------------------------------------------

Alexander Bulekov (2):
      fuzz: fix broken qtest check at rcu_disable_atfork
      fuzz: do not use POSIX shm for coverage bitmap

Thomas Huth (4):
      tests/qtest: Unify the test for the xenfv and xenpv machines
      configure / util: Auto-detect the availability of openpty()
      hw/m68k/mcf5206: Replace remaining hw_error()s by qemu_log_mask()
      tests/acceptance: Add a test for the sun4u sparc64 machine

 MAINTAINERS                               |  1 +
 configure                                 |  9 ++++++-
 hw/m68k/mcf5206.c                         | 39 +++++++++++++++++++++---------
 softmmu/vl.c                              | 12 +---------
 tests/acceptance/machine_sparc64_sun4u.py | 36 ++++++++++++++++++++++++++++
 tests/qtest/device-introspect-test.c      |  5 ----
 tests/qtest/fuzz/fork_fuzz.c              | 40 ++++++++++---------------------
 tests/qtest/fuzz/fuzz.c                   |  3 +++
 tests/qtest/libqtest.c                    |  4 ++++
 tests/qtest/qom-test.c                    |  5 ----
 tests/qtest/test-hmp.c                    |  5 ----
 util/qemu-openpty.c                       |  5 +++-
 12 files changed, 98 insertions(+), 66 deletions(-)
 create mode 100644 tests/acceptance/machine_sparc64_sun4u.py



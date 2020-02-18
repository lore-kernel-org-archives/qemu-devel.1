Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9C720659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9C720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yqi-00030T-JO
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j3ylf-0006V5-2U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1j3yld-0003cz-MQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:56657 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1j3yld-0003NT-Fx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:02:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 945861A2176;
 Tue, 18 Feb 2020 10:01:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0DCDD1A1FF6;
 Tue, 18 Feb 2020 10:00:48 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] tests/tcg/multiarch: Add tests for implemented real
Date: Tue, 18 Feb 2020 10:00:40 +0100
Message-Id: <1582016442-1677-1-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series covers tests for implemented rtc and alsa timer ioctls. The names
of ioctls that are covered by these tests can be found in patch descriptions.
The functionalities of each ioctl that is tested can be found in patches that
implement them.

Some of the features that are accessible through these ioctls are not supported
on all test host pc's. These tests were written so that the implemented ioctls
can be properly tested on pc's that support all of their features.

Both rtc and alsa timer test folders have separate files for manually written
and remotely obtained tests. Tests that were obtained remotely run multiple ioctl
tests at once, while the manually written tests can be used to run both individual
and multiple ioctl tests based on the command specified when running the test.

v2:

    * introduced a single manual test file for all ioctls instead of individual 
      test files for each ioctl

v3:

    * fixed alsa timer ioctl manual test so that it can run ioctl tests individually
      by specifying their name when running the test program

Filip Bozuta (2):
  tests/tcg/multiarch: Add tests for implemented rtc ioctls
  tests/tcg/multiarch: Add tests for implemented alsa sound timer ioctls

 .../manual-test/alsa-timer-ioctl-manual-test.c     | 294 +++++++++++++++++
 .../alsa-timer-ioctl-tests/remote-test/timer.c     | 158 +++++++++
 .../manual-test/rtc-ioctl-manual-test.c            | 352 +++++++++++++++++++++
 .../rtc-ioctl-tests/remote-test/rtc-test.c         | 226 +++++++++++++
 4 files changed, 1030 insertions(+)
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/manual-test/alsa-timer-ioctl-manual-test.c
 create mode 100644 tests/tcg/multiarch/alsa-timer-ioctl-tests/remote-test/timer.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/manual-test/rtc-ioctl-manual-test.c
 create mode 100644 tests/tcg/multiarch/rtc-ioctl-tests/remote-test/rtc-test.c

-- 
2.7.4



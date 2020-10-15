Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B24D2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="btXOOb0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B24D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTASm-00064g-7F
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <97a64ec211d051439b654950ed3f7cffc47d489b@lizzy.crudebyte.com>)
 id 1kTARG-0004k3-TQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:05:31 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <97a64ec211d051439b654950ed3f7cffc47d489b@lizzy.crudebyte.com>)
 id 1kTARF-0007oS-1x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=fY3kGr2meHazKYLfP/jYQjp9AdCN5o4fm/ITXShNbfI=; b=btXOO
 b0/N1lEZ77CBFbdLgL6zkFG/6j9NTbk7biUXBOL1HQyuNGTgwmK/8FB5h+wnIslCAAEfhNlM6i3tS
 e9JMYyUc5FxIBoIs+eZvXLK/dvXMk8kZSuNQvNwoFeZ3zlYnaxfNyO2eePtCm9l8jClrSwLzAe1gF
 RHfXToKnRf3tMqqrLBjVqO5qsEVEy7E7pKvlcXa05r31mEeWUiL5n7llrGP8sjjgLFNeQ9LMlj1Ql
 XaapjTMkuYq/WVeEpgFb4T74cUrnLG8qjiGpazvkPB8hLqYQDZd8vqpReeiYJa0zgC4vQkkhBhn1C
 KPIQ6YXKIS4czxYtG3YrGVClaWo1Q==;
Message-Id: <cover.1602771296.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 15 Oct 2020 16:14:56 +0200
Subject: [PULL 0/5] 9p queue 2020-10-15
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=97a64ec211d051439b654950ed3f7cffc47d489b@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 17:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201015

for you to fetch changes up to 97a64ec211d051439b654950ed3f7cffc47d489b:

  tests/9pfs: add local Tmkdir test (2020-10-15 16:11:17 +0200)

----------------------------------------------------------------
9pfs: add tests using local fs driver

The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
fileystem driver, which is a very simple and purely simulated (in RAM only)
filesystem. There are issues though where the 'synth' fs driver is not
sufficient. For example the following two bugs need test cases running the
9pfs 'local' fs driver:

https://bugs.launchpad.net/qemu/+bug/1336794
https://bugs.launchpad.net/qemu/+bug/1877384

This patch set for that reason introduces 9pfs test cases using the 9pfs
'local' filesystem driver along to the already existing tests on 'synth'.

----------------------------------------------------------------
Christian Schoenebeck (5):
      tests/9pfs: change qtest name prefix to synth
      tests/9pfs: introduce local tests
      tests/9pfs: wipe local 9pfs test directory
      tests/9pfs: add virtio_9p_test_path()
      tests/9pfs: add local Tmkdir test

 tests/qtest/libqos/virtio-9p.c | 100 +++++++++++++++++++++
 tests/qtest/libqos/virtio-9p.h |  10 +++
 tests/qtest/virtio-9p-test.c   | 197 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 286 insertions(+), 21 deletions(-)


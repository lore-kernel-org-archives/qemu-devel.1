Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C59C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3678A20708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Pn23/OGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3678A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnKr-0004IB-Db
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b@lizzy.crudebyte.com>)
 id 1kTn8Q-0005at-01
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:24:38 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b@lizzy.crudebyte.com>)
 id 1kTn8O-00061X-1Q
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=HR23O/4xAUapO13uh7b2roDYpuzB1pX6ruOo3j2cLHM=; b=Pn23/
 OGfS/FTIAHv//zptVya1tiU46iqOkYPvWvgErO/s6d/uc+k6K65CavK5C339zgvDTru5hGsi5/+L/
 Bs4e5E0Zc5inxcc8Bqf2Yjs6zGw19IJQsnZYrdqzoJ25afLF+w9Y1Pjxo9gP8f2gXuMPoulcH3U+D
 9LbGXw0U3Q3RrqRnDaaA2x2F8IliTUGbuoyhtzmFSidLO5gPbqmlWjmdU3IpKQviTu6jHkciTV1cN
 LnlueS2BcEFoC35ojB+26QdMWjVAgmpWKWaXFn18NaLvmpkwIE0VthbJElfueNkm51dgVWyQiQke7
 7/7hq2EAUWZZHUVU0D9oNLWRu0ixg==;
Message-Id: <cover.1602943547.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 17 Oct 2020 16:05:47 +0200
Subject: [PULL v2 0/5] 9p queue (previous 2020-10-15)
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 10:23:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e12ce85b2c79d83a340953291912875c30b3af06:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-10-16 22:46:28 +0100)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201017

for you to fetch changes up to fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b:

  tests/9pfs: add local Tmkdir test (2020-10-17 15:58:39 +0200)

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


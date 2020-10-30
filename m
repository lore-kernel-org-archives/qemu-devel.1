Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44274C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728D820724
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bhLeLXCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728D820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVg9-0002M4-AP
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com>)
 id 1kYVe6-0000Tj-V1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:44:52 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com>)
 id 1kYVe4-00033o-28
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=soKAdxEUl44HPNXcdEE/GOtcPss5ahvax6Cp3SYa/pk=; b=bhLeL
 XCByjtNOu/MEWg4PoX6SR+4Xdou7PT3rYCzSntG2ykJKhdtAkIM2tLJiIpBAc1AV5i1Wx7rYDn7G+
 omoSfnKcV6VETe2gepZCKfA+A2wEoyN7NNhkmKguylyfRUUIyOmLnCJsbPHQwQ9aEqWIlNG3SzF5F
 VRXEd99gOyvp/YVcCro5LI/zs+FD5VrS22hk+2KJo3+Xo/RNfuTYJnq2hme5dy1ojjtmGlamyOoms
 O8dTn6Nt33yylVnS84D9V72fwckksakdzr4Q8Z//l6F+3POp75pnT3n8yzwpKFlbSQjSoVZiv4+uk
 7tYynjsSoDnXYMIYq/2WJlEcH20dw==;
Message-Id: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 30 Oct 2020 15:19:28 +0100
Subject: [PULL v2 00/16] 9p queue (previous 2020-10-23)
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=69067bf1436aab1c84b98b8461e81a9633ec7872@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

The following changes since commit a19d4bc452532a9402f90b77d2aaaed9fe1df046:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201028' into staging (2020-10-29 14:30:58 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201030

for you to fetch changes up to 69067bf1436aab1c84b98b8461e81a9633ec7872:

  tests/9pfs: add local Tunlinkat hard link test (2020-10-30 14:59:39 +0100)

----------------------------------------------------------------
9pfs: more tests using local fs driver

Only 9pfs test case changes this time:

* Fix occasional test failures with parallel tests.

* Fix coverity error in test code.

* Avoid error when auto removing test directory if disappeared for
  some reason.

* Refactor: Rename functions to make top-level test functions fs_*()
  easily distinguishable from utility test functions do_*().

* Refactor: Drop unnecessary function arguments in utility test
  functions.

* More test cases using the 9pfs 'local' filesystem driver backend,
  namely for the following 9p requests: Tunlinkat, Tlcreate, Tsymlink
  and Tlink.

----------------------------------------------------------------
Christian Schoenebeck (10):
      tests/9pfs: fix test dir for parallel tests
      tests/9pfs: fix coverity error in create_local_test_dir()
      tests/9pfs: simplify do_mkdir()
      tests/9pfs: add local Tunlinkat directory test
      tests/9pfs: add local Tlcreate test
      tests/9pfs: add local Tunlinkat file test
      tests/9pfs: add local Tsymlink test
      tests/9pfs: add local Tunlinkat symlink test
      tests/9pfs: add local Tlink test
      tests/9pfs: add local Tunlinkat hard link test

Greg Kurz (6):
      tests/9pfs: Force removing of local 9pfs test directory
      tests/9pfs: Factor out do_version() helper
      tests/9pfs: Set alloc in fs_create_dir()
      tests/9pfs: Factor out do_attach() helper
      tests/9pfs: Turn fs_readdir_split() into a helper
      tests/9pfs: Turn fs_mkdir() into a helper

 tests/qtest/libqos/virtio-9p.c |  34 ++-
 tests/qtest/virtio-9p-test.c   | 467 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 457 insertions(+), 44 deletions(-)


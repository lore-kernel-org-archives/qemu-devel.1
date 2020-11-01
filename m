Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E72C4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B1622249
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 15:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UgmQjxx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B1622249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZFEM-0004Uq-L8
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 10:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7746f42d8f557593898d3d9d8e57c46e872dfb4f@lizzy.crudebyte.com>)
 id 1kZFCT-0003Ey-Dt
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:23:22 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:43213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7746f42d8f557593898d3d9d8e57c46e872dfb4f@lizzy.crudebyte.com>)
 id 1kZFCR-0006jX-9j
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 10:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=E89zUvvTnsPZotS/rjepCXsjA5Lb0J07hcIWq2SYElU=; b=UgmQj
 xx5ET5PX/Ib7m9lsVLGpM+5Djeuw1h098u19v8nLOhNQhPMK6tL+AzCeHJKctdNbtPEWDNVef41uM
 QextxMRJfqLWNAU2nBwoxnEUB3rBLrOQx1SMmbgcATr9R454bwSofeN9zFm6zrK6kCBy5QB9JJM//
 HwwCmb5v546k2GiO3qGJUdbp2DBPCU/VOgqxOSgWil2/usKBh15NI8H9JKr99WtZP3/7yHIT7iWhq
 cPbxkk5cqRvw8gGLrhx9uoYYGGgiuFyAnf6pRYpJi0tWnnfd3jNvLUlC0US8KBT7rzIc6v6bnOFEi
 CnvxRDy7Sy/dqwl32NyTg0zdV0x0g==;
Message-Id: <cover.1604243521.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 1 Nov 2020 16:12:01 +0100
Subject: [PATCH v3 0/2] 9pfs: test suite fixes
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=7746f42d8f557593898d3d9d8e57c46e872dfb4f@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 10:22:17
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

Fixes test failures with the 9pfs 'local' tests as discussed with latest
9P PR. See the discussion of that PR v2 (Fri, Oct 30th) for details.

In conjunction with Peter Xu's two migration patches (fixing occasional
lockups of migration tests) overall situation appears to be smooth now:
https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/

v2->v3:

  - Make the two functions for creating and removing the 9pfs test directory
    public [NEW patch 1].

  - Place the constructor and destructor functions in virtio-9p-test.c, not
    in virtio-9p.c, because the latter location would cause the constructor
    to be executed whenever libqos is loaded, which would break other,
    completely unrelated tests suites that just link to libqos [patch 2].

  - Previous patch 2 (coverity fix) is already queued, no changes, hence
    omitted in this v3.

v1->v2:

  - Added Greg's tested-by tag [patch 1].

  - Log an info-level message if mkdir() failed [patch 2].

  - Update commit log message about coverity being the reporter and
    details of the coverity report [patch 2].

Christian Schoenebeck (2):
  tests/9pfs: make create/remove test dir public
  tests/9pfs: fix test dir for parallel tests

 tests/qtest/libqos/virtio-9p.c | 20 ++++++++++----------
 tests/qtest/libqos/virtio-9p.h | 10 ++++++++++
 tests/qtest/virtio-9p-test.c   | 12 ++++++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.20.1



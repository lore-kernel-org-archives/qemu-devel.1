Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4353DC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646BC2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BiW1izqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646BC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPyw-0006xe-3n
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b111895492f8fb79bcca1c3e9586c0615f46cc97@lizzy.crudebyte.com>)
 id 1kYPyI-0006Ck-78
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:41:18 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b111895492f8fb79bcca1c3e9586c0615f46cc97@lizzy.crudebyte.com>)
 id 1kYPyG-0003td-IJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=2Di0ZkcguuNFEQk2O0yhBNVqRcIe/tlVGUFcAmSPFHM=; b=BiW1i
 zqfnpzHZvoYP3CAnDw4pAwkamrhK6anCoqx33EFzDoLJeDH1dSp0qbIuEk+WsRjBj3JPnIFYLttpG
 v/3q0xNOv86AH5wLh8js1YHb/xkcMy3U2psOvWaoqUV5wx6RAaWngsIt9+dLgtVZRM51pB7Ut8FSG
 7S6J8N1hm1Xr6XNfqJFkcoYFV+K1a34D6AGEEG1idIwTp3nsVOi52UaBknUDx/tNPtRQA5sHtM4ad
 aZD/PxJDRmn1cM2tneCEnCPUT6Cmy/4nnmArlrjtfKCvCDEgLRt0zokJoNg+aEe9G9xQ0BKznxEvk
 nXJ0x/f+V4/lT5e0awTqDaAYOzxuw==;
Message-Id: <cover.1604046404.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 30 Oct 2020 09:26:44 +0100
Subject: [PATCH 0/2] 9pfs: test suite fixes
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b111895492f8fb79bcca1c3e9586c0615f46cc97@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 04:40:14
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

Fixes two bugs with the 9pfs 'local' tests as discussed with latest 9P PR
(2020-10-23). See the discussion of that PR for details.

Christian Schoenebeck (2):
  tests/9pfs: fix test dir for parallel tests
  tests/9pfs: fix coverity error in create_local_test_dir()

 tests/qtest/libqos/virtio-9p.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

-- 
2.20.1



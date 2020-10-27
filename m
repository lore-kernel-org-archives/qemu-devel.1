Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A81C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3876B21D41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH55hGEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3876B21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQj3-0007Rg-5f
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQh3-0005yi-3z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQh1-0007Zd-CN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dg9VESWWOaz58adcMO+rzi4KbnTGo4B9y8i/7/tuReU=;
 b=YH55hGEdCFJoz40ZV5DskbFNBRaOnkG/7r43o/Z+fRLwP8uJmlTb47181rW9rV+EH+nCAq
 KpmHsPFYGbO3e5itjBklJkRDASn/ZYXzyzzJDijyWHTrLuqafbPn9tFJPxc5s8eJRY1OLN
 Ck0RW5nNiDmS5x+3Qw649okm5WU9svw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-hFsruuyjOya656A2F4RukQ-1; Tue, 27 Oct 2020 11:15:19 -0400
X-MC-Unique: hFsruuyjOya656A2F4RukQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68C71EC1A5;
 Tue, 27 Oct 2020 15:15:18 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62BE45578B;
 Tue, 27 Oct 2020 15:15:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/5] Block layer patches
Date: Tue, 27 Oct 2020 16:15:10 +0100
Message-Id: <20201027151515.213565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d55450df995d6223486db11c66491cbf6c131523:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201026a' into staging (2020-10-27 10:25:42 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1a6d3bd229d429879a85a9105fb84cae049d083c:

  block: End quiescent sections when a BDS is deleted (2020-10-27 15:26:20 +0100)

----------------------------------------------------------------
Block layer patches:

- qcow2: Skip copy-on-write when allocating a zero cluster
- qemu-img: add support for rate limit in qemu-img convert/commit
- Fix deadlock when deleting a block node during drain_all

----------------------------------------------------------------
Alberto Garcia (2):
      qcow2: Report BDRV_BLOCK_ZERO more accurately in bdrv_co_block_status()
      qcow2: Skip copy-on-write when allocating a zero cluster

Greg Kurz (1):
      block: End quiescent sections when a BDS is deleted

Zhengui Li (2):
      qemu-img: add support for rate limit in qemu-img commit
      qemu-img: add support for rate limit in qemu-img convert

 docs/tools/qemu-img.rst | 10 ++++++++--
 include/block/block.h   |  8 ++++++++
 block.c                 |  9 +++++++++
 block/io.c              | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 block/qcow2.c           | 35 +++++++++++++++++++----------------
 qemu-img.c              | 38 +++++++++++++++++++++++++++++++++++---
 tests/test-bdrv-drain.c |  1 +
 qemu-img-cmds.hx        |  8 ++++----
 8 files changed, 128 insertions(+), 29 deletions(-)



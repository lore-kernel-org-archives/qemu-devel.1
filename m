Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1926C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51787208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/G6+Y2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51787208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNdN-0001N0-3H
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNbg-00072P-EC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNba-0006aq-7n
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593790076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=94WCJCZAsGwCW/ii3m5fkBjWBjzzryveqkiLVxHkisE=;
 b=G/G6+Y2RVkjp37DiaT91mg80xeLhLe2vXaL5MpdPQQ9jvT8YVuQ4/0HSz8CaroqjbjRv8s
 +OAYVzWTty75aijv8NGY6+hKRegeCI75gKcfJ8KQtE2Wo6Em01lk4Uz4e5sj4X4pcgAwWK
 9cObNUR8Kb8wlAzpz8N8vk9bz8UFuz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-UYO5l0IRPpu0XjPBM7iuXw-1; Fri, 03 Jul 2020 11:27:54 -0400
X-MC-Unique: UYO5l0IRPpu0XjPBM7iuXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F55107ACCA;
 Fri,  3 Jul 2020 15:27:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-207.ams2.redhat.com
 [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBA7F2DE73;
 Fri,  3 Jul 2020 15:27:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, zhukeqian1@huawei.com,
 stefanha@redhat.com
Subject: [PULL 0/5] migration queue
Date: Fri,  3 Jul 2020 16:27:43 +0100
Message-Id: <20200703152748.277255-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 6651620b92bc08cde07cb500e9a43dba7bd9b2b7:

  Merge remote-tracking branch 'remotes/kraxel/tags/seabios-20200702-pull-request' into staging (2020-07-03 09:55:35 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200703a

for you to fetch changes up to fb6135807fcab4670d69663ac88e88e124348ffd:

  migration: Count new_dirty instead of real_dirty (2020-07-03 16:23:05 +0100)

----------------------------------------------------------------
virtiofsd+migration pull 2020-07-03

A couple of small migration fixes, and some capability
rework for virtiofsd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (4):
      virtiofsd: Terminate capability list
      virtiofsd: Check capability calls
      virtiofsd: Allow addition or removal of capabilities
      migration: postcopy take proper error return

Keqian Zhu (1):
      migration: Count new_dirty instead of real_dirty

 docs/tools/virtiofsd.rst         |  5 +++
 include/exec/ram_addr.h          |  5 +--
 migration/postcopy-ram.c         |  2 +-
 migration/ram.c                  |  8 +++--
 tools/virtiofsd/helper.c         |  2 ++
 tools/virtiofsd/passthrough_ll.c | 71 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 80 insertions(+), 13 deletions(-)



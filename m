Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A42C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209A5206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQbsu347"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpPN-0003QF-Bv
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMD-000764-PI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMB-0000N5-QP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZTd3XKFl5v4EM1k6M3C71l146fMa3v2q8feq9ZXBNaE=;
 b=RQbsu3471xbrHGIH7+30vwA86IsNWug6hBG6jukPTsEMursjPF3dFT0Nrzo10E2tq6REnP
 iV4WnSi3AG9WRVPMh5uA+3lk/iRp1ni0njc1DzOp5NRhO1F/hjcSeEtn2njHQqDSLYlngq
 RhaEMVY4V8WQCS/78jdOysevrl2dkY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-1IBMLMmqOLWVqAhp2UAl8w-1; Mon, 01 Jun 2020 14:40:13 -0400
X-MC-Unique: 1IBMLMmqOLWVqAhp2UAl8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D240B805731;
 Mon,  1 Jun 2020 18:40:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92FCE10021B3;
 Mon,  1 Jun 2020 18:40:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] migration/virtiofs/hmp queue
Date: Mon,  1 Jun 2020 19:39:52 +0100
Message-Id: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 7ea32024c6b3ad9c88d6200e73dbf76c8e160024:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-june-01-2020' into staging (2020-06-01 13:43:59 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200601a

for you to fetch changes up to 773861274ad75a62c7ecf70ecc8e4ba31ed62190:

  migration/migration.c: Fix hang in ram_save_host_page (2020-06-01 18:44:27 +0100)

----------------------------------------------------------------
Migration/virtiofs/hmp pull 2020-06-01

A mixed pull with:
  - RDMA migration fix (CID 1428762)
  - HMP qom-get addition and qom-set cleanup
  - a virtiofsd fix
  - COLO fixes

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      hmp: Implement qom-get HMP command
      hmp: Simplify qom-set

Lukas Straub (6):
      migration/colo.c: Use event instead of semaphore
      migration/colo.c: Use cpu_synchronize_all_states()
      migration/colo.c: Flush ram cache only after receiving device state
      migration/colo.c: Relaunch failover even if there was an error
      migration/colo.c: Move colo_notify_compares_event to the right place
      migration/migration.c: Fix hang in ram_save_host_page

Miklos Szeredi (1):
      virtiofsd: remove symlink fallbacks

Pan Nengyuan (2):
      migration/rdma: fix potential nullptr access in rdma_start_incoming_migration
      migration/rdma: cleanup rdma context before g_free to avoid memleaks

Philippe Mathieu-Daudé (1):
      migration/vmstate: Remove unnecessary MemoryRegion forward declaration

 hmp-commands.hx                  |  16 +++-
 include/migration/vmstate.h      |   1 -
 include/monitor/hmp.h            |   1 +
 migration/colo.c                 |  39 +++++----
 migration/migration.c            |   4 +
 migration/migration.h            |   4 +-
 migration/ram.c                  |   5 +-
 migration/ram.h                  |   1 +
 migration/rdma.c                 |  12 ++-
 qom/qom-hmp-cmds.c               |  34 +++++---
 tests/qtest/test-hmp.c           |   1 +
 tools/virtiofsd/passthrough_ll.c | 175 ++-------------------------------------
 12 files changed, 86 insertions(+), 207 deletions(-)



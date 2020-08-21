Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D8620FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emWA1EYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D8620FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97lZ-0004KY-VJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iu-000750-6b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37642
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iq-0004Vm-7W
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TJk+cO4vCXrgKyAzZSSTC8ZmGTjFhu1hEJnG5JapE7w=;
 b=emWA1EYy96BIXZNmQTa5vz25FDJ/UnPFhkPPTkAPysCr9YcZLAxdzHeygjQiSgtNn8gDdG
 sjs8EIzqDp3uRTsiVoCKR4jRiz9AbiniPQp25xBfKggm5UN6kEU9EOIcrRidSl7EkrDVEA
 0pJoROvtPwsEwO21Yf4q7EMM1UUHwns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-PyASLVMuNd6YxEUxZ7ncFg-1; Fri, 21 Aug 2020 10:08:30 -0400
X-MC-Unique: PyASLVMuNd6YxEUxZ7ncFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6861074665
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 14:08:29 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00ADB7B92A
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 14:08:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] bitmaps patches for 2020-08-21
Date: Fri, 21 Aug 2020 09:08:12 -0500
Message-Id: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4:

  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-08-21 12:42:49 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-08-21

for you to fetch changes up to cb5c6cd2dc984812f560fbe41f57a6bfc34d8708:

  iotests: Test node/bitmap aliases during migration (2020-08-21 08:56:09 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-08-21

- Andrey Shinkevich: Enhance qcow2.py for iotest inspection of qcow2 images
- Max Reitz: Add block-bitmap-mapping migration parameter

----------------------------------------------------------------
Andrey Shinkevich (11):
      iotests: add test for QCOW2 header dump
      qcow2_format.py: make printable data an extension class member
      qcow2_format.py: change Qcow2BitmapExt initialization method
      qcow2_format.py: dump bitmap flags in human readable way.
      qcow2_format.py: Dump bitmap directory information
      qcow2_format.py: pass cluster size to substructures
      qcow2_format.py: Dump bitmap table serialized entries
      qcow2.py: Introduce '-j' key to dump in JSON format
      qcow2_format.py: collect fields to dump in JSON format
      qcow2_format.py: support dumping metadata in JSON format
      iotests: dump QCOW2 header in JSON in #303

Max Reitz (3):
      migration: Add block-bitmap-mapping parameter
      iotests.py: Let wait_migration() return on failure
      iotests: Test node/bitmap aliases during migration

 qapi/migration.json                | 104 ++++++-
 migration/migration.h              |   3 +
 migration/block-dirty-bitmap.c     | 410 +++++++++++++++++++++----
 migration/migration.c              |  30 ++
 monitor/hmp-cmds.c                 |  30 ++
 tests/qemu-iotests/300             | 593 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out         |   5 +
 tests/qemu-iotests/303             |  63 ++++
 tests/qemu-iotests/303.out         | 158 ++++++++++
 tests/qemu-iotests/group           |   2 +
 tests/qemu-iotests/iotests.py      |  18 +-
 tests/qemu-iotests/qcow2.py        |  18 +-
 tests/qemu-iotests/qcow2_format.py | 215 ++++++++++++--
 13 files changed, 1566 insertions(+), 83 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

Andrey Shinkevich (11):
  iotests: add test for QCOW2 header dump
  qcow2_format.py: make printable data an extension class member
  qcow2_format.py: change Qcow2BitmapExt initialization method
  qcow2_format.py: dump bitmap flags in human readable way.
  qcow2_format.py: Dump bitmap directory information
  qcow2_format.py: pass cluster size to substructures
  qcow2_format.py: Dump bitmap table serialized entries
  qcow2.py: Introduce '-j' key to dump in JSON format
  qcow2_format.py: collect fields to dump in JSON format
  qcow2_format.py: support dumping metadata in JSON format
  iotests: dump QCOW2 header in JSON in #303

Max Reitz (3):
  migration: Add block-bitmap-mapping parameter
  iotests.py: Let wait_migration() return on failure
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json                | 104 ++++-
 migration/migration.h              |   3 +
 migration/block-dirty-bitmap.c     | 410 +++++++++++++++++---
 migration/migration.c              |  30 ++
 monitor/hmp-cmds.c                 |  30 ++
 tests/qemu-iotests/300             | 593 +++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out         |   5 +
 tests/qemu-iotests/303             |  63 +++
 tests/qemu-iotests/303.out         | 158 ++++++++
 tests/qemu-iotests/group           |   2 +
 tests/qemu-iotests/iotests.py      |  18 +-
 tests/qemu-iotests/qcow2.py        |  18 +-
 tests/qemu-iotests/qcow2_format.py | 215 ++++++++++-
 13 files changed, 1566 insertions(+), 83 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

-- 
2.28.0



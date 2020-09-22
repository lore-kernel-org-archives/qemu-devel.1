Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF2FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DFA20719
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQqgA19E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DFA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKWkK-00010L-W0
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKWii-00008a-Jv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:03:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKWif-0003nG-Jn
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600736623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=flukJHZuXon26LclHP5w26nvxgUQOmauUNyDf1lcCZs=;
 b=YQqgA19E8+TC1oZFU4iysOi2yj37wnuZjfuQwlENxUVfmyvl72QFkb7Y3YS61PaZDc8YyD
 wEP0r8hO0ETYMjgWhBGq2ncUYiMFaV6tvfXeyOrtzFZRX+d6d1/ZAXS7mRHZDfy0UKqjtG
 frRM7s2Wctr2oImVEVcL+w1ejlZGuhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-J5OBjVz_PpiKf2gJRbX2OQ-1; Mon, 21 Sep 2020 21:03:38 -0400
X-MC-Unique: J5OBjVz_PpiKf2gJRbX2OQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A082B107464B
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:03:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-127.phx2.redhat.com [10.3.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0545DD99
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:03:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] bitmaps patches for 2020-09-21
Date: Mon, 21 Sep 2020 20:03:34 -0500
Message-Id: <20200922010335.1578850-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 21:03:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5df6c87e8080e0021e975c8387baa20cfe43c932:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-09-21 17:41:32 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-09-21

for you to fetch changes up to 14f16bf9474c860ecc127a66a86961942319f7af:

  qemu-img: Support bitmap --merge into backing image (2020-09-21 17:01:09 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-09-21

- Eric Blake: Improve 'qemu-img bitmap --merge' by not opening backing images

----------------------------------------------------------------
Eric Blake (1):
      qemu-img: Support bitmap --merge into backing image

 qemu-img.c                 | 11 ++++++---
 tests/qemu-iotests/291     | 12 ++++++++++
 tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)
The following changes since commit 5df6c87e8080e0021e975c8387baa20cfe43c932:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-09-21 17:41:32 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-09-21

for you to fetch changes up to 14f16bf9474c860ecc127a66a86961942319f7af:

  qemu-img: Support bitmap --merge into backing image (2020-09-21 17:01:09 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-09-21

- Eric Blake: Improve 'qemu-img bitmap --merge' by not opening backing images

----------------------------------------------------------------
Eric Blake (1):
      qemu-img: Support bitmap --merge into backing image

 qemu-img.c                 | 11 ++++++---
 tests/qemu-iotests/291     | 12 ++++++++++
 tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.28.0



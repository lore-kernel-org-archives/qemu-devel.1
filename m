Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC729C433F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A11620719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtPCOYr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A11620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Hm-0004mP-PN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Gj-0002tv-T3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k04Gi-0001xK-9a
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vV3C5Gohux4UvIA1bARucsOydTd30RrcoBvyKH1mirU=;
 b=GtPCOYr2Y9Y2xTLPQ20xNhTJ8xM2HtlfK5589Kqa8ZySOO96+XOnU+rcftUw+HdTiisi1e
 S/bhfeNMZSdYxxKOmsN8qPsV3SK4KlDUQDtNJrWx95rRamN9tnxp4vxOoKmOHr8DIskyMc
 JyH8fJUSCS6GJxesZgzD7qT/eLu851w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-D9_SaS2KPDeXZ3yB_zg3zQ-1; Mon, 27 Jul 2020 10:38:15 -0400
X-MC-Unique: D9_SaS2KPDeXZ3yB_zg3zQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E7F58015F3;
 Mon, 27 Jul 2020 14:38:14 +0000 (UTC)
Received: from localhost (ovpn-113-45.ams2.redhat.com [10.36.113.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10E9F19D9E;
 Mon, 27 Jul 2020 14:38:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/3] Block patches for 5.1
Date: Mon, 27 Jul 2020 16:38:09 +0200
Message-Id: <20200727143812.1101547-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-07-27

for you to fetch changes up to 1855536256eb0a5708b04b85f744de69559ea323:

  iotests/197: Fix for compat=0.10 (2020-07-27 16:35:17 +0200)

----------------------------------------------------------------
Block patches for 5.1:
- Coverity fix
- iotests fix for rx and avr
- iotests fix for qcow2 -o compat=0.10

----------------------------------------------------------------
Max Reitz (2):
  block/amend: Check whether the node exists
  iotests/197: Fix for compat=0.10

Thomas Huth (1):
  iotests: Select a default machine for the rx and avr targets

 block/amend.c            |  6 +++++-
 tests/qemu-iotests/197   |  4 +++-
 tests/qemu-iotests/check | 14 +++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.26.2



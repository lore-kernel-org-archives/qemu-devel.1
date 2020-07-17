Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF5A20734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKhz4Jns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF5A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwS6A-0001a8-8t
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jwS53-0000bV-TR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jwS51-0004Hm-8N
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594998918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l7wurX9GNs/LOQ7/QeYjTsSMtslTMmwh9bMiOKwULlc=;
 b=TKhz4JnsoaEsmdKYIW6qyPygMOX6P494rGBTw137NJjrdIs6zSe1XWG1iHf+id6WRfoXYW
 1jj702S/p4ywAtofEubCQO4QsKwOoZDSe3QR5SOiM5RcVrFHNVDTV+WW0IPjqNMHF+D5SG
 V2RWJQ09p4U+7wuhxYTlAU/3nLR/xNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-3MZkFduqNoO27YRTDxgFKg-1; Fri, 17 Jul 2020 11:15:01 -0400
X-MC-Unique: 3MZkFduqNoO27YRTDxgFKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E5FF52640
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 15:14:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-239.phx2.redhat.com [10.3.113.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C39C872E6
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 15:14:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] bitmaps patches for 2020-07-17 [-rc1]
Date: Fri, 17 Jul 2020 10:14:45 -0500
Message-Id: <20200717151446.655571-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
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

The following changes since commit 151f76c689b1ff4c2c59e6d8469a0d4fe5346f55:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-07-16 21:46:18 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-07-17

for you to fetch changes up to 7cb015197b383a62f5729d2c92b1050db0185c1c:

  migration/block-dirty-bitmap: fix add_bitmaps_to_list (2020-07-17 08:18:51 -0500)

I had been waiting to see if I had more than one patch to bundle, but
given that we are now coming up on -rc1 and this is a bugfix, it's time
for the pull request of this in isolation.

----------------------------------------------------------------
bitmaps patches for 2020-07-17

- improve corner-case of bitmap migration

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (1):
      migration/block-dirty-bitmap: fix add_bitmaps_to_list

 migration/block-dirty-bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.27.0



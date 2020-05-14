Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B6CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3544A20657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYryO23e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIBv-0005NP-Ca
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZI9k-0008Rd-AM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:00:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24653
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZI9j-0005Ah-5S
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589479226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vOs2N/7su80Y9w3xxlmgnclaOuhozQ0+hJXS82zgAI0=;
 b=YYryO23eyRfwLq54DdbZmAa/AdWHVGSQ9XGD7QZNF9gZ8X0+kmdoVFOGw1uYqCmQoxns/T
 4guoGle7o2PH8F5jV1ZR1ZiLaivtVhKACQSb4wUAbqXqez5WQqxsX6UQfg6+iVcUDfEFHG
 klnYryQAcwBg3P7AUhQ8JVMZFoz5wf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-2y377TxWPMKf2rzD0R75eA-1; Thu, 14 May 2020 14:00:10 -0400
X-MC-Unique: 2y377TxWPMKf2rzD0R75eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7981100CCF3;
 Thu, 14 May 2020 18:00:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A13281654;
 Thu, 14 May 2020 18:00:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] bitmaps: Update maintainer
Date: Thu, 14 May 2020 13:00:03 -0500
Message-Id: <20200514180003.325406-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dirty bitmaps are important to incremental backups, including exposure
over NBD where I'm already maintainer.  Also, I'm aware that lately I
have been doing as much code/review on bitmaps as John Snow who is
trying to scale back in order to focus elsewhere; and many of the
recent patches have come from Vladimir, who is also interested in
taking on maintainer duties, but would like to start with
co-maintainership.  Therefore, it's time to revamp the ownership of
this category, as agreed between the three of us.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v2: further tweak to maintainership, update T: listing

 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d11f3cb97613..ae23062a51ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2001,8 +2001,9 @@ F: qapi/transaction.json
 T: git https://repo.or.cz/qemu/armbru.git block-next

 Dirty Bitmaps
-M: John Snow <jsnow@redhat.com>
-R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+M: Eric Blake <eblake@redhat.com>
+M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+R: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: include/qemu/hbitmap.h
@@ -2013,7 +2014,7 @@ F: migration/block-dirty-bitmap.c
 F: util/hbitmap.c
 F: tests/test-hbitmap.c
 F: docs/interop/bitmaps.rst
-T: git https://github.com/jnsnow/qemu.git bitmaps
+T: git https://repo.or.cz/qemu/ericb.git bitmaps

 Character device backends
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
-- 
2.26.2



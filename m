Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4ECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB472054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhBY6n87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB472054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYz9B-0007u8-Si
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8F-0006rh-IO
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8E-0005ac-RL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QffVv5xbmQImW4UmidPHrV3KfMFnmJXLW/0kpOw5Hc=;
 b=VhBY6n87g+8U+4nlIniW+JC6u1PDNgOJaKQAwF68tul5V+loDBjCEfOUVeSZ2oY9DVq+ck
 q4vnWYJ3zGi10k/DDk6TVyMnTy0r6l4oRmusBwaODWRJrPMGfMRJ2/lyjf7kJTJiLCK7XB
 dM50V8R8OM2kbLYll4AVKIaSnC8QWyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-UdF1q2RmN5qu5NPljf8WsA-1; Wed, 13 May 2020 17:41:34 -0400
X-MC-Unique: UdF1q2RmN5qu5NPljf8WsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8AE883DE6C;
 Wed, 13 May 2020 21:41:33 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE9A1C94D;
 Wed, 13 May 2020 21:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 2/6] Makefile: add delint WIP
Date: Wed, 13 May 2020 17:41:26 -0400
Message-Id: <20200513214130.15375-3-jsnow@redhat.com>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
References: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/Makefile b/tests/qemu-iotests/Makefile
index 27380e60c1..7dbb7f0fff 100644
--- a/tests/qemu-iotests/Makefile
+++ b/tests/qemu-iotests/Makefile
@@ -1,3 +1,6 @@
+PYMODULES = $(wildcard *.py)
+
+KNOWN_GOOD = iotests.py
 
 CLEANFILES= *.out.bad *.notrun check.log check.time*
 
@@ -7,3 +10,6 @@ default:
 clean:
 	rm -f $(CLEANFILES)
 
+delint:
+	pylint $(KNOWN_GOOD)
+	pylint --disable=R,C,W $(filter-out $(KNOWN_GOOD), $(PYMODULES))
-- 
2.21.1



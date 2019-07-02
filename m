Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C0C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B02208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B02208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGNT-0008ER-2q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJm-0005mm-03
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJk-0007eh-KP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJk-0007bD-EL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58D0730BB367
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22BEF6F7EE;
 Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A978C1132A05; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:00 +0200
Message-Id: <20190702104716.9140-3-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 02 Jul 2019 10:47:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/18] MAINTAINERS: Make section "QOM" cover
 qdev as well
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23a8c5ac0b..3d139b61ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2033,12 +2033,18 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Eduardo Habkost <ehabkost@redhat.com>
 S: Supported
+F: docs/qdev-device-use.txt
+F: hw/core/qdev*
+F: include/hw/qdev*
+F: include/monitor/qdev.h
 F: include/qom/
 X: include/qom/cpu.h
+F: qdev-monitor.c
 F: qom/
 X: qom/cpu.c
 F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
+F: tests/test-qdev-global-props.c
=20
 QMP
 M: Markus Armbruster <armbru@redhat.com>
--=20
2.21.0



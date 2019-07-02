Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44838C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D59720659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D59720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGQl-0003es-DU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJn-0005nf-3I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJl-0007g0-6s
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJl-0007bO-0Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55663859FE;
 Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA072E039;
 Tue,  2 Jul 2019 10:47:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5B991132ADD; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:46:59 +0200
Message-Id: <20190702104716.9140-2-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 10:47:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/18] MAINTAINERS: new maintainers for QOM
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

QOM is not a particularly active subsystem now: 51 commits in two years.
But, we need active maintainers to review and merge patches, and Git
shows the following top committers taking on QOM:

    Markus Armbruster <armbru@redhat.com>
    Eduardo Habkost <ehabkost@redhat.com>
    Paolo Bonzini <pbonzini@redhat.com>
    Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Eric Blake <eblake@redhat.com>

I volunteer myself, and also volunteer Eduardo and Daniel as reviewers
since they understand the code well.

Cc: Andreas F=C3=A4rber <afaerber@suse.de>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8206fc51db..23a8c5ac0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2029,9 +2029,10 @@ F: docs/interop/qemu-ga-ref.texi
 T: git https://github.com/mdroth/qemu.git qga
=20
 QOM
-M: Andreas F=C3=A4rber <afaerber@suse.de>
+M: Paolo Bonzini <pbonzini@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+R: Eduardo Habkost <ehabkost@redhat.com>
 S: Supported
-T: git https://github.com/afaerber/qemu-cpu.git qom-next
 F: include/qom/
 X: include/qom/cpu.h
 F: qom/
--=20
2.21.0



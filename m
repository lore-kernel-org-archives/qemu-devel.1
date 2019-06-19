Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF6BC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDDD208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDDD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgxC-0006PG-On
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdgvC-0004Kb-3L
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdgv7-0001AK-NL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdgv7-00010k-1B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 569BE223899;
 Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDD06013D;
 Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8917011386A3; Wed, 19 Jun 2019 22:10:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 22:10:34 +0200
Message-Id: <20190619201050.19040-2-armbru@redhat.com>
In-Reply-To: <20190619201050.19040-1-armbru@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/17] MAINTAINERS: new maintainers for QOM
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
Cc: kwolf@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
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
Message-Id: <20190607113737.13473-1-pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d32c5c2313..63390eadb5 100644
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



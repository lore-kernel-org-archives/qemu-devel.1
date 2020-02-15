Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD42C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C3B20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O33frsGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C3B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vts-0004y6-3t
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpU-0004dP-7n
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpT-0006v6-4O
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpS-0006v1-W9
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQVZIM30qVtywxVsKFvM36jgS73jo3ftZHSsOFgP4EY=;
 b=O33frsGpnJD7L65tEFHt4zelPKjSqbfWpLKyrCiUoJAimCf94psZbdmIveFSzqx3sceDmX
 wcSxCVDL7CeDBcxBNaoUKdBDpz3u+iVWU3ckjhr9pfublWwOPeZV597x4DwC3UvcLnOfF7
 Ksw052NDQYFZHdR1MgjjekMMWGFk3vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-US52eF4dOxKTXQnuyNpHOQ-1; Sat, 15 Feb 2020 06:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87FDF800D4E;
 Sat, 15 Feb 2020 11:41:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D44AA5C12E;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 559161136368; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] qapi/migration.json: Replace _this_ with *this*
Date: Sat, 15 Feb 2020 12:41:32 +0100
Message-Id: <20200215114133.15097-18-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: US52eF4dOxKTXQnuyNpHOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The MigrationInfo::setup-time documentation is the only place where we
use _this_ inline markup for emphasis, commonly rendered in italics.
We would like to switch the doc comments to rST format, but rST
doesn't recognize that markup and emits literal underscores.

Switch to *this* instead.  Changes markup to strong emphasis with
Texinfo, commonly rendered as bold.  With rST, it will go right back
to emphasis / italics.

rST also uses **this** for strong (commonly rendered bold) where
Texinfo uses *this*. We have one place in the doc comments
which uses strong/bold markup, in qapi/introspect.json:
    Note: the QAPI schema is also used to help define *internal*

When we switch to rST that will be rendered as emphasis / italics.
Markus (who wrote that) thinks that using emphasis / italics
there is an improvement, so we leave that markup alone.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213175647.17628-18-peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 11033b7a8e..52f3429969 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -178,8 +178,8 @@
 #                     expected downtime in milliseconds for the guest in l=
ast walk
 #                     of the dirty bitmap. (since 1.3)
 #
-# @setup-time: amount of setup time in milliseconds _before_ the
-#              iterations begin but _after_ the QMP command is issued. Thi=
s is designed
+# @setup-time: amount of setup time in milliseconds *before* the
+#              iterations begin but *after* the QMP command is issued. Thi=
s is designed
 #              to provide an accounting of any activities (such as RDMA pi=
nning) which
 #              may be expensive, but do not actually occur during the iter=
ative
 #              migration rounds themselves. (since 1.6)
--=20
2.21.1



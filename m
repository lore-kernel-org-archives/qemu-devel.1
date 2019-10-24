Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF5DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAEB205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECS11l21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAEB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43727 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdqC-0004bE-Pn
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKg-0003pn-Ly
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKf-00068x-JS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKf-00068c-Fl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=be0BwK+WI51a53q3dTuHUsRjhO/h4OkPgEmwAXu9BBY=;
 b=ECS11l21s2tY4ijHsBvpEv40DtOhYLnTRZBmmEHqInWtG/RQ79ZIs3jfiIcykU01EqGg1i
 u6Jvi2qqNWGyl3hs9vLkeS/4sl54QGgK6YTgq7IHaRQjrZ51mysmQ/HfFlgfgjNahVYcn+
 GQ8WJM3Dj48VO27qTUEkQo4ucu3NWyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-h5TPNVbsPR2tLJQM1LDiuQ-1; Thu, 24 Oct 2019 08:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08CC1005500;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B47D52E7;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2177F11328A8; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/19] qapi: Replace qmp_dispatch()'s TODO comment by an
 explanation
Date: Thu, 24 Oct 2019 14:34:51 +0200
Message-Id: <20191024123458.13505-13-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: h5TPNVbsPR2tLJQM1LDiuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 0cbb663097..55bc224c61 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -164,7 +164,11 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
         g_assert(!ret);
         return NULL;
     } else if (!ret) {
-        /* TODO turn into assertion */
+        /*=20
+         * When the command's schema has no 'returns', cmd->fn()
+         * leaves @ret null.  The QMP spec calls for an the empty
+         * object then; supply it.
+         */
         ret =3D QOBJECT(qdict_new());
     }
=20
--=20
2.21.0



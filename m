Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D0CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1043321906
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDzJIoPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043321906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMp6L-0008P1-NB
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1l-0002ok-LG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1k-0005uM-LE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1k-0005u2-Gt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGqr3KhgZltGCnvqSmLeVMxSxj4NjL59SFZXI8ZwUIU=;
 b=IDzJIoPanADFVHs0GYwMHHqdbgH044QaaOBQsX0/b9549pEreyYy3+SvWCEtS0m4ec2QHX
 DRHHC/zlWHsx3fTuCyd531ouStHUbJGUDnae8BjuQDrbqNMm0O6FrA6EvpjRVyvkjV+EHe
 4XaF1WYrjUSYcBIjrNziUTWAI9aJvp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-DBvLYmFuMviIlwGdRjokVw-1; Tue, 22 Oct 2019 03:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98F81005500
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 847A15D6A9;
 Tue, 22 Oct 2019 07:56:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8172C1132986; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] qapi: Clear scripts/qapi/doc.py executable bits again
Date: Tue, 22 Oct 2019 09:56:10 +0200
Message-Id: <20191022075615.956-8-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DBvLYmFuMviIlwGdRjokVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit fbf09a2fa4 "qapi: add 'ifcond' to visitor methods" brought back
the executable bits.  Fix that.  Drop the #! line for good measure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191018074345.24034-8-armbru@redhat.com>
---
 scripts/qapi/doc.py | 1 -
 1 file changed, 1 deletion(-)
 mode change 100755 =3D> 100644 scripts/qapi/doc.py

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
old mode 100755
new mode 100644
index 1c5125249f..dc8919bab7
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # QAPI texi generator
 #
 # This work is licensed under the terms of the GNU LGPL, version 2+.
--=20
2.21.0



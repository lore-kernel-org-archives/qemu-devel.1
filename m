Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A063C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DBC2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YINNc7yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DBC2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3QQ-0004ed-2A
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nx-0000IB-IZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nv-0006lh-2n
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33626
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3Nt-0006ko-Tq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7kpII5WrSYrg9Xg7NO+QGAFuzWkAtr0LHYGkcwUmp0=;
 b=YINNc7ywZ8798DGbhtO2wcO3+1ZYeNpVsmAHxZhPUybDBKkWfqIZX0OzdNzdAO4uZaduxo
 Mmdv92/ORXoKENzUA1itor73J3XauIEgeqDuiGZo9iotQu50puvM+J1R46qs7pHkDxXSSV
 sBqn8dsO0e8Fo+641OXsP200DTmQK8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-NEclL7deNNyDbwiIXQD2aQ-1; Mon, 27 Jan 2020 07:20:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26585107ACC4;
 Mon, 27 Jan 2020 12:20:46 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A42FF5D9C5;
 Mon, 27 Jan 2020 12:20:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/15] docs/devel: fix stable process doc formatting
Date: Mon, 27 Jan 2020 13:20:08 +0100
Message-Id: <20200127122016.18752-8-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NEclL7deNNyDbwiIXQD2aQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enumeration of stable criteria needs proper bullet points.

Message-Id: <20200113103023.31255-1-cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/devel/stable-process.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/devel/stable-process.rst b/docs/devel/stable-process.rst
index 98736a9ea487..e541b983fac7 100644
--- a/docs/devel/stable-process.rst
+++ b/docs/devel/stable-process.rst
@@ -18,8 +18,10 @@ What should go into a stable release?
 -------------------------------------
=20
 Generally, the following patches are considered stable material:
-- Patches that fix severe issues, like fixes for CVEs
-- Patches that fix regressions
+
+* Patches that fix severe issues, like fixes for CVEs
+
+* Patches that fix regressions
=20
 If you think the patch would be important for users of the current release
 (or for a distribution picking fixes), it is usually a good candidate
--=20
2.21.1



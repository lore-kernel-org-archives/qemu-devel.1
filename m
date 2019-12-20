Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F83C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E9E2465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INvxvXCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E9E2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiBRm-0001c1-Cz
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 01:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iiBQp-0000kt-35
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iiBQn-00035l-1D
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iiBQm-0002zj-HX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576821987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FYHFBgDjbM2tJwbOfhflg74Uvf+1xwyUnLyRQbH8wIM=;
 b=INvxvXCChl8n2W4vcyEuANEB5+tWRdTrYd27iIFeaaYpVnlY9ZbZtE4FPws4NUykilhoSJ
 Ku6CF1M/lmgAG+zGqpTXmcQMsh2IprC5XuZjyCDYXSQdit48dwmi871qye6OhKZvUbJPO0
 tMXyur1lhH+lOcDcOwV+ZjRPboQ0paY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-3aIhlF2HPq2ft2KxU58cpQ-1; Fri, 20 Dec 2019 01:06:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42110107ACC7
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:06:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC3CA7E477;
 Fri, 20 Dec 2019 06:06:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 16BA09ADD; Fri, 20 Dec 2019 07:06:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] vhost-user-gpu: Drop trailing json comma
Date: Fri, 20 Dec 2019 07:06:15 +0100
Message-Id: <20191220060617.32326-2-kraxel@redhat.com>
In-Reply-To: <20191220060617.32326-1-kraxel@redhat.com>
References: <20191220060617.32326-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3aIhlF2HPq2ft2KxU58cpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cole Robinson <crobinso@redhat.com>

Trailing comma is not valid json:

$ cat contrib/vhost-user-gpu/50-qemu-gpu.json.in | jq
parse error: Expected another key-value pair at line 5, column 1

Signed-off-by: Cole Robinson <crobinso@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobins=
o@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 contrib/vhost-user-gpu/50-qemu-gpu.json.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-gpu/50-qemu-gpu.json.in b/contrib/vhost-use=
r-gpu/50-qemu-gpu.json.in
index 658b545864b1..f5edd097f805 100644
--- a/contrib/vhost-user-gpu/50-qemu-gpu.json.in
+++ b/contrib/vhost-user-gpu/50-qemu-gpu.json.in
@@ -1,5 +1,5 @@
 {
   "description": "QEMU vhost-user-gpu",
   "type": "gpu",
-  "binary": "@libexecdir@/vhost-user-gpu",
+  "binary": "@libexecdir@/vhost-user-gpu"
 }
--=20
2.18.1



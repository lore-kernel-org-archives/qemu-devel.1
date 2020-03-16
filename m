Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C45C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20A420658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5DczBBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20A420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxVA-0005as-Ms
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHJ-00035M-Ex
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHI-0002tX-8V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHI-0002rN-1r
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IitM4mPKiN40CFCMH52RVRIdZAz8klQZG8CpYOPF4jk=;
 b=B5DczBBots0WWZ1Shi7EkoOIUZsJLFbOFeF0YjdGe9xl4NhnUVDX/NrABjNMrjCu7rj3Pm
 PZvyY11BncJUFj/fZbm6Xeol/BS6h+zTgRDymJC6FMaz5DCY5yjs/fw5MNwzQy/19QqF4/
 r2wtWScoiPKSVn74ZCqLb01d48xX5I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-RcfB10rANgmUfkVAYFnVbg-1; Mon, 16 Mar 2020 17:28:01 -0400
X-MC-Unique: RcfB10rANgmUfkVAYFnVbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393898010C7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:00 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCDF19C4F;
 Mon, 16 Mar 2020 21:27:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/61] tests/docker: Install SASL library to extend code
 coverage on amd64
Date: Mon, 16 Mar 2020 22:26:42 +0100
Message-Id: <1584394048-44994-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Install the SASL library to build the VNC SASL auth protocol code.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200309122454.22551-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index 3b860af..0456fc7 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -17,6 +17,7 @@ RUN apt update && \
         libbz2-dev \
         liblzo2-dev \
         librdmacm-dev \
+        libsasl2-dev \
         libsnappy-dev \
         libvte-dev
=20
--=20
1.8.3.1




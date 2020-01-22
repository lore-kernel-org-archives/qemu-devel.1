Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AAFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2202465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJzpyvI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2202465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJiP-0008Rb-1p
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 12:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuJhS-0007Sj-1g
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuJhR-0007vn-26
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuJhQ-0007va-Ux
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579713712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=81TkLNXfmbOYYGG0HEzvgfCJtTEvF70HIv7HTaQpniQ=;
 b=TJzpyvI5rQisfHDvgr6jmNJlTF53r+nlwo1nS0l7SPtGmRK1D6qsDlG20LX7VvlXNXmVpT
 A9IH0dTmFZJXKCz2inD2lPG3wzVSYu7o5vQCAL/MbpYXDTqPADdZcNVWblz+10GokzClSV
 ctZk/YrVoiRMEascIkYr5+Ogmod2YII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-oTFEtTClOhi5LEZTvRyCdg-1; Wed, 22 Jan 2020 12:21:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B03E2108594E;
 Wed, 22 Jan 2020 17:21:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-78.brq.redhat.com [10.40.204.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E634160F8D;
 Wed, 22 Jan 2020 17:21:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Makefile: List the sphinx documentation in 'make help'
Date: Wed, 22 Jan 2020 18:21:37 +0100
Message-Id: <20200122172137.7282-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oTFEtTClOhi5LEZTvRyCdg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 5f71eac06e1 we started to support the rST documentation.
List the build target we need to call to generate the rST files in
the 'make help' output.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6562b0dc97..b777f7fcdd 100644
--- a/Makefile
+++ b/Makefile
@@ -1197,7 +1197,7 @@ endif
 =09@echo  '  vm-help         - Help about targets running tests inside VM'
 =09@echo  ''
 =09@echo  'Documentation targets:'
-=09@echo  '  html info pdf txt'
+=09@echo  '  html info pdf txt sphinxdocs'
 =09@echo  '                  - Build documentation in specified format'
 ifdef CONFIG_GCOV
 =09@echo  '  coverage-report - Create code coverage report'
--=20
2.21.1



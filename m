Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1A3C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B8E21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqH4tYB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B8E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoeE-0007wr-Oh
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaP-0000Bz-BB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaN-0004uF-Ht
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaN-0004kX-DT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFFa9HY1i6n4oZk0OJpYn/G/ddYPgYjpGM4yZPhI9W0=;
 b=aqH4tYB/jsEC1nxR8E2Qtzyavle9noQlZD7eCqO7DmgM/HamaLvm0SBPf79jt0q0UIqu2O
 7RQlKjag6wPMMrCMgvhRjpB7PeiOHNBMP5hZvqpADIrqWZCPyvfpO/gvBSzScmc30yk1tT
 98fLGM/dJ02Cq6nSwonVRL7N/JcTNig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fwOVVAfZNfehxF6osASkAQ-1; Thu, 06 Feb 2020 16:21:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F8581034B5D
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:15 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC1D260BEC;
 Thu,  6 Feb 2020 21:21:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/46] tests/acceptance/version: Default to -nodefaults
Date: Thu,  6 Feb 2020 22:19:14 +0100
Message-Id: <20200206211936.17098-25-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fwOVVAfZNfehxF6osASkAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the default options to run this test.

This fixes errors when running a binary built with
--without-default-devices such:

  ERROR: qemu-system-arm: Unsupported NIC model: virtio-net-pci

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200129212345.20547-29-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/version.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
index 67c2192c93..79b923d4fc 100644
--- a/tests/acceptance/version.py
+++ b/tests/acceptance/version.py
@@ -17,6 +17,7 @@ class Version(Test):
     :avocado: tags=3Dquick
     """
     def test_qmp_human_info_version(self):
+        self.vm.add_args('-nodefaults')
         self.vm.launch()
         res =3D self.vm.command('human-monitor-command',
                               command_line=3D'info version')
--=20
2.21.1



Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D9FC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AC220658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9cMcaZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AC220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46413 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoiY-0001ht-LU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaL-0008Vo-LB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaJ-0004Zt-Nu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaJ-0004OO-Jm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhiGiZ2nCw4GnOoUFpJGWIgsrnlCdbszfjGpfva7u+8=;
 b=D9cMcaZTt8J61qLYzWXxsawTyqNb6XQjJOZhxg1FaRilQcUYZ5o8vqdThFIty6xdJGZJOr
 KBG92qUiu2cQlVIw6XuocrYpi67GXFfIgPNseHWWIA16S019U7f1odQKWKvEcSAiBm0fp7
 GugsIh9CYJRpav7htLF2/X8W33izLjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-sbwdV9x4PAGIfiGXCgL2Jw-1; Thu, 06 Feb 2020 16:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4951007268
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9352660BEC;
 Thu,  6 Feb 2020 21:21:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/46] tests/acceptance/virtio_check_params: Default to
 -nodefaults
Date: Thu,  6 Feb 2020 22:19:11 +0100
Message-Id: <20200206211936.17098-22-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sbwdV9x4PAGIfiGXCgL2Jw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the default options to run this test.

This fixes errors when running a binary built with
--without-default-devices such:

  ERROR: qemu-system-s390x: Unknown device 'virtio-net-ccw' for bus 'virtua=
l-css-bus'

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200129212345.20547-25-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/vir=
tio_check_params.py
index 29e91bfa37..22792d4ec6 100755
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -79,6 +79,7 @@ class VirtioMaxSegSettingsCheck(Test):
         logger.debug(mt)
         with QEMUMachine(self.qemu_bin) as vm:
             vm.set_machine(mt["name"])
+            vm.add_args('-nodefaults')
             for s in VM_DEV_PARAMS[dev_type_name]:
                 vm.add_args(s)
             try:
--=20
2.21.1



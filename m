Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDBC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40EE24695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O94tS40G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40EE24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GdP-00053o-6z
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7GcE-0004bz-0S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7GcC-0001RS-VL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:42:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7GcC-0001OO-RZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582800120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uRcbd5vFEKQrMM1BmW5dsfJLhdM1+Xd/b7Y+mRdcSZA=;
 b=O94tS40Gso86RMiAX8tNCugLYWV9sF4r6Mrm7HnHLE2KpglCeIpn3/WNN8WtlCAGlffsD9
 BIS7DIaHo8kHzZLE+3JTM1WOxbftoFfinDYaJCcX12dgR3VD9AeyS7q2L7D2YJ8p+8+Fs0
 fo7EzSmuZrpu8SMPiqjDjouEM8roL2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-9pTu7RXrPCKe_Gzax-n8tQ-1; Thu, 27 Feb 2020 05:41:58 -0500
X-MC-Unique: 9pTu7RXrPCKe_Gzax-n8tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54C113E6;
 Thu, 27 Feb 2020 10:41:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F96D84779;
 Thu, 27 Feb 2020 10:41:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qapi/machine: Place the 'Notes' tag after the 'Since' tag
Date: Thu, 27 Feb 2020 11:41:53 +0100
Message-Id: <20200227104153.29425-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes when adding a 'Since' tag:

  In file included from qapi/qapi-schema.json:105:
  qapi/machine.json:25:1: '@arch:' can't follow 'Notes' section

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..2b4f5f0962 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -16,11 +16,11 @@
 # individual target constants are not documented here, for the time
 # being.
 #
+# Since: 3.0
+#
 # Notes: The resulting QMP strings can be appended to the "qemu-system-"
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
-#
-# Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
   'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
--=20
2.21.1



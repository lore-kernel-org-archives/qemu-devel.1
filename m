Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0761C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7C220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW99lAy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7C220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoWk-0006GK-OF
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDnwu-00021R-9q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDnwt-0000uM-2y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDnws-0000og-Rc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHmFc0/OXCCi+NT1SDYJ51HQ8KXTFUSMmYS3mQHZnoU=;
 b=IW99lAy/pzHkdRhwql/YbPjX0bRATYjFB5N7UfGB71qznLdJq6TTBxNIXPlzFBZRmIl57W
 GcnlzPLg+AWv48TwOagqt6l4ZpR4yIT1qKykFoxudUqwHAql2gxIVlb9Xul7O9ew/tNg9s
 AEEc0ail1nsnv8C8wWcsF+cKraXWSXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-vbl2EKiCNC6HlDaGBsdDFQ-1; Mon, 16 Mar 2020 07:30:20 -0400
X-MC-Unique: vbl2EKiCNC6HlDaGBsdDFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AA2100550D;
 Mon, 16 Mar 2020 11:30:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7154B5C1B2;
 Mon, 16 Mar 2020 11:30:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8C21E9D13; Mon, 16 Mar 2020 12:30:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] qapi/audio: add documentation for AudioFormat
Date: Mon, 16 Mar 2020 12:30:10 +0100
Message-Id: <20200316113015.28013-2-kraxel@redhat.com>
In-Reply-To: <20200316113015.28013-1-kraxel@redhat.com>
References: <20200316113015.28013-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

The review for patch ed2a4a7941 "audio: proper support for
float samples in mixeng" suggested this would be a good idea.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Tested-by: John Arbuckle <programmingkidx@gmail.com>
Message-id: 20200308193321.20668-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi/audio.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index d8c507ccedae..c31251f45b57 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -273,6 +273,20 @@
 #
 # An enumeration of possible audio formats.
 #
+# @u8: unsigned 8 bit integer
+#
+# @s8: signed 8 bit integer
+#
+# @u16: unsigned 16 bit integer
+#
+# @s16: signed 16 bit integer
+#
+# @u32: unsigned 32 bit integer
+#
+# @s32: signed 32 bit integer
+#
+# @f32: single precision floating-point (since 5.0)
+#
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
--=20
2.18.2



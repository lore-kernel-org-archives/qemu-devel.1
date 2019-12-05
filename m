Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7512C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704DD20640
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 02:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGxetJkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704DD20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichDD-0008Iy-Kn
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 21:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1ichCL-0007OR-28
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1ichCI-0006mu-NU
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:48:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1ichCI-0006jB-5k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 21:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575514133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NGHZZjPA7/Fhrh2YNKMXXBFjXsWVRj7olDJRMs5n9eM=;
 b=dGxetJkVctm3IXOdgjWOsRrCgCGUKTFn5kbSFDWoVtkozLX3B1qhTQHsC4IA7lBtDmJjY8
 uNG1s31iywDg6nnD/JaJcyPR/z/bagzjataebwoEPZIlAaoc1EaUjVjz7Leh+5JEPFJ5z0
 xbNXRMvhd19oT+f8GSCYXKrgwYNazQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-xP2MoCgKODG-rHAC37hX9A-1; Wed, 04 Dec 2019 21:48:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051F4801E53;
 Thu,  5 Dec 2019 02:48:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-175.pek2.redhat.com
 [10.72.12.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0282C5C1B0;
 Thu,  5 Dec 2019 02:48:48 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
Date: Thu,  5 Dec 2019 10:48:21 +0800
Message-Id: <20191205024821.245435-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xP2MoCgKODG-rHAC37hX9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-trivial@nongnu.org, Han Han <hhan@redhat.com>, laurent@vivier.eu,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.

In 20a1922032 we allowed reboot-timeout=3D-1 again, so update the doc
accordingly.

Signed-off-by: Han Han <hhan@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b..e14d88e9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -327,8 +327,8 @@ format(true color). The resolution should be supported =
by the SVGA mode, so
 the recommended is 320x240, 640x480, 800x640.
=20
 A timeout could be passed to bios, guest will pause for @var{rb_timeout} m=
s
-when boot failed, then reboot. If @option{reboot-timeout} is not set,
-guest will not reboot by default. Currently Seabios for X86
+when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will not
+reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
 system support it.
=20
 Do strict boot via @option{strict=3Don} as far as firmware/BIOS
--=20
2.23.0



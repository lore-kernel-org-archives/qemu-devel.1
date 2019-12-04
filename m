Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2304C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8685D20661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fySXNFiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8685D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQnH-0001Px-Os
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1icQTn-0002me-Sq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1icQTY-0002yC-FW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:57:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1icQTY-0002dH-Bz
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575449850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y23+RdbMvjvtLaFIS5I+BFj/BYYOnzn2u86o+c1g6LA=;
 b=fySXNFiDQpVPFh9eMXhb+nZUe1OtjMyEXbl1AcM+jjPHxh4FD4yDj8DJWarns56Hz+bkDE
 SWCAShMldcw51TLbBVAl52Y5ygW38BMaEStQdhE/202rXtSMbS4IXXBCcoh0H9fqZu0x78
 f6HopRo/4Yk3pmnK8qkZbPHtpswQC5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ZqwEjixHNB6hzj_KHzj07Q-1; Wed, 04 Dec 2019 03:57:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6408026B9;
 Wed,  4 Dec 2019 08:57:25 +0000 (UTC)
Received: from hansolo.pek2.redhat.com (wlc-trust-29.pek2.redhat.com
 [10.72.3.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC1F55DA60;
 Wed,  4 Dec 2019 08:57:22 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Revert "qemu-options.hx: Update for reboot-timeout parameter"
Date: Wed,  4 Dec 2019 16:56:28 +0800
Message-Id: <20191204085628.2892-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZqwEjixHNB6hzj_KHzj07Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b73..e14d88e9b2 100644
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
2.24.0.rc1



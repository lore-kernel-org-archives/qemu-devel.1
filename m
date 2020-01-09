Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DEB2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlJYQm4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DEB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipa0F-0005N9-V4
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZuq-0006oa-IS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZup-0002rZ-Bl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZup-0002or-6T
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578584406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zhOhvEQYQgUim1shmmIdvB0/IgzwY3sRGi/2inNpnA=;
 b=hlJYQm4FnDII1xOtcrRCRBqkFODagB7qxosxdC/eeg4ezs3SzfWI2uvkMWcChNbiTbH8O7
 gnu4ByQX5V0l/bqmekVYdkJ1NqtjhIs9GECX0ZHFwqtIdtsujsVY+uDcAQu18gizIGNEZ+
 uFfzFA8WVlSgWGn0NQ9uz6K/Wi0pNHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388--qDzSktSPCOu1QUlw7UJ_g-1; Thu, 09 Jan 2020 10:40:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCDC12DE2B;
 Thu,  9 Jan 2020 15:40:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75DB686CB8;
 Thu,  9 Jan 2020 15:39:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] Makefile: Clarify all the codebase requires qom/ objects
Date: Thu,  9 Jan 2020 16:39:37 +0100
Message-Id: <20200109153939.27173-3-philmd@redhat.com>
In-Reply-To: <20200109153939.27173-1-philmd@redhat.com>
References: <20200109153939.27173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: -qDzSktSPCOu1QUlw7UJ_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU user-mode also requires the qom/ objects, it is not only
used by "system emulation and qemu-img". As we will use a big
if() block, move it upper in the "Common libraries for tools
and emulators" section.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f9d6..5aae561984 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,6 +2,7 @@
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/
 util-obj-y =3D crypto/ util/ qobject/ qapi/
+qom-obj-y =3D qom/
=20
 chardev-obj-y =3D chardev/
=20
@@ -26,11 +27,6 @@ block-obj-m =3D block/
=20
 crypto-obj-y =3D crypto/
=20
-#######################################################################
-# qom-obj-y is code used by both qemu system emulation and qemu-img
-
-qom-obj-y =3D qom/
-
 #######################################################################
 # io-obj-y is code used by both qemu system emulation and qemu-img
=20
--=20
2.21.1



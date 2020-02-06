Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74FC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FBA21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG4Bg+zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FBA21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izobt-00033Q-MS
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZb-0007PY-2S
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZZ-0001hD-Sp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZZ-0001fo-Oh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKNyHxXIdDkOwIbKajC3fUgi3Gp4Rt3/JZ+mGbH4lvM=;
 b=hG4Bg+zTNOymNiwCeIfOGojTTWo+Um/p2k/ntf31AyITpYBZ/Ps++l7Q0tOyaSH97ytcC0
 +frydmTG+M7zGNWAeHEZqmA0/BZ8lfXr9W8cbsFftrIimM3xlFy4/HrPCfW2dBcm3DLE4R
 WCZS5rwMT6pl5kCm5S/jjurM07kE848=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-GnmA74GTNLSMYqZ5Y2xhZQ-1; Thu, 06 Feb 2020 16:20:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01CF61007277
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:20:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68D4160BEC;
 Thu,  6 Feb 2020 21:20:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/46] qemu-deprecated: Remove text about Python 2
Date: Thu,  6 Feb 2020 22:18:57 +0100
Message-Id: <20200206211936.17098-8-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GnmA74GTNLSMYqZ5Y2xhZQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Python 2 support has been removed, so we should now also remove
the announcement text for the deprecation.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20200109095116.18201-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qemu-deprecated.texi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index ea3e10bde3..97668edf92 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -351,14 +351,6 @@ they have no effect when used with @option{-n} to skip=
 image creation.
 Silently ignored options can be confusing, so this combination of
 options will be made an error in future versions.
=20
-@section Build system
-
-@subsection Python 2 support (since 4.1.0)
-
-In the future, QEMU will require Python 3 to be available at
-build time.  Support for Python 2 in scripts shipped with QEMU
-is deprecated.
-
 @section Backwards compatibility
=20
 @subsection Runnability guarantee of CPU models (since 4.1.0)
--=20
2.21.1



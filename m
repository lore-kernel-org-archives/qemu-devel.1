Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E9C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A6C20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwK3IruP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A6C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUUf-00074y-9L
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipUTX-00069s-IG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipUTO-0007zu-Jw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:51:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipUTO-0007xP-FN
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578563485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R1fR3737Lv/UEQJxtppOOADnf3dLezBh8D0Q4ghgqIY=;
 b=JwK3IruPCqBe0fYyG4BxQghuqgrkmEB8CGjqDiuvp7O+EiDYKYfmY6j/kz6yQteBV59N/9
 Ja/PRnAhQSf7b5ybIw2G6uE4mXmBhvpMaguRqjfMDLc/c/yhzj6dSLcN70PJ9es7r0Rbi/
 6tK0h8k49/Bbs9r3NzjryKljO02vOC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Jd6gC2FvPoyFCFoVlA9yzg-1; Thu, 09 Jan 2020 04:51:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFE13477;
 Thu,  9 Jan 2020 09:51:21 +0000 (UTC)
Received: from thuth.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C7E086CAB;
 Thu,  9 Jan 2020 09:51:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] qemu-deprecated: Remove text about Python 2
Date: Thu,  9 Jan 2020 10:51:16 +0100
Message-Id: <20200109095116.18201-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Jd6gC2FvPoyFCFoVlA9yzg-1
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python 2 support has been removed, so we should now also remove
the announcement text for the deprecation.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 7033e531de..8b23e98474 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -341,14 +341,6 @@ they have no effect when used with @option{-n} to skip=
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
2.18.1



Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ACEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53086206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYOYg2a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53086206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufwH-0000AK-8O
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctG-0007xE-3M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctF-0007Mr-0n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctE-0007Lg-UA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tTJUVNUTqrtyvMtlE8g0R7jZIoGePCw/hdMPnUY4Wqc=;
 b=aYOYg2a10GgtYX5Q5IPr5nclup6bjk3d4YCGJA8R/trgO2/aORl9lqNmwhDvqXxoNZQSFP
 OFZ2H2qC1mjIu67EL6odE4iv/PFcYD4garizB1qLQasUgFdo6OxfVesVYSyX1J0l6teCOn
 JB37mmwDEL+R68Am4TaTHJeucEMcHtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-_xHPP617O7aoJk9AW3y27A-1; Thu, 23 Jan 2020 08:51:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6957318C43C5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:18 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63F7F1CB;
 Thu, 23 Jan 2020 13:51:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/59] Makefile: Remove unhelpful comment
Date: Thu, 23 Jan 2020 14:50:05 +0100
Message-Id: <1579787449-27599-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _xHPP617O7aoJk9AW3y27A-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

It is pointless to keep qapi/ object separate from the other
common-objects. Drop the comment.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 395dd1e..c6321d0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -71,11 +71,9 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
=20
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
-######################################################################
-# qapi
-
 common-obj-y +=3D qapi/
-endif
+
+endif # CONFIG_SOFTMMU
=20
 #######################################################################
 # Target-independent parts used in system and user emulation
--=20
1.8.3.1




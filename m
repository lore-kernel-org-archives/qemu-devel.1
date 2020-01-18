Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E3C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B86824699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpgChz5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B86824699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isop3-0006X3-3O
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isokc-0000RO-O8
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isokZ-0007iw-OI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36512
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isokZ-0007il-KK
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579356415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VNUfzxXqcHuILcW1VKvscxZ//xM4OxDV8QQYNvQ7dw=;
 b=gpgChz5xEvyH1OmNjdlVmC4IZKDmke7bG7hly8t3/pMaBrlk7tTMA0Lg/numyJp6CHX7GJ
 VkBx6FEfFN8x0v/dGnXAX9oagX1sXEfBOfZ9O9a2PwFzitIUmdp8Erg00tnCwmQXsmnNX8
 UhyMyYM2+RHiqMkZ5w4FPkDn/wXDQf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-MAZvt9-QNrik0xxkmF_XXQ-1; Sat, 18 Jan 2020 09:06:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E85800D41;
 Sat, 18 Jan 2020 14:06:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABB3B5C1D4;
 Sat, 18 Jan 2020 14:06:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 4/6] Makefile: Remove unhelpful comment
Date: Sat, 18 Jan 2020 15:06:17 +0100
Message-Id: <20200118140619.26333-5-philmd@redhat.com>
In-Reply-To: <20200118140619.26333-1-philmd@redhat.com>
References: <20200118140619.26333-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: MAZvt9-QNrik0xxkmF_XXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to keep qapi/ object separate from the other
common-objects. Drop the comment.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 395dd1e670..c6321d0465 100644
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
2.21.1



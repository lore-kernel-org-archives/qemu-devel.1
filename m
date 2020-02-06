Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72510C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAE821741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izghO-0003YD-Er
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgch-0001Mf-8z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgce-0006Mq-96
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:11 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgcW-00060H-G7; Thu, 06 Feb 2020 07:51:00 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWitM-1j1zws2frE-00X8C7; Thu, 06 Feb 2020 13:50:46 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] qemu-options: replace constant 1 with HAS_ARG
Date: Thu,  6 Feb 2020 13:50:23 +0100
Message-Id: <20200206125027.1926263-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oUS9/CdvOMTgMQUxXzkvMUnhIKE+wbz8rdCq2y0WIs9E41NNsNp
 z7d1JpcONN9ivWLRIapo/5quaJv6DrNIaKZhhJwRV7vP/k5OX3aKs9+Lt4LyCf9YrNOIOd2
 pD0rgm5Oa9kTJdxp7craCW7YYT2zYcPnrvQo+5IP8dtR9Ffw62AKYCvlGHRBAWpjgtb9R/X
 BoIZL4WhNC2YlTkt6BXiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oCwD7SN5neA=:iogWmR6DI49knC4Kql8lrV
 qb2ZwyQK8f1kCwAYiNIK85dPEBIsxLFMxigtpoWedagIzXgebvoEIUfkcnDWO9vTwQIKWQvIK
 Yp42cUwMezy8fX+9kei9Kv4R2OQQphB86nC3HJO1EiSp7rnujPeH2tm6PLETYfLEk+OBpIp1Z
 WfnKCtZI0G2dtUPVsQnm+/kDWPuVg8KUKsYxAEXLnQQY5Mc/pm4stguTiUguAl2XCkThAXcDh
 C1FVnc77/EJB0M+DSIj/wLXOiLd/mvOWglURLYdElhHHTpNotHzwkdvfhYIWX/N2ILpWJJuwC
 Iwy26Rcb4SfWxvcWcLyGwTf9Rd6G6YKYrnlMj8Eym/TR2yCU7Jmfm5u4Sq+dJ5Qfmp9DJ72fq
 uNzYihVBSIJxEfAYKC71rr6T8a25wkQAQ5AS+rQ8QbdrkOwxYDwQK/yp8fuWV5YF3AvAY01Fe
 /9H1JGnswftqUTibxzSHzYxRUPVl6dHIyM7rZOMpOIlr8VfyqV/b+pAP4mTiL3oIKx4dt41W4
 bbjr1mKcQzCvQ+Mkaga7LrLWUvt09bkYCkT0p3rn8dvYWCraNAHKC/af9KwlyGUMxx2mANIRq
 ZcrKW2FpZf7+1R5FN5IGgTWGVbWx1Yti683zkzzakMF4euK3k8dJL8oRzMSkW9nGm93/Vn2le
 95h2H4CssrkJpZM1Sy1JPILQIQOYYnN0cehD6rVuK3tS5uDY1kSyrsu8Ei2y8ATvsdWlbN9Po
 BIb1JUy54dBxydLhm4GLhjxKfus++aSqO2No5UoE6B7z6koGCBjgzLzMuSG+iDZAS0brGL/6G
 Rz0YQir4oJeGrPuhSzCFo6V4JigyLakHqIdBmmtd5ujgjWp9uLZTAxqH4x8VnwBDMmTv3LP
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This is the only instance of a non-zero constant not using a symbolic
constant.
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200204165638.25051-1-jsnow@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 224a8e8712a4..ff3e806977a8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1955,7 +1955,7 @@ STEXI
 Start in full screen.
 ETEXI
 
-DEF("g", 1, QEMU_OPTION_g ,
+DEF("g", HAS_ARG, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
     QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
 STEXI
-- 
2.24.1



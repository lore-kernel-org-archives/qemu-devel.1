Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A13C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B73208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B73208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50409 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeSL-0004aI-Io
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:31:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHc-0002Dp-K5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHb-0000V2-JC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHb-0000U1-EA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:20:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7CF5307EA8F;
	Thu,  9 May 2019 08:20:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C22B5B680;
	Thu,  9 May 2019 08:20:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:30 +0200
Message-Id: <20190509081930.19081-15-thuth@redhat.com>
In-Reply-To: <20190509081930.19081-1-thuth@redhat.com>
References: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 09 May 2019 08:20:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/14] include/exec/poison: Mark TARGET_FMT_lu
 as poisoned, too
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already poison TARGET_FMT_lx and TARGET_FMT_ld, but apparently
forgot to poison TARGET_FMT_lu, too. Do it now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190508150608.3311-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/poison.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 1a7a57baae..b862320fa6 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -44,6 +44,7 @@
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
 #pragma GCC poison TARGET_FMT_ld
+#pragma GCC poison TARGET_FMT_lu
=20
 #pragma GCC poison TARGET_PAGE_SIZE
 #pragma GCC poison TARGET_PAGE_MASK
--=20
2.21.0



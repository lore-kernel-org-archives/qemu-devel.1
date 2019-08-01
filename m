Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B518C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150ED206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRblJsCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150ED206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKiz-0007PI-D1
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhH-0005Xa-EK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhG-0002d3-Fi
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:23 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKhG-0002cP-AW; Thu, 01 Aug 2019 19:41:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id f5so26229662pgu.5;
 Thu, 01 Aug 2019 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=sRblJsCzFkP5cxUc0otHsHJIx9cnvVRdxSxVbV5r4nlaQUA25oPZ3zjR1D4AVM4IEL
 bD5S9ztG1h7BBoiiKzmrFyJqiPsoq1zM04wZCLADPo6xAx0p6GzkO8L5wrqjtR0FHqr5
 Sl+JtdCAISYTtjWMD1qxJWuNxH8Zde3Z8utcG1yrro/brXKLs9wQMtlABfCQ437WHJBy
 z3TELbbX+8E0iQwM+LlyT2LwiVeqwX27ChXzDxupbUWTx0Fmg6DZGJpFAZeG5LyroeHC
 JSDrbdOZPLsxTjpInOpraPZEYwODwB7YeLuBPPcGX4mUXu7OPwKLCYmp1BrTYuCvYbp0
 6gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=nVtkj5xN0gHt7ILwc1pjX690X31P2c4mO2oyaImwEq80qYCgsJRkyQnxazQ186LRt2
 mlGctTYTWe3Eb2iNO3CCVDwxYmxphbTJEQR4+GDuaHTsmeK9H7t9HDKHAz1wgLTCCmwY
 kiWp35l385NHbrYcWfNo8D8HcSqohSTsQDXgcVFXSbPpwT2jAvmlRQ+jgvdrTk5+/c+l
 r3vVe+dhqPpCG8oTE61QUjpLY2khOQeJcsoAX77SOx9tl2PLxEYsuwjxYFwQCkl14eWi
 xl/HNwqROlrmfBJlLQGlkaJKIQKihOewCHjqIOXPKtDTc6BG1dzMH116pJoNr9EeBtxy
 UjYA==
X-Gm-Message-State: APjAAAUdLnp3EGb33m6HTl0D1olE89whO6Ve07JC/FI548K4YuKAejcz
 oVMSptB2gJuT+g1wKI/u2xAGfKJz4S6qaw==
X-Google-Smtp-Source: APXvYqy76Pmq4P8MzDrDXm3AcVoRzrsr0vLd9ULztHgi/12FeyDStq0M3pdWkpb37AG3RINBv/cC9w==
X-Received: by 2002:a63:c70d:: with SMTP id
 n13mr120222407pgg.171.1564702880898; 
 Thu, 01 Aug 2019 16:41:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.41.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:20 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:17 +0530
Message-Id: <20190801234031.29561-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v9 03/17] block/block: add BDRV flag for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..e29baa172c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.21.0



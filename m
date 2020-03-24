Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA65C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F920774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJUqmdcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnLj-0006qM-Oj
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmiV-0003Sj-6H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmiU-0007wE-7T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGmiU-0007vz-2U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id 22so12193604otf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=i4y/hjStADTs4XYJUMM2HizGinURYTHFuzvbnc9AFAQ=;
 b=XJUqmdcldOcsxSNkBke8bWVrJmbn3fi+FeDOzYeQJvIeHcz98XbS3R/a0L/1MFMCDi
 Y8OQQe4KVWX108QauVKsKswEkObYeYcrM2JgkOl+j879YUBnUC7RbBu5IVe7Pp5wRPo/
 KNZ07AaiAGktO685JMO9qxuTpGap/c9j+reSiLev5a2FZnSIEhbU6mQSjIoSe7LPrjr1
 IHqP9sniZJoEiuc+zawbA7UB9GD46559ZcUFDV3doF45UldS/Wpc6w8gLweAhxJA+MQS
 doClOfmSMwbGLGkcZ38KkFa8fD+33hs0InluDiyA5xXYzw+QRDTnST7p3vkqDfoDAwFk
 V6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=i4y/hjStADTs4XYJUMM2HizGinURYTHFuzvbnc9AFAQ=;
 b=iw/MduJFHuIRgILBWngvyyiAvqoZzvz1TRI3m3eg3w1M3Hjni2ScBGrCyjCRDmMovh
 8DB+heBlXt8/IC7wIgwepZwFXK/R/Gjq/NFRva/8EwzJE0mz2Em07MvGh1u96nmTlOE+
 vi4RzdppLbt/1H0E2brhfKU9CQ7DMyaQrdIcbxDY2B1DVtm7H4HBl2f8Sotu9GHgMIAa
 wzLLkwh3wP6E3SVp1kjR81Yr7kk9qF6K95QfbyV/gtc9tq2nx1g4bbopU++Uw/mtLUHz
 A/vsVRp62CysO6KlycgTwsAfzHWYJVEldPfL5ONh6Triy1BTRjTY9XGcMZ8P9uYZRE6/
 KPxQ==
X-Gm-Message-State: ANhLgQ07WUNEE7Q8Cg5Fbs9o+Sw1vVDt8+jT6Eo0wXPi2GLX6FT+1VBG
 0tDS/R3T9Mbg8sAgx3MZS1t5XQM9R4w=
X-Google-Smtp-Source: ADFU+vufdZL/MRyTRsbOoGVRuzOO7vJb2ijvo/hqDzC+mgRSKjLTs2Vo70F14nJLmrEgxo48L/I0Ow==
X-Received: by 2002:a9d:754e:: with SMTP id b14mr14718276otl.293.1585068468879; 
 Tue, 24 Mar 2020 09:47:48 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h3sm6152625otr.4.2020.03.24.09.47.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:47:47 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 4/5] qga: Fix undefined C behavior
Date: Tue, 24 Mar 2020 11:46:52 -0500
Message-Id: <20200324164653.19449-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
References: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:20 -0400
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

The QAPI struct GuestFileWhence has a comment about how we are
exploiting equivalent values between two different integer types
shared in a union. But C says behavior is undefined on assignments to
overlapping storage when the two types are not the same width, and
indeed, 'int64_t value' and 'enum QGASeek name' are very likely to be
different in width.  Utilize a temporary variable to fix things.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 0b4b49387
Fixes: Coverity CID 1421990
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index f8852beb9c..4471a9f08d 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -482,10 +482,15 @@ done:
  * the guest's SEEK_ constants.  */
 int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 {
-    /* Exploit the fact that we picked values to match QGA_SEEK_*. */
+    /*
+     * Exploit the fact that we picked values to match QGA_SEEK_*;
+     * however, we have to use a temporary variable since the union
+     * members may have different size.
+     */
     if (whence->type == QTYPE_QSTRING) {
+        int value = whence->u.name;
         whence->type = QTYPE_QNUM;
-        whence->u.value = whence->u.name;
+        whence->u.value = value;
     }
     switch (whence->u.value) {
     case QGA_SEEK_SET:
-- 
2.17.1



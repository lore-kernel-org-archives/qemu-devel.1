Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9699C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A337D214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VakG3AdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A337D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoEy-0003fg-CE
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5p-0007hV-6H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5h-0003IG-1f
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:29 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5g-0003Fn-Sh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id e12so2880848otp.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pQrNrlutSjh4UjFqEukTp7P40byeYhsqRJhsys+eh9E=;
 b=VakG3AdTk8YJ/lPm0bxWU2fWgXODErwMaQbs1amdlkJKzim7+0taiVUwHQgmqbmiKn
 bFu0vrb6BhKhD9gt4Jk15Uzg1w9iPgQaQfZYoUKc72VV8/TemimoMmo6U6rTMmcjP4DZ
 Nv4W2IxIMrDUMygH0cOk9YvXBrX0o1Jgp964Wgc+G+KkyP8jGRjo9TUi/51aGdGUbAQQ
 TtOZsNUxsaxoSlHNi+6o4wF7TxmH9vKkxT1d6df5hpcW02kWxXOaDSCeozF2YQnYEqjC
 i/vb+AlfrB3AtbHzi8IR0Oh5DFlUWuMAffaloM5smp8Z03MCu8Ar/PjIGOGayN67Th43
 sSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pQrNrlutSjh4UjFqEukTp7P40byeYhsqRJhsys+eh9E=;
 b=fZ4TszrGToXpBCo6zFHJMUd6kYo5RJ+UTMo5ntTOEGwbcLC6/h6RvV0fJqL8KRms/2
 DhrEm2plXg4ef25EQak3csa1q70AHYoLHUBcJYpUBLIGgF88WU64THYfuKECLhAwiyuH
 zL1cT1k+Dz43sGNv1KmCvyg5M6zkWQdD5OJ/5gQAMZ+DE2yc1Jj0wZ01jYdpqZRfRafY
 jPYqH/APuP+iuFf64MFVJHAijBavG7+dF74T0HAu3kq3fO1Y5mtAd7oNrTaWWhX/TuRT
 u0sw2O+tOtSdb3f2cU1nm7vS4osEHlXoXnjSha+6RCrG1MFALxI4Nj5Tu18XWPQOR8O3
 1W+g==
X-Gm-Message-State: APjAAAUUYbVA23a28MdlZ0cXKxPLEJ8EDu3efCsepgdo1F1HPjPEPLdG
 6jxN8unIYt4LLJwFFu9X5g==
X-Google-Smtp-Source: APXvYqy5saHztBC4/aREnzmk95haJv2h9GxhnpTnMjqdU0pfO1jso1JjIRmftL0uLAXZ8WZQw6L9+A==
X-Received: by 2002:a9d:4801:: with SMTP id c1mr19981615otf.94.1566245839964; 
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id r2sm5743461otk.49.2019.08.19.13.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 7F4B71800D1;
 Mon, 19 Aug 2019 20:17:17 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 4169B301220; Mon, 19 Aug 2019 15:17:16 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:55 -0500
Message-Id: <20190819201705.31633-6-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PATCH 05/15] qdev: Add a no default uuid property
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

This is for IPMI, which will behave differently if the UUID is
not set.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-properties.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index bb34a614e2..47b7029ccd 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -235,6 +235,13 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
         .set_default = true,                                       \
         }
 
+#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
+        .name      = (_name),                                      \
+        .info      = &qdev_prop_uuid,                              \
+        .offset    = offsetof(_state, _field)                      \
+            + type_check(QemuUUID, typeof_field(_state, _field)),  \
+        }
+
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
-- 
2.17.1



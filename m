Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE8D2196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkPB2Qv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE8D2196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Zj-00059g-Cp
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49b-0001Xm-6T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49Q-0006AN-3q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49P-0006AC-TQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id k25so3980224oiw.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gWzJgnmTsjgDALss2ZvZftEVRHxBMzzLKAhMT/OJ2C4=;
 b=ZkPB2Qv/ZTphNpr1Cclbl3gSK3dZziExaL0MZGDcu14/ggovvDLoCqNMeeng7b5b2r
 PHSWJn9qIh6Ujt9mZnbKfVA8Y0egX9Ix5dMJr11C/8mckWjSVf0LuiOtJ7fGzDVKUopu
 wrD1LZ17BvJBm0C/HZOLsjKTn7HUe+tjMO19ki6RSwd9nI9clh4e96zISBLlGtxRdZdj
 LODrkSMe9fOZyH0zYDEwnui6mZ3pbMGe4Q7ZOCu5NtAJ08sGjtorTbBlOAc7sJ0U3O41
 sKaU5pig5DkOD8ipzGuGxPWjzOE0+e0AN6z0TIAmeZbrVN3EFQCxN52HyfFxGqwdh6Yt
 Oqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gWzJgnmTsjgDALss2ZvZftEVRHxBMzzLKAhMT/OJ2C4=;
 b=lQF7fTU01lUorYT2cx0VDP2mCyZVN0lismbqKwYzMmbsCnxC9vfJGmIC6p7TnfPwNC
 NdpZJ/Xv8oAw4EDdJ21Dmls2Kq4ZqcO9OP+OLxjxCVoTZ1ShohZ3m1T2+9WCLpxMVmM0
 DAdQq9SauS0vsfi9vK2OuodaEEDthxQ8H9/+nAAS0l1JIUum+ILjiKeqej1a7wIAFyef
 RTZWXPg6nVg6+fdUtZVjCKdX2ESblUzrq4DW4dqyKTA/KGe1XTidV/cjaBZmUDx+kGZy
 Px2rku4SN7DRQCPlgCmm1Vvfjf9yIqeVFd1VZUojr4vj43gyyIpx4ummk1Hpzq5Et1xC
 Je3Q==
X-Gm-Message-State: APjAAAWZLgyOdcRPkmgGpfHxVDKhYy12Mm/ngjGztklAZs0KxSgtMpjA
 w2nc16PEwregkFOPa2kwMg==
X-Google-Smtp-Source: APXvYqyQ2lfqpjjaLX6qhYLtBAa2f+Bq/a8RtqwE2Z8IalQXEMAvxn3ouTVqfzjEf4vI/h7jvpsbPQ==
X-Received: by 2002:aca:4cf:: with SMTP id 198mr22057oie.109.1568929183027;
 Thu, 19 Sep 2019 14:39:43 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id 8sm35705oti.41.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 37AEE18059E;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/15] qdev: Add a no default uuid property
Date: Thu, 19 Sep 2019 16:39:14 -0500
Message-Id: <20190919213924.31852-6-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
index 2e98dd60db..c6a8cb5516 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -238,6 +238,13 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
 
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



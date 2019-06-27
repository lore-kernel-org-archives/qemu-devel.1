Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A1C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888CC2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUpOwAUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888CC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTs9-0000gq-Og
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpb-0006yI-2p
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpT-0003iI-7g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:50 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:38894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hgTpS-0003Us-Ej
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:42 -0400
Received: by mail-oi1-x22a.google.com with SMTP id v186so1467825oie.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NO976jdjcFbYo6B4xUhDqG/yyhIQxVSBAlIMZVWwaus=;
 b=dUpOwAUbwktlxlpmYLv8s2PXazcdMOTqU52XVwiFrgze3ljKHq8Wh6mpvEc//w4vd+
 PTHHA2Go0hwHsGIIHYw9Nmjtnh0qwV59if2mLeIjO+YEa+NDrfmJkU+cwEczgJ1wOUS+
 b/p/9jf9gOnneWNsg7WhsdlTbHx+RO49vvm5s6ztkn1EcREGeEKzJDydLtmI6907e12b
 R6HCvfsDNYhZJPwpnlCCuy34mg8tKCnWyNgRp/aY3cevXf6q2yOm4K2MVe+mB/fhuln+
 oXstMsImpVC1kgu6F8xFg0VCIrBU/61IO4SwlVH7mu2B3FEgdlGF34cEE9+eewz2FhdP
 xDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NO976jdjcFbYo6B4xUhDqG/yyhIQxVSBAlIMZVWwaus=;
 b=Tl65RWvmepFpsJiZtoUgSZ4mwlUD4dm0ceubTe8CYOgABwKvKt7FqwzVmKK9ngqA5k
 qCtoZJN0DfXy9+8XeNuEJsVflwEDcTjDHeFQ7jgFVX6LoWNExaahpILKr9LIvjiRQH9a
 QTP/DIP7r7QvT98JFRdH9+1kW9jocau/bCnwzP9xTY3fKXr29CrkUW4MiYSsKFVmEQMu
 Lv5pYHuzwzQWWyFwV/aHDkeyaYqQasrDX3lTn8olkTwuFEOchqQ5kJsyZH39B+x6rJ+I
 ipdDDwjPkbl1N0QPBexV+XWRfwt1eZW1SyhrObaTyE+FEOiLMa9K4hJcIytp975cIoJM
 8UZg==
X-Gm-Message-State: APjAAAXElyh9xgaxXR03A/XrCkXSFRR+H/5gJgzw/lUcJyDt+uJoAK4n
 BDAPfJ218Cs0x9lX7UvVEw==
X-Google-Smtp-Source: APXvYqyIvQgZWTnN1iSptbWjSkp0dPm2qY6XFbUBGW+Tm6KVSl4Psskuz9fLjVqJmCpS4mbsfONy0g==
X-Received: by 2002:aca:c256:: with SMTP id s83mr1991984oif.111.1561639705721; 
 Thu, 27 Jun 2019 05:48:25 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id y83sm773314oig.41.2019.06.27.05.48.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 05:48:25 -0700 (PDT)
Received: from t430.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8437:2822:278a:bbee])
 by serve.minyard.net (Postfix) with ESMTPA id 8D8761805A7;
 Thu, 27 Jun 2019 12:48:24 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 4AD2E302332; Thu, 27 Jun 2019 07:48:24 -0500 (CDT)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jun 2019 07:48:14 -0500
Message-Id: <20190627124815.29536-2-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627124815.29536-1-minyard@acm.org>
References: <20190627124815.29536-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: [Qemu-devel] [PULL 1/2] qdev: Add a no default uuid property
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
 QEMU Developers <qemu-devel@nongnu.org>,
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
index 1eae5ab056..7fd887af84 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -237,6 +237,13 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
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



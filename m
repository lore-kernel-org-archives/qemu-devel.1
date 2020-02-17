Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425CC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECF620725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeOZbRy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECF620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dDQ-00011u-9w
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3dC7-0008Nz-OM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3dC5-000612-G6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:00:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3dC5-00060J-9A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581933600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aBUM4RhrFQaFVL53PnuDx46tuqyZHMgvM89LDIoHmC4=;
 b=XeOZbRy65gGx5xDmNKTvQp3/jkwHwUMUEYMb2N37Hew7QNVxmkHr3qq3HEWAIGNSfxi4EU
 9Ln0s/ikXlMY3zWQnoJiXaC1KsDDLMw7+lTP/XOi2eMBTVQljWwbbs+bbIdO5c6/oY5oce
 UvzIbSXYE5c9y05Zf8clvIH7gxQraMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-U_YmfMbQPY2WGdI96k9XCg-1; Mon, 17 Feb 2020 04:59:58 -0500
Received: by mail-wm1-f69.google.com with SMTP id z7so6797113wmi.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UCF09Fgd49cOgemPoXX5ZeHHrmg7S4hpMM+6xGvqp9w=;
 b=J0qUhQKQBnGF7DArER6cSEOuseH4wmFW8JoPSOdbxdxSFE+hAc3OIKL6y5/Zg00Lij
 FFetJ7CGMFfzJbv2O+uhdoOhsITKqHIOoJkvCsX3KVixmc69QGrtYco5yDWeYnfBXfLh
 I8c1evfL/KeFK5Mfartr517Sb2bGlYA0lHuYfJsgLD2enpSEsTnPImF0vG5QVYstMbQM
 WTG3fnpuZ0ItDM8DpV0quU9UqIQ/74/Cb53RCitJ+nt1cm2GCx0xCNDUXf9cyw7t0W3f
 T93WeA5dU9o8va/GW7xUqi5Udn0AmYsOOHbFKm0vbzomN4Fvwa2Xoy0eFlG09gV5EIlA
 EVdQ==
X-Gm-Message-State: APjAAAUX63M6TG5DC91F7FF4518wcQqQDVZ5t3G+7inldtrb65ZISaGy
 gtu6Wo3WQ+lXB7gYcH4KiEMHiuWoEqHi3Ng9h5ls3/Fcnwmn1IWspinyBAQWhYCLZ8DYaDF+T78
 PcLlLpOEgpSX5tBM=
X-Received: by 2002:adf:f58c:: with SMTP id f12mr20389658wro.22.1581933597393; 
 Mon, 17 Feb 2020 01:59:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZyZrzOhEz6IwIasyHwl9kujQo0qwUfK6iOs84BdJhqLiLH6akTeBJ5Eoyr6OKpq1h+6xO2Q==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr20389637wro.22.1581933597220; 
 Mon, 17 Feb 2020 01:59:57 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t13sm228546wrw.19.2020.02.17.01.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:59:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: Avoid compiling system tools on user build by
 default
Date: Mon, 17 Feb 2020 10:59:55 +0100
Message-Id: <20200217095955.11140-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: U_YmfMbQPY2WGdI96k9XCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

User-mode does not need the sytem tools. Do not build them by
default if user specified --disable-system.

This disables building the following binary on a user-only build:

- elf2dmp
- qemu-edid
- qemu-ga
- qemu-img
- qemu-io
- qemu-nbd
- ivshmem-client
- ivshmem-server

The qemu-user binary is not affected by this change.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2:
- use simpler if/else statement (therefore not adding Richard R-b)
- improved description (Aleksandar)
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 16f94cd96b..d1877a60f5 100755
--- a/configure
+++ b/configure
@@ -455,7 +455,7 @@ guest_agent_ntddscsi=3D"no"
 guest_agent_msi=3D""
 vss_win32_sdk=3D""
 win_sdk=3D"no"
-want_tools=3D"yes"
+want_tools=3D""
 libiscsi=3D""
 libnfs=3D""
 coroutine=3D""
@@ -2199,6 +2199,16 @@ else
     echo big/little test failed
 fi
=20
+##########################################
+# system tools
+if test -z "$want_tools"; then
+    if test "$softmmu" =3D "no"; then
+        want_tools=3Dno
+    else
+        want_tools=3Dyes
+    fi
+fi
+
 ##########################################
 # cocoa implies not SDL or GTK
 # (the cocoa UI code currently assumes it is always the active UI
--=20
2.21.1



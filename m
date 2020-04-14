Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158FCC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E1B2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJxGhJiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E1B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIkp-0007J5-VT
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOIk6-0006NQ-Hi
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOIk4-0006JG-Ux
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:24:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOIk4-0006J2-Rd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586859872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3LUSN68By7GXDCNFcXg97x6JG3M9Y0txbo3rfMOS+jw=;
 b=IJxGhJiHd3IDUoc6W5Jjn5lVcfulbyK7jbycXKTK/raUi16aZwyeKKh5eNJ1Gja1ayHkHa
 mRP8GvSQSPOcBumDrGrIrn1Vhe/rHuXsfpcCCgXvHy8l+XAgd2TcTLYLjVikRbbXfDlfs9
 XF+cmtXPgxE4361vyMaOJiuzyaXOhak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-6PaJ8aTUM5-dUTQI5fikiw-1; Tue, 14 Apr 2020 06:24:30 -0400
X-MC-Unique: 6PaJ8aTUM5-dUTQI5fikiw-1
Received: by mail-wm1-f71.google.com with SMTP id n127so3588541wme.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t9E1GwNsR6rUONzYsXKvSxSFUaDQMMKRLLPUd0eAVmY=;
 b=KCj4Np/HzLX70L5E85JG25LVLUMrccot22v049pZkyxxFrhjCfXENR+e2gBH5rgloZ
 RUgJvWK7DT5B0X4U0av2Y3o+zFVR/9oD14uWvEBkM/16Au/B4hYHqNEBZ32f5GZLXSRl
 nFZl/C3lO/I5MXCADpzkN+UmGxLloqyHTkKsIUFWWA+s7u4Lj4DDVdkysDMe8dqIOmGM
 OwMNwV0dGh+uhoTQLRMudltH650qMBUjQRpxWTLldmGnqqAiQ6XggoLEoz2upQccTfQE
 omlXgNLwxP/5ljg0Ih/u3H0H+Yc6UxSTVf1qFi8WTAt/TEnTaqMlQvv5jivEIhbV/+8O
 c1pw==
X-Gm-Message-State: AGi0PuYuCScMk4i3BsfL1pVHdfNNl7TtA3qXO8Av9lInCOlWhj814sTx
 ++yHP7CR8eWpkM3x5SSTh5gK5Qqz/wTVcLtQSBiWzpL2UD9NhW5mBQNfS0CILQmzuYWuri+h+8E
 ZJywp6nRbhGu0LL8=
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr24395650wmj.185.1586859869452; 
 Tue, 14 Apr 2020 03:24:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPLRhDKCZlkba0V+nkKGZ5RGTY9WvO1C99No1msj2x6q56zZIRMK5N3PN61qDPF/EejrJrvw==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr24395635wmj.185.1586859869224; 
 Tue, 14 Apr 2020 03:24:29 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l16sm3475766wrp.91.2020.04.14.03.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 03:24:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
Date: Tue, 14 Apr 2020 12:24:27 +0200
Message-Id: <20200414102427.7459-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/gdbstub.h  | 9 +++++++++
 target/arm/gdbstub.c    | 3 +--
 target/xtensa/gdbstub.c | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 30b909ebd2..b52d9933ee 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, uint=
64_t val_hi,
     return 16;
 }
=20
+static inline int gdb_get_zeroes(GByteArray *array, size_t len)
+{
+    for (size_t i =3D 0; i < len; i++) {
+        gdb_get_reg8(array, '\0');
+    }
+
+    return len;
+}
+
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8efc535f2a..063551df23 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -47,8 +47,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *m=
em_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
-        memset(mem_buf, 0, 12);
-        return 12;
+        return gdb_get_zeroes(mem_buf, 12);
     }
     switch (n) {
     case 24:
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 0ee3feabe5..4d43f1340a 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -105,8 +105,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
         default:
             qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size %=
d\n",
                           __func__, n, reg->size);
-            memset(mem_buf, 0, reg->size);
-            return reg->size;
+            return gdb_get_zeroes(mem_buf, reg->size);
         }
=20
     case xtRegisterTypeWindow: /*a*/
@@ -115,8 +114,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
     default:
         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n"=
,
                       __func__, n, reg->type);
-        memset(mem_buf, 0, reg->size);
-        return reg->size;
+        return gdb_get_zeroes(mem_buf, reg->size);
     }
 }
=20
--=20
2.21.1



Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCBC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A0020753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA+1ewEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A0020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbt1-0002un-8i
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMbsE-00020x-5M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMbsC-0006ku-Ts
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMbsC-0006kR-MX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586456755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XpP1+Pjt6b6a5a97WHX4mOy2IBBm0OGO1n4M3sTT3s=;
 b=CA+1ewEOmLQ2s8w3n6k/Rhd8wbRfDCgZplcdKN08VHdaLJVnP/OFELt0cy4PZEDwrI7bLk
 3Kw0TvA63QUPq2eTlIe1M8s4xwLyKTLjuO+491D5pQbxtR074V5Dc08IfjvKLvOPmpgPE1
 OTJ30eUcUo+B/e5/Q8wqPocYYr3lmRk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-4ippi2MnPZmkyJLVRPrbyg-1; Thu, 09 Apr 2020 14:25:53 -0400
X-MC-Unique: 4ippi2MnPZmkyJLVRPrbyg-1
Received: by mail-wm1-f69.google.com with SMTP id c129so422796wme.8
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DMIBHhMmhgMRZOGANFmaZ+fu0Zf4rstcSLqki1mHDjI=;
 b=HbmsS0opbGbQI6TZRiwBY1deBkxwHxkVuPutyzUaaCWOm4AXmrEKbGcnTjMmkskY0B
 zdUWcfFyJ+wfTSqXD54MA3Bp6S2liTCe2bp3Dx7F5e118KFjerVV3JMgHMcNTFD+mibb
 lqsf8ojliaWem4PFX8m6A/52OcpuFB9ICJsJpL+/7+rdotyU6G2xen7G3NSx4NcVjaTI
 KDggRnYGJUyolVTbsfuLibryxJxOKNNMe+vf0bWG38VU118s+OiUYdyuUwhim3F7SeoE
 b5bBQxeRJrJNnwdA2F6P09x2+tGxhVkYgbaWV4Z7ZOUhRvZvmrMH1EyPy9XHCCq6mAS3
 dCZw==
X-Gm-Message-State: AGi0PuY7I/J8r0GmYV1nuYgih5jm65h7Bcc7nrYNb6RII6k9QmTqWmIY
 sa2cbQNJmrUtwdgEUkFyrLon+nN2aEEyLAo3u/75Z26ky+j3xotHfICGTSIGoDpQWWGy4jv7rbQ
 SOZkc5hZBlhZKrlg=
X-Received: by 2002:adf:eed1:: with SMTP id a17mr412556wrp.287.1586456752354; 
 Thu, 09 Apr 2020 11:25:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1Fr42UstJC0TB8JJEV6ItHPkTfsuoTjSvIe4kl10t1/uu+b5Dw7e0wVl9eYkegwaynpiM8g==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr412538wrp.287.1586456752177; 
 Thu, 09 Apr 2020 11:25:52 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a187sm3817882wmh.40.2020.04.09.11.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:25:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Date: Thu,  9 Apr 2020 14:25:38 -0400
Message-Id: <20200409182538.40816-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409182538.40816-1-peterx@redhat.com>
References: <20200409182538.40816-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should only pass in gdb_get_reg16() with the GByteArray* object
itself, no need to shift.  Without this patch, gdb remote attach will
crash QEMU.

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Fixes: b7b8756a9c ("target/i386: use gdb_get_reg helpers", 2020-03-17)
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/i386/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614e..b98a99500a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
     } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -=3D IDX_XMM_REGS;
--=20
2.24.1



Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC42C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75F2205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHT5Sy9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75F2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40465 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNszs-0003Cy-1e
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNsye-0002V6-1F
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNsyd-0005S4-1U
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:49:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hNsyc-0005Rh-Re
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:49:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id o25so7552303wmf.2
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=gUcCm4i1OeCf+HzJrBGVY7Q5mpogSng+t/VW/HOB4wM=;
	b=vHT5Sy9FxUkR8gbtJs1UxQY3ysKV+7pFHNEhZOCA/8c2DtYwSL0pALDfjYfaZW4KwT
	QaYPBVb7vb7zItEOKvz/pfKql7yTp6kFcj0t+nynT6fxAmB9NqwunNE/3q4R+B5RKEKk
	R+b1+7eUMXYgcgiXlItPlmZJ+uvCW2eTPmGKh3qvgLNOwMPLeCXZHlqwYtNE6CCMfPKz
	6RUXCWxd1Nr4WYAiZ9Bf4k/mEK+32ioJ31SNG4Ca6HqaNf2BPE/1PGauSFonhftu/C7o
	UtZIWqlBuchVxeaOeXTlQFT8yqjp88qSyytM/75dGOVmYUSbsg85yDpSxHu1ZAP2hzlq
	0V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=gUcCm4i1OeCf+HzJrBGVY7Q5mpogSng+t/VW/HOB4wM=;
	b=TsMZhlrfEHzPnGkWL3gr8+NuY4Go8cCvitmDWIAWYlhoPb2lcZXODisbr6S4jFXbqo
	5/SKQ9BBFIRrn755949PUflZfUdQjtArRIk8D9S1yj9gWJOT5DZWtBMknq6QHYiBCbKw
	O3MDu25Q3NTD5+R63EUSjtSTIoZD30k1pG4iwacnguGvlxUqGe/6rUKdJYlG86m0dsMc
	uR9KRk+JB8mb7X104sw+MdWxD9B3nhRWLEvusci3W6j9y5BmcMPhzFPFLyv/i4glKUkT
	LlT1fVDsPQVOcTiYlDSAl30qjE7N56nj/q/Fm806UAWvRM8Bw6Mp1StgDtmSTB7LBKG1
	Svjw==
X-Gm-Message-State: APjAAAXGmuqGLYnU8fmUn/jmnkEkRr/jdyeB9GbHtP/RQqgx55FjJ+7H
	E1VzGF96aw7yaR4WwZAQZ55ws/UM
X-Google-Smtp-Source: APXvYqyENjjQ5fXs9tlH8VJz5TvhdWJB0loXMP7DnPXfOTHyEJ2b8+wnjcx4YantKzCST/SJnr11vg==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr20192977wma.71.1557208157468; 
	Mon, 06 May 2019 22:49:17 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	n63sm11513439wmn.38.2019.05.06.22.49.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 22:49:16 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 08:49:14 +0300
Message-Id: <20190507054914.25261-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2] ui/console: Precautionary glBindTexture and
 surface->texture validation in surface_gl_update_texture
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
Cc: kraxel@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: HQM <hqm03ster@gmail.com>

In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
surface_gl_update_texture is not necessarily
surface->texture. Adding a glBindTexture fixes related crashes and
artifacts, and is generally more secure.

Signed-off-by: HQM <hqm03ster@gmail.com>
Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
[fixed malformed patch, rebase to master]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---

v2:
 - fixed malformed patch
 - rebased to master

 ui/console-gl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index a56e1cd8eb..c1cb3bd673 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
 
     assert(gls);
 
-    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
-                  surface_stride(surface) / surface_bytes_per_pixel(surface));
-    glTexSubImage2D(GL_TEXTURE_2D, 0,
-                    x, y, w, h,
-                    surface->glformat, surface->gltype,
-                    data + surface_stride(surface) * y
-                    + surface_bytes_per_pixel(surface) * x);
+    if (surface->texture) {
+        glBindTexture(GL_TEXTURE_2D, surface->texture);
+        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
+                      surface_stride(surface)
+                      / surface_bytes_per_pixel(surface));
+        glTexSubImage2D(GL_TEXTURE_2D, 0,
+                        x, y, w, h,
+                        surface->glformat, surface->gltype,
+                        data + surface_stride(surface) * y
+                        + surface_bytes_per_pixel(surface) * x);
+    }
 }
 
 void surface_gl_render_texture(QemuGLShader *gls,
-- 
2.17.1



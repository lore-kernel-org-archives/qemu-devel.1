Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E1EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670A420409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUx6dsgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670A420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu4F-000599-F4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRJ-0000Xy-F5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRF-0007uz-Qs
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRF-0007mM-DC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id f3so15285632wrw.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GepS+RBgIfLthS0hHsFgjFpLev7UFXBivw+uaPGBApc=;
 b=qUx6dsgqVC2U0YNRqa+a3JBiPqNaMAKBGYqmHIoPjpBSZZclRm15foe2xZeH0I1ccm
 /R1qADFU1V7mZ6zJBW7jbPRKjxdLi48H/+ZCeCSsVPKxyrCK7o4b+QTAVpijmGQjlaKJ
 VsOwtDrymGoxoE1B1GjQnVyHCafQVnPmaFoFny19hulQ5Ach6B7xDRyVPjNFRS/UfYuz
 +VrX9vsD4XATfGzi2xVfH5Yw4e85c4GrVUxWaNX80L0rb2V/ZVevnMg7PTt5VbLGcLnz
 SqJHFP7MFcVINRN8zm3pAdwztVeSFoqt9ELeM6bEKuEkw75zMhr7lNPBXCsgA/QySyPX
 Tk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GepS+RBgIfLthS0hHsFgjFpLev7UFXBivw+uaPGBApc=;
 b=s9F4HAW769B7w+nIQVGHq1yM0Esdj5grN8jgmsnSusXLM2hJCZRYGrVkj0gP6rBYqw
 mPfjnjaJ2Zv1ks/v11mH4c6fluJgkhh6evdV1qYi4A7werlPvKtMzng9SOA1OdIGRijO
 UQC3oBYOEnkg9TFGP9bVPCA6H9i3XJ9l4l47njq3erUASpSpZ37ZcvKsQBvULQ9Cg4HT
 soMOc1ZteIvM2fNzSq/RQniXDj0mlxUbHlD+hyNVINJRYzzVdg/ofH1q8XjcFK9AfxJg
 x1X2KRVRp2BwU8clSI57xLVrSFi72sdyCfNv2mPII//ekMORD7wjBi+6xDf+OGf51gHN
 icBw==
X-Gm-Message-State: ANhLgQ3lSaVzPK4eQYnlbFEZ+F76znHYKYR/Dhh2nd11nRle3mglMSKe
 fe1wW3GiQEFca4rCGe4OBPxgE3Eu3Mg=
X-Google-Smtp-Source: ADFU+vunb8f+NCXHLrZ4yIAkGI7wyPJBJcb6fuPiaZ0cJkgAilJFfkyv+ig0Q6CUQopY3rUGIg4QdQ==
X-Received: by 2002:a05:6000:189:: with SMTP id
 p9mr353182wrx.391.1584379323180; 
 Mon, 16 Mar 2020 10:22:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o5sm483071wmb.8.2020.03.16.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:21:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E7B01FF90;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 04/28] tests/docker: Update VirGL to v0.8.0
Date: Mon, 16 Mar 2020 17:21:31 +0000
Message-Id: <20200316172155.971-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Building the qemu:debian-amd64 fails when building VirGL:

  make[2]: Entering directory '/usr/src/virglrenderer/src/gallium/auxiliary'
    CC       cso_cache/cso_cache.lo
    CC       cso_cache/cso_hash.lo
    CC       os/os_misc.lo
    CC       util/u_debug.lo
    CC       util/u_debug_describe.lo
    CC       util/u_format.lo
    GEN      util/u_format_table.c
  Traceback (most recent call last):
    File "./util/u_format_table.py", line 168, in <module>
      main()
    File "./util/u_format_table.py", line 164, in main
      write_format_table(formats)
    File "./util/u_format_table.py", line 132, in write_format_table
      print("   %s,\t/* is_array */" % (bool_map(format.is_array()),))
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.py", line 164, in is_array
      return self.array_element() != None
    File "/usr/src/virglrenderer/src/gallium/auxiliary/util/u_format_parse.py", line 73, in __eq__
      return self.type == other.type and self.norm == other.norm and self.pure == other.pure and self.size == other.size
  AttributeError: 'NoneType' object has no attribute 'type'
  make[2]: Leaving directory '/usr/src/virglrenderer/src/gallium/auxiliary'
  make[2]: *** [Makefile:906: util/u_format_table.c] Error 1
  make[1]: *** [Makefile:631: install-recursive] Error 1

VirGL commits a8962eda1..a613dcc82 fix this problem.
Update to VirGL 0.8.0 which contains them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-4-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index a1d40a56fa1..c70c916343e 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -28,7 +28,7 @@ RUN apt update && \
         libepoxy-dev \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
-    cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
+    cd /usr/src/virglrenderer && git checkout virglrenderer-0.8.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tests && make install
 
 # netmap
-- 
2.20.1



Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C81520575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s41d2B/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4IL-0005cd-PJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41W-0001yT-G9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41V-0002UY-St
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41V-0002QT-F1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id r14so229923pfg.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2sdxv3dgmobchGTZXq4ItSud4I5lO54dfCluBdiq+N0=;
 b=s41d2B/aqcjMxy5JWu9he0XufXmRzh6dKf5RTg3RSKL7JS/ohQtd+eZVIq4dhLZGyA
 9JDw/wBQRg8dQj2GsQhh4U0VGLkXhY64Hv2LRqgVtDy5Fp9Arl5sJ1h5sLRn+Y37XQHl
 moCSyW/r+K5VahNIJktsXe64jppD7+oEuql1fcit6J13DG//+AIVMupIs91Z2lVv77Rd
 hT/kRr7C7230XsRV4KspeNGUqAE8Zakd0GQWnJYZMXysyWHMOLNzq1MFhWgisEt26he0
 pq479WS3hqXIIxfaPmJOo+1bqZ6sMcMF9ncsjmHS6TI+Z/FC2AQfoi/bdY6OknKJgttb
 E1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2sdxv3dgmobchGTZXq4ItSud4I5lO54dfCluBdiq+N0=;
 b=g/E6Jnz9KKFrLCG36Sc/7azOpO568B3QZ8SvxDiaaPBGIQ2a5QYLP4IIUaCQ6cWKj9
 oFRG+TgfHq+yOD5xbdrbDpN08ApkFNnd48utON4mt4+0gVOEKuAcNkH/Br4sWaBvCswe
 Am0lUmMv1vsblnWI8cMCKWI6EYEBT4z/D+GyhOy+KUbV5bZHL6Cs7K+88RN6xQDIkhtw
 7ITM0QdTbUI5z3rbNFlxHgWiEoPLWgECcBvGGPcOGoKoyKiDwR8AuWE8cg3J7beWoM0H
 fACNPB3ZpiOd7WIPNgvH0V+VjQavXv+rGqb4wZMcpit+XzBYvVD1rtEURB8hv8mHFfoV
 Seog==
X-Gm-Message-State: AGi0PuaywP7n5aKjcjGftnx2xqK/F0bmwVsffH7FXePU1pZL9JZPyoAJ
 Z0CzuKulKW2IJtsvhKnLiLeMrpMKLP4=
X-Google-Smtp-Source: APiQypLV0QfgYl429cGiVPd6tusWz+XzH7+pLb8I61S/GUdUi0h8Wx617JLocYXdl/0LPF3F9WP9BA==
X-Received: by 2002:a63:296:: with SMTP id 144mr23831256pgc.110.1587518275718; 
 Tue, 21 Apr 2020 18:17:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/36] tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
Date: Tue, 21 Apr 2020 18:17:11 -0700
Message-Id: <20200422011722.13287-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::42c
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These interfaces have been replaced by tcg_gen_dupi_vec
and tcg_constant_vec.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  4 ----
 tcg/tcg-op-vec.c     | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 11ed9192f7..a39eb13ff0 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -959,10 +959,6 @@ void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
 void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
-void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 6343046e18..a9c16d85c5 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -284,26 +284,6 @@ void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
     tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
-{
-    tcg_gen_dupi_vec(MO_64, dest, val);
-}
-
-void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_32, dest, val);
-}
-
-void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_16, dest, val);
-}
-
-void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_8, dest, val);
-}
-
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
 {
     TCGArg ri = tcgv_vec_arg(r);
-- 
2.20.1



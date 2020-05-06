Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A3220736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcVUoOMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A3220736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOux-0004mr-It
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoB-0004UP-Jn
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:15 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:37864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoA-0002yb-HK
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id a7so1286707pju.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NV6lL8g5TLJgWVXBQ3cW0c77O/M78yXELJw+3HhuoJg=;
 b=QcVUoOMyheeJiU9SvzaVQWBwid0WUYiyG6IKjGRdsQnpuRDSZkeoWp0hztktEReim8
 XOSeyGiLRqBq2hCFXVA+iV8BHqNkbh+tfM0Ra0428sddFt9YCOinKTGJ8gUMgko92iq2
 7vMrDBBrtTj4o5ot73cADUm5F3cpLg6OcCunh0LdSSI06BjFDhcY9pIhXEf0e7a5mmO6
 SYpfn/XJPPC0igh0TA6pHsAmJAC8f5ey1lWIGbKAGeiZfX9FzekrtD7vHU9yU+oegc63
 cECt2XUV57NgYweAAiCHYW4C96Cd/a6pY406o6t/UxHFndzDFWsH4sJKGraXammdiQgE
 vdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NV6lL8g5TLJgWVXBQ3cW0c77O/M78yXELJw+3HhuoJg=;
 b=VDpM+4VwdG3XUUPliO9bpYSoB92Jbl9loy1GM8s0Pny2fz4oNzgYePCPDbT+KAVFnZ
 +G3Dm6mHSEi7nIuS32u6nafYU7e/7Is8mck7dD9fyAXNuSJoIFQ6tVYsxaijlIHGMJi6
 b5rrsQjJoNJlEVwwDpJsHRGGvSwcuvsVKmwewG56+DuRom4EzLYwBfllNRE0Jn+M+x1C
 lAsQNbYEuHRqzFdHaTZBse51YhXt1zB8EJYZaiRx9kdnlbx8oWS481Br+DazO4EqXjEh
 9n78/TpjbelDSErh5cwkYflK+X/Yqx5oiKsQg+LUehmvyZ8oEwAG5BWOFgemToFpRDIZ
 EsYg==
X-Gm-Message-State: AGi0PualtmTHS78v5l0eqMpbLZwhB9G4uv8kGKF7/VyCevTw+Qbb+1y2
 qRtEv646QrN/FZANyfj62CeFamgvE68=
X-Google-Smtp-Source: APiQypJYxRvEKSX9yyqVuiAPwMOsWvXoMHJv1zFhXAhbOwBr+CMWx2nQj9jAfBMdkBxJ/UrfpUUL4w==
X-Received: by 2002:a17:90a:3266:: with SMTP id
 k93mr11464051pjb.118.1588789812777; 
 Wed, 06 May 2020 11:30:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] tcg: Add tcg_gen_gvec_dup_tl
Date: Wed,  6 May 2020 11:29:59 -0700
Message-Id: <20200506183002.3192-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For use when a target needs to pass a configure-specific
target_ulong value to duplicate.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index fa8a0c8d03..d89f91f40e 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -320,6 +320,12 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
+#if TARGET_LONG_BITS == 64
+# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
+#else
+# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
+#endif
+
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
-- 
2.20.1



Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88046C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5248D204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoPYiIoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5248D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7Y5-00064A-G3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7W1-0003k0-J1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:40:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41226)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vw-0007hO-Ko
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:40:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id b5so548422pgm.8
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h9lWVjb7H1XkkBgxSVShhNTX95JNTaemDIvGHo4y1DI=;
 b=EoPYiIoWDGbiFqh/gRr04SvwHczr8aOWHQSXCVs3lpJT8euZfREjYWmeWhpLGdGD43
 HbOSpFwz9ZKoBnwl9yLtqxLub31SDpEALw/9xBmsG0jlBVzCzimefcFjorXbeIG/D2Gh
 ldLPI6pnIQHvwfJfn/hNVeohpY/UDP+gUGsIu6oDFHSNqYoyv/JIcJ6//4DtrfjV5mL/
 eINFuYMVw99Fmb9d90sm4ftZ3JtA2FgAbNVXSaIRwQJ32DVESVNZuyzxYCw3Nxye5Rt8
 4Gz4GGvVfcFlkKo0r26EIY1Xq/WdCDlkgQaXFAMFM1+nPyCbEv3OKhZm70UE3+lTM+Ro
 cfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h9lWVjb7H1XkkBgxSVShhNTX95JNTaemDIvGHo4y1DI=;
 b=hjPx0Tg86Z8xgtrTWEZHSTqwiKnDwbB+ydxryemf9d7dlwHZXs5qzwtf2NS5gmoybj
 Bwkgs6X5duNWQoXmoYWkUa8xzWE0MaudFZzH+j05wIu5empB7xAyb2snaW21er8ISzYp
 mDFiHKip4fJuqGURxwBOPym9j3rMFPXNQG5CLOHZSXk6kwOfAsoDKoNRdqpTnvtmVfwq
 /l3CAe+yfWWG+ZI3Ku33fxLjbNt9EMAx8FDVF4usCjL8KHK15hdqWvtF9UbAYdlST4fV
 XFP7DzR1SkeQMHSDLW/tLBo6luQkKp1IWPGBZNOJEVWxrB6mS8N5NzrIL/kUIWfFTDlE
 MFHg==
X-Gm-Message-State: AOAM531SQaK8JnEpp34zq4I3dHmUDKnOFNjFE5x5gF88l+NNfIxALvs+
 fdtG12NlMS1wn091QoKBYpaRoBIx614=
X-Google-Smtp-Source: ABdhPJzRp7vs2Ttfmt0fJuWYjfv/3JEr1MFGLJatG5fe+nzDLJ9x7cGh1XmBfeMALfW3KkkojHJniA==
X-Received: by 2002:a62:1c46:: with SMTP id c67mr4162269pfc.170.1591821589289; 
 Wed, 10 Jun 2020 13:39:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] configure: Disable -Wtautological-type-limit-compare
Date: Wed, 10 Jun 2020 13:39:41 -0700
Message-Id: <20200610203942.887374-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610203942.887374-1-richard.henderson@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang 10 enables this by default with -Wtype-limit.

All of the instances flagged by this Werror so far have been
cases in which we really do want the compiler to optimize away
the test completely.  Disabling the warning will avoid having
to add ifdefs to work around this.

Cc: Eric Blake <eblake@redhat.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1878628
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use the new add_to function.
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 464202e375..8b33447048 100755
--- a/configure
+++ b/configure
@@ -2035,6 +2035,7 @@ add_to nowarn_flags -Wno-missing-include-dirs
 add_to nowarn_flags -Wno-shift-negative-value
 add_to nowarn_flags -Wno-string-plus-int
 add_to nowarn_flags -Wno-typedef-redefinition
+add_to nowarn_flags -Wno-tautological-type-limit-compare
 
 gcc_flags="$warn_flags $nowarn_flags"
 
-- 
2.25.1



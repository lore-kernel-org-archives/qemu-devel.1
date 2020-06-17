Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D37C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5972082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjVDRpzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5972082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlPsR-0001nV-M4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 00:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpv-0006p5-U1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpu-0001Te-4J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id h10so640624pgq.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U2OhPh1mOGrVWInaZNwiPEgVVlC79KKQnsD/xgS7OZI=;
 b=EjVDRpzOtBEADaOdZfYBlVrrf4zOQbwJmXHEaS7CS+RmV+e7Ux9wIaH91zTTFhTlMY
 bkgnNwjb6cZ7W2dt46Uu0nkxpLzGVowXBgqw1/2y6Y1wKXUearzXR2lQXHJB+ucULWgz
 9jHo2Yl9/bb/UvyGs7tXlUJFTGmtlZVKeqbGmrN8Y1eH8UjpuidZSrLYM8x1xAuyCiTg
 Ti5eOfYRJw7kM2GHAz9tHUTPG4E0ANvCOfKGOVjbv9bDLTXEJJPQ0xHhL7rfwChIYFmW
 ALqls/5Z2+3KUstJD/T13m+71hGuUIp8B8SWu3TtghlMSHzrE9qu+2raN3kORMktuf69
 rL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U2OhPh1mOGrVWInaZNwiPEgVVlC79KKQnsD/xgS7OZI=;
 b=EalNUAm4toG1byNCuXFUpSpcr4lI6gX1eFGPMb0LEfE/XdvP0H1ZzaBBfcrKYNe51B
 GoUs/Z61Fc0kqB4gepgWbr0MgVEGZ0fy/EndH3AgcEG8PKax2Xez+wkh3xMaDq0wHoy4
 yiO4idn7ZzGEIbwPoTzyfTPSQ+Kvv4nAdSu01QwYRbbWpYigoOrEr0ew3yA4MG2G37vA
 f7KMQgOyTldGwtgUapAZEgJb73H2P7FfD566TMYJNE6gXgQv4n+azTeGNeWNQBgtlOMz
 HnI5ZqvBggRQrOTMgRiYDOdsT4lxmHgb4eYSD+vjpeV3C+ur+VtMuX69wL+RKal2Vvkz
 iPUw==
X-Gm-Message-State: AOAM532+IIyB8IOpVUKmY6MYrqQQ+279cXQvBonrzgJvaruuTggpZzMu
 +bXsPP+MP9YTh2c/MwVuwP9q+jhzot0=
X-Google-Smtp-Source: ABdhPJydTKviR5eJuaiBmOC0DsuxAbF3eYDe1gxkRhQOkDGl1ORDKIdAKBOwZP830+x9d4zt9QbZXg==
X-Received: by 2002:a63:e004:: with SMTP id e4mr4532828pgh.44.1592368684253;
 Tue, 16 Jun 2020 21:38:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x3sm18585808pfi.57.2020.06.16.21.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 21:38:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] configure: Disable -Wtautological-type-limit-compare
Date: Tue, 16 Jun 2020 21:37:56 -0700
Message-Id: <20200617043757.1623337-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617043757.1623337-1-richard.henderson@linaro.org>
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
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
index a8bef95282..5e27229f58 100755
--- a/configure
+++ b/configure
@@ -2054,6 +2054,7 @@ add_to nowarn_flags -Wno-missing-include-dirs
 add_to nowarn_flags -Wno-shift-negative-value
 add_to nowarn_flags -Wno-string-plus-int
 add_to nowarn_flags -Wno-typedef-redefinition
+add_to nowarn_flags -Wno-tautological-type-limit-compare
 
 gcc_flags="$warn_flags $nowarn_flags"
 
-- 
2.25.1



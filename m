Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E00FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175A3206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQb1ysMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175A3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleUc-0002n3-BT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQz-0005lZ-Bo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:21 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQx-0000IY-Jq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id s23so1673124pfh.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dEZjzTX6+ieOShJN0mJuNiYarK9Z1RqMn0K7hfGtGUM=;
 b=rQb1ysMkQvxua3wjxBWBVlNxm8mA1y2GuGoNe7v2Ea/vjtPFkBP3twB/f2xL+aplvf
 WFzGp9+rvN2FCFlcTnDtxcOjL3Hp6IooSf2+rSqwk3WBblNLlIa3AUdZkWiqBi0XDxd/
 ACqp4VQyGdX+u/BNzOqDkahJFzx+VTb6dlshKPax7D/J8TbyddhS8nfQ0SERgwFPL8Jl
 tgkjzRvLys0vI/Ia1NDB9MSpfVq4ALyJn9AiQ/+cvuVcdsiulRZ7Q47abzV6Wk9yJziw
 txkl7aZUEnTZyyY6i+H9LftplS0s6wj+XYVsJJlPHIB++VP5acVSL0BGirLSB0SaBACI
 K/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dEZjzTX6+ieOShJN0mJuNiYarK9Z1RqMn0K7hfGtGUM=;
 b=TqAZ+xiSRGx8rKQa0U2HTLQH9HCfSt3m40J8oR3jSMtaf+rHSnt5cKD4oZHtdgK/by
 fn7iIeySRxsOICC8sW3vvGLdVniGDOtRiw4I36Xbp5JcuwewNzfhe9MADzTYLpaLaa34
 VjTNMORj7EfHdtsyh9UmBy+onRIy6LhzsRuZ7uAoskoK3qN1UFllZewK1I7EmeBCriU0
 +QbQFev2C93RRKQG/f9Rr6/U5D4x1q1XqHCe5eD+Mju98xQEq1JjNrqEL4kaC6olo1o9
 sKGSyRV8GCoYmij4Ev6vDvovGL37NAWFBr6zMHpcuf9QxYyHQjvmuEOiLQSUMImfu2mZ
 UaZA==
X-Gm-Message-State: AOAM532ay86p0DzgPnu/8cxrZ4ljveG3cZS4fZyopZtO8Xkx4a30VWmn
 vCgwndkr4A+6Rop6nbqSmLTAe2JK+dY=
X-Google-Smtp-Source: ABdhPJx1QqIaUPF+bXK5GSgI5anA4G1edhjiqM7QiyMW1H7cSEvewAl9HM8q4wVDMl/D12z0LfFuww==
X-Received: by 2002:a62:7c09:: with SMTP id x9mr402043pfc.287.1592424797860;
 Wed, 17 Jun 2020 13:13:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] configure: Disable -Wtautological-type-limit-compare
Date: Wed, 17 Jun 2020 13:13:07 -0700
Message-Id: <20200617201309.1640952-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: philmd@redhat.com, Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang 10 enables this by default with -Wtype-limit.

All of the instances flagged by this Werror so far have been
cases in which we really do want the compiler to optimize away
the test completely.  Disabling the warning will avoid having
to add ifdefs to work around this.

Cc: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1878628
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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



Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD12C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBE520857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blmg5Yts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBE520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfLa-0008TH-FF
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIi-00016g-5q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIg-0005WL-T5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIg-0005VN-FT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id x18so7716598wrq.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yWh3aRGKef9xVplQd968UKYGmgCSPBAT3qOdlODDYkY=;
 b=blmg5Yts3E2FGVs0grpxsfYS8jud8lWn3j+SF33/gpZRJABufOPfba5LX5OAuhWtnJ
 arbfWMWXeI5/CuA6Cp0goThYJZBjtzmGkE8/tQLdTjel8JA4LYeOUNo1htzx2XALctUF
 SMq2rnmHj9LaHMODFjcKh79XIR3kFcNrKc38CGeq/9bTQNO1hMqdPvzIkPQXJoNy8t1b
 3lAAePsqtGKkBnxqLAVzzdJ/07Como5kE8X4GJhtdejnPLseSSreelYH7FepII/7fdTB
 e+Btyi5gT9OmAWD7Yaw1ywORdv7kRUyCARDABOx5OandNZh12d6MP8GRdinDWni2BAfh
 mJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yWh3aRGKef9xVplQd968UKYGmgCSPBAT3qOdlODDYkY=;
 b=KA9Ij5fIVZNitHs62tDPDArtaD/F6JhYeLB6OkpQQcfuEmOlf54rvpm222/eUV9Gws
 EecsuU5Bi1HMzNVXnm0JPZU+67ZclbdB8UgbobS/8XghZL3OeMSg2WEdCOf6YrWOPRvK
 kq4P6NFwm8Pswpd9knz/C7DxC1JVmFvHXbRzo/FhYbejR7uTc1hYXjEo9NAHmBc0u811
 146A2zb9BQmGxHT+cUnUf+kTpfg8eS5/Yviy8QWUOSIroEbpmwsfP7Et9aLCJ/QmszJR
 SG7NC3Ffvba8sokVduspzx3WvuSwQwiBZi9nYrxdYXPdRbH56VOPf4kyQmUa9jNHJD1K
 QTyA==
X-Gm-Message-State: AGi0PubnlCf6PIo3w0sO5HPkgVppaFg5GZ4S6ekVi6th1LBYHmC1oklE
 FnZhXc+K+f/NYOYch4mK4XJjaA==
X-Google-Smtp-Source: APiQypIFs3dXAdjNv6rSx2Yv4reRcQA3tzEzFcec2qC0Nn7So3SGTRHf9tlrHl65FKRldvaTHPUcfg==
X-Received: by 2002:adf:9168:: with SMTP id j95mr5724202wrj.145.1587661569041; 
 Thu, 23 Apr 2020 10:06:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h1sm4686289wme.42.2020.04.23.10.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1C741FF91;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/14] configure: favour gdb-multiarch if we have it
Date: Thu, 23 Apr 2020 18:05:48 +0100
Message-Id: <20200423170557.31106-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As gdb will generally be talking to "foreign" guests lets use that if
we can. Otherwise the chances of gdb barfing are considerably higher.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 23b5e93752..c58787100f 100755
--- a/configure
+++ b/configure
@@ -303,7 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
-gdb_bin=$(command -v "gdb")
+gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
 if test -e "$source_path/.git"
 then
-- 
2.20.1



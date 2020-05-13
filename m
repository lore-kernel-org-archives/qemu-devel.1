Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1152EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810D2205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpw2fHKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810D2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvKx-0007VO-39
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEv-0004uy-4a
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEt-0007nQ-EH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id f134so15293168wmf.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1chDwz94RrS85XCVVBqcwsxgLaBVTqxdPFO1xuLV3bk=;
 b=xpw2fHKXQtK4NYVNby1EzTcnvzHvTpoIFbBtfpjc537l4xdL0yt5wYHRhffX8UBjTu
 ifitgSRksy9OPMF29j3Q3kYYf8gZRFbOhpBuv7V7y0+63xcYHosqx8GwxRTXY5GctW8A
 JS3S/JoyOHEVtSqvvmBk2Iod2tszqTugJW//FVdeLBp5GJNu4meeZdBIbuDkc7A/5aTq
 8W7QNM5VP2AAbbeTMuiLq1gzW69GGOAig2DoV2JhuD15aVq2fowQ1U7j571x03BvXu3S
 PRA5V68VAWHtOc9B0TiEmXVFf6GcqbX7dmlzgvHF5iJAJF/InEbFzotGX4aRRZOpBpef
 058w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1chDwz94RrS85XCVVBqcwsxgLaBVTqxdPFO1xuLV3bk=;
 b=hO5TtlHamsDhVXYda8AK2tqtesCKs3MqSnTHvpm7xfPG+GVdfCdMVnYielqw/jIpCT
 RChBHzbKyZebZ0I64azaIlEsYQw6ioVe/RRoNNFi2uej8d0JsuDBtvZdMC/2NLLjIVms
 bc612lR/iAaqJ1WQpYxu1W2iqaTryK3xb/+x9RECqdHU52mK+yyMtNxrJB0MbB59da6N
 ogKIRh6csQVcGSRooztr4x0q8t50JoG3mMLCTV+J1tQom+rlgNnGOQIPLMfcZgWPbKgJ
 Bn3yX/Jsv9c5+7UM5g8mrN+hFLFuyuVdh1OZlyEQSd8v4QvqndY7g1ygsxQ2yRGkN/Z+
 CaSw==
X-Gm-Message-State: AGi0PubCZerbjg1ANt55XNzczxlaKt3E1rZOrWseg0Sy18EdNvLQYvYf
 P4nmJ0K/IJx/9syrUHkVDqCUKiIUN8o=
X-Google-Smtp-Source: APiQypKNHIpJm9pe1wQkvX+tNEHXlwNc27iKv6iOuZxwBUpjlVj/btXvrEvoMjFOsBLSijgiKDm5Iw==
X-Received: by 2002:a1c:6884:: with SMTP id
 d126mr25031171wmc.179.1589391134028; 
 Wed, 13 May 2020 10:32:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q18sm2579484wmk.28.2020.05.13.10.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40B0B1FF90;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/8] MAINTAINERS: update the orphaned cpus-common.c file
Date: Wed, 13 May 2020 18:31:56 +0100
Message-Id: <20200513173200.11830-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We forgot to update MAINTAINERS when this code was re-factored.

Fixes: 267f685b8b
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c6..cfe71898d2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -115,6 +115,7 @@ M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: cpus.c
+F: cpus-common.c
 F: exec.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
-- 
2.20.1



Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FAFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757B22098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Izno5A/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757B22098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBIp-0007wh-Lz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDd-00085p-L0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDb-0001c6-Rd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id x14so20692459wrp.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e785/2ytWUq6m1CZckPntnQd1feVAR6FA8r2SV7OZRA=;
 b=Izno5A/Ej21+Rl8NmYILa60fUa4RjKNZXiFn7pemj+0ybzwSooDDlzHswfzkcskusY
 4RYs6SMBLKESM0cGgi4eMoZZcy+ezw3Ze2PE2ehw8NOrO1uYaq/bE5LTi8M426IJvgHW
 uxwZt+5s0FwOERHufttuga4jucdrAVGmzFnEVoOdzzGvxWdGTuEAizXMkw4XdxmCCYg9
 dKe/rvmdoeoD20is3FJtXdVRs5hHUZNc5wdYLrRVYEym3nXkia3ILrHA0ypLzjt+RT5A
 iUhL0k5yaO9iD6f6TcvgmelK3yfpdXwOSVU79NP6nSIk4U75wskdh/Qb18szzaha4g+g
 EP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e785/2ytWUq6m1CZckPntnQd1feVAR6FA8r2SV7OZRA=;
 b=H7BVQ31sUH5+uPIBOQUKlv3hDdh7vPi9glYozplEiEz8KMUU/GTM2z1EhcqlvjN506
 5NygWMCgoIIP6MHuq50DA8dtc21+lo4PQYgdgm6stCK5f1hVlv4gh3gMplTnthGWAlhK
 /tM+JGdj3KvRIVHl5TqVm0RGXT0mpjIkYsKgE1lvmkzIGs8Mj8WGFsDqOwnpy9GDt5X0
 Ya8Q6ciag4ItofyJLm2HAjd1Qd2ULktKgxdSVVtpWqIjpuQAoRISK5nifZNyk+KpEIhk
 S+H5woBg5n11Qd1NJy7moskRDyPTdY6ccwHP1QKpbC8+APF0sJjM/6F0yS0wTZq45qks
 JBKA==
X-Gm-Message-State: AOAM533wNDzUei9ED7IZO6lpxSaxPcdd/fBQNO4FlSMbhLfNkzYHPJ1w
 H0oxAFKHXX9ldxSeYDxyGPk7lA==
X-Google-Smtp-Source: ABdhPJw6btr1iUBsd/wSurYqHBHuQlxMOuNgpp/MaT3dVl+iRcDVRHvuc8urOu72gc/1DQsOeOPZHQ==
X-Received: by 2002:adf:ab08:: with SMTP id q8mr2892324wrc.216.1592312494465; 
 Tue, 16 Jun 2020 06:01:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u9sm4165844wme.16.2020.06.16.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:01:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F2CC01FF7E;
 Tue, 16 Jun 2020 13:53:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/21] cirrus.yml: serialise make check
Date: Tue, 16 Jun 2020 13:53:21 +0100
Message-Id: <20200616125324.19045-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this on our other platforms to make it easier to see what has
broken.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Li-Wen Hsu <lwhsu@FreeBSD.org>
Message-Id: <20200612190237.30436-19-alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index ce7850a320e..69342ae031b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -14,7 +14,7 @@ freebsd_12_task:
     - cd build
     - ../configure || { cat config.log; exit 1; }
     - gmake -j8
-    - gmake -j8 V=1 check
+    - gmake V=1 check
 
 macos_task:
   osx_instance:
@@ -26,7 +26,7 @@ macos_task:
     - cd build
     - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check -j$(sysctl -n hw.ncpu)
+    - gmake check
 
 macos_xcode_task:
   osx_instance:
@@ -39,4 +39,4 @@ macos_xcode_task:
     - cd build
     - ../configure --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check -j$(sysctl -n hw.ncpu)
+    - gmake check
-- 
2.20.1



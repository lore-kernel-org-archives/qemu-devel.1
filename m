Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86786207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZGtQ/PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86786207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxUx-0006I6-LJ
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSP-0001gg-43
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSN-00085b-K4
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id c3so20025898wru.12
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q0LNOa8nsE+fbJC1/7wmjeLH7Nwb81oPzvCmA/EHk64=;
 b=GZGtQ/PGLhy1yXHKmol/QXOeYUW22qxABlNkqtNYvsWFapcSDHmUcSJKlB9qxvNkHY
 fVjyP/irwtMhtzrS+lhj00+TV+wMU2Ki8658VZRYmub1Gm5Thb4GdRr+FH2S8nCZqFyA
 UNGcnSVVrp9N2DHVkS0rthNG4ZieKg08TmaxKcpGJHzyoj066qpgFecA4OmscMw80ePO
 fRYvYYP2QUwmvIrnH5MF4y/XLT0WYRsUoSsjV3iliFS8uNvZXM/JCuJ1kx2h2KcUjgvi
 yGIysAXqIIlaZl9Aa8A1rwxlQMO8nRUCrPVoF7CF0CxMlTbKGrqPvDSX3kOr6lnBc/6H
 9MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q0LNOa8nsE+fbJC1/7wmjeLH7Nwb81oPzvCmA/EHk64=;
 b=pKhHXS1Z51ja23/CPHVnsKQFlUsUhobnnN/fletkPSxoJOG4KbgWkDiUBAh0zHpMJJ
 Q79ICLtu3eAI8Cwn6ZtJmie9C+VYYGIK/6O6/4GJ92Jlzxu9aObkx2JuWzusq7g9o436
 3Da1o/c7Krxq5hJfW9kONvzNQZAZ2XjgVI8ziuL0PeinMojg3RWTFYB3oXHjhv4SpbHf
 s6Ghdu/1473dIwQTDibpsbMkhmxj/ffd3ebq3ntm8DJkZdyGQsuPV2V6gR/d5BRUIzp3
 nyXsL960bAWWYXxFhkF56Zgp0Ac+SBdLkL+zgymSdjKo2+6XApmm9tx9BJeEJWjfw5/r
 wUdA==
X-Gm-Message-State: AOAM532yCLAaj+Y2mMIFBWGc53Waok9TuM6Wdmf1zCoaf3FOIYKaiDYJ
 pZawceevraRV3ffu5h0eaSfAiA==
X-Google-Smtp-Source: ABdhPJzP4/fQyvgGB1s8K0AduePsWgAYrWi1C8kkmZQRLYub+FEITkNUs2pdf/YhejBLs4Y/GqvkFA==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr26226263wrp.426.1590591297872; 
 Wed, 27 May 2020 07:54:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k131sm3433133wma.2.2020.05.27.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:54:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E2DF1FF87;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/12] configure: add alternate binary for genisoimage
Date: Wed, 27 May 2020 15:54:44 +0100
Message-Id: <20200527145455.2550-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all distros ship genisoimage which is a Debian fork from the
original cdrtools. As the options are pretty much the same support it
as a fallback binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Message-Id: <20200519132259.405-2-robert.foley@linaro.org>

diff --git a/configure b/configure
index b969dee675b..af2ba83f0e2 100755
--- a/configure
+++ b/configure
@@ -941,7 +941,7 @@ done
 
 # Check for ancillary tools used in testing
 genisoimage=
-for binary in genisoimage
+for binary in genisoimage mkisofs
 do
     if has $binary
     then
-- 
2.20.1



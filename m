Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96FFC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02182082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTv6Lby9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02182082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Io-0005Jl-U2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dz-0006wM-1O
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dx-0003ZU-W8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz3Dx-0003XA-Ps
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:01 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so24429905wrw.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PRUtPn265vexHf4VVNiwt/Msvkmc1PvT0xeNxB5F/RM=;
 b=FTv6Lby9v2XCBqEpuSrxPvB7zU7rQP/Rbwu4qj0q0dChRbGF4+cGRYdGNnZdPKWhi0
 oPKDtIav7BnzL8L9mI2YiltweU770REkxph3KatiBtJuyNbucYZk2lqowNaQ8xMVyVbE
 gRFhXdRW0bnsumFz2c2+KLNVqN0ia56VhQD2Fb/G8xp1PuDMBT4oIE+lJB0v5tqrecdb
 lPIS2n4pvkGeLaVyCAE/zkQxT9PwTL36nNho9fCEaX5JteDgMB7RMInxuEzScpavTUHq
 mlB2WE2Z0CiS8JDustJpHf9mLpB85iuwSYzMk3vYgoMBqWeYO0Ul+Sc/+jFaAz26AP3d
 2MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PRUtPn265vexHf4VVNiwt/Msvkmc1PvT0xeNxB5F/RM=;
 b=ZDVzzqEmH8mZ8XpqVvyPQWSWmNe9iCjvXNxeZLS43NEZ0LH1ufvMlGt4bA/awRuh3C
 f5LbbJ6n/PW+v5f2VbFMdooWXtyWNUxQ3Yx1wT8bDJUfqKgOOzIWunX4AuqP4r+G0UYs
 S4DRey3HojdGJxFFV61PZgWufqcPJEENdNKN7I7QpziFiekHWMn0BbgCMrYfPY3aBfS1
 4y9HnX36MRVEHQjs1lA/tLZhGVuzY3jSKFL5nVNzDrAPQWl1npsCy6lOze/5dhob+ilX
 d+Xlvaz32qWwCZx7kFcCZ8CybTxW1v7imrpkMGr/0jxS5jHZymtlv2d3cHLN+f8PXAV1
 U/mg==
X-Gm-Message-State: APjAAAVQSv0iNpnViDjq3RmY9UBbo2VcXs45VA+uZ1Na0fpJmBjkasOH
 zlA249mG0ishLEC9lmlzNW2LAw==
X-Google-Smtp-Source: APXvYqxlqp03gkY5bdBv+E70VxnfThBCkGoUoM9CgdkKMi8LRmUgzrXhHaMzkbFh9pZWVJzgJDGpDw==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr21986011wrv.291.1580842020818; 
 Tue, 04 Feb 2020 10:47:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm15929797wrw.15.2020.02.04.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:46:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA4221FFA5;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/16] .travis.yml: ensure python3-sphinx installed for docs
Date: Tue,  4 Feb 2020 18:40:28 +0000
Message-Id: <20200204184028.13708-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200204105142.21845-1-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 3b35b7cf04d..6c0ec6cf69f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -194,7 +194,7 @@ matrix:
       addons:
         apt:
           packages:
-            - python-sphinx
+            - python3-sphinx
             - texinfo
             - perl
 
-- 
2.20.1



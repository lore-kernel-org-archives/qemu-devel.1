Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0991820897
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knS0pgnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyMe-0001Cu-VF
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGd-0000IB-Gq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGb-0006Xt-O0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so2563080wrm.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0gAQyx4BUxAer/TPI6eyMofMbH+F+n5vgmbKXdm5rcc=;
 b=knS0pgnxnowVxpTrJvI34NE04fgEQFLk/FZ4V9wU3KKfHE+CKjmhBbRhF6IGNKW76G
 23n7ND1mb8VMAWkxMd4mEFGF8SFkwavf9iISI5+0rN6DVXmyJBalPLrayfe4fk2qovvz
 TGsaZkC8nONs8pYxd5wxPJDz4VrNTtOlc2osJJXP31AyrBnhWqjO6mMCqvOOLBv5FKmM
 JKqDltUqPN65b7a98NsFfO+XgZpR9hERS7XoqOTa4aYfmSdVS/Y55q0+yAAQ7FJ8N5uN
 0uGRrwuYPAWEGXz6gRYWiovoI+nYZVelK/JObZsYV0KE4uOJPxfCPpDaMgBPTpldWdhg
 QR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0gAQyx4BUxAer/TPI6eyMofMbH+F+n5vgmbKXdm5rcc=;
 b=iotHuxZ4AcfWE1QKgHNRWjLiN2hksm0XqxDPtNRN0p94+CJ1W6aQJiewcLcSlwHeti
 Vv7lvdE73osvh9WIo9VjKseBQQF5NHjLZNurwaaY1rXyzFvbcDX3mEZEt9vV2adD5EWy
 pg+62vA5+A7hiT+Wo8taMbrXxy+KOdyQOT5bjdAviigy9fggxGXL4v+HM/Jxfnmw3Lvp
 BjP/DT6+GSndiJc9Oj804upBdznHfibk9+U34cqMRDLFQhi5EhCcgS4UpbMu7HIWqt8Q
 Mt/HfmwrDlcUBHZuZiyaqPNBhs8jextgx/3yq4zxJLRguBLkar2nEwQC1URhHXxdIHc6
 Kjew==
X-Gm-Message-State: AOAM533pDyyUj+/4oTqp0nFEVVib2ZeddhmwTh+ZmHoIt/+NGGbHGQXd
 ajQPVbRWAFI6fM7Ny7ntsCLmpw==
X-Google-Smtp-Source: ABdhPJx7eIhuRfxNQj2vqvws+oK+MInZQgoG75Id/OhtcwHHJKC7unR6ASZ2PwBWI0/ZSQEDpiGxmw==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr3662835wrr.390.1599650876389; 
 Wed, 09 Sep 2020 04:27:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q186sm3547348wma.45.2020.09.09.04.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 800F31FF91;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
Date: Wed,  9 Sep 2020 12:27:36 +0100
Message-Id: <20200909112742.25730-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's buggy and we are not sure anyone uses it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/system/deprecated.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 851dbdeb8ab..a158e765c33 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -424,6 +424,13 @@ linux-user mode) is deprecated and will be removed in a future version
 of QEMU. Support for this CPU was removed from the upstream Linux
 kernel in 2018, and has also been dropped from glibc.
 
+``ppc64abi32`` CPUs (since 5.2.0)
+'''''''''''''''''''''''''''''''''
+
+The ``ppc64abi32`` architecture has a number of issues which regularly
+trip up our CI testing and is suspected to be quite broken. For that
+reason the maintainers strongly suspect no one actually uses it.
+
 Related binaries
 ----------------
 
-- 
2.20.1



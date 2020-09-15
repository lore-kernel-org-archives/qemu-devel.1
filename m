Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAAD208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1v73fky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAAD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF2g-0001CH-En
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXP-0000i5-Ip; Tue, 15 Sep 2020 13:14:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXN-0002pq-Vs; Tue, 15 Sep 2020 13:14:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id b124so2289197pfg.13;
 Tue, 15 Sep 2020 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=U1v73fkydNQnHcMcbp3JTeTZOjhtisqCvxkSJCSyxxK5JRkpBavtwsXuxDS+wViYsI
 KDgDVMTdlPe/CKP82/QurVWtCetpuhs81V3kIptAmioF66RwzWiGuXFRd5/gDR+oCZEs
 jllWPl5quHm42JyxWGUqphLfZ480SnGiGBMfGFCcji4DEmpSsE29LtsIKKFh27btsD2s
 4/mq/6Lx2fbsDXjhDsDs7EWEdusQh4BaXnQYqsymhLGo7fw6GIxLems/UtpIPeR2bsn4
 Rd3bs0JlFllPBRas8PVXS8STfkzDqV3YOrzEzcMODTLHEBTv6wJPoMUT4iyWB5c9NhKD
 C2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=gU6NO1rbHMogy4I3/YjgC8rr5ds7Y2UP5uNTEqqB/VsNqp3oHTN0N55qjIzTDi2UKm
 oDMftNDim5hjlJR81yIBVSTOWKz18cVuu8BBA8SEyUAB0qsd+dnqInRt+71PFoHPvA7t
 x4UuxS65ZeMPZ/a+QiBIKguXbV1ShW2/yXQLSg+TWZ8pc7OBRKBX+SPiy73tLxQmxxHJ
 M56Nc22CsrD5XS3vEHPNVJviqMPzTOpVTBi48cbeXfK/l3UkMt2ToOuoXVFMIp6nwhgu
 sobzn8cfJ4NiUwCJMI/OFWdgzwJjDWxIihZ1a17R9HgXJJAmQR818T3q9539jYeiuGHE
 sjJA==
X-Gm-Message-State: AOAM530vZ6FfzXXen2uPtEO98SkPFKLh6X6oN7zLuPOeG821JOhSVYJQ
 XfLFe/Zuim4OR/6xCutvRpdPdRIHDH9a7MgXnlk=
X-Google-Smtp-Source: ABdhPJx6CrxI2ejTyVJxO9kSWHtWoBx8L/1qCVZ306sN5g2xbSmH66vo1s9Bsy/VX1bgejQmLKJnRg==
X-Received: by 2002:a05:6a00:1703:b029:142:2f13:f1c5 with SMTP id
 h3-20020a056a001703b02901422f13f1c5mr978323pfc.29.1600190075790; 
 Tue, 15 Sep 2020 10:14:35 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 23/26] meson: upgrade meson for execute custom ninjatool
 under msys2 properly
Date: Wed, 16 Sep 2020 01:12:31 +0800
Message-Id: <20200915171234.236-24-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bump versions to 0.55.2 for release

* Tag Info:
object 008d13038f95e7c7d8ad553f14e408da5b94c360
type commit
tag 0.55.2
tagger Jussi Pakkanen <jpakkane@gmail.com> 2020/9/11 1:24:47

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson b/meson
index 68ed748f84..008d13038f 160000
--- a/meson
+++ b/meson
@@ -1 +1 @@
-Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c
+Subproject commit 008d13038f95e7c7d8ad553f14e408da5b94c360
-- 
2.28.0.windows.1



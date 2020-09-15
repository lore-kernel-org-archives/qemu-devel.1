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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8335C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7FA20678
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnUenlhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7FA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEuq-0000TB-CW
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXe-0001DT-82; Tue, 15 Sep 2020 13:14:54 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXa-0002v4-O3; Tue, 15 Sep 2020 13:14:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id bd2so1686104plb.7;
 Tue, 15 Sep 2020 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P2cCxFgoYyp2z7D84YXVHfqMZS0c6Jo38CVly2RpvQA=;
 b=BnUenlhAsXSEYCp9b0xScR2s3qiMAXmj19mTnDoPFBlIOtfGg6eEkuLuagozpepOPC
 +cdW/fbDPOV0+Tbe5smFZJVMPOezovs4Vx6soDE9DAV3Vr6O0oLH3Ik/REvVQKge8ftz
 rKismj8eRsoAMi1NG2LvktF9XXjeMDtq0Cd5K80BHR3pD2YYsJgoTdQsJ2iHmjRvIfPM
 CB2Neqta9u1GJzbNsHuR85caKczxpuu/i9agAbp/9lSRUJ+jSKkNcX6I9EQ2dM/XXi33
 OV/3Mw9lLgk9ZbiHqh4fs+ZNMGs4UmefD2QczEw8hXbUzVEH31JAhrKz4XqC5+5A9qRl
 I6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P2cCxFgoYyp2z7D84YXVHfqMZS0c6Jo38CVly2RpvQA=;
 b=SfDuPCuu438X07BFHUhh7qlM2mpOEGRzQ0I5eV2G4XkSbphf3G99Awaw308jfg6oRZ
 q73j92uQ+hR0syxTOoWxaY9U3ewQMqfgzSWqVCm3NLdz9o/H0Z2cIGiSuxXXSZNS0vu9
 D+77ZPKLrmtZYaIGbDNOZIC4FYS1F34/WFh9BZm49qfEVzu671OAOY6fkIOLTp6EUIV2
 qyxivr832SRZQGagm+z+nrycOW/HAAn4tIV5SK6CdWu5GrcPWJXw3hUHr7tOvXG+QY1e
 l+SNHFpJbf2c5dx1btGuJuYlvQcPoGf4JIPHIZPhOHUeOiKkqZ1JmI7AzHNfMAjAcFO5
 PlZQ==
X-Gm-Message-State: AOAM532/A5qSpQKFUZZPUYR24Q613KxW3AN6+lM6RUJETgbCrwggQzTW
 LUiY32Re0E64xEDLIoC9TFMfnvNQJtn7tXX3Q3E=
X-Google-Smtp-Source: ABdhPJybOdpovnJggf5X+NGTcPc/J7QzOKL6RnT5ZeP//QiU4tHCC3tKo+CIp75NQoZhCCk42m6luw==
X-Received: by 2002:a17:902:208:b029:d1:9bc8:155d with SMTP id
 8-20020a1709020208b02900d19bc8155dmr20366669plc.35.1600190088848; 
 Tue, 15 Sep 2020 10:14:48 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:48 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 26/26] block: enable libnfs on msys2/mingw in cirrus.yml
Date: Wed, 16 Sep 2020 01:12:34 +0800
Message-Id: <20200915171234.236-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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

At the begging libnfs are not enabled because of compiling error,
now it's fixed so enable it

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 90ed891865..ca4d7db64f 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -93,6 +93,7 @@ windows_msys2_task:
         mingw-w64-x86_64-libusb
         mingw-w64-x86_64-usbredir
         mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-libnfs
         mingw-w64-x86_64-nettle
         mingw-w64-x86_64-cyrus-sasl
         mingw-w64-x86_64-curl
-- 
2.28.0.windows.1



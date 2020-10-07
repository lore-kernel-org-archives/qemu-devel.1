Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C4C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB002215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqa0Dt5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB002215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQC9S-0004sR-I3
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsL-0005MH-U0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsG-000163-1i
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so2882043wmd.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LmmMRaF5jJ83D7WaMAkaWRnQ/L4Ibd0CoqL53vJHWT8=;
 b=Iqa0Dt5/NwpxJyBmmRWU1Tl3fWjKMQajJ+ypl+R5t2gcKanVGDxXWqD8C+Q6GpSdYS
 mERw6LhUd6dHIJCEIWWqxDpINzNbdsHYbpSkfRGzFXlgQB8uLX7yTM3m2pBJ0epOj6th
 COiuxTOeaaMPUusOWDSTA+vzy0ehaSwe610CfCUlAoX08DRSQ8mH/6L/g6Km0QN5CgWl
 IUVcX6sW3NL90xA6FbQ+V7Bruwvw3O9IOElaImU2rALHgpIVi9mlYbQPcsLSwRJvA0ss
 QcDEZh3w6m/dvabgrGQy2KiRpr3uBCd5sM5wTwCrsOyqJRfS90Nr4mr4oLwPWKsPfS1b
 jkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LmmMRaF5jJ83D7WaMAkaWRnQ/L4Ibd0CoqL53vJHWT8=;
 b=b672KFIqc3lyKifv3ipE8dG0NMhlSBJMv6MnwVUdGoIm7u/JP3jWCrKYmYbzPzr+BY
 p3rboY5xcDA5jCu63zFA4wt4vEgwUfj0DK2UZQTgFmEuFCo+6SZlFmo0FlTrpSezvHPm
 Y1Ky4Bkoa6MSvTxJU3ieleXSvd+Uh6yY3Q69jP/bhtDiRafL/vIq7KUZnXoyDVT5PuOT
 F/7/zE+Irsxbv76De+db/56+vB1cU96JfHEgnNnsI65BHW4SOgeN4BTHfgozjJ/IXqaw
 UYPzjjaSfzUW/wyrmgUdcrBYDnGz3DnHxXOclpqvOoHT0I9hYzei74i7/gDwdZ08RzmB
 7bPA==
X-Gm-Message-State: AOAM531q73K4gBh2WvjCmLTOXXwkYJ5I65ITra6O4dkVGxNH0a5d/WwZ
 Aj5ucMin6mL2LFlpFdDxW7D9wQ==
X-Google-Smtp-Source: ABdhPJyFMErADnk9QBXCaSNr7f/crQ+gIS0aNVApF+dH2/LXu4XpzP4TnGo/LV9FDe4VvOp7MEEijg==
X-Received: by 2002:a1c:bcd5:: with SMTP id m204mr3921953wmf.26.1602086461754; 
 Wed, 07 Oct 2020 09:01:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c21sm3322774wme.36.2020.10.07.09.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 262251FF9A;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/22] contrib/gitdm: Add Google to the domain map
Date: Wed,  7 Oct 2020 17:00:27 +0100
Message-Id: <20201007160038.26953-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Erik Kline <ek@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Erik Kline <ek@google.com>
Message-Id: <20201006160653.2391972-6-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index ae5d149434..72dc65f2b5 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -9,8 +9,9 @@ baidu.com       Baidu
 bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
-greensocs.com   GreenSocs
 fujitsu.com     Fujitsu
+google.com      Google
+greensocs.com   GreenSocs
 huawei.com      Huawei
 ibm.com         IBM
 igalia.com      Igalia
-- 
2.20.1



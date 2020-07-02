Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5173C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806EE20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ9gq1qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806EE20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3FR-0003HF-Nr
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AM-0003qn-6T; Thu, 02 Jul 2020 13:38:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AK-0007BJ-Hn; Thu, 02 Jul 2020 13:38:29 -0400
Received: by mail-ej1-x644.google.com with SMTP id dp18so30733391ejc.8;
 Thu, 02 Jul 2020 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7julCGiGF9JJmMXluhtA9EWXD+I+RvsjAFbGDldCUJk=;
 b=BJ9gq1qNYr4uw/5mZz5Q0SCEhQqt84swdf5C2UXyJlmilA7aFOy0zqa6vp0F0BXQPM
 n037ntdmwAH18xa+QMo0fzMWXzsMEKU5MgwBYkXcbdKiQT53HFta7uarN7lRRQXp9WHg
 H051VMvoxHlQaRobVwrb8uOnbxGNQhn/PIKWiAZKzX7QHdAaL7/iuof2VEo2miInl295
 sBqZjqyNRqVbo5CCDeCI/QAlmqY4bbniIuQkqdCZLYomQeeSTZYOsRROpkbC9BEqkuPP
 A49FH09slCc259RSVFYOzUUCwxg/QCTiaWD4Oq0kNUalo2h5LteQbajPDdbRAHBaUjyQ
 deWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7julCGiGF9JJmMXluhtA9EWXD+I+RvsjAFbGDldCUJk=;
 b=f8DdYlhxS/VWCwbZQPdzuWhojuc0R4zErhp5M+LnMKXS3IOaS5OVM/Pt5zIoBAj6p2
 bpuZXb+Vs8eZ0i/ifWqpgf7U3MNVqau3Sk/STkKuEqYbiv0Pu+2ao/gCLTit0Eb/gQCP
 JY6Fo9hedBNFAVfwQYuRH1QvUb0Z+IGfNAubgqdPRFeGYXg5Wck3tZT7LPj6bWYU7VxW
 DMsBnn+B20rsqYuVgxKWOJviMn8mcNsbQ2SRrk20KcGYoIJyXUwgUCOADRDoVR8rJFwN
 XBua91qORQlTd3MBrTX0M/VZSxUCs0LEmZMkTg62DEMl4E1Y/U6aly4sOoqMYKEmgPMU
 SuIA==
X-Gm-Message-State: AOAM531iNTpPBitLoNwrNDrX8xGRZQkXRBGOOQWI3UXDFTzQuFMfepUz
 9HATYSHS2vuwCAKBhQ/e5PpXeOrpYj4=
X-Google-Smtp-Source: ABdhPJwZnNwWRFKfTZzhLV8BHnHfaQ1OW0Aejrug46Oc1FH5LKP2+gYhz8fdQLR4RRRZjcTc0rqqSA==
X-Received: by 2002:a17:907:94cf:: with SMTP id
 dn15mr30797271ejc.457.1593711506189; 
 Thu, 02 Jul 2020 10:38:26 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/19] .mailmap: Display correctly Chen Fan name
Date: Thu,  2 Jul 2020 19:38:04 +0200
Message-Id: <20200702173818.14651-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Chen Fan name in the following commit:

  $ git log --author='chenfan <chen.fan.fnst@cn.fujitsu.com>' --oneline
 5bb4c35dca target-i386/cpu.c: Fix two error output indentation

Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index dbf674066f..1d444e4fce 100644
--- a/.mailmap
+++ b/.mailmap
@@ -79,6 +79,7 @@ Brijesh Singh <brijesh.singh@amd.com>
 Brilly Wu <brillywu@viatech.com.cn>
 Cédric Vincent <cedric.vincent@st.com>
 CheneyLin <linzc@zju.edu.cn>
+Chen Fan <chen.fan.fnst@cn.fujitsu.com>
 Chen Gang <chengang@emindsoft.com.cn>
 Chen Gang <gang.chen.5i5j@gmail.com>
 Chen Gang <gang.chen@sunrus.com.cn>
-- 
2.21.3



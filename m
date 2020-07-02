Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0070EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C500C20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPozuas0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C500C20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Ek-0002B1-1A
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AN-0003s6-Uo; Thu, 02 Jul 2020 13:38:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:45590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AM-0007FX-IS; Thu, 02 Jul 2020 13:38:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id a1so30708860ejg.12;
 Thu, 02 Jul 2020 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6+7Dna7PupoOpJpTfABoYp5s9P9L4jQYo15PmumTzs=;
 b=hPozuas0sXL3Bx70Q0+2u9Vms/wYtD7lKEPWUZSz5H/EW5TreQMIVwGdI7ghULlTCk
 Ruku0phevJuzOZbxmBrGnXkLx/c1B0tbY/E/Q50dFGxQyoDT0dfZBxc7wm9p6BNX9kf9
 5gpKP0GxiwLN5io4lIAsBprMm2pgX2/GrsabOu5EyhdQp7OP3kuGxOfXJW5oH98OlR6W
 IwHPjQ/6LCS+L03ZRm4xcjQbcKySUqmzZgHq+RftI8uAcTNXj/RhHNcHo3OraQhb/kih
 8h1SwJmJFIE206wlONrBxrG41nJbD+8hLvAZBfvqFWGUCF8tS7B/UFcIR0AUcKQSM4JR
 mryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f6+7Dna7PupoOpJpTfABoYp5s9P9L4jQYo15PmumTzs=;
 b=GxErtgfnG9kPk4xAkporJ96fM2W64+UIVUKdPerWRzfJmUu1gyakkoTcK/poHqHwTc
 8eG4WGWgXyk2KjPAXQS+iZSAPPSVKC9+VDNNV1M/lxSL5sQaau35ongnT+R3a3y+6my+
 saZUxLR8iBTsyryO6XbtQxU42KKFoZuPWql60gwCKnGiD0VV1+mjgXLRsEHvB1s/SWVp
 m+58n/TEDfkyZDTUO2LNvBgFXqrqDbMAvdORLtVdmcljQ0ts6/E2NUZH5DLQErAFXU3g
 HrGtdW+TZEHx8ljoKxxInqOgVQUFaUeJhIHIGMG5lk31vOk82C7HMyUao/TBlojZBfZV
 HreA==
X-Gm-Message-State: AOAM531YkfiYvjLECjRbfLgK61sDEoeUY2al9rn5KM98mmRFy9jBSgCN
 rlEAur4O05CgVLx+vRL1J2yLIbGega0=
X-Google-Smtp-Source: ABdhPJxrK2k7Dp15VoWLRK1+tCORHXaWqJ0NxBeNVlx5LBrSWIQyApXl1poUEaxnhQx0vjGmli8x3g==
X-Received: by 2002:a17:906:f2c4:: with SMTP id
 gz4mr28021995ejb.484.1593711508730; 
 Thu, 02 Jul 2020 10:38:28 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/19] .mailmap: Display Disheng Su name correctly
Date: Thu,  2 Jul 2020 19:38:06 +0200
Message-Id: <20200702173818.14651-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x630.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Disheng Su <edison@cloud.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Disheng Su name in the following commit:

  $ git log --author=edison@cloud.com --oneline
  51ef67270b Copy snapshots out of QCOW2 disk

Cc: Disheng Su <edison@cloud.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8c8bbcf2e0..ce0d62b60d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -88,6 +88,7 @@ Christophe Lyon <christophe.lyon@st.com>
 Christoph Hellwig <hch@lst.de>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
+Disheng Su <edison@cloud.com>
 Eduardo Otubo <otubo@redhat.com>
 Fabrice Desclaux <fabrice.desclaux@cea.fr>
 Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
-- 
2.21.3



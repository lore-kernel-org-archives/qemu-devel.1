Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B65C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45B420702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4t/HNii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45B420702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3IV-0000nh-VQ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AV-0003xb-T1; Thu, 02 Jul 2020 13:38:41 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AS-0007KQ-7G; Thu, 02 Jul 2020 13:38:37 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so30675152ejb.11;
 Thu, 02 Jul 2020 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M55xFY/xPWPb5Bgb/SELLfC8q8usUuWnemTLrpeqLdo=;
 b=H4t/HNiiNiuzXLByuoqsaQPEEeBJBVlSVOQTpRxid+Jo+7pRKJ/UyFdpsKdAHOFxql
 5ejvzWvT/qvJLE43NeepDCWh8Bb4YzhxQeRUvinhaQ9BXieX3iHVvHy9GFwfiTbzAxvL
 2vUlaxZTzSLzhGyxbesYPyEfXPTEgigisfxsa4naRinL6xGJAADKMI/pFqnho9jDjq4r
 wczgowid1liXbonOCPiCTveYA7KYtccoUavwlTFHT/isnAChpjGWENG40HhPPzYAETSd
 DyZ8NglZNwb3GkDG9SUyvwnrfwOrMWMpajBqR3MAntnn0PU2Omt1x6bi55yKVlvoIBST
 8Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M55xFY/xPWPb5Bgb/SELLfC8q8usUuWnemTLrpeqLdo=;
 b=hXH+VQ9JDidOyFM2Vo1ows5EVhLnOP3VlezJQt8hNOo8ymF78gECvKZKIo0MnjzmvG
 re+Gt3nIq3mteqNLvdrLvS6+uvytsSRim+FVGQyHus1PNUrovp1Ttz7qO6Dv015rRY6E
 w7L9Z9ZNbwKgWtw6FBIaT5d228kdbiHrcATWNV1zIgwsIoVhMG5wqJXhIyefEeMs0VmZ
 JSeLxTPFsQZerfRK6wca7u0qjjSOwn8UIKieRt4yIWGNiM3ItgKGQcDs7sz6exxZKz/3
 kE8gbIF/ESpq4QSKlEPmtjFhP4kaF7ZpsshvDqbOxIVdU/Y1IyEg3vDqSslIGYvcoXzb
 ZCgg==
X-Gm-Message-State: AOAM531A4aDTFUt86Qysx/65/QccXsZObmDBZHrBiI0FC3Vw99FacjzH
 zC/7Ab4+hiasqw/+KlkuJEGCOQx5DQw=
X-Google-Smtp-Source: ABdhPJy947x6x2pxdBTXd4U1fo6YSzpN7EuTQrminVSwI4WUNd434OjeMKAamPRgonT83KwSfD9vag==
X-Received: by 2002:a17:906:46cd:: with SMTP id
 k13mr27898132ejs.312.1593711514431; 
 Thu, 02 Jul 2020 10:38:34 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/19] .mailmap: Display Marek Dolata name properly
Date: Thu,  2 Jul 2020 19:38:11 +0200
Message-Id: <20200702173818.14651-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
 Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Properly display Marek Dolata name in the following commit:

  $ git log --author=mkdolata@us.ibm.com
  commit 5a07192a042e60ce7415279a48aff8a932829f55
  Author: mkdolata@us.ibm.com <mkdolata@us.ibm.com>
  ...
  Signed-off-by: Marek Dolata <mkdolata@us.ibm.com>

Cc: Marek Dolata <mkdolata@us.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index efb012f357..3219bb5d4f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -127,6 +127,7 @@ Luc Michel <luc.michel@git.antfield.fr>
 Luc Michel <luc.michel@greensocs.com>
 Marc Marí <marc.mari.barcelo@gmail.com>
 Marc Marí <markmb@redhat.com>
+Marek Dolata <mkdolata@us.ibm.com>
 Michael Avdienko <whitearchey@gmail.com>
 Michael S. Tsirkin <mst@redhat.com>
 Munkyu Im <munkyu.im@samsung.com>
-- 
2.21.3



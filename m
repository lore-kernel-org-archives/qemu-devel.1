Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA6C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3697E206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHBDiO3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3697E206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpaG-0005Mf-Se
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUa-0005l6-7I
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUY-00040m-Ql
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k18so3673519wmj.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rq7v3PlGbO8r2GNFtLjMgF3yoPzwS0ECN6TUYe5e6Xs=;
 b=iHBDiO3b0XIhaDZojpKemtej7envj1CUcDxoBF7117Wy7nn50uXoJH/CibFUZs64RF
 Un/6PtNEvOVWNAY29Z2GJcjlkGx+IRaMGbcT4ORV8gpJPjh4H8tWFyGJ2D/CKozqlGwn
 LKjJ5QgvGunWbDFz2A/RtV6cfSRVKuDFMutGgDwoEsYM4BBkeVH5WGqBTS61wkYW4Hjj
 F4peDilOPSWMWJPHSpZ7scS++m65ip7XjdP+f3s0pMKE2j8C7j52Us3fyk7XYVjnLKKz
 6xpWRuMjiI8bn43LX2pWFWlasiqEjZxY8L6Oa2PrE9hVjsoidKvTvtgzPKAlFLDOLSJj
 yBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rq7v3PlGbO8r2GNFtLjMgF3yoPzwS0ECN6TUYe5e6Xs=;
 b=NNWhExb8f/25lCH7P8U7Jq/8WLly58uAXbCUfsk/8W6Kdt53V2xZGyNODgN2qQdTis
 Zm0LUtmuqni87RnGq2QQZzNLVvibbkUf4PitVxroRKOmp08npjIHRdnhcWGZ+ZcW7Ys6
 LM7QQC11sYlZZrWakVzySxGxQ+5FVEJZ+H9PFxuWvYI5RzbZRy0jJGbDtwD4RMQmSOmu
 JVXk4EFbFguL9ykOSzeI+ihrUAkWzFcdJmcTA8EHsXsABX6vNx2FSye8keZeLhmCdAHT
 Jgw5Jj+akj9myrNtSeTRX4NP2wkUYNbSTpFMvdPGMWvoD1Wyiu4MA0ITSKSoF+Lx7nOR
 0wtw==
X-Gm-Message-State: AOAM531ru5rfHC8z/sQDWaBNhiI6a8p8L1SK6pKnH6LJnP68wr66h9Vs
 uYYujEKqNPIX/LYWPEQUVBs=
X-Google-Smtp-Source: ABdhPJzb46hlPK4Eysbe2wu2kazsFcYqXJTVT/NbNKyIIGMRL54/TMPhdQ9q5SyQJl01OsMzTOoCJg==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr5964630wma.155.1602000425569; 
 Tue, 06 Oct 2020 09:07:05 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 08/12] contrib/gitdm: Add Nir Soffer to Red Hat domain
Date: Tue,  6 Oct 2020 18:06:49 +0200
Message-Id: <20201006160653.2391972-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Nir Soffer <nirsof@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Nir Soffer <nirsof@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/group-map-redhat | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
index d15db2d35e..02507b7b53 100644
--- a/contrib/gitdm/group-map-redhat
+++ b/contrib/gitdm/group-map-redhat
@@ -6,3 +6,4 @@ david@gibson.dropbear.id.au
 laurent@vivier.eu
 pjp@fedoraproject.org
 armbru@pond.sub.org
+nirsof@gmail.com
-- 
2.26.2



Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53202C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A6205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coEv5z5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Zf-0001Jr-Nn
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nm-0002gH-5w
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nk-0008LF-IV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so6333297wmj.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CNCNpGjp96y2JHNzWJfKXUrq2r9Jjr3LOoTmZiDw5nU=;
 b=coEv5z5b1IdIdlaOwxBIFASZZ3vVzCeFspJUpC2XTAHbysALFWyD3cVd3hdOjHq7Ij
 6Obm2WWXE0tpG5H00B2hgUN52uWZfxvL1gpgyQLS93vsBdNHuEwBgd92cht5DquBjC4K
 ktolLd0KUwpuG+fvPfVPjFDKVORlGlCO7oEBVglb2uD5+jC30VPfGjM2x7szQirXCkwO
 J5IyqrmBImcBySzkMuGM8P07S9y6KFuDMZ9j8WzHaMKrQP4c7epefLl2qqZkFJQua27d
 TJn/XZIOvsuZvAQN7Mv3Ro5wHC19ys8ICPuZlJfFrLWGZH6tcW8NyopKbryZv0rnuRHK
 wDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CNCNpGjp96y2JHNzWJfKXUrq2r9Jjr3LOoTmZiDw5nU=;
 b=h5rcRyYsekzH35F7g8c70hKhVfHCKhnKABIFwAMejSDimM6THWgRRmsXPrEgcLZRC9
 Vvt9qer/hiXNHcm9G+bgx5aorwuYAgFq+uwK9sRiBSnbay86WSPV86tLfCzFw7Gb/1Dg
 hxPK9uTd+XA1+83iCrQokiATC8QNb5fd1OQbXI60hFMiBwy4YQ32mQGAvVjroqtyCqyn
 qc0SapZL2kW2QwmRZ2lynD8BlUPnHeK16w/jHpBTge7O7m709fLdufqn5FPOps8Ov6ub
 ZyMI04VM9gtSDifpD/0JnHgFAtupAoZAX68ci7Sy+EjvimFZlQOovi8oTd0rQrpJCCh3
 /Nug==
X-Gm-Message-State: AOAM532HuwnZdtfuc++GUPIgnErQSooR4CD6KZJQNgIKXPKNoWODCag4
 xPW32KyfO582KY2fBNwpdlkbJajtgLMjlw==
X-Google-Smtp-Source: ABdhPJwvv6/nXnLF/IRr/xIsEIAaY5mEtsnaB9rBvEoJmm6SUkwmqfqwWmt/l1ioYocCmDlo6/0VYw==
X-Received: by 2002:a1c:23c9:: with SMTP id j192mr13301915wmj.6.1601834711029; 
 Sun, 04 Oct 2020 11:05:11 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 18/21] contrib/gitdm: Add Wind River to the domain map
Date: Sun,  4 Oct 2020 20:04:40 +0200
Message-Id: <20201004180443.2035359-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Jim Somerville <Jim.Somerville@windriver.com>,
 Bill Paul <wpaul@windriver.com>, Vlad Lungu <vlad.lungu@windriver.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tiejun Chen <tiejun.chen@windriver.com>,
 Yiting Wang <yiting.wang@windriver.com>,
 Jason Wessel <jason.wessel@windriver.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Bill Paul <wpaul@windriver.com>
Cc: Bin Meng <bin.meng@windriver.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Jim Somerville <Jim.Somerville@windriver.com>
Cc: Tiejun Chen <tiejun.chen@windriver.com>
Cc: Vlad Lungu <vlad.lungu@windriver.com>
Cc: Yiting Wang <yiting.wang@windriver.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.

Ben, can you confirm your bmeng.cn@gmail.com address?
Should it be considered 'individual contribution' instead?
---
 contrib/gitdm/domain-map          | 1 +
 contrib/gitdm/group-map-windriver | 1 +
 gitdm.config                      | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 contrib/gitdm/group-map-windriver

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 9642fd44fc..6b3a2c3b4e 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -39,4 +39,5 @@ suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wavecomp.com    Wavecomp
 wdc.com         Western Digital
+windriver.com   Wind River
 xilinx.com      Xilinx
diff --git a/contrib/gitdm/group-map-windriver b/contrib/gitdm/group-map-windriver
new file mode 100644
index 0000000000..8b4662daa9
--- /dev/null
+++ b/contrib/gitdm/group-map-windriver
@@ -0,0 +1 @@
+bmeng.cn@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 6db72da339..c384d0f4ab 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -40,6 +40,7 @@ GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-nutanix Nutanix
 GroupMap contrib/gitdm/group-map-oracle Oracle
 GroupMap contrib/gitdm/group-map-renesas Renesas
+GroupMap contrib/gitdm/group-map-windriver Wind River
 
 # Also group together our prolific individual contributors
 # and those working under academic auspices
-- 
2.26.2



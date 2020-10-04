Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A0C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DD7206DD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNb652Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DD7206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPApQ-0001h7-AH
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAno-0000pL-8D
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAnm-0008Ko-Ak
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so7334630wrx.7
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RYJteSOOfFo3m/CvcNV9rLBtaBuFYsOa4hhbQf3DcUM=;
 b=iNb652OtJPPAIQ26h68h4xF2xeS6MV+PCuxHNESeA+Us3X/n5YqjbuEqvA9QtpXzVF
 3J9aAsd2GQTzq1dh54tN5KO7rV+9JwFtcIssZq6+TzERXczD0pd6MEUlgQZsQcNSSbdQ
 LNMwDHF35DhIJX9vHKb61zyDlj1zyyaQUVWxCOheLVNKQc7++cqwqhuQ4jcVAjuBylWB
 ah0nOefO1cc7uoP5O9jOw5R9ae+KtwVMuq7UUIiXjMY/GMFlKWa3aicz1IOILKY+d9Wn
 siJE6Ic9qOQVVbpAtMc88ASwdGWydFzAFtAtP28tqL+M0XlyubgX8EC/ROYaNSMm0Pas
 uIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RYJteSOOfFo3m/CvcNV9rLBtaBuFYsOa4hhbQf3DcUM=;
 b=br+BfMIUW5rv9nH3I66ZHuxxk3wXGohOlABzgY7j0qKwdwgvF4kVUH2WsFqDL9QBdD
 p0tt5Z8utCLPwg9IqEo0Q3EJImY3V1md/mDgjBy/UKpPBd8nhaWfSdFbmVqVzEFxpNRH
 9pE/vWJeafhNo7LBwj+VIpmM+cMQGCQxIviur5EDRRkgjF6YY5Z84V8e6i6X+pWdFVmL
 f7kmXe4Jr7cvnDfDqCZoGsaXFe13nomlRuk+DdoFMl/j4uH+O742bQtb6a7n0NmLa2ef
 26KhAH22c8jL+H0bOgD3yN9PgJF1GrFIPUEbc5gaeLZgPo+ykwC0lRKnHCv/Ja8QjxSY
 XIFA==
X-Gm-Message-State: AOAM533Yws+WXlJJU1efCwRkWKahFTJilERtG6xpx/t52KYBfLNvyTqF
 4T4yfcSU3UMgp9qe5Pw4M6urQcPX1W3Obw==
X-Google-Smtp-Source: ABdhPJxaugTIvmAatpd33UL4oO+C6DxFl4nKA3ArPenkEfd32EpoBh+lXX65D/tgggV5I8D2V9lQCA==
X-Received: by 2002:adf:e552:: with SMTP id z18mr13189233wrm.50.1601844012625; 
 Sun, 04 Oct 2020 13:40:12 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y1sm10245424wma.36.2020.10.04.13.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 13:40:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/2] contrib/gitdm: Add more academic contributors
Date: Sun,  4 Oct 2020 22:40:08 +0200
Message-Id: <20201004204010.2048608-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better represent the academic group in git-dm statistics.

Philippe Mathieu-Daudé (2):
  contrib/gitdm: Add more academic contributors
  contrib/gitdm: Add more academic domains

 contrib/gitdm/group-map-academics | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.26.2



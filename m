Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9882CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC742206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNA3+b1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC742206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpco-0000Vi-M7
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUd-0005mL-Bu
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUa-000415-W2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id t9so5475494wrq.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7u3MXT7cMtXMFn6cSa9ako8EHB+wadlH89G6kATSljE=;
 b=tNA3+b1A9RIz9ExfxZR5fYtO3gm2ENaeAQnpxtk19XxEDVbDOu/vncDOJ9y+QEWm+T
 e96zbcwods4cVrZF5eiHvMVnPcXg/1YyimaOFJuJCJAKftyynwDVXNWOft5+ZIN3CRHg
 XWYtinn11H9Gb8B0RV6qZzj6FetJir41tGXj9pwaf4S/v/zShk1MgP6xOi/w74Zb6+9x
 R1gMRAohDqB6JeljpBwu3bZgQYQG9/s8dqTQRdg5LaKDTHUEQABPpwVuiY5aapmMllxM
 neroGXAaQmXGH8L8Y5P6dIR8YuFqYRU53G5e1aYLIOpY0p6FSVR/REDQaGnJj20nd0yE
 yJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7u3MXT7cMtXMFn6cSa9ako8EHB+wadlH89G6kATSljE=;
 b=SgMkCKFF/VUVjZ9cHMJq/OYIUT1AsXutogSRSOUMtbdJr9LLyI4rvUldTcHPDWczy+
 W8DmZdUrOQiBJqtrF9WJe0ks9mNVNStMGExduup3SOqhxk64X2fLpLlCz2WnbCLDIUU4
 wR7fjLUe64Q2nDwhg7f/JEEFzbFNTMFa3uwK/XZ1NfSkMzxE4mt8/OKPpCdiw5qLLjqp
 ucqQQYpbc60sfZ5Bj1ytSprtPWWZxuptVT4KBN4bwWJVpNk9aTCuTAS9aDABm4tJHYrg
 /0VcWv3tf9PeQ/oXwfqU3nU4/dk8ribqwLSit/RJgAG3t2/+SDII4/1o9IVsC9f6oVuP
 kmBA==
X-Gm-Message-State: AOAM533LeU3+TuXHYxa0d28hDiIINpHfjjNGLbeMJSjIKLLvbGdmWUZs
 g1IfIhFK0quPrtULJ5V1VyA=
X-Google-Smtp-Source: ABdhPJznxM2oPF5fgtdQ2utEfm8wy9hCKrhdPUCE4diEEiOPcVHT9TCI/1qq0jS8wRLoFvVrOTsDng==
X-Received: by 2002:a5d:550d:: with SMTP id b13mr5675349wrv.125.1602000427685; 
 Tue, 06 Oct 2020 09:07:07 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 10/12] contrib/gitdm: Add Yadro to the domain map
Date: Tue,  6 Oct 2020 18:06:51 +0200
Message-Id: <20201006160653.2391972-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index d767620837..1572070cf4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -32,3 +32,4 @@ suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
+yadro.com       YADRO
-- 
2.26.2



Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AFEC46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B87206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqHh1HEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B87206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpdk-0001YQ-QV
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUb-0005lr-Ih
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPpUZ-00040w-Rc
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:07:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id h7so10485062wre.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zWZNUQCszXHr18/+jnmR72HKCbr/Q8n5xwOgMRUpq6s=;
 b=qqHh1HEdi+PrO4P9wThX9uS3xp6guO+XT47tpDjImg12l8mgBMg86pXWAyKqQasY2z
 wkmgUFVYCNekdCJiWbkQ2bJ72IsOnNmAjH1S0tHUYN7qGFKxBIT+8mkmNW20u2BEjd7Z
 EZYBYc1mDcIsHthqeY+J/u7m+E1YIjIvrDIr/6YeLHR3v4W7omAXZQmPYLv1ZFTn67fy
 97g5HKCBOyazOxY2iPCcEKLRWpM37PSMEQkaR/hjj7Mxh1lYJeuD4zFCyd+YVwX6tm/P
 YwWy4d5JD8Dx5/JU6tYx+d7RUvayWIxGXPufCrxtrgni5UyuwsJfj4MvQ6WH9PcYHyEE
 Wgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zWZNUQCszXHr18/+jnmR72HKCbr/Q8n5xwOgMRUpq6s=;
 b=ez/f5uC0CC0JYum+ORrbtJ+ylRkealdmusIfH241c/6aA0d6KdjVckfhxd7YIZOHsP
 HqYAVFLt7nyAa2T/N6u6EGyXo5GFerfjskLPuDhBojZuNf5EECdADELEKc7K71bd/qza
 3+Owjq8ILePQz0OUqPLIzzBmj3gW8gktstDFecgkGGshPYnlksWByrv9T/AnxwZkjXlP
 aJE350ywqkO+cgPFmA7jtMJWEFebS6CaGW8kM41vrHLuazSV5LbUsqQgoSsJGKVxbAKh
 2MMsHVZAjr+uGRgN9dzN/Y0mHuHXVtL8Vcps+0UzcH1aA3wlPIlmr3FIhJnt4s90ai4I
 G8xA==
X-Gm-Message-State: AOAM531pHfKa7t3Fbf2IZGy3uyWthLtLCDyZsyz3wWg1HDalQwNYMiMF
 MM2BACtrKX3lCBOWwlScmhk=
X-Google-Smtp-Source: ABdhPJy+gguTGTwyGGD4/SeUA0djJEiZDSQ/4rcGSTX++YPP5XQ6eYjJmeGgItABWmVzZNcvAU9Fkg==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr3334084wrn.52.1602000426605; 
 Tue, 06 Oct 2020 09:07:06 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm5204629wrw.68.2020.10.06.09.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 09:07:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 09/12] contrib/gitdm: Add SUSE to the domain map
Date: Tue,  6 Oct 2020 18:06:50 +0200
Message-Id: <20201006160653.2391972-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006160653.2391972-1-f4bug@amsat.org>
References: <20201006160653.2391972-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
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
 Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Acked-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 6c5c92260d..d767620837 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -27,6 +27,7 @@ redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
 sifive.com      SiFive
+suse.com        SUSE
 suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
-- 
2.26.2



Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC503C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2A7206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofH7FeBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2A7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Te-00029Z-E3
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NT-00028P-UJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NS-0008IX-4g
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so3464715wre.4
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SO+qYOo46qQMyDUhAIXcGcd/9ocN9SHzhBygYkEzwoI=;
 b=ofH7FeBpqz+CSmZYXF52o1O0r3Co2zBxckYYW36eHumpHDpqjsCBAsTe4CQWUtxMrU
 NBLTFocFhX5VBQ8UIArMIju6gz+XOMDHa0daKpRIJei+9Qbv/Ajv/jkxqY68gLwgZU71
 f/jSbdkEV+K7/KjGpmRfyWPMS+6xrlgRuU+DT2xavu+h1rXP6THDvqMeOEWBmqEHyCj2
 unIQgDCe/0pawRU106/+bLkt3UcgNmvsas/xN9n67dr+o0NrjYPOM60iFFgzBKTov7XH
 uXpMuNmAM/KrrfBGv5W+HMcfe+5CWi7cZIQFAFQZzmPt6COcNGtfczJbIecQhnfqYIBG
 G8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SO+qYOo46qQMyDUhAIXcGcd/9ocN9SHzhBygYkEzwoI=;
 b=VqVgrdsLX5wwHNrXQKC/8eDrXxeDhTWhxcN1yA9PVj8vCIKLkDkV9bt3uJ+sunmKBx
 LpYWKYg0Sji3Uy6IgZq0WM9j3Wb04G+72pG9CUU3Q19dpYS4MMteb6l1wQt8/trPOhsg
 DgwuKGJ2cKmhjZcbn1VaKnb7usIe4TFY/pOmdaCipqOOn1hkSelYzyTXHfcNzNZe18fG
 Nqnx+/IFDpvp7oRcUybuLT481lFf3XoK3PUZeMrC/q5cdwW5YIoFMEaCsjXd8JDV4+3T
 F7UC6pkq0rsuuQXzqQMnsXE3rztWqWUtgPK9iv0T9M1vE+O0qXqARzYZYti2EyL0YukU
 rBSg==
X-Gm-Message-State: AOAM531d0ZJvEXs9gxEjmU1fNeQJzaKrHWS4NljG8oPH4tyZu5Vjv6hQ
 E/dJ9m3f/PT2lBtOwc3kBPcFdf4pZU4=
X-Google-Smtp-Source: ABdhPJwD6LGOdwra7wHqONVeitd1BdiwZ+PvM9P6IZozdeaEYCDo0Yl92WGcXHrICj9uWFITVYlX2w==
X-Received: by 2002:adf:f846:: with SMTP id d6mr14418379wrq.56.1601834692641; 
 Sun, 04 Oct 2020 11:04:52 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/21] contrib/gitdm: Add Daynix to the domain map
Date: Sun,  4 Oct 2020 20:04:27 +0200
Message-Id: <20201004180443.2035359-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Andrew Melnychenko <andrew@daynix.com>, Sameeh Jubran <sameeh@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Leonid Bloch <leonid@daynix.com>, Joseph Hindin <jhindin@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Daniel Rempel <daniel@daynix.com>, Dmitry Fleytman <dmitry@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>,
 Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Andrew Melnychenko <andrew@daynix.com>
Cc: Basil Salman <basil@daynix.com>
Cc: Bishara AbuHattoum <bishara@daynix.com>
Cc: Daniel Rempel <daniel@daynix.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>
Cc: Joseph Hindin <jhindin@daynix.com>
Cc: Leonid Bloch <leonid@daynix.com>
Cc: Sameeh Jubran <sameeh@daynix.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Yan Vugenfirer <yan@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 7fd20b1bb0..a27dca6b44 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -12,6 +12,7 @@ baidu.com       Baidu
 bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
+daynix.com      Daynix
 greensocs.com   GreenSocs
 fujitsu.com     Fujitsu
 huawei.com      Huawei
-- 
2.26.2



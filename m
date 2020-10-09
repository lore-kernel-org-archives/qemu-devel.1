Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE6C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D750E22251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi5yP8aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D750E22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQveG-0004He-W3
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcu-0002ej-G0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcs-0007iL-Vk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so11017929wrn.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LmpqxRDOSD6Y0ROM5eXEsmel/Juskc7iItZ6lbtqH6w=;
 b=gi5yP8aCWN6zonsoX0iKI44zQcrufhqTpTIjB0A+Ob7OU2o1JYe65UqKz+YrOoFS2W
 Btj6DbAMZcf4DOsXf4AVO+0csvxy+oj1wEp47ZrQVjWsL7Gti/Is6RQ+1Q5COuRnEzfa
 c67s+mzp+Rwt8PhMa5+KLg6UPP1S0/JJ7cacPDPzXenLAbZKdEBdH8VpbwQkuuX9ImOI
 Y8FPG4F8lJszyqRZTEVZldqTL1cgzXZlIO3/35/w49E2zAOWdhOXABD10VO6s+hR6XaZ
 1LUM04macVhus7dFOdT9f2a0D15PhUtb6v5HMPFNFb59K9x2ySvzGpYaF2BTDcSmB9Q8
 dyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LmpqxRDOSD6Y0ROM5eXEsmel/Juskc7iItZ6lbtqH6w=;
 b=lj60sZpUh5axzfrSUiiI1ZTaEBnlZFcmbXWyki1JabCOgev6t1WNEOxS6KX+9GBhdI
 5j86GMcjeffHUPKocdInlE91nLwGV1zPa1Eb+x/dlE0XZkmmyZSbnDA0c3FaYq+C/hUi
 uwT8erAyW/mIzOzw0ayFR9hslncSdvFm2jhmc3DsLwJQPyVFFiKr/tf8nat2vgBm5AGr
 WStRrCnrymxGLxVFO9jHqho4J9uOTm+OfraKakmbTtNZKv1Twq3C7er3Ve3ohwLqY0JG
 5aBJ9Bbndq+to1B8i9svuExB0kslzOBaku93nh5AKSb2PHMvIn8125LSNJ+kKDxI4okd
 Uq9w==
X-Gm-Message-State: AOAM533GRwyIxqvsR/JZXfsOfsA3XBHnNce+WqKqvCxRwxFxPlfHVIN3
 avrDn/bY1bbMJdxqxPoMs+y6MBB08zs=
X-Google-Smtp-Source: ABdhPJzNtZhqAisbxfpFTLSEJb5KGOeqtrOWyJYuY5WzcgoyxQgMOuvLJE1xaSrobhu4T4dBVk524Q==
X-Received: by 2002:adf:e806:: with SMTP id o6mr15824531wrm.42.1602262333022; 
 Fri, 09 Oct 2020 09:52:13 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm12777125wmb.5.2020.10.09.09.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:52:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] MAINTAINERS: Remove duplicated Malta test entries
Date: Fri,  9 Oct 2020 18:52:05 +0200
Message-Id: <20201009165208.2905569-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009165208.2905569-1-f4bug@amsat.org>
References: <20201009165208.2905569-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Malta tests are already covered in the Malta section.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d59e5c05c10..2de5943e388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -238,8 +238,6 @@ F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
 F: include/hw/timer/mips_gictimer.h
-F: tests/acceptance/linux_ssh_mips_malta.py
-F: tests/acceptance/machine_mips_malta.py
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
-- 
2.26.2



Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C91C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA21207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOonw/QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA21207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzYQ-0008Vt-4h
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOx-0001Xa-7k
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOv-0004Id-CV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so27961511wmo.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n8hLW2GDwAPKTyInaARed9CzonkKW3ufXz4O6Cmf1SY=;
 b=OOonw/QQLs4OEKwDHjCcElde1OKaOpPojTMwONk+AdyGjE7bQqn25T3jqc/X0C9edq
 Rcv0f7KYmM6RN+1F00f1dXOQFVm6kUQ8QjcMiycuTRMqwHVvUefvQoCrjj71zcAio5Wc
 bT3iBhswpk1Q9lYFFVcqJE9ZC5mqClBimjVjdS4HFQw5AKXtSzIqOV29C3QxvDL4nWNI
 +/cCZsI/DYUglYEcjtQiF1uhoPIj8pvY4gdSoVwDnR60QWKj4M4948rnRl2Xw6v2aEWM
 hZg3Rwu/fQ0HroNsrzTdylhdgNfEjMzBvNM4GBb6jV+imGy6HxhZRiuv6N2kU+/5JIja
 l4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n8hLW2GDwAPKTyInaARed9CzonkKW3ufXz4O6Cmf1SY=;
 b=jiihW52Z8yXUYT503B+23q1BO+nVljw1FXqt29GsXFcSOBJ0DMn23RWqLf2vbFVa1U
 lQkYDFgJ1i36B+5t6YB+2xvmD40aFIVvp6119J/lnIKPMjRtBSrNyfEHTS3OJjM3oRoL
 AIcsqVlPKHwWcjV4hVzkboAULqyXUIIF5mei3ZMJqF8/fvaEATfKT8F2dvU8tCTuL49J
 dEQUviTUk74cVtULOnTFMopeUSEDSeO7w3w+PRKWSrMrHWIC6Dp+ZdqnAbq5a3EE9TKL
 YsPzZXwOvdMsvVUoYyqjhBtvXNOPv4sL94w5DXKErOJD2IUL8/6MIdTggdzEHyVnkAZi
 Gpig==
X-Gm-Message-State: AOAM533x140rtkVYv0WF9ozBFbbjkR89UiVjZCc3XX9ztda8MeMRi5C4
 ICjy1T/UGXXgboWubsc3DG8jd4r5zlo=
X-Google-Smtp-Source: ABdhPJw0AeTNrezLThErHSGSh8D4IZ1TfLhQ5B1OMaoccF/FZM5srzT14vrw/gAooP7lnti1zp4REg==
X-Received: by 2002:a1c:7f82:: with SMTP id
 a124mr29787304wmd.132.1593697035796; 
 Thu, 02 Jul 2020 06:37:15 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm10190511wma.47.2020.07.02.06.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:37:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] MAINTAINERS: Adjust MIPS maintainership (remove Aurelien
 Jarno)
Date: Thu,  2 Jul 2020 15:36:59 +0200
Message-Id: <20200702133701.25237-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702133701.25237-1-f4bug@amsat.org>
References: <20200702133701.25237-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paul Wise <pabs@debian.org>, James Hogan <jhogan@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Adrian Bunk <bunk@debian.org>, Chris Wedgwood <cw@f00f.org>,
 Paul Cercueil <paul@crapouillou.net>, Jonas Gorski <jonas.gorski@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paulburton@kernel.org>,
 Helge Deller <deller@gmx.de>, Yunqiang Su <ysu@wavecomp.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mirko Vogt <mirko-openwrt@nanl.de>, Huacai Chen <chenhc@lemote.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Ulises Vitulli <dererk@debian.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
 Stefan Weil <sw@weilnetz.de>, "Maciej W . Rozycki" <macro@wdc.com>,
 John Crispin <john@phrozen.org>, Lichao Liu <liulichao@loongson.cn>,
 Richard Henderson <rth@twiddle.net>, Mart Raudsepp <leio@gentoo.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Aurelien Jarno removed for not being present.

Aleksandar Markovic comment:

  A polite email was sent [less than 12 hours ago (Peter Maydell
  was Cc:ed and can confirm)] to him with question whether he
  intend to actively participate, but there was no response.

Aurelien Jarno response [*]:

  QEMU used to be a fun ride, but it happens that interactions are
  now hurtful, especially on the MIPS side. It's time for me to
  leave this community and say goodbye.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718781.html

Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
[PMD: Split patch in 3, added Aurelien response]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: Lichao Liu <liulichao@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Cc: John Crispin <john@phrozen.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Adrian Bunk <bunk@debian.org>
Cc: Yunqiang Su <ysu@wavecomp.com>
Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
Cc: Mirko Vogt <mirko-openwrt@nanl.de>
Cc: Paul Wise <pabs@debian.org>
Cc: Mart Raudsepp <leio@gentoo.org>
Cc: Chris Wedgwood <cw@f00f.org>
Cc: Maciej W. Rozycki <macro@wdc.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Ulises Vitulli <dererk@debian.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f463b83d7a..53404a746e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,7 +213,6 @@ F: disas/microblaze.c
 
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
@@ -1061,7 +1060,6 @@ F: hw/dma/rc4030.c
 Malta
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
@@ -1080,7 +1078,6 @@ F: hw/net/mipsnet.c
 
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/r4k.c
@@ -2676,7 +2673,6 @@ F: disas/i386.c
 
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
-- 
2.21.3



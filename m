Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE267C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC3D20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC3D20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdaz-0000my-DA
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVt-0001J4-F6; Mon, 04 May 2020 12:00:14 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVq-0005kX-Nj; Mon, 04 May 2020 12:00:13 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Ml6Vg-1ir1uS0yyq-00lVLH; Mon, 04 May 2020 18:00:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/19] MAINTAINERS: Mark the LatticeMico32 target as orphan
Date: Mon,  4 May 2020 17:59:41 +0200
Message-Id: <20200504155956.380695-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uL5p/nsB0SL9v6+OlrXPk88iIW/lceEcRXqq1kPFLlsqck5NLVq
 qnFfxx8gneiX7DlS8ylUgCy2qulqQehChjELnmOQXYixnBG7nOp4AghGJOb/tAK1D06M6G/
 Z8pFWlTnTdcQ4gAX/7CZ2mnfgDf72ibAURP/yAMWP6yyK2x43ItDp4rh3C6N8g170jV8cdW
 jS+bAfM6/MaXgsxwv95uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJBEcdtFzpU=:TZ5Wxr+iLpdkhvFv8jb4ak
 +v+UkQmcrkGliVcfy/3JCiGWiKAn93usySCSvwP9e6Q9AqB4HpueODQKp+gIJiuFCQeGW6RGV
 jzcqLT8SvngEias602hhuQMRRU5nJLYOXDg4jUkvxvSszaCTjM7zD6TKSU/Ob7TNKNDh6apxv
 kUpVnXCeGtbj3JDNIKUu1zigaUxRE1si5f8JFnHc3YJZTN2uANIdapqYBZbw9BjlVVUb22h4m
 ffOsP1R++6UOqUtETM/9aX2x29QFZh6UdXiw7NaRW8s7YH7mGgRWPR5durE3kSRWOmFC4hAUl
 VesIAUVvAzCtT1N+i7I887ExLHA76PSsYzMdkeOVL5NPPFy22pInsxC1ZmVD8n+2BZnv4uyQo
 AMPd0dcLHGl98hybsVsU6AYQvuvfOBzF6+loGt6nB7sun6rZu07paSjg4p7Al9vJvUubV+gvp
 PQH2ATcg6JHwZY+KZ3gXlefO+1OnolW9Ouxa7OBvEMJYlNPRlEtuVDkrADM/d4nPn6lo9Io/I
 Nv9O3vJYk+l6lowYjMP00wKpbsgkxgNMI/v/F5ThYh3BmloAsEHVGJZcZoFiPCB9JTl/G0evW
 IBhUwghYj6wNjWFBKiHsJfTMhnhKzBvdSse5QMAUa/kNQHcgX/iSlUBPYrNHAgXm5U4VwPdV6
 d8M8P3cNznFNdKzSd1rcQdmD2sVbe/Cl+nmiZrzQ6S7MhHzMt8EumloGLzf+VlGYD22lcguBd
 vsheW8FU9FbryDuUq4GfzJAoHA6HKCjg2xCQDbpT21+W6swWk5xwnGi2ah7wkDKMGnjd+2wFx
 uAaG02ouXsLQbBwEseVmyvGt7rOvt5Y68fjxc24GIJZjv52p7q1ZpFMnUSsk3KJXLBGySep
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Michael Walle expressed his desire to orphan the lm32 target [*]:

  I guess it is time to pull the plug. Mainly, because I have
  no time for this anymore. I've always worked on this on my
  spare time and life changed. And secondly, I guess RISC-V is
  taking over ;) It has a far better ecosystem. Also, to my
  knowledge the only (public) user of LM32 is milkymist and this
  project is dead for years now..

  So time to say goodbye. It was fun and I've learned a lot -
  technically and also how a huge open source project works.
  Thank you everyone for that :)

  Basically everything still works and there are even TCG test
  cases which covers all instructions the processor has.

Many thanks to Michael for his substantial contributions to QEMU,
and for maintaining the LM32 target for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html

Acked-by: Michael Walle <michael@walle.cc>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316142827.20867-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa8efaf1d7f..d6886be13159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -184,8 +184,8 @@ F: hw/net/*i82596*
 F: include/hw/net/lasi_82596.h
 
 LM32 TCG CPUs
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
@@ -977,13 +977,13 @@ F: pc-bios/hppa-firmware.img
 LM32 Machines
 -------------
 EVR32 and uclinux BSP
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/lm32_boards.c
 
 milkymist
-M: Michael Walle <michael@walle.cc>
-S: Maintained
+R: Michael Walle <michael@walle.cc>
+S: Orphan
 F: hw/lm32/milkymist.c
 
 M68K Machines
-- 
2.26.2



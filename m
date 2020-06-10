Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E94C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF929206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF929206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0cO-0001Io-1S
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Us-0007mr-1f; Wed, 10 Jun 2020 09:10:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55147)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uq-0003f8-Sq; Wed, 10 Jun 2020 09:10:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCsLo-1jaF3J1PaC-008nvu; Wed, 10 Jun 2020 15:10:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/16] hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of
 debug printf
Date: Wed, 10 Jun 2020 15:10:01 +0200
Message-Id: <20200610131011.1941209-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f6tXZMwZDUbgrvEjnrqNSAxGAjaPzbZV3Tk/jRVBuao3Axji1JW
 iMcdgfLsBJQn0KoAx/EV2dKJIUc2GRqsaO4VDvLDJInZYsMkXlN4ZEfPiNeSSEavMfRP+io
 BTHcMLFyZjwApHoxVHGBrGX6vsjL8KPLT8uo9FmRPNil6K43vnmtfNVSmxq/E2gtyF0131s
 3pZtqv2KCoqAqEeAciDuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:95eZisdeyBY=:83FmCVHX5OnDe1rohRwect
 2FTdWFWRbPFFZ9zEdLuVdCTBCNJpsQxZrbK+oiCx/pRjQbQK+YcnqCdiOM62+nXBuQOVzcL8t
 NZ9B/keYw8nmaqoeI3e/MyBxFoF1x8qsbw2milId6RmT09qasAAZ5B1znMUE1y9vRGmdBgEBA
 AmwgtqEAvj4pOmIatd6a/Q1B0n2U9BWTqEwOFvb3Y0dDT4Q0aXlVgMJKq0n9P7Op6SycayPtl
 fNbecJec7WMbrrQoIW7BXrj/EXguHdLF1fZ4HTjZdVyQjJqsdlLKXduJNGWrnAGKQwPuhaj/7
 6Q3lVGlZupYS5uKIHFrIM8WeUm6PCK7Ec5AZR5R+u8TEB8do52S1RHk5pqNjwf8agfxErT9P/
 KU2uzPj4/vQXjSJDvqzEsRIZwiHt+q4xEHA+DZrmPd3aUGnefgmSS6YfOi5kPo2QU1bTDkytr
 1Di95RjFa0Tp5BqIGbInIEdEPiYrrCOOQkb0V+xsZOzBAx4rfBh7FEJTsjz7PjplL7EuwP9yB
 g6kbfcw3yurhnuQh9M7Z5xeakAxCLB4ThPKu0GLthrwR88jE51Gj0ra3T1RVLkDSARm8DIcxa
 w9nO9UAwYkY/m3mG5OTZVsJoZjXnLCv3va3KpSywGky0vqLLACwQFAIqfJgrIK1U8GSEEh2De
 30oZZTaPdB6zlNzY8dMr8HBZ8WndugaImUtkpQ82QwOCDqs61bbqI5UHXJ/+vQNQVl/Da5Zi2
 oznqZX3CicSGA6UaW3GZwmdUYHBNmoEux0Ingq5+d0Zj5+JaHzhUe6YKbfcXmoDTrh/xPuDON
 FZTKMJfNDff29JOcrmzqy7+brJFXSMTEfapg9tHoLDCYPw8wl24LqIYhpA6xOhoqxZjc7dY
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace a deprecated DPRINTF() call by qemu_log_mask(LOG_UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200606070216.30952-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index f8e7b9797125..06aabf20c59c 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -196,7 +196,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uint32_t address,
         }
         break;
     default:
-        DPRINTF("Not implemented!\n");
+        qemu_log_mask(LOG_UNIMP, "AUX cmd=%u not implemented\n", cmd);
         return AUX_NACK;
     }
 
-- 
2.26.2



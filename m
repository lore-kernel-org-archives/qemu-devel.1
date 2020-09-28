Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A50FC4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F62C221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F62C221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpJH-0005yk-MC
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGc-0003pp-U9; Mon, 28 Sep 2020 05:16:19 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGZ-0002XF-CL; Mon, 28 Sep 2020 05:16:18 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mcpz0-1kwRCL33li-00ZzAk; Mon, 28 Sep 2020 11:16:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] timer: Fix timer_mod_anticipate() documentation
Date: Mon, 28 Sep 2020 11:16:00 +0200
Message-Id: <20200928091602.383870-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E9M87k8ilxga7J2Kbq+H6vVR+koCd8hGomfw+KeNjO2JHx2wwEe
 ygudZXPk3dcCs8FQdw41GFQ8Ir+pn+Br7BZ/i2kMoNqxV7r/GNp9m9wklpgevU6NqDU2WCJ
 HkjPXRIADnWOVByx2aWzoJ7pezmC0VlCNN+pWgS07RDSjim+10ndEc32gw0+NGKaEU5E48p
 YZ5Vecso7HUksaI0dEV9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J0DpAWLij7g=:9mtf+MbMYOo6TtETCJ+pdJ
 40C7SkWltLLtfMsd4rzCGt4zT3k84OCmwIAocHD79Qnaa6xg0EkvkoOCb3ffIp7MjduqPJrhU
 3T6ar8BHeLHnQ7SF67ljcSsEoHaZpnn8IKwySg4Ko71ris2UL8pbzPVy1wPXDH1KV++RJC6G1
 7wCFiyMJdEuk65BJgBW4op8idmqeW4YyGEhbqq6SNgFmMFbFObOynyKCy0P+Ov+Dg/b5hzHXY
 j10IXvXEFcjAHD4E6WCde8l7Zs/5rhC71mtUs1NvHJVASa5x9u8JITmxGyY4fXfCRlJofS/D/
 fNwUAKtsH5J/79uW+0IUBEkYI/JAeq543KsTcCuXX5i5PoJf24/QWdA8bhKno3523EZGPf/wb
 oNM+XqyE+KUwfnpB60ujzXJ0cRerrWRZIMniKPRb5XQ6EKR4NGkAFApcH3M8oFkwCS2tpn0JR
 lFIvHTE2JrVjvSLJgkhr2ah77fkTNA6SvYpPHD6lb/FVuxMpAMk/CdmwGEHfTT51PfO+Q4gRr
 ravZ05angkc+W5OIUcZkpUMyYs1HZMxQHkxUBeXme01ukrJFWR5XMygkBj5+Sfu6WmZgDKVRg
 EyL8xyxdDVdLkr6EFHrJVdzFUJSTkVd0HPw9rn4potCkVAoq6oh4Py0kZ8J0TmU8B9/ehfiS1
 ZWtfItzEs1RfR7t6bcg2qcYW3DNQAbhbeMV/dBBUREcy07fWM2iMksUKkjCMkaM2o0sW2Jq6m
 n6EA/Biqwp5ThfJqE5ccSoRC5BEIsJUQuGqY9PxOwXL2bnFUHlmBEhnIE9a+8yMYRcx3Zx+5t
 wJijkt6B+9WjfTpfczv6kR1Gf6uDhv4X//LLoUZG3xjIR1mI9AHafNXMbU3E1ZfmHnlAtBn
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

timer_mod_anticipate() will be scaled to the timer unit,
which is not always nanosecond. Fix the documentation.

Fixes: add40e9777d ("timer: add timer_mod_anticipate*")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200920155042.400737-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 6a8b48b5a9d8..1dc880e94e76 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -679,7 +679,7 @@ void timer_mod(QEMUTimer *ts, int64_t expire_timer);
 /**
  * timer_mod_anticipate:
  * @ts: the timer
- * @expire_time: the expiry time in nanoseconds
+ * @expire_time: the expire time in the units associated with the timer
  *
  * Modify a timer to expire at @expire_time or the current time, whichever
  * comes earlier, taking into account the scale associated with the timer.
-- 
2.26.2



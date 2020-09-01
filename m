Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F264C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6A5206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6A5206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD79r-0002eR-T7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zQ-0005fU-2R; Tue, 01 Sep 2020 10:10:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zN-0003uU-Qy; Tue, 01 Sep 2020 10:10:23 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQaz-1kNJD416sP-00GmgK; Tue, 01 Sep 2020 16:10:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 21/44] util/qemu-timer: Fix typo in description
Date: Tue,  1 Sep 2020 16:09:31 +0200
Message-Id: <20200901140954.889743-22-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fBZk9ez3vhEgDKEwBIi+DZi3OhQueHvRjUMJcSzEeEqICWTwBLL
 VaRxBQkmEKu5bJ6M31IZM8JvJGlUQME5tsjp7C22vrYi7AWu/X6YnPFxN7S8bnv5BtgTlmB
 hiEljrKb9YAEeA91ura+6HZON2aC3XcYDgh6c6gFXTxs9PLHpkTft+/EIcJTN8GsViSJfrH
 B76QvdpFkltiXKzNs0I2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i43uraF2Yhk=:zvcwRIBjL3uFBNQTqxTsfG
 Mm8ifcRhrfOKRXjWTUWxlyiqxyuLNsC0STxyY+RUM7+cNC1KaNHy64mvVVwGV8TLtMTHPrAuX
 M4Zg2SZzU3wfeKvQnQaqnm8/gF/93wDODu9R1EFvRDWWYKl4RcpKWdlhgpH4KIeY5eAt7++8e
 eGJr4JbHWhVc/J6qA5MkGCJd6VTAfJQdUzPAATv8L7EXgO6d00PrCg8yjru4/Ofz7vmMItPNQ
 uBhAcYxXXVW8fenUW9kaXsjW/mkTXEgNVH5hgt432nJmZIFAc07DwCz9N9US64eRToWiVZcwW
 rfIpB64q/DReR7yHiaj/V1guH/jCbyJnliOHUcoxOC2OJwrC7RO6u/oMZYkIpD6FLE4bFkrbj
 gTlwFGbQo+jkRhj6BU+IEm2EbKOOf40/aknqmBQmFCemcEPNrn0+HnwcSnQlZ487ZGoIiVbuS
 2BgGvZB5lXrF5yr2fy9H2GRkzGQ1sK7isfoLYaihJhC/jI3YBIonEFw5rNwpNtoJvPFeihLKP
 OAjj/Dathm81qmhXTuGJN1RNcA1hhXKiZplp6zerQxLZTW3IDyprIE/jlcpw4NLfPLX9xiLI+
 3obtBNZP+gAL2A5mZbQ36Jwu//RC/sGd+MiS7OtA4EhXM7aVek2Ga7zHoIH9ngbbZAwPC1tPp
 ftqAkslWKeHbfb/ZYRApdQwMTouMqpfKQo8BMzXBK5RHh9OqOaO4mifyhJmnq9s7Bl8Zftb6+
 9B4ZhtJZTm42xGb2+f5L0ea4vs4VkLQCxL8KOidNkvTw8YcuRkPy7ftNW0Lj1+04BVyEeRTpZ
 1ezb0EkkFf6VOhnnOfmjkmY1EHbet+Ct1lYuvGBn9n93jBkUzlwKKzREC5aInr4Nk0P+6rg
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Remove the second 'and' introduced in commit e81f86790f ("qemu-timer:
avoid checkpoints for virtual clock timers in external subsystems").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200811151643.21293-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/qemu-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index f62b4feecdb0..878d80fd5e5e 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -530,7 +530,7 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
     }
 
     /*
-     * Extract expired timers from active timers list and and process them.
+     * Extract expired timers from active timers list and process them.
      *
      * In rr mode we need "filtered" checkpointing for virtual clock.  The
      * checkpoint must be recorded/replayed before processing any non-EXTERNAL timer,
-- 
2.26.2



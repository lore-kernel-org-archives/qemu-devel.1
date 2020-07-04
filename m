Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E54C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B661420724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B661420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl6R-00084G-1f
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzV-0005Rb-EB
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:13 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzQ-0002PL-2z
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:11 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mg6i8-1kZ4YH1ozO-00hi9X; Sat, 04 Jul 2020 18:26:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] MAINTAINERS: update linux-user maintainer
Date: Sat,  4 Jul 2020 18:25:45 +0200
Message-Id: <20200704162545.311133-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8sX+e2NSDaIHCQu0TTEDNlcZ/VwtWKnGjqGdSQNDsdPP4ZpZrR2
 enIelki7JMOnKwyJih3gJEsuwOV6wpr4POBzNLbxQW/1byQtMBQMj4Mx+cP+OjfRZY+qIWv
 VtGs6zjR+z4JKHAzuc0aY47V7R8QRnY0Boc1RdJVpSu7t3f1KnpwlgRqbNzfliO12z7F/T4
 Cq58+XMKib2+jVqEgOOXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NlzIBrMGrl0=:h8HamdyMe011bgR8o55aK2
 uhMXEHhP+QI9UsMm6Fvn1ubMZrVEJmN2ORPG2MEVheVdk/Vn7Idzzd6GJ/IP/4oYQlBnKkpTj
 JEbexuFNewFoC51GV18Q+xv6Whq2uJbNOhCBVZ/cRSLGJfYFac6MTqgxuVWdiySvt10nRmPbF
 XZ/PgQV8+R/gc6peRkTXfUTNrHDc/XjELieZtl1QLghIv9laxyLim9YaWiN4o6CAhN/kjRvaD
 0G1A5XyI7ysB7ZuA2qs/lJEN4eKxVQMK6IkYbapL1tTmxTRZPalOOIH/bHE1ymH5MCbz2ry91
 vVvvEasMA6vx22U0G/oapUOJcmAD8ALeJjZvSJyhMjLsApL4J7Jxi1mkIj5cNTx23DIcXFE3m
 6qrFMwgo0mRqDBAksgZyTRcd4SZl+aAJvpGXG/Oo8w4fMNbcaJSEQTVmuRMOSXnF+G8C6Bvhh
 RV1d9QJYVQo0ACgS8OycXqbXT16QNd6hBu3/3UuKMqf4TfITBJWr4aPMyA/dkVGW3ozif+KJi
 k0jLnputa5MtLYkM++ayhXMga5xF0cKq9NipnKcYPT0gnhjAiSNN4rJce38v/jSGKwqStjlXn
 ZDZ2H8dxmZuaCHlF/teLue7jTUtvbESk4eRTsGJFprlIlUzdNgNVQREe/taH14wsvgnlXWg3T
 2PmYfLlhwxLVGe2JzUqx9+f2Nqb34vc440ujn8o+2Prw3aM8jLfDHpvDHClBfSg1cp5mHOYb3
 Plut9rFhkungsUBGVxEhhsK5Qvhjr6mVgZLcGiitchN+4aJtm9Cj06quoJG2cHNas8iFrKFWw
 fAS+DBhDrFixaPJExbDxnZX1NqbycP1XkbSvcZczBm89F+A7WI=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:55
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
Cc: Riku Voipio <riku.voipio@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Riku Voipio <riku.voipio@linaro.org>

I haven't been active for a while. Pass the maintainer hat
forward to Laurent, who has done a stellar job filling in.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200702111636.25792-1-riku.voipio@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b1d..29a23b6d3a5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2629,8 +2629,7 @@ F: bsd-user/
 F: default-configs/*-bsd-user.mak
 
 Linux user
-M: Riku Voipio <riku.voipio@iki.fi>
-R: Laurent Vivier <laurent@vivier.eu>
+M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
-- 
2.26.2



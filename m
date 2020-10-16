Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E264C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B542083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B542083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUJh-0005EO-Bj
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kTUGt-0004H0-72; Fri, 16 Oct 2020 14:16:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kTUGl-0007Bf-H5; Fri, 16 Oct 2020 14:16:06 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRC3Y-1kqXQJ2xd6-00N9wz; Fri, 16 Oct 2020 20:15:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] goldfish_rtc: re-arm the alarm after migration
Date: Fri, 16 Oct 2020 20:15:48 +0200
Message-Id: <20201016181548.1096112-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s/iqftZ7tir8IDxhMcA7EMpvwSV2Jk89v0PYGwhqS9p32nbGIHX
 CldMaA7/q50d7U6LfEL93+bD8tNwM6YxKBNDlFfVusX8rHyqUykuIX50FEIbs1AadBVnX/q
 lPVDceO2YFHmUKGMMY0o2jmbOIAtJ3eTHIehR5AMHHA2lyYgrdERzwPasTgm4rkv+0+WPbi
 FL9Lm0xTMPf8EpSFvADAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dnf7TBKgIVA=:QM4YmSH95VIvPFu8iVXnsn
 I1C5WZ1y4CCv9dhZW0owpsDgB5oKLibhJ3MYBR9kZO9RAXxv4dD8wGEdxQUm474v470TPJ+It
 4SV1qe71BsWKDunHQmh2aY8PRkm7xP30N0ONSg709Ymf7gXxnix5GGgpNsTsRXEzOhHZ2GENL
 jmABmuMSnAoLKlpu+Ll+Fa22wg34M8Td5+DOIuE+0xXe8G2s2gbtXoLwzcF+ABxve55TX2gG0
 XFSKV5BOM8ySnhko1WZPY7GhJ0LETn05+Pg2pbalZI1NuDw+eDfSQYcIaOL8O6ek8OAGKoTiG
 mFenmBO39/HiiDq805On3xbuDbRVUSIw09brwBcfnQt1KFxY2lMRHT5UTEWd1HxdT8iwRfv1t
 EWhF1uYO/xm+uEDImBf8f9kSlJB+LixVcOiH5ry8WjF5KS+ISFKML/NplfcUz
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 14:15:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, qemu-riscv@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After a migration the clock offset is updated, but we also
need to re-arm the alarm if needed.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/goldfish_rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 0f4e8185a796..e07ff0164e0c 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -211,6 +211,8 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     s->tick_offset = s->tick_offset_vmstate - delta;
 
+    goldfish_rtc_set_alarm(s);
+
     return 0;
 }
 
-- 
2.26.2



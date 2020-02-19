Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE073C3404D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876BB2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876BB2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MVA-0005lJ-Ja
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPe-0003aU-Vz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPd-000579-V2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:02 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPa-00050Z-Pg; Wed, 19 Feb 2020 05:16:59 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHnZQ-1jH4062Uz8-00ErOT; Wed, 19 Feb 2020 11:16:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/17] tests/qtest/libqos/qgraph: Remove superfluous semicolons
Date: Wed, 19 Feb 2020 11:16:06 +0100
Message-Id: <20200219101612.1033925-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JpUVUNN+S0+cpEQ7Ukn+HanppYJnz1MOzhIPtY9bWWbtdRnlNeW
 fjmIzxWyibl5/aaGjt/3Edg+TX35x3OMfs9jkkp0lWrOWeKWGYYZEV71XfZUHhO+kXj5IpG
 RsVNYTu7vEFqBSZVfY0U66m6UasYctRfJOKM5sGpObgMNIORDVcSsWjUhqWHysEREbhwSrf
 0lynHRHLcq1aaZsVnYy1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6VzeMLdb83I=:dcixetq2v7BjSE39LhHLZb
 SlPSv938kldCjaw+Xl59xA+Rm9aVV5LXOfkqnNkyCd87DhhVd3KamGTTd+g2dEpgzO9te7K9n
 hVRXu6w+f0cSHsZ3GwaA33nYwh/AEMzvONqlzTfvHoNpSdCEXOSM/Vaf3Ce9JoDCiOyN/wRVE
 BdOLErc7SNcstp0jMxWpHcjjJzztxbdLclwsavzuN1q2Q4y11QzMsNipswGU4RnOxjFj9j1aI
 QzX4V8v1oUHkwn5cqAoPiElHcbQfiM6VLRSucLIcBD8oz8y6yv5WNQKbCk6Fk49bc1cIreuEn
 GPFrCXvgSUwe97hka79PZPYsy+TsX3EBiwIm02KbsgeO9j+GKDf+fzCk39BIJeT9tl2vVR8N9
 eNs9Uajobg3xnXyZE+ZtDvnJIRygUK5uoM0zeh3UALO5HiMxRdg6IirDfSTPb5WfTcP4FaM7j
 o1/mG70nIXVB4Wcy7muuUGYgA0fBLR62JY4X5AsRZSxKUCR62XcTZj3eiouOSFGuugGL/50It
 ZPekopFAG5wSLpaBg4rYHO/usOnN4lwujP7tyQiauBwoW8twayiYIoFftGoCt9oN6dH/M8vj2
 07/7nr1sicikV0dFEk/YIRoMx36A5wByLNe4WYgtqqewoh4AY/paHJJQxQZDeuDwGxh+qIRnC
 +pmkzVmKVRgSDy9qGDYeqBCw/ZVy5Wqwc1PnbOmho8/T+qui8Z7t+DI8VutZ45Q+MJVb7HqoM
 Uv38HchWPngc6lP05zNTVvcfXShsesjscX0EcalDZBNrCkz6fn1Y18hFZPkP3tJFqGvoXpRfy
 nV8h3JikpueruaW4d7qFy1gsgqyhIUGNZmgAh5psE9B0iwJoV93UHcDYcYqqixG/zvG7zLP
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: fc281c80202
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-13-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/qtest/libqos/qgraph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 7a7ae2a19edc..ca01de07437b 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -474,7 +474,7 @@ QOSEdgeType qos_graph_edge_get_type(QOSGraphEdge *edge)
     if (!edge) {
         return -1;
     }
-    return edge->type;;
+    return edge->type;
 }
 
 char *qos_graph_edge_get_dest(QOSGraphEdge *edge)
@@ -590,7 +590,7 @@ void qos_add_test(const char *name, const char *interface,
                   QOSTestFunc test_func, QOSGraphTestOptions *opts)
 {
     QOSGraphNode *node;
-    char *test_name = g_strdup_printf("%s-tests/%s", interface, name);;
+    char *test_name = g_strdup_printf("%s-tests/%s", interface, name);
     QOSGraphTestOptions def_opts = { };
 
     if (!opts) {
-- 
2.24.1



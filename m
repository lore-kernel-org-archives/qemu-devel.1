Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD322073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD322073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZo0-0000Gs-FS
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjp-0002zg-Sf; Mon, 04 May 2020 07:58:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0001yg-Om; Mon, 04 May 2020 07:58:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOzfO-1jmAmM2VKO-00PKXW; Mon, 04 May 2020 13:58:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/mem/pc-dimm: Print slot number on error at
 pc_dimm_pre_plug()
Date: Mon,  4 May 2020 13:57:44 +0200
Message-Id: <20200504115758.283914-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nMIjpqcyfeagiB2tomuREloaNkW9VnRkFmvDSw6OsS7MG4ZWEii
 4KXMpA6rphhNRiAmq5w26xpimy2x9RyUt1nWl1050+tx5soX9Y9ErNKzM3GkZEhwNJRD3NR
 /TuI4KSaaKe2wa5fhFrNcuB8TJ013OSrCQeKlQuECnzyvaeKK9j74xftsZc7ugV+9CH+9qk
 Vy1PKXICu3pjuZ/ADCYnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mTVN/XyWfEY=:W16uyu/pJhNvkGvWiPgjvA
 2FWi/MiH2OyqHoIKaAEFr02+vgsbblDvDWSVhkbwGHKBGdZCLG5P30o86Xir5E7FdC2FifVsR
 h4MQhI7bC4IfLArOSalR9WxYlEB2Y9/TVQ4Q9Q/4iun+O+f6sHYs23ZAUxqMQ6LV0UNuCLtpe
 4Z3040p1xG0mvpUCfys22cVjxtsCR6e1JpQPgd8EYGcUJf/4s8G06rBG5+0xpd/4eGu3c4EKH
 bY0DnYZVJHzySeqRbKTGZ6Kiu5zNZpqFrij7ziboOX+po+ivuIcP93NKzQBzhvTIAyPaB8i6N
 Mz5TcRB3EXm5kNl9mPl/FiIvv/nCSUwkD1prNjI+b1494bJtaHa/HRLRadbEumg3m+6qHd33D
 imJa1PMWBnNHOql+9teP+kFBQJMtbaMTRaEz1k71l/uNMky/morF4jQfY7hulWSEBoK1oiFiG
 YslBiV6EkrPphmZ0MNQcuXdhaaN8lS5KgB+GLwZCPtYf6eLjGRxbBGwu9Fc35r49tZ3eu6aUO
 5zDhpuBPFgjuxBK/j2IycSlxk5xQw2KJsDIKnxnmfJD9jHu2ex/sRVH/MjIfrAcJkL49bTz9k
 GrUtrclUpqc2+WXgO1WGMsEwMhFaoWHO2j9a6EIroO6HTKL8Zfma1AgvIfbNSxZK5wBG05Gs1
 0ha1HlasfB3mgQRQUkI+wivgNE9rJYaBL8Kd1DvSe/mdn+MfgoXm/TkuSIIlkN19h7PCNYikH
 rAdYXRFw0ji90cBFO0ERL2tVcRdKDRi9sOOoP05U3xMgvdJUQuYwMjVA7VTJRztUsVJGZ9+jx
 vRzKidr6n/kn5EapysUJ+ZxZyjQtteYpQ+NrKqLtpeqkGn3w1rlz0UlQqLZoq0Ze8QsIusr
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The error report in pc_dimm_pre_plug() now has the slot
number printed.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200310180510.19489-2-wainersm@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/mem/pc-dimm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8f50b8afea3c..36edfcf46799 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -44,8 +44,8 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                                    &error_abort);
     if ((slot < 0 || slot >= machine->ram_slots) &&
          slot != PC_DIMM_UNASSIGNED_SLOT) {
-        error_setg(&local_err, "invalid slot number, valid range is [0-%"
-                   PRIu64 "]", machine->ram_slots - 1);
+        error_setg(&local_err, "invalid slot number %d, valid range is [0-%"
+                   PRIu64 "]", slot, machine->ram_slots - 1);
         goto out;
     }
 
-- 
2.26.2



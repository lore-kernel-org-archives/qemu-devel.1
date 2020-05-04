Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ADC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8E220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8E220721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdYp-0004oI-Ck
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVr-0001F1-3I; Mon, 04 May 2020 12:00:11 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVq-0005kK-3B; Mon, 04 May 2020 12:00:10 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MofPt-1ilnFk1Wwr-00p6Ni; Mon, 04 May 2020 18:00:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/19] hw/mem/pc-dimm: Fix line over 80 characters warning
Date: Mon,  4 May 2020 17:59:43 +0200
Message-Id: <20200504155956.380695-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:em8Ro7Bxb76UX+NhBZVrhfAo2IY158fF8IAqTyytP9VC0EvtNvj
 VnN3b3aL++yj4gdmMyTg9Mn5sUN+Ve+Zqh51S5Ux6UUME1Es4TkFuAFj4yo/4RrlT4OPAZw
 us95WJ7qwU+ipeYIVpJLwiS5gA0SIAKt6sHaBS3xFws2vxn/Ezb1D5sZg4qm3OjTxVSVEHt
 qsrF1QLItJdFcJ7dHtnXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EsG4avR42vE=:8iY838rOaAJiXcAfwcAo6O
 wUGkOvzha7fDgU7ARzJeN6er9b/9p14U1PxuXhTpHeFntFsF9KCOqAKLgWM7difDayPoRD19T
 NT/SJREm7vSaT8UmNuTPMMDHvoiOoTkJvcou6av2/fKxA3cdwlGeD04Tqlftwa0EkDVUbprLh
 z+EJNF2DQUxm4jacL52bos0/YwRRB9EZI8AI5pj8Lr43+GqzCiIf9wjXmH6c8nvra5qpvUeY1
 jgoXe1iTZ9K1B1CtTh1GZL0gpYm5i2F04BK9JuHkAN9Tc+mQ+1/+52jIeTvEM8Ee0YKfwM42Q
 4K6JM8EbYQ9JMYxCHNg+wUS29MvgTkxFVYMbBhh/vnzWhaIlDiatWM8ek5oWBT5pFvcMA1pcS
 8a58vo2FYmKuSnW/3QpVT3tEqNQySqUZHpSQKq02tpiFkVZyipqteZMHKRuCo5q3RcSPF264/
 r6XedbzwX0olTai/e8LIco5B1Qtdtuf1evv5ozGDNjObgnFm4+ART4Owujhr7BK0WlM6Cb2Ov
 qwCDsyE110jA7XlHPmhipoQ5vCPjzhFK7fqSGi4RXOz7ffG5KlL1BhWr9bFwdeV9yUwn7mOKf
 U6VMicYQt1Pk0R2pr4KEkCSAkOcloW+rxL9lYnNGWE/NeHNl0PYkp7+yJXeC4Cu0eBzaBxm2D
 PSF/A7oz1WPcRGrokPG0dKnggHX0xvn6J45XlsPFaLplT2abQp5wjgglE6brJVid1e9NFDO7w
 zWJA3dmJZPS25d6fc7mM9l/Fqnt2tN1/d+5PYCZKVzK0duycezkdTkxeDYTk+BKKhYLfobfZr
 DPsu1C5L8qJn6xnKddBlqoe07iPcmk6hNN/qXxYoNHa9nK+Pq/oa4qVQSCXcKMq/XwmWK6o
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:08
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
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200310180510.19489-3-wainersm@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/mem/pc-dimm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 36edfcf46799..6d62588fea8c 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -218,7 +218,8 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
-    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, &error_abort);
+    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP,
+                                    &error_abort);
 }
 
 static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
-- 
2.26.2



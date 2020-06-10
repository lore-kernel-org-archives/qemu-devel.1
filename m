Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA069C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF002078D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF002078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0X4-0002Fw-SX
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Up-0007iM-8b; Wed, 10 Jun 2020 09:10:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33379)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Un-0003a7-V6; Wed, 10 Jun 2020 09:10:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8GIa-1incZS2u0W-014Dwg; Wed, 10 Jun 2020 15:10:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/16] net: Do not include a newline in the id of -nic
 devices
Date: Wed, 10 Jun 2020 15:09:57 +0200
Message-Id: <20200610131011.1941209-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zW5agQm9+hnRkugX9dRv6OmtIMNVTi/qL7EpK+RoYDoTmod2A5g
 lV3oXzwahxJw72SWY7LHB/N2bOdU23umLr+LEvpi11y/3ONei4iWPMrl3z5CERtEQWU+CDt
 HXJBHVX1OKt3aXCWkDqGTUrP0MnnwkkhW+Oy6GvCTmC3hWStuH1nqFJZQqQCsbQhATAewh/
 fKibQv8rovx2XdwjtMGCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5J5hcVjLmQQ=:zmL8+vTkzeBwOhQPCqsUl2
 U2yAmhYHA3+LS5TeyXRziGo8+dAigCZtBLBwkOmUVAoRTZVl/edkJPn3GGPKFlBpIsICDvS4C
 1RMi3aRmomf8nZ1sh4wI1ybW8aM+ovj23SENpt1uFIj6lwmOhlc7DHm3Y6ogjQuDWY78kO74/
 QqUzYGQpKc+fljJxU4023vA8F6om9bcPB9drenatls5sa2p+O8yNEpaT5VqdBAx1ORR6cdtUh
 a5pkdbhDzpY19GuviVOFw6rni1dxUAbvXduivOKQVfBBqRPArxSqNTR8yNJ0qzAEVwgvh2t1/
 u7Jr2U1HNak4DO0SDUePMcR2NX8ktKiqEHRt6jo0KUpWZwUEITme4tV8ixWYQtu6n71gp93RC
 Cnb6PO32SZu6+bm5MAFvh6eQUEIK+gxsOgpQg0yTBzWkpBufdTZ9LufKMtrsz1/a26tsHhcgP
 t4k2ZEmgpHIg0iDIJflypnL+wZpYiBs3jeJ3YNywgsuGd1D7X7k4VPFiTVodPTkjqhzDKEtDx
 1KIvXPqyrbQCAb9zxJbqN1uB0wMdulfhal2gGjqswQjTsZR8KrKpU8kkEpqwqv+V+5/dC2TSH
 V7JR7skh+gKr4z9FLH/GdGSu+bXmWlaeRQxePacp9omTauw99xurwrjUtOMLycii4vZ1uYQFy
 PyloLiwAqLb0rcChZLniuEfNqgWgYhtOb+QKzvrO7IIfHx/jD6Bs46OCvRJ4Y+9Pd5WO28w8d
 MZtMe2nXDxPuoIm9e+U994JEtQdKYa/qXp+U4M6c9h7XmsJBSTzV3pdspCFrBQLrJHsZR83lN
 6wtARNCmuPe21+MRzTraG0Oy9nlEsjwmcHS/7F77YgJhCLy6Hk=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The '\n' sneaked in by accident here, an "id" string should really
not contain a newline character at the end.

Fixes: 78cd6f7bf6b ('net: Add a new convenience option "--nic" ...')
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200518074352.23125-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 38778e831da2..cbeeeadff8f8 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1506,7 +1506,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     /* Create an ID if the user did not specify one */
     nd_id = g_strdup(qemu_opts_id(opts));
     if (!nd_id) {
-        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
+        nd_id = g_strdup_printf("__org.qemu.nic%i", idx);
         qemu_opts_set_id(opts, nd_id);
     }
 
-- 
2.26.2



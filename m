Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414A5C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBA121D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBA121D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGowZ-0001nj-M9
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGony-0002na-1M; Fri, 11 Sep 2020 15:33:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonq-0000pD-OT; Fri, 11 Sep 2020 15:33:53 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mm9NA-1kyiH82wNs-00iCoM; Fri, 11 Sep 2020 21:33:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] hw/net/e1000e: Remove duplicated write handler for
 FLSWDATA register
Date: Fri, 11 Sep 2020 21:33:21 +0200
Message-Id: <20200911193330.1148942-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y/4Sk9ZML6j6d7n4zSs4wCwLlVgPAzfY2WrD6YIIDM30LKGNFML
 ljMQ17ZVwLHCpUytAcSfMZBzQCprAwZZoRpl7IL6kZWczDLsIDqTN5WouRTpyZ7+0eFhA0c
 akMa1Nsrm81XwwIVVEe5P2jQ7tWl1XCR7voTHoORb/QbyFyludvSBVpzxjnR2WL9JQC3gRn
 PNOdaNLF75m5lyelh6D2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwAWt+jCFKA=:DEREyALNF8B/RQCivYJ1x0
 mOSVPrr2Ne/h2Vcq3swlZ63CUcyO7e3p8FwMqJDDG5kI+m8V6yD222uRYb/KUtpQIWa7UHOe7
 wyAJusnAbW2oZs7u+Kj5gfwPeysupvoKeR5QIRmt1liNcyx4WUOXyDJiicuh5uQz3Qej9Qjiw
 l1iMsq3BzIInv4JtCH5+CK7yE5kwW4TAhHO+7ACRE+lYJ77HWlLf5WvuXtBvis2iVDiDqOEwN
 /YNJpozUEeXOE5N34xV/QuTZr4YFe2DL41YZP0pvTMB/vmSbOKwbrU0u9xAyyoovdwD7ByFdF
 3QMBRdMNWtMepOW9LUEBkTabB+Gvzizp3sCMwQbKmTu1Jp2hgCUGNYdYyJTbYrwwSi4+4tX3M
 L3d1tnx+M/aYjV+HD4TmNzcbjS+h5zSJGiVpQb2fO3/XjnUK0KfIpK65OdUACzeYqg3DXNmtR
 77twjq0y8GDD83z3ljs9xeggte9DOu1Y6bXGq4005WnAiwZ7+Zd3SQksBD9sAFPT/O6YONd8h
 5W/c1RUTfMaWfqPu6Ui4GKu13zucjmI6a+ptXdCB4CaCu7i8Qs6xsN23tcWWcliCmcGPvzDre
 2PE7zx5StOJKDhvLtNmMr94mFZQx1u6YaFaYye8kYinaCXJZIt4qIi2Yw1LHB/A1PIUCWUd+p
 vwc4tLVxyuoSN47B12ANe3SWHZ45XrV7qcE0oe4S6UTDJ8Q+67wc2njoyGEXU48KOPpWRL3TX
 WIRFKConZrp4iPwzxOM2RRrGpHVanLWuQWXI3opPk+na2vGnQG/krSbxp/5B4F+fLK1IF/ZKi
 ugbwL9yp89d9eDzBYExiuOPG94/gOqBKNbe657CzP6NMlP6N+lVWYdARLDLllTpVdBDwNa3
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The FLSWDATA register writeop handler is initialized twice:

  3067 #define e1000e_putreg(x)    [x] = e1000e_mac_writereg
  3068 typedef void (*writeops)(E1000ECore *, int, uint32_t);
  3069 static const writeops e1000e_macreg_writeops[] = {
  ....
  3102     e1000e_putreg(FLSWDATA),
  ....
  3145     e1000e_putreg(FLSWDATA),

To avoid confusion, remove the duplicated initialization.

Fixes: 6f3fbe4ed0 ("net: Introduce e1000e device emulation")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200904131402.590055-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/e1000e_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 5170e6a45633..bcfd46696ff7 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -3141,7 +3141,6 @@ static const writeops e1000e_macreg_writeops[] = {
     e1000e_putreg(RXCFGL),
     e1000e_putreg(TSYNCRXCTL),
     e1000e_putreg(TSYNCTXCTL),
-    e1000e_putreg(FLSWDATA),
     e1000e_putreg(EXTCNF_SIZE),
     e1000e_putreg(EEMNGCTL),
     e1000e_putreg(RA),
-- 
2.26.2



Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B32C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ED82078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ED82078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEDO-00076W-0G
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBZ-0004y6-Mx; Tue, 13 Oct 2020 02:53:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBX-0000EF-Cb; Tue, 13 Oct 2020 02:53:25 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2m7Q-1kKcMb27WW-0134cR; Tue, 13 Oct 2020 08:53:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] qemu-img-cmds.hx: Update comment that mentions Texinfo
Date: Tue, 13 Oct 2020 08:52:59 +0200
Message-Id: <20201013065313.7349-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9/2TaPVs7al+WnuZp+H12LjHAViYpMZ7YNXLDTtzwILLgfmE4E8
 0vH5w/K4lr15QfP6lnmAhf8hpaAFvlcNIE9GMe5tWtZK5s+Q/PoVGRgt/F5uKWWg/eGwtao
 JBbDzFoyezbq/uZmCFHH9i/Vosz7/KjNmDsAPkdCVwlcXWiwHMWS25NQek/ivZdHDHTRXgr
 iPtqccT4SC95HNHvMYRHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbBWPb0gV7k=:BS8Ayd60zCkUFoZBIBicJA
 nXjCfAYr6DJkOMZ9hHB6h3Q9w7evxye+QbI12YEX6UAgBYRXVX466bWJ7Vq2z65khk1REZizS
 yo8FwZtEsVOI6fw53k4apAVEaMwDl3NYnIP+X7Y37jtVcuf0VP63o43KJ2fgNgO0V3DPZSYQ4
 dS11Td843KrcresVpPPzIbbUx5kkKWXzHWSRSDYZpb1QflbHuj14ejy6KtykvvFRNhDXFSk0o
 0Pdf1zkYOB6Z8EGC0dW68lJpgdkFS8QqVS/XeNUwfgM5NPkfgTGbtx3hZa0uEbNOtUJ41HgLi
 FYqCBwpgN7O1TasifY5SzTuNMMf4CPg1tc8LNN6j59VCdTKtPIBzTnRoihP1n1yVHvFsz2G0A
 tCR027rFu06BBjmeJh6LXONLUsGWKFU2c4AK0lAC3PzSUGFKq82BBfYAQYMgR3J+RnAjBx9zZ
 Sibc11JdcZm/Y9CTyowgcQVO16nIN7zGXDMif/7+aioKaNOxSwvwTWQ1nCqsl049AwXUA2tg/
 DpX+DtC7yFeVpzQBoFUOVy7US2F6kUf/KnHxQc6YDI4FeyrR4d/VeEvQmEyQK6K1eRmvQQZI4
 iUEsflWvA8DzqJwWipItMnm9LKquHLeAnmB8F2tfYdzBjf8PahB8Q/SsXOgdO5aVftCisKlj2
 qNK3BVyXtyh8uT/qeLmPKm+VNDs7GUZnFooUsaQ7vie18GNfanR1gcVxx7vcvf8+055s0gX2Y
 ftALUX2RCBwd9/Lwy2p8/IlXBLZAA8V9ENivoIIcbjN8Kn3NzxIDHfdoL4r2mKXVbbKH3CIYL
 oY9EPYVfpIVXjaCfhteaasueLyHDk/7VDKfZYwpPccf2HoTXRgIBlsCtAMGFnU3cO0430Tg
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:22
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Missed in 3c95fdef94 "Update comments in .hx files that mention
Texinfo".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200929075824.1517969-2-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-img-cmds.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index b89c019b76bf..cab82342358e 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -1,5 +1,5 @@
 HXCOMM Keep the list of subcommands sorted by name.
-HXCOMM Use DEFHEADING() to define headings in both help text and texi
+HXCOMM Use DEFHEADING() to define headings in both help text and rST
 HXCOMM Text between SRST and ERST are copied to rST version and
 HXCOMM discarded from C version
 HXCOMM DEF(command, callback, arg_string) is used to construct
-- 
2.26.2



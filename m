Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58856C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E72C206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E72C206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYiB-0000Ml-F8
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgQ-0006zl-0E
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgO-0007eL-Va
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuUza-1iq8qb25mU-00rWhI; Sat, 06 Jun 2020 15:16:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/19] Makefile: Only build virtiofsd if system-mode is
 enabled
Date: Sat,  6 Jun 2020 15:15:55 +0200
Message-Id: <20200606131607.1250819-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kR6Glro0iE2IiwhSW8XBSZzUErqBsgKd+ANlyyEybyGpVz9sqWM
 CrFh+lv6QonGpHAdkfCF3gdEnbi4i84lAMoTRigBGxqJSxLDsrX2Ksu01/2ZJziIkcouYG5
 1t8hY3TE4gVhf4k9kHmHbDTNBU9XGJD0ggrpLFwiNzCbIdK10ZlA94ZjE0/3zJR35gPpvbL
 +BPE7T8KBBZH2BdZRbJgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YSsFSs0MX5o=:AQEftK5myj91suvnjLaBYe
 /WgqLm6MeKaeXH21ye7/3iCpph5h9cNl2NfmVdcbOEwXyRxD12vi03LrF6wIHeGotUurrykce
 dNMHPPefNa37vcWRTM1UOAUkkin3CxoLNZMxrnf07LzMJLr5XviPmNM8tFgmqb5Z3MRZRdQzM
 qy6lNyncBuURR9ovjiKBM0xNiBfC5a7nEBzcSRX4QBy7wgmUbzBk0LWo3Zy7/ayvKTMViFwaT
 Uog8CWmoiBl849s/fZI5I4aSAES4Usfv4ho9dTxycWXjA9/YGqAmqNAYVJ8c+htTNndC/rzMU
 0kKy1CvYnIxC6jEIdA/GEASTRvmTtk4UAK8/i55ZHqabFYmeA45ceRH8aHQCmXsyLmPN4lnkf
 Tf3ooZLHhjrqnqQxQuKCPWnad2Bp7I1uIQ9A+S//IwqsZCaIqfyZzlubYotpB+9YgR+/3AfiL
 2vVlMYkPNn7EOobSI/HIPFVRh/SCYLpXYknpxdDH9/aJsrAXB8/PPorzlwMDZJKNYe+jYr+WO
 yrTCnSDCOsvSWrdPrImM24SuRJCcNHkaovaqbohMlncMeffVs06eZhxc5yhpoP31caJDY55Pm
 hg1DhBxTCM6FlcbauSy8pSCS71VdAefMgwJZQiq1Kak920qPMgD84/Q6L04UM+I8PkXufXUpz
 Sarn91hBMWr22hnK8rABFDixgBOYnfaMPBLqsUaiunZ+QgfxeDOOEp7lcgGF2tacVOBygVL5L
 6MWmp9+3/Ef5ZDBdjIchKQdExt8+6R7imS5PMRh0I1lK438l/PD8Nm4KnSJNfZ7Fzkt6zJziM
 eqOVM8ez9jcVtiNQ5NH4fEtAzij0ty3+lpjVSLpxl88RDVXJOp+d20xpLYA3E63lWjXuLd1
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Do not build the virtiofsd helper when configured with
--disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 40e4f7677bde..d1af126ea194 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,7 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyyy)
 HELPERS-y += virtiofsd$(EXESUF)
 vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
 endif
-- 
2.26.2



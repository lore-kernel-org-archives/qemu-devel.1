Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CDAC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54D420797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D420797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSELd-0001OQ-Qx
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBs-0005k5-09; Tue, 13 Oct 2020 02:53:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBq-0000I1-9k; Tue, 13 Oct 2020 02:53:43 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtOT0-1kCKd52MQw-00umtZ; Tue, 13 Oct 2020 08:53:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] meson.build: drop duplicate 'sparc64' entry
Date: Tue, 13 Oct 2020 08:53:13 +0200
Message-Id: <20201013065313.7349-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:y0Yp+Gd0K+6zJdPdrgiMojG/5KFVmFzm0M6k3ATbBCx3uBj419y
 BKJYEysUfe4et9AK9oqQp3aUZwtrciLFuKO46220htCsDFOkSFq8MIocc64RFs7rRP4v4sk
 hk0TdpD5pQlktJvxplIupKCYUvOzZBJ9k2RDGx8DRQIi9yyibnWsxCI+ERiNkh1wgdg+PMZ
 kHaxtFHzHWvrBUoStlJhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3kiei9YpVKo=:WkfQEgXt8LIHssHiN58ipV
 er3LiXpdoDO64Qc+9HbndSB5sKksVh9Nt5oUM1yHa9TcjQ+Kmsqa5gon7kxIlCXbyAplHkTwC
 kX8XEFuWpE08s10WrXuFWeWkmmGeb8piSg4r/L1izDaMZxjUXlYfs+NbWt57UPiDWFti7C6ry
 DwSNoDmEM33O4HBzlArgj1IfJSI0MQoUO9xEd5QPFcFJ080roBhClWwB3+Vf7CNMhkU+Y8vCn
 EI5CiQTfSed5VX/gVbWNhC59CShHzr0aQbZzKu32WNUUZAVbpxT4wN0pawnlyoc250ksimfAs
 i9eNg0kWN6YrenmdDSPlur9qN5opctLyjlNk089QXZTRDE2neZpS2uuMm4zFEq+08//VrJcWf
 OYBhkGM4hs0blCfEngd0M3iLrjph10/6ieJeOoLB0Iqt+OaVR/+6MQfO7BGEb8P0eyZNDD2+M
 oVAxUTzTRg4t7pWR1d9LgDyvauq2lKEvo6DHzhFc+i7H2YTxigzAFVOOmYwkP0TD54PNrMOO6
 TSUrjuQHIjTIpv4wEDThoEnkOlZ5LxEbMhbD4P2ZiugNh0P0u2ML875DB/SibIezpEacnwBCZ
 q0LhPY3hdRDDtQNj1pD+Ibbl03zFrFglnynHgsaIlcSnYAbXjMijEW3wV3cQZV3ZACVLaJE68
 YBsVzoVcPMai2j3Svz8xzSKoQ/PiaKnfUYRpUSwH7lxq3iLN1Tkwpnms193nIdawYxrKC515c
 dxge88kmtNc6Jjat1SFEkQrgwQYH966epVLqxO1FdjfFX/TGrrvTgAZWlqQkq9OdmMpWFq+M3
 iXx6QToflUMe45cXKq2r9/1VxOzy6atmIsPVyfyVHYfTnPY6Qq1yqQmGf3hiTad6ORfsGO7
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Sergei Trofimovich <slyfox@gentoo.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

CC: Laurent Vivier <laurent@vivier.eu>
CC: qemu-trivial@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Message-Id: <20201012175719.2573367-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 17c89c87c626..392d326f4563 100644
--- a/meson.build
+++ b/meson.build
@@ -41,7 +41,7 @@ have_block = have_system or have_tools
 python = import('python').find_installation()
 
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
   'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
 
 cpu = host_machine.cpu_family()
-- 
2.26.2



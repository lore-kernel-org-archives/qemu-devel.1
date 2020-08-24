Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A184C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311F42078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311F42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEM9-00062Q-FU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKx-0004UY-Kk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:43 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAEKv-0003e8-6B
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:24:43 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWitM-1k7yDj2z2O-00X2gF; Mon, 24 Aug 2020 17:24:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] meson: avoid compiling qemu-keymap by default
Date: Mon, 24 Aug 2020 17:24:30 +0200
Message-Id: <20200824152430.1844159-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824152430.1844159-1-laurent@vivier.eu>
References: <20200824152430.1844159-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w0PNymbRYVT/DGV+LFxT2+L1XvNtUGU7gd1rfc07X8J9DTZ4rmf
 KFcYmcQkUfQYj3CnqBRqePuK5M793Z818M/blggJ9vTZ7c03q3aGlugoADooZswl9MBx1wo
 VuifzAyd6CPGl6LcqQuAHAmtSzXBnu5EtUTM089hIBs1ghT5RAkOGCzmlLgKXff41lEeXwz
 aFEySU3aQK182wqToUjYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oz3VMNszdZg=:zM7gCogZyZ/wtsSOOnEQtm
 oFDHB2G2M0azhaEjac8IB0XLJL/Yr2kpS0Q7bTnjlLPZTrAHfU3JbWmtkD1A6cZDvSTWKTLGE
 MdRQpoqtzbgPfg80vgtGcQ6LyCdUFNouD89fzdaBI9Cdwi/oYnIVN81wAos+QGSym/gQrXxfT
 3Ar5g+XO75tz3JxJZXQIhXuG8SrlfCE656whA76I3diAbVWoSYc3r5E7JXz/SASb54FyV9Rhl
 UIQY1EHWmrMMeHAejmjuOOsEpOb7qhd5STNJzPwH+eyNF5Qholw8Acm6jEWahfg8xe9hfjIZh
 RwJm/6Jcgyxv6mXb+jOx+BCoL+F4nL6x1Uf6I627JioS4RfQi++et5LsqfYwfhL+LY9zDtIKz
 ZE9cj1AlEl7BKfGoBKZ/tqYTcQ+uBU5qx47MtMSUbk45FZynaLzGNDRxK2c7DV6nl3abStdNT
 BjSryMT5bU8tcOHbD0rhl0xL5XZ6N3rz4usxtON00FG8sL6gIZ+YmxNcmhtraprBJKMnr+kk+
 HxahicIz4PGy2z2qqunSIMxqBOXdzZrvL66avUgeeiDLU2C60Nz5x+Rb4bexcsyTL9XkpGas2
 3sW8Zeku21n7Yzbn+qQpDit6qwgZE0aSH2tjqoelUud5bcqCTmr7P1mnwGyA84LBrMlr0Imbp
 wttHdNjhpdFO1CBj0WiWj750VEDovFKE1bIDKXTmF5RORm8VtUBuijdQJh0giCO1Ff2Hjv7i6
 0vVyVyq9jfw4KtJea4yWDbqB00Cc+0Elr+lDscoOZfmyNKtV7fOwlq5fLc1okxjU+HlQ39o1s
 UEdIbGfQJiV/JtCakdie0qxV5H/HFtB6/91v1nsWaKcGBRqa1w71BlEtfwEJqnSRulrplfn
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:24:39
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-keymap is not needed with linux-user, so disable it by default if
tools and system are disabled (tools are disabled by default with linux-user).

Avoid this error with statically linked binaries:

    Linking target qemu-keymap
    /usr/bin/ld: cannot find -lxkbcommon

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index f6e346af1a69..f0fe5f8799e0 100644
--- a/meson.build
+++ b/meson.build
@@ -1063,6 +1063,11 @@ if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
 
+# Don't build qemu-keymap if xkbcommon is not explicitly enabled
+# when we don't build tools or system
+if get_option('xkbcommon').auto() and not have_system and not have_tools
+  xkbcommon = not_found
+endif
 if xkbcommon.found()
   # used for the update-keymaps target, so include rules even if !have_tools
   qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
-- 
2.26.2



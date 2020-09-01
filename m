Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE83C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD836206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD836206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Ee-0006IC-RM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zY-000666-Id; Tue, 01 Sep 2020 10:10:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zW-0003zt-NN; Tue, 01 Sep 2020 10:10:32 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6bsM-1ke9Gf1l1C-0183pD; Tue, 01 Sep 2020 16:10:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 44/44] docs/system: Fix grammar in documentation
Date: Tue,  1 Sep 2020 16:09:54 +0200
Message-Id: <20200901140954.889743-45-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7L1YI38AnTxw8KGs1szZB3nJpEddnBvc3/Yy/tk98nSmivRkKzW
 NRoBAe7hIrdpBwO+0keWhvVKogCZ+DZgks69Z3HwLyfRsnb24YFwgXtjmnaugxw55T+ehI5
 n/g/zyXHbXBMxZdsq02QMeL48tqzottUReKPFoWzikYJP+d/VRoVaXdh8i/D5VVomxykPCM
 eZfKSgOrJCChuoicfHcpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzroLXl3Brg=:lKGWd3nt6vvRvdwA8n39sO
 NKrZbk0uwYSGDwWnlXnQQkMatoDj0eY7Ulvrfk/3RkqkxaG/qCW8oL9RSl7KuGvJ368FKaBv1
 qbW56xSi5dn/z1BZOkHyGpU5KgD9yaR7NH3tnuK1uh1TpnYDIlVCUvcEt0epUWp9cWzTRnp7C
 MVmg5GpgZF/WTXXiXxV3Hv5kBpTmRRiKPWoudE7vvkXmTf7gjH5QRoh//hLlaxyvySVd6Ynim
 RhaW2NtUPoQ60FKbvMlQiCIRUMmYomsgZT4KTvrNXfHM2+6QlC3RFky9ICwoWNWvcVH9xMaT3
 oNVl6D2R+q8jw9SYSrAfxC6k9TAT5SruQfXmSJ5uwfbqs3YxbHTIQlt0w5kCb+BTKt5CLph4C
 nonabsvy8PLJN8xHnlF+wJ7COr4t3Mk/lcXn8RG3hvyCrRtpP/LQmzYFVw7h3XGWy+x5LkmsR
 X2wlsSDMRLpe0FAa/SgsFZp5yC6UGDnGknlykeItkmehHtJW+CoWwYl3AFXjJ4W5O3EUdXxZm
 po0qD8aCkbMM+VRXxLSuAqtM1UzPouIxxWO96RMxghIUwTXLJYeAleuE+fQvFPfSa5r7PT9J5
 rlundj79jXJFLxDEcZwClO4B4qvxLMy9OkJ/olZql9BFiuvmyOjDiZEkSD7J6n3YU8apQnPm3
 fXUc1vojz5OTA6IO9tssfNeFTo7ZAYVAgYh7bJq9jQ34CQ6KmoD3/53uuyohqsM376LBIymab
 Ze2iOl6Azp7mJ7/oxI3iKCUQf9WXOsiw8CwFwq8iH0d5sHFAzUT7o4zq+fUMUijmow1RSBeZh
 s6paYKCkLi6asfuGxvAO4+4qElJekS/DphaUECOji9PPmj+unI93cITnb/zn/eWT/l1oqi6
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200827173051.31050-1-sw@weilnetz.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/system/build-platforms.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
index c2b92a96987c..9734eba2f180 100644
--- a/docs/system/build-platforms.rst
+++ b/docs/system/build-platforms.rst
@@ -57,12 +57,12 @@ macOS
 -----
 
 The project supports building with the two most recent versions of
-macOS, with the current homebrew package set available.
+macOS, with the current Homebrew package set available.
 
 FreeBSD
 -------
 
-The project aims to support the all the versions which are not end of
+The project aims to support all versions which are not end of
 life.
 
 NetBSD
@@ -75,5 +75,5 @@ new major version is released.
 OpenBSD
 -------
 
-The project aims to support the all the versions which are not end of
+The project aims to support all versions which are not end of
 life.
-- 
2.26.2



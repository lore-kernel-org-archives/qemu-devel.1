Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7C4221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7C4221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpLc-00017W-BO
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGe-0003r2-Ni; Mon, 28 Sep 2020 05:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGZ-0002XI-Pj; Mon, 28 Sep 2020 05:16:20 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHVWT-1k9Kjw3AXZ-00Dahp; Mon, 28 Sep 2020 11:16:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] Add *.pyc back to the .gitignore file
Date: Mon, 28 Sep 2020 11:15:58 +0200
Message-Id: <20200928091602.383870-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZJYK1rFyvYfcc1RY9shQRugdD/I2fgxXiA5GSPXHDWik7DtpDjJ
 o4naIrgY093fD8n/YDr8+FdVkdYd0sLGeFzzXvGKhtj8C1Tf6Jhwl6W1zxVTI6H6oAYCXF7
 YwSrdhBC8Ge3dMaL7US6KJhbtFyimqf0VC7KConAmbVzvdt9csL34qrEeIJyiUHDmgOzFoO
 M4zjSD7MUsQqAcN4OH30g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sHi8vO6LAyw=:b5I++VPdeCqL1djMULZwhH
 zeNdBpBsGL4XtKnjqnvvR3c1huKZ2Ljlkoj13TIf/MIGziBKfRdI1dYSKGNWSa07NmXeP2sSx
 YeyBZl/4JBOBHCkIt5r4ocSrflqmrIdbqeJ3vtwmlpWqacTs/9zJysEmVCE9gMBFYQfyd42v9
 mY0h0M1yJt9cor8EyMDqYyXpd+nPQ3eHTBI3fR0Q98opCFSCaIlwZQFh51swmqvhye3ugob9Y
 AoxqriFaJML8wJ/Hn4ul3paDF7kf9n1P//ZGH0ySYG5NSuuswTGsiZZnPyu7fnv3Z8lyVTUlk
 HVTa4KAH2BoisufgWchRJlMoceh2jS7g+OXZhwrQ64ysGjBtAPeqJp+EkdLweTZRuJ4bEF4/C
 KrTPL2VKUDR18QFd/aTAe55ybKaaQ4mewsssFVWNsHqdbWJeVG/7IEd/N70sS7aosLTm8a6ER
 vrs3Sdx2+/2W57JwKyHT8z4taBgJDfYsX+3mpmUvM0ojryXAR6AQlFcqbU1yWe1DYb5WrRvam
 yNJAPidMibtU3Td4OAgNIqf2LhM9iZ1SvWHy9vGW/WUNaU3yMRG4XsGkUZEtWmr6So8bR2Wir
 P6ydG2Oliw0yg3d4oKvHF08xKEPpfSXbIhheuFqABIP60uIJhgu02LTJNz5ykNW59zIM/1wGx
 m0ZQeFJf5Xy/0/2ojJctHm5YOBi8n6yU5tohWEKUdtXG6HmC7nJTO6Fq0xsRzzT58U/gUocoJ
 Erszr3nJ7/9BpGOaMRVJ9XmIssTE8kiwbaYC3rv2MA7wcpMqn/kck8Fg0YlNQ6sk2dAYQOuyV
 YsaWaChNhaWjXA0/lkfRDeMK04q9icFMQXk0rmDR3KnE/0QDF5hX7hlBvRsinJ2wpdZCuYu
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Python still dumps its bytecode into the source directory, so
we should continue to ignore the *.pyc files.

Fixes: 0e72b7df4d ("Simplify the .gitignore file")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200919101859.28739-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5515f595e67c..b32bca1315e1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,6 @@
 /GNUmakefile
 /build/
+*.pyc
 .sdk
 .stgit-*
 .git-submodule-status
-- 
2.26.2



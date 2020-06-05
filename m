Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000002063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000002063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAvk-0005Vg-9F
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAol-0008Jw-37
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006jF-1U
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTikV-1jXb6W2aez-00U52w; Fri, 05 Jun 2020 13:47:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] configure: Avoid building TCG when not needed
Date: Fri,  5 Jun 2020 13:46:49 +0200
Message-Id: <20200605114700.1052050-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hjUC/xLjH0YaY+x4xTptgEWCI6ojMy6nXlGlI1vlOqTTpkEoa5R
 0gduAp5J6Bz5Rv4u5rLf6j/R2VUKi+1XBu6ivWOZxAZt577MBdeOnJ0Vy8NPxyuda652cuL
 qfv/WwG3+kxvEQkzXS8bpNwLkcfd993HXvUUFmtsvVTIMJBFO/VTinWNJzF9l78GnqFTd9O
 ASWoUr/cFWdIT9RFpE9xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DsEViz2dYBs=:kqsQQVRlVN+bLVvRqfp+cJ
 Ql783gKSipkHTfS1IcIn5Z+MVxLfCu+lr/VHxWnGf5SwAp93/f1xjrIlW0rKamMelHnxpX6HF
 BNVoZOpp6YDCGX18qSJwNp/lJnFgG32uEFVvV6vID5QaoVbZPl+NWVJPw4g23Ysusia07O7Xk
 SNCLxLOz5z0KAVlGDGI9NJcihWj/UZdZE1902+uLyRIL07ExPTO7lqd04lR+b+t0tF3x59niC
 rVwirIfueVZykHQaFCsDD2lpPqze3SV5ltmiTeVArIKaRk5ccPLsh2hdhnneN+7LOl8iHGPHr
 WNTxqZXBscSJeWQjFT5SxK6EclCq4nk0b14Ux+JVUT9Qe++rnUgZakFI+fiHeEd9/rTkhBCix
 NU9xuLtHut30k9uug23CuJz47qAxUHq/XLDFvkDmYOS4Gcz7xdY4SzxQSfgHmz3cghmCkl8vb
 5UCz2VXrE/Uy1jiMt9gOYp+LupJZs7YROJhSu0ge4sHy182homHXUrHqkGBdynk9Zuy54zbNI
 zQeuhWPazcTVccGEVJ6ykrbDmo/sM8lS2wuUQ6byuX1NHMxeysAEouAEMPWiPwYkBScFv3gv6
 3gCBVpPXtkncJ8M6uWvs0p4eDDlmhJXCtgBJqhEBtn0uSORpQ8lezCNGMXqAb7vsVj6r6cb9Y
 TaFCupf9ttUj3v2JnIue1cyIop6K6ei2e1aLja0qm3JCeJn83GN9CE9WdFSGIz5ZixhXdd6N9
 N75PexIqAQzX09N0qBQI7nKhj9YhZXpG0mr2lmKvTYarClF4aA9lb/521NOC5tv+GsQpLmq41
 mxCQt7fxetYjLwGlpserS8ux4pYGBSefvgEWw9lF6SOOsJaaWaLbBHtHlGt4YomejHC24vc
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:04
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
 Alistair Francis <alistair.francis@wdc.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index b969dee675bb..fccc56bd4d1f 100755
--- a/configure
+++ b/configure
@@ -1663,6 +1663,10 @@ if [ "$ARCH" = "unknown" ]; then
   linux_user="no"
 fi
 
+if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
+  tcg="no"
+fi
+
 default_target_list=""
 
 mak_wilds=""
-- 
2.26.2



Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB85ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C669121928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669121928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wZI-0006Fh-NX
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRf-00061q-76
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRe-0004Mp-1u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRd-0004MK-QF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mo77T-1iSRH21szb-00pfb6; Wed, 11 Sep 2019 08:49:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:09 +0200
Message-Id: <20190911064920.1718-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tZI6n73vaB5Qv0qy5MoNsYEtjZ5ZaZbRe8BNUoALuIYHSgURjaB
 3I8034V3qK3vmu2YNHZRf9tNx/70H2DOEquDRe5C4ecb/PCTNxmGamqHOUD1I6O+WjQlBBS
 jBHqmWT0p7Drg8ZdSKxx23fQpQcMzHiKZh9nD/78MWayDxb3lDgjTHEDXFYGp/njvVi5+lo
 j/sH0FciNz0RlCizQMslg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hToNasJc+CI=:l8Huln66Xq1zBK/XPsnOan
 0jzkaJHK3hRFQrILRcE4QNRir5CgxXu8xUnyh2ObbPnif/ji5Lh+qevST95SVDWi28Uh3mld1
 qo4R87gfu0r5lSntBQDo7qE8uctHwYhHd41uKyDAC3QtfJtmh/4s4EuO+s1KyU7hp+qfEt+H0
 pfsqfWz8NUizGFRh3XHc5rgV8hl2ExjDKmTEUF66FImx8/APNLHOV+xi65aRO/2DHdfUvuLCn
 +f2680fH6DCPiCxJ44C0/ZOPHWBk/6qEkQZ6QAs7ndiLPh5nMgsBl0XnwFDQdZWO2cpm11IZv
 L3GjNK04zhcyjlup0Mk2OKvZqNMdjz56LbOt8OllyuY2U8FRYE1UTbACt7myankS9Bm1SbPr7
 Hz5M2zBJ7qkpi5YVhjna99KMiaADtjtIrbdIRH0znYBsemMDLhLO3DKHjItrFOrPLv7b4gr/w
 3h38rOIbjCtbTI5amz/Kk7H0F0INHW5INijfEl8+AmJVHKrUQLgItoWF7dla7estOSxXBbm4G
 6xEdh0xNRNKowPb84zszOOpmEYoEe21ruBAjpBhGvXlW0ClkEHm98w8M83n9LtVId+2BXqVA4
 63OudArRd3Ba77ZgZ9a3tAsuJCpBL5ixxmm9SSc/Wk/h0n7MH1r4HLl+J00ABYPBTb2PEjZJE
 yaSpQNjVuXRtG3kxMw4XLEwWi3uYbAc6pldi/pFfJALAoOb9zhX8+2alf+yipQT+KKZkNqih1
 tbARWKU8Ur/B9/QgM9es9Y9l7CdrwGd64ylIpuithH3YgQwnfT8Mn/o6v5NlyKnar29pvEnW/
 +jXbWEptu/vI3kPQPlha+BRK3a09ctROSB7RLuvniVQQxHsBHM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 04/15] linux-user: fail and report on bad
 dfilter specs
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Just passing NULL means we end up ignoring the bad dfilter spec
instead of reporting it and exiting as we should.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190830143648.2967-1-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 28f0065b6ddf..c257b063dbc1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -235,7 +235,7 @@ static void handle_arg_log(const char *arg)
 
 static void handle_arg_dfilter(const char *arg)
 {
-    qemu_set_dfilter_ranges(arg, NULL);
+    qemu_set_dfilter_ranges(arg, &error_fatal);
 }
 
 static void handle_arg_log_filename(const char *arg)
-- 
2.21.0



Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC4D205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC4D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiI7T-0001Gn-Sd
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiI2H-0003yV-FD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiI2E-0000dz-RD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hiI2C-0000XI-CC; Tue, 02 Jul 2019 08:37:20 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N95mR-1idsBW2Q2Z-016AqN; Tue, 02 Jul 2019 14:37:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 14:37:11 +0200
Message-Id: <20190702123713.14396-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702123713.14396-1-laurent@vivier.eu>
References: <20190702123713.14396-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MpVnjE9ILMkipRn4MKez3x505bdBBbNHNpT4QgWdLUuT25Bmqcz
 8o0hcFfpRpjTJVFA/q8MlwlzJ03BZopcx4tsLhBhOFfds31VF3rrF9h/ktu/hczqiYV9JfB
 wFC9D7rxMB67waIEDZ18YqrSxp4a6GLfqcOXDzxKDv2dRXGEuBuSE4ebOaxxC2UN/tAC/07
 nU5OcByicxxvBmlRTvmaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t2dAFxFol/E=:H8zjlW6jT2n6hR5wCwK1Bv
 VVoZ9XSpXwBL5uXHAsd/BTMVddGv3yRH+NoxeRW1vIRBmPp/ZN3rO8CnH6h/1bvGxBTj19flf
 cgVHaIk/bVrS1LhNuEr5UmBSHTELzBbAfZfd+eHpNzm9RtLJ4WxuoN1NrBwEyRbUoHgLy9i29
 jTAjmCNRcjoXO/Y82d3Ui2GZ16vh4l0zxx5rNPHdM8bafjMlilRqUukg88VrqgUoW7WqbzQ+O
 UvzB0WaTNxBrSZtxXYgRPEB8szMjKSAkmaFpD3yPx89K3ukAeKQ71A1HEApmEAkE/X+OhVjla
 QCyBp5ntDoyXhucCE8CsA6XvfibE3/n88PqyBMkyx7qvnXxAYko9iIUPBkepKppDSrrtco/DX
 CpCP3qnexDW4rul+IIQOKDf4UBC+kajeXXU9W60yeTzmbhqe2zRhlUaT3s1bqAUDmkAHfhPF2
 1DT2vlLLyJpUy3RC5qT7Ixn3E+VunqFbp7PydsIIj6zl9SaapREKPm4eFlDVEiw0Z1RW7aoF/
 ChLVbBAeSg5o54qWjItactAhFYRAN7WstovCcnXu359vvWA/pIh+Oe59ZoZK1DYPLo1AZGlLq
 MMG821E4EEYmWbg5rnG+ukddTI8xF+W0ap7sV0gCYGyDB8hHjGPxxotq0cS9/v7DsYP/KbmD+
 5UhlpByXFI0Lw5Ux/z0bvwfyLy/ujOBqghw3WZkKiwcZnjuly7YuFwFA5+pAwfyJJfxXuulX4
 ktF18A/Rowo1n9p6wpqtgP2u7h24HjFznwW6vQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 1/3] Fix cacheline detection on FreeBSD/powerpc.
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
 Laurent Vivier <laurent@vivier.eu>, Justin Hibbits <chmeeedalf@gmail.com>,
 Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Justin Hibbits <chmeeedalf@gmail.com>

machdep.cacheline_size is an integer, not a long.  Since PowerPC is
big-endian this causes sysctlbyname() to fill in the upper bits of the
argument, rather than the correct 'lower bits' of the word.  Specify the
correct type to fix this.

Fixes: b255b2c8a548 ("util: add cacheinfo")
Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190607135653.6ece685d@titan.knownspace>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index eebe1ce9c5d2..516f837748a3 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -77,7 +77,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void sys_cache_info(int *isize, int *dsize)
 {
     /* There's only a single sysctl for both I/D cache line sizes.  */
-    long size;
+    int size;
     size_t len = sizeof(size);
     if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
         *isize = *dsize = size;
-- 
2.21.0



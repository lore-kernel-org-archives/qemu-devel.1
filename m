Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C3C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEAF217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEAF217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP37W-0002s2-TE
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:51:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32J-0007JC-SJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32I-0003aj-Rd
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32I-0003Zu-J6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1N8n8I-1gcBHK00zm-015uyb; Fri, 10 May 2019 12:45:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:33 +0200
Message-Id: <20190510104536.17483-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ubgID+gWm+qkyi2y6W3QMdWgDsJHIWHa875H6PHh3ZB3ovZMDgv
	1D5YI+bD51iQBXityIq1lKQcgSeofIveFvxrV78wP/X2ip7EH0mBzsQI3lL1wXRFKtKedBK
	qEAnHkpFd/nPD1nkaRWHCqLRhTtvScg9jLRrlv24Fg5FZakWJ2UtY4GNZVCcMaJQLNJKdKw
	a3U94kxDx2YiiLfuFKHcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DehIOTSA6LQ=:S7Qy7G7lw1RXQuauAq0g1x
	PvJbzlZPXQdwlmmekuIK9WJEgQg0vKqaOVrgrffc4FC3LJZh72i8j+4whbhEfJP1Y2mo6iIel
	QKdlCNKZRXpluR6lyDONKi0hCAIoETXRpYA56gNW+bxcgCblQ/xLap/uwkoRdvo7NL53+241j
	DptLHagdk43ZKItbqxRxpIOO9SimlX+CVCqQmte/Mca9ErkHBUWOXFiGVMi++39HsuoSkYjM8
	6jCJUPV3aawtmh2ZGeE2+mtTRDSq/7wutIvzdTilZyeRC+t6oMGIDdaykAvjQpjC7WZZ29zdH
	Xbbp4SlBR52qDApfqGbQuTRUUaQ/M9VsKmpH7YP4rQwxjIiFLmI70rKvr4Hj8DlYKY8sPPsJd
	wNY2SLRZ/b04YfRv34o+CQocNlC2L8QRs9xS/xTDHfRow2b9O9ZjSmHXh9bHsgYfquTD3K1P7
	GCMAFFlWSHgS2CYMQDqtSwrHqLoTr5LbDg3Tj/NW3I9E0st9r7Dp/9wpn0Jlyv70tVXoV2CZX
	GV33kJVHf4+FbuGLGGuy30ewJDlZ8lmdq/uQu5G2LX7MIpsu1HaZ3+Dq+2PY5MPFFIa9eAFpg
	TXnYTehU0Gp878uCrSKXLKsiFVvU8xruYoXj1vLgVSxSb5+rr36RmNPNF+axhEyPb+ecVxSa1
	oUXy2jf/LxlLEDw6ZQCmkhsfY+X1boW/vmfli49UZ4X7nQxKWwyg7hFF/PJ5oLmkoGcMPwtOb
	FmrCrnRqjDaD5rEzaK4orC99XoLtVE1CrErEbA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL v2 4/7] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Erik Kline <ek@google.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Erik Kline <ek@google.com>

Signed-off-by: Erik Kline <ek@google.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190423222005.246981-1-ek@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ae8951625ffe..37501f575cdd 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,7 +178,7 @@
 #endif /* CONFIG_USBFS */
 
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
-  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
-- 
2.20.1



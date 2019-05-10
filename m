Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E24217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E24217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOznR-00077x-1N
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:18:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlQ-0005l2-I1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlP-0001iU-KV
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlP-0001hs-Bk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:15 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MekvT-1goYTp3cGb-00aj9S; Fri, 10 May 2019 09:16:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:51 +0200
Message-Id: <20190510071557.30126-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hErQGaTBbND5t7nJ/LWEJl/IglfzKsDSI624jFpB1FY/W+RCTan
	IBnBPvj4e77HNKYlOc+KT70s2rgqEJxT0X+sU0N5aZnT/RoKuzNoau3J9K7JxAEzPCmOk2O
	5T9kUDPRklS8hjscapJUyujltG3Z8CGaxbr9fuT8Er+q/5FRs6ESBead6H5N/R7cYk0Ua9+
	5jv6fmgDI4Y0CHzPaYmaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tC5HB4Broy0=:/ykASt97M8pVIoX3m12re9
	uKgv4XCcLxZXevzzG27NgAC4K/tgzwX7tvGWKVmABjPgCV7245fWwui6lUG7/rcURzm/gPhlY
	AIdc++H+t0r54HbYDw181WvaIn2FDsm92F5QDAPVaK4IN5c9kP58hnBQmUBLEUqAqnj1Uwzvj
	86xYFkJMMCUdL8KCc/J65pzcqShOdRIOQ9MKK8meh1uXOE0L4gAk6ZlJaWQ6xX6x+Hdlmfzst
	lEePawuMmLUbAINAzNUrnjK0UuQDj0p2B1dXSXf2jk2Bga/JpaEcJsnsRCL/T+kYZ0TP9oQP8
	le+IfZkQFcvjQF/VUjQ3cmn6nl8oJvNVwyqi+cwXXZm643MvGwY0fl1qMaXdzuwfbDa87hGQ9
	B+1yptwluxh64id3vBh5XFIR7pcihVMlUGk9pquuYQOkPIDlZH9e7QnU62x1Ly7hbFcNKodl2
	o3J6Be1fvsSaAnD6d+qjwLMBEMQecS+ROZlBnw1+tqyVKPXA06VbKy0c39rlCtY46cCT0+4pt
	y8v02oFG8ljRrt/qmqD98nQLoJMBl4EWns73aJGLKGDayJ3KZLsARln5x/2khJjWbhlkX/Yjo
	aQvNhiIESioJX1+Zx88oeDRRj4ZY+dZ+5N3kW2j3y2K4RxYGkLWG1eE9kfL3d1wwsEdB2/8z+
	ud6i0KiduzpfotLndQ6XDDw3HZ20v1kTkjyKYX70NP0jm6EpeGPG1DFXxii/xLvGCDT5lXX1q
	3kr4IrI5LvV1FriztedSZ2xSgL69aULF7nKFgw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 1/7] linux-user: Add missing IPV6 sockopts
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

When running ssh over IPv6 with linux-user I faced this warning:
 Unsupported setsockopt level=41 optname=67
 setsockopt IPV6_TCLASS 32: Protocol not available:

This patch adds code to the linux-user emulatation for setting and
retrieving of a few missing IPV6 options, including IPV6_TCLASS.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf86dd3..44b593b81161 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1864,6 +1864,28 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
         case IPV6_CHECKSUM:
+        case IPV6_ADDRFORM:
+        case IPV6_2292PKTINFO:
+        case IPV6_RECVTCLASS:
+        case IPV6_RECVRTHDR:
+        case IPV6_2292RTHDR:
+        case IPV6_RECVHOPOPTS:
+        case IPV6_2292HOPOPTS:
+        case IPV6_RECVDSTOPTS:
+        case IPV6_2292DSTOPTS:
+        case IPV6_TCLASS:
+#ifdef IPV6_RECVPATHMTU
+        case IPV6_RECVPATHMTU:
+#endif
+#ifdef IPV6_TRANSPARENT
+        case IPV6_TRANSPARENT:
+#endif
+#ifdef IPV6_FREEBIND
+        case IPV6_FREEBIND:
+#endif
+#ifdef IPV6_RECVORIGDSTADDR
+        case IPV6_RECVORIGDSTADDR:
+#endif
             val = 0;
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
@@ -2358,6 +2380,28 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
         case IPV6_CHECKSUM:
+        case IPV6_ADDRFORM:
+        case IPV6_2292PKTINFO:
+        case IPV6_RECVTCLASS:
+        case IPV6_RECVRTHDR:
+        case IPV6_2292RTHDR:
+        case IPV6_RECVHOPOPTS:
+        case IPV6_2292HOPOPTS:
+        case IPV6_RECVDSTOPTS:
+        case IPV6_2292DSTOPTS:
+        case IPV6_TCLASS:
+#ifdef IPV6_RECVPATHMTU
+        case IPV6_RECVPATHMTU:
+#endif
+#ifdef IPV6_TRANSPARENT
+        case IPV6_TRANSPARENT:
+#endif
+#ifdef IPV6_FREEBIND
+        case IPV6_FREEBIND:
+#endif
+#ifdef IPV6_RECVORIGDSTADDR
+        case IPV6_RECVORIGDSTADDR:
+#endif
             if (get_user_u32(len, optlen))
                 return -TARGET_EFAULT;
             if (len < 0)
-- 
2.20.1



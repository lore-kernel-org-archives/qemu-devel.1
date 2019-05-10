Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCAAC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9AA217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9AA217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP347-0000KO-2E
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:47:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32B-00077o-63
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32A-0003UN-75
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP329-0003TT-V0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:46 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mkn8B-1h0CTq3NMN-00mIgu; Fri, 10 May 2019 12:45:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:30 +0200
Message-Id: <20190510104536.17483-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1cemR1IMCoutiFI0WkuqLwest01H/jxjryGQJ8RRL8GxmqvQtnK
	kE58QL5EQJqPqb5sc3WsmPgZROT/P8euEFvsAtYZnkRbfVxoPe4/oRytQdE5auFDlLe5TtF
	sN4HNOvH4kDLyne38fj9dIiwMhi2fiMtH6gBVArHTdujuLmn8WoJ2d+Wa1a6QnhnGiAU5aK
	+rUlnELk7pMR+nGcI70dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kr8g74zSNac=:tTU5MkHXAAhPgICqCNTzzW
	AV0Q8FfHaVsnxL9ry33kc0IdRQlDe1VgS5kj1HmfvnMPl7cOsDG2ZIcNS5BGoV2hTeLiFca+y
	/wfLFMKv0q3hW+/BHUl7DK+DdpALe3TH5ziOesGDU537pAEdNLuX9XhZsdPiDaSXT4rs1ybVw
	OWNa6Yb3JRT03D9U5Gt1rZmCLpm2A4IoOpiwPLYtzkQpX4sOASL42R+a3sRmvSQ00w7GhON6v
	AmNGzYqeQNFvS75lLzDXJYXXFiir5wMSMhrz9n64RHODUBnhMMBKUjG0n4Pob6zipoEOEC9uO
	chL0hHbque3Cip+pJWMlRWipswtbKmv+gFWl4KM15X3YZsDF2gtLkGR57FC7KJqi5ScNP8KaA
	P800wJdiIgMf3QsfEzmjkd407tqATaNKYA10ADm93fR8U6bW3WOCi/kW9mMs59hQwpApCvMHE
	Wr7xGhk9RITp/xHLi3CsFpnPuy0o8YcHkYnWsx8/d68ogR4Y6R+LFr3lQlgbS9ZAZvQToSwbu
	NHFEvtEXHeUrxWWjGyNhsGlEtDPG/M8ROLvCPPZlxT/SoZYQdnDyj2bW5JJE6q+BQ+XANDYnw
	CdKlrW5PR8TnjUdQOa6eBNkS0G0sqeGtoUSB8Y+/8bTrxrUvyz0hURE+Ss0RR6BUNScZh3tmX
	EDc7lEqPz9+aK+3zG0TGYyimTC//hw1N/rJ7/aXxIX48P03pQUL7KMasZn67/gmyM5BFNcNtA
	x3adDLxxCXoWuYo4H4o76U2KVbV7wQkwbjHHHg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 1/7] linux-user: Add missing IPV6 sockopts
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



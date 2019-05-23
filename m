Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A97C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B1420863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B1420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38157 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp4n-0002KG-FF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:52:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowu-0004CX-3L
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTows-0006Be-Tv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTows-00069c-Kz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:02 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mzydy-1gfh6S11Bm-00x4Cg; Thu, 23 May 2019 16:43:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:33 +0200
Message-Id: <20190523144336.13960-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wqhZU6gk88fwROrf82j7nD5p1cGnks1SE+P6uFI2h9boVBYa1xx
	j9dCF/nuRHLxPrQ6ONJFor1Dz92nwXFH7sKA7QSWl+3xBN5eWC1WsPuS79PaV2qqP46woZo
	2TNddznXiC0wUznWi1fNKR7KKGlnz6aOlgwH8cOKkkEUN1EJtsRCDUW1XrfssjU8N1T7foL
	QHeZeC24NLwd0P5NB7Pzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+8fK3F9eAM=:UNZiI+IwYo77XXgZv6V4fp
	tGpGZe0jTg0AgVyug8vmoX5XMzcUMBEToFDfjrOqmGOub7Ui4ktNmtbggjdbpIkzTcb0Hc2n8
	PC5PXuecoi5q+HR1jUKSYymmIxcvFa3D30nKPpjjrdX/wB+7hx+m7LPA/lMSwQtFwehFGPKmc
	rUdKTncqztVHifTTQN3Lm1vtCuaAR2/jtxJZon0zc3FV/ZGADRi6A2rKP4O0BXUM08SmRV2BB
	szEV6NA0+2/KmAHSCenVj5tItlPE+Sx9n7koapoBnBoy2dgLRYrAJoH63cjZ9tm8qFtFwarRQ
	V85eDITLImlqgZTGbRLl7xs7ivypI/dBRCST5tMmMut6lPFdoWWOeJTLy9EYsmpCQ6vf6jdmN
	kLCJWk4ACiDk/XrSlAjOUl5hSGVmsW1I/VCeblYhu5wY7ZwLawqzKGAJNr6aKP26MI7cw2udx
	orDBmC44oGGg604vT4jkq8aH+YFcHfDQfYOy3qTa34LhpcdvhOyyYHMJxtWz2Xl5b4RqCdWh8
	UXgOY4WVQ754O64jraI/GUqrDzLkkcjRwroUMv/Py3ROfK6w5SAxcCE1A+C26/q7ltbrMxbQ3
	s1eigAeXszK0GNHpNVlM5NoUm592OwSkj7lmDxld3CFVADuYrW292T43y5kTHubp6o+80Zx0g
	B8pFuwkHEwiJHZT5iJOh2LU8vYYQnKUM4n6NGvAlCqy860YeKuTZ5s4ichzG/mGAEUbcrETMH
	dakVKqKney1fGkYBtYTiRZ83Zz3dEHZp/hGQaw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL 07/10] linux-user: Add support for setsockopt()
 options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Neng Chen <nchen@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Neng Chen <nchen@wavecomp.com>

Add support for options IPV6_ADD_MEMBERSHIP and IPV6_DROP_MEMPEMBERSHIP
of the syscall setsockopt(). These options control membership in
multicast groups. Their argument is a pointer to a struct ipv6_mreq,
which is in turn defined in IP v6 header netinet/in.h as:

 struct ipv6_mreq {
     /* IPv6 multicast address of group */
     struct  in6_addr  ipv6mr_multiaddr;
     /* local IPv6 address of interface */
     int     ipv6mr_interface;
 };

...whereas its definition in kernel's include/uapi/linux/in6.h is:

 #if __UAPI_DEF_IPV6_MREQ
 struct ipv6_mreq {
     /* IPv6 multicast address of group */
         struct  in6_addr ipv6mr_multiaddr;
     /* local IPv6 address of interface */
     int     ipv6mr_ifindex;
 };
 #endif

The first field of ipv6_mreq has the same name ("ipv6mr_multiaddr")
and type ("in6_addr") in both cases. Moreover, the in6_addr structure
consists of fields that are always big-endian (on host of any endian),
therefore the ipv6_mreq's field ipv6mr_multiaddr doesn't need any
endian conversion.

The second field of ipv6_mreq may, however, depending on the build
environment, have different names. This is the reason why the line
"#if __UAPI_DEF_IPV6_MREQ" is used in this patch - to establish the
right choice for the field name. Also, endian conversion is needed
for this field, since it is of type "int".

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1558282527-22183-5-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e5545cbafac7..a0c2bf7db43c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1911,6 +1911,29 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                                        &pki, sizeof(pki)));
             break;
         }
+        case IPV6_ADD_MEMBERSHIP:
+        case IPV6_DROP_MEMBERSHIP:
+        {
+            struct ipv6_mreq ipv6mreq;
+
+            if (optlen < sizeof(ipv6mreq)) {
+                return -TARGET_EINVAL;
+            }
+
+            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
+                return -TARGET_EFAULT;
+            }
+
+#if __UAPI_DEF_IPV6_MREQ
+            ipv6mreq.ipv6mr_ifindex = tswap32(ipv6mreq.ipv6mr_ifindex);
+#else
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
+#endif /* __UAPI_DEF_IVP6_MREQ */
+
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       &ipv6mreq, sizeof(ipv6mreq)));
+            break;
+        }
         default:
             goto unimplemented;
         }
-- 
2.20.1



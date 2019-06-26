Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890DC48BD8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D5020663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D5020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6vf-0005NU-0F
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mZ-0005fK-Fb
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mX-0000yq-Dc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mV-0000q9-Dx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnJdC-1iPJUv02VQ-00jHfM; Wed, 26 Jun 2019 14:11:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:37 +0200
Message-Id: <20190626121139.19114-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7TAxZSKcncYtCqBr1MuuDh5e7eyk5WkHUwdqneS78+dWpefslQ9
 q5m8nq1dmd3hIj2Ho5c1h66NKOGqCeMqBOOvRid/pq9kWSN5CwfQ8GsAxBc3/pvD7KTjSWg
 rucahPSSUiOeeMJdTVuzvR2GhDrha+i5bVmKA4Z0xY6VwetH5OEGqqntOWTWkCCKunN/Oel
 OK7SQQcLn7xpxV4gdasjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GlpujgIpShw=:DNtxMrgebXyaauCP4V996w
 QK+Ngex/96afYAx5wqp+CbqqwhD7u6BTAmvmegeTM/V5qAOMT7/J6RlyxpMBWw5fqBeJ2lAdN
 9dUVSwbl65ktUmSfYHBH0eue8Cf+cSEdsY6W4cyfpbjJaHHFN3AYTIkj+bnChSbmEOwzOFPcM
 25nw0B7Xgdp/MOlHYx+AyYFNiKtW8aeb9qBsEM8cp74teFtm5IlU+jvqN7LBgdWOHYFs2nzZ0
 4vKnbFgqmcNkxg0GI6Gy83cXmEyd/LL1DdbZsh0gUymC6HusD8ccIAbMJm+n9JCUi+hLA2NgG
 cPBiR9Z1BmN/Eslp/FjyIYQh2VZ5IFmoZYLAyxpngXX0yKHHgA8IrRoAAH8Twn1VjExmfJ+H+
 YRg1opPITMraqY/7eolkRLGRVyu6vMJy/PzbyGfodfusWE3Y293NKV7G4Xssv6w8CBIt/D65u
 iiovLt1B0807okIhdZ4YbR5u2MHjnbAqlioba2fqa9gm5pW+OtgxHg99uA6yn92yTt0PpiYwU
 Hb68vTj9/ogBMadY7/HU/+K/jjEGQIQXSU1wPCVxd0Q5QvY062+0YmoYjSQZBjdzys0U6tga8
 X5Y/n/pFDCn3PlmBO1pEfJUyZbCnaHyCZMGDXyPp+uxJtm7uGBB7aebpXDbER+qO9vm8qS3U8
 aBz3rcpRzMByzhgeJ4mwIPmHWMw4UKGxRSso+Sy7BVngf9NCcdmTfGlkUF7EHyIdMj5jHcmQp
 UMDEVSFIZ6VjqkEGRpM/zoeAXw4A70VYJyf2wQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 4/6] linux-user: Add support for setsockopt()
 options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Neng Chen <nchen@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Neng Chen <nchen@wavecomp.com>

Add support for the option IPV6_<ADD|DROP>_MEMBERSHIP of the syscall
setsockopt(). This option controls membership in multicast groups.
Argument is a pointer to a struct ipv6_mreq.

The glibc <netinet/in.h> header defines the ipv6_mreq structure,
which includes the following members:

  struct in6_addr  ipv6mr_multiaddr;
  unsigned int     ipv6mr_interface;

Whereas the kernel in its <linux/in6.h> header defines following
members of the same structure:

  struct in6_addr  ipv6mr_multiaddr;
  int              ipv6mr_ifindex;

POSIX defines ipv6mr_interface [1].

__UAPI_DEF_IVP6_MREQ appears in kernel headers with v3.12:

  cfd280c91253 net: sync some IP headers with glibc

Without __UAPI_DEF_IVP6_MREQ, kernel defines ipv6mr_ifindex, and
this is explained in cfd280c91253:

  "If you include the kernel headers first you get those,
  and if you include the glibc headers first you get those,
  and the following patch arranges a coordination and
  synchronization between the two."

So before 3.12, a program can't include both <netinet/in.h> and
<linux/in6.h>.

In linux-user/syscall.c, we only include <netinet/in.h> (glibc) and
not <linux/in6.h> (kernel headers), so ipv6mr_interface is the one
to use.

[1] http://pubs.opengroup.org/onlinepubs/009695399/basedefs/netinet/in.h.html

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1560953834-29584-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ed1c9b0033be..d2c9817938c9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1892,6 +1892,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
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
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
+
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       &ipv6mreq, sizeof(ipv6mreq)));
+            break;
+        }
         default:
             goto unimplemented;
         }
-- 
2.21.0



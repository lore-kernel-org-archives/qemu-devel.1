Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9A5204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9A5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFS2-000374-Hn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR7-0001Ur-I7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:09 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR5-00024N-RM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:09 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYN7M-1kQXgZ05MA-00VPAD; Tue, 14 Jul 2020 09:33:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] linux-user: Use EPROTONOSUPPORT for unimplemented netlink
 protocols
Date: Tue, 14 Jul 2020 09:32:53 +0200
Message-Id: <20200714073259.1464675-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W8tc4ceolGsH6LHGPhqIvvP44+GvrN4edGrQjVNEYtQcOZbSOWp
 K84EOwH1QSumPJ45j0WW6YGk9UspzlYMZnqBDbv7E8VFg9P/RKLY9EHi+Cmsp4TBLPCnzJV
 r59It/nbNC+KX7lshkEKUvi90pWOfNF8dmRJaNZMGWj9XxeFk4E/C5tBZKYMveKEGeHh7TJ
 Ioj7ODMtjvPoPYNhL6uBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQpbJyN0Hhw=:H0gjQsm0qJ3RqZ/iqAz/iT
 Wu2eldudg6+crqCiNqXRukManuCYkEk7bFdkAtp60wv0pwzKvCHuPSvPnKJ2K9B0RlRj0FLnG
 bjRjNWhtWf5spNP93qp7Yu/QshGrHQbSSwBXJd5DGqn8l4rFGCD7liS0YFozwFYqpCFL6SKEa
 3y01/VNFFE935z3/6pTXDshhydBMM5MoCeWSdp529Kk6lgUFdr8EfivOGH8vG1GKabgHiqCZB
 YqKzaTFlPSCpv2IKaUp5oWZDTy8OADliYjlNG4i/sj0flPBvZiPamW3sP051BwbaLnPi4NEwy
 oANSW2t7XidpVb6SOsTTo713ajAI/VsIVswVgEmcMCyltIb+1D45Q+wQAUtCkp9AiO4ooQHf/
 6xT1+BojLiEhnENChvHw/owk/TthCnU1ezxTtbQUiDtHcr/fp3D7cKuoptytjZ8X2qsd9aMqt
 eyRgQ3Jn6QVqH/fIHJjjjJyQUpMDjcjD0zrtPDGXnSHtZk6D2p01RX5OuhmgLHOgbsNhQdg4u
 W0APXVOJxr9XDHfxfh+5V8MrjhW89S1K7++RHclMJiSH7v//b/xEkGcYyS+qvYyypvwUuldxH
 cBIwgapiOAvrIRVcVV808j1uTDjFrQ5utxsGqR6kURyn/5yNlVPrzT2PExIWiStLR4EEJyWYY
 qKot4RsIWsStskhJ8IQ/mFEHnY+21NfYp+bmKV/tvelW0pVT5JBtTpui5y+BbofgSu9K5Quwu
 oHojcqOCq8dCKqLL3cV3JR8GTy0nK0XDs8a12crdwcC0zFUWdJ0FJG4p3JYIZFVk9EPHJmu7D
 5f2lZtmE28R39BdzDrxJwgevvIukuuvP7BrVeeyQagaQfM49fjsS72JCLO3fR/9dVf+7BOA
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Josh Kunz <jkz@google.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh Kunz <jkz@google.com>

Linux uses the EPROTONOSUPPORT error code[1] if the users requests a
netlink socket with an unsupported netlink protocol. This change
switches linux-user to use the same code as Linux, instead of
EPFNOSUPPORT (which AFAIK is just an anachronistic version of
EAFNOSUPPORT).

Tested by compiling all linux-user targets on x86.

[1]:
https://github.com/torvalds/linux/blob/bfe91da29bfad9941d5d703d45e29f0812a20724/net/netlink/af_netlink.c#L683

Signed-off-by: Josh Kunz <jkz@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200707001036.1671982-1-jkz@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 98ea86ca81fb..e9f53340cd65 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2990,7 +2990,7 @@ static abi_long do_socket(int domain, int type, int protocol)
 #endif
          protocol == NETLINK_KOBJECT_UEVENT ||
          protocol == NETLINK_AUDIT)) {
-        return -TARGET_EPFNOSUPPORT;
+        return -TARGET_EPROTONOSUPPORT;
     }
 
     if (domain == AF_PACKET ||
-- 
2.26.2



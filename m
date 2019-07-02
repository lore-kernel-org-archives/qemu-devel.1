Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E45C06514
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB123206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB123206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKcp-0004dD-33
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMY-0005Ku-T6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMW-0007zj-OW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMU-0007vk-Ny
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McYP5-1iGIj93lev-00curO; Tue, 02 Jul 2019 17:06:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:45 +0200
Message-Id: <20190702150545.1872-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SVXugMnuhSklwwTuZulGZNB0tLMT7GqBN8M8EkeLw7mqoRRR2ci
 z/YuVZ3NSKA+gYcNRNS+FWNLHe7l9x2ERBhDJUw0DyJbtA4AAYq2e/sHyuo5vs9WWcgoKga
 Q/5OuRoB8MyH6QzR4TjisPeoec1zfTc8kzwG1KQckgKWvp8sVd6xEywOVg0zWstfvkQTMer
 4e3G4fVxjmL5Pw7pXSzcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9H01oSAYfS4=:nY4Z39eL8SBo8v5CCVU26T
 ZvocLj2dTogc28gQbRwOOJd/KjHucbS/Zw9gShtdTbhiBd/EkoxV9JfYlK2hLhS63Ogre4Lpm
 fQxG7Z9qo2ZJIbgCepYUnKIwNUoxX9eo1wMMPbWOTEassu5uKbOCIFk5sn4Iby+IUkaYgazA8
 ulOIboK6IxZS3OwQhQtmmATLV5neYEogLBmLOYiA/NYGUaK+XV9s080MukcmEhr8ZY4O4+VQW
 D72RlG1ARBMW9Y7fiPxGTKjbMxb+i85mwFEPV1LYpncUhM+t7kyF1kuMOGZJhv0HbmhkfwxKm
 /zDv54h4skesBU82+auCOQM5xSPHsOKfzkDYkxDaxQOJSCk68Yv7w4a/AHqumRrHRcf8BhmgI
 uJOke+We6/iBrgDI4Ca6eREL+R9cV7NCNU0l3Q//gU+63Adsn+2BHR1jtI9txaJPziRulisC6
 hD0xHdterPd04TK+Hj3jc2WCZJOmYpDzEtWY7KgXg9cj+bvJxhhGlvC4Ebu5euO7VSPH4BtbF
 +G6PepxLpGnC9pwAqk8sdj0P2Zcor23VuZ/K1BJLLvljA8obK+t7KwKvmBXeIVzp1vYTQFoAC
 3sMYMjBc2nUYSEDC0Nad6fg2h/QRA+rA24d7VI6+b8P8JFAR5mCim8npbzy9DDzCAuMmEfcd9
 DxXHH5aWr0efvpURw1E4Gs6lm2QDGJSQ6vQ4CSexsseORH/EFz+iqHuoKCabK6VFfCPsuTiG0
 UA87li9Inw1i6GrwrqaRV/6RyJEMV3IlrZ5x5w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 6/6] linux-user: move QEMU_IFLA_BR_MULTI_BOOLOPT
 to the good function
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU_IFLA_BR_MULTI_BOOLOPT has been added to the wrong function
host_to_target_slave_data_bridge_nlattr(). Move it to
host_to_target_data_bridge_nlattr().

This fixes following error:
  Unknown QEMU_IFLA_BR type 46

Fixes: 61b463fbf6cb ("linux-user: add new netlink types")
Message-Id: <20190626150855.27446-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 612819c1b1ec..60077ce5319d 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -483,6 +483,12 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BR_ROOT_ID:
     case QEMU_IFLA_BR_BRIDGE_ID:
         break;
+    /* br_boolopt_multi { uint32_t, uint32_t } */
+    case QEMU_IFLA_BR_MULTI_BOOLOPT:
+        u32 = NLA_DATA(nlattr);
+        u32[0] = tswap32(u32[0]); /* optval */
+        u32[1] = tswap32(u32[1]); /* optmask */
+        break;
     default:
         gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
         break;
@@ -546,12 +552,6 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_ROOT_ID:
     case QEMU_IFLA_BRPORT_BRIDGE_ID:
         break;
-    /* br_boolopt_multi { uint32_t, uint32_t } */
-    case QEMU_IFLA_BR_MULTI_BOOLOPT:
-        u32 = NLA_DATA(nlattr);
-        u32[0] = tswap32(u32[0]); /* optval */
-        u32[1] = tswap32(u32[1]); /* optmask */
-        break;
     default:
         gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
         break;
-- 
2.21.0



Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E659BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED55206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED55206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAk5-0003S5-02
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj9-0002Bc-5o
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:35 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj8-0005ez-At
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:34 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7xml-1iugbN0S27-0154t8; Fri, 05 Jun 2020 13:41:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] linux-user, alpha: fix oldumount syscall
Date: Fri,  5 Jun 2020 13:41:02 +0200
Message-Id: <20200605114120.1051236-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114120.1051236-1-laurent@vivier.eu>
References: <20200605114120.1051236-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vrjynv6bZQdNwwKZKnRDWL7rwm3uAImACqQyOeb7ZC//Rx175T2
 9l2lCVIxjQh4LFN8LHf/FMHLNv+eCF+Xhd4onLukjyofdIXwR65evIqaGjvMa9Br3LiBN0A
 iE00IuBqITT/XFgcOFQ93w94hpA66XWKjtTCN60Of8xW3Q6pSCwUkFCTB54SoOg8sDnDykZ
 3OfOIxn+9IaQhY2WCiOfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gGNxyUGKKRk=:hHoLrBcpJH8XM564QgqFeW
 fGygZ5sslnZ4dxRcCHNlWt1+O6oazvySR9SmjSYgah4PI2R3uW7r8bijxwyAIRcB4fq2NNTeL
 whe0+DAx++F+LS6BGhMEy50mNMIF0vQUm84UiZD9J/XJ2MnTZwx+g3NRnGAAXe8R0XreoDzC3
 y8AsI7kSkEBqJyabhiGU9M/MJMPNSBJ+6tasTEWHg+6vAGddhpfneRVOZ0eyZVLwK9QjSVYuQ
 stt/+f1ejJ8Jpgpm/Gi/ESqnMcZhj3qi5or8ZAmzVku9yg1A/NM12IxFYECOvdf5gdoR+bdVZ
 l//e0eik7Ot1yhSYn8tBnyh1osFWSmIM3+P8QXe4cw4vwvW/zJuxO9k3WgOHp3SVCsTkEBXfi
 R/7OQrCKHi9I1S/2FSTyNA1x2QRYzdMvN0gzMBigrundDhN+9k8s6eVVpunRc5cF30CptYnPK
 /KzjAVMWc+EKEhUxIihQuXVGmh/ZQ5fckiIbJpLu/ysPg3aRjQY4cavm7NtRwqWr+CGZuYFmK
 yKRrvvXFFBP6l+w3pt4bTM0505bYWewIIp5sDZxWzowM0Xx+DBaI/cMMDwlWuzm4mT/O922ft
 l5aRAWo9jeYZ7bmeYx0QprFTemgMkKYgjm+JXQR2OS7kp79Xam0h0lsicH15wZgTUQ3XMo5r9
 aEAfAGkgke4CDNGEmzDdmksX6lHwCbXXET7EWmgo4ylINQj/EgkV0XvoanQ9fXsBM+EAhKkH8
 54mtoGHeEo2HsokbJ4x7fB0aHg3MoR/C4+OEWlrR7Vi/nZQXRNoLLVPRboPqwf1Vl8GAKxRy8
 qHP02O6yv0vC5eWKhLoujccWXLOQnKSFPw2Og+093dIaNmjwQLTAHRsyzHllukWvESXd9s0
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:41:33
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we try to bootstrap debian/lenny for alpha, it fails because
it cannot umount /.root directory:

  ...
  Setting up initscripts (2.86.ds1-61) ...
  umount: /.root: Function not implemented
  dpkg: error processing initscripts (--configure):
   subprocess post-installation script returned error exit status 1
  dpkg: sysvinit: dependency problems, but configuring anyway as you request:
   sysvinit depends on initscripts; however:
    Package initscripts is not configured yet.

This is because, when we switched from syscall_nr.h to syscall.tbl,
the syscall #321 has been renamed from umount to oldumount and
syscall.c has not been updated to manage the new name.

oldumount has been introduced in linux 2.1.116pre1 by:
  7d32756b2 ("Import 2.1.116pre1")
...
 * We now support a flag for forced unmount like the other 'big iron'
 * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
...

Fixes: 6116aea994 ("linux-user, alpha: add syscall table generation support")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200502194642.32823-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff07..e89b815ce983 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8028,8 +8028,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#ifdef TARGET_NR_umount
+#if defined(TARGET_NR_umount) || defined(TARGET_NR_oldumount)
+#if defined(TARGET_NR_umount)
     case TARGET_NR_umount:
+#endif
+#if defined(TARGET_NR_oldumount)
+    case TARGET_NR_oldumount:
+#endif
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
         ret = get_errno(umount(p));
-- 
2.26.2



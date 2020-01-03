Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35586C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015D9215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 14:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xf5M2ZDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015D9215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inO1Z-00074O-0l
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1inO0m-0006Nw-5c
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1inO0g-00039E-MB
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:33:07 -0500
Received: from m12-14.163.com ([220.181.12.14]:34367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liq3ea@163.com>) id 1inO0d-0002NC-H1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 09:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=931iMVdhvW5AM00GpJ
 u9bjVBAZdK+z16Ma78ajKWm80=; b=Xf5M2ZDsviloyfz65z+eMLmnSd56sjEAVP
 7o14yAB94Bmkrq20/IMI3tSgisNUkrYuuj6zLDC4kFd8aLJT1mmKvj/nGObKJYVp
 tiIDT9mAmoQaiaX6wuRvbZ2oHpS5VlAOMUT0c1EgRu/FNeyvSpEEYbgl8Ze3ZO69
 6wMM7o+TA=
Received: from localhost.localdomain (unknown [183.159.67.212])
 by smtp10 (Coremail) with SMTP id DsCowACHjZ2QUA9el6XiKA--.1900S2;
 Fri, 03 Jan 2020 22:32:49 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
Subject: [PATCH] target/i386: kvm: print info when the kernel doesn't support
 ioctl(KVM_CAP_GET_MSR_FEATURES)
Date: Fri,  3 Jan 2020 06:32:24 -0800
Message-Id: <20200103143224.49187-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowACHjZ2QUA9el6XiKA--.1900S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW8Cw15AryrGw1UWF17Wrg_yoW3ZrcEkF
 n7Gan2q3yUXFn29w42kw1rGr10yry8C3Z8Aanxtw4jyry8A3W3Xan7Aw4Iv34jvFWfZFn8
 C39xWrZxKryUAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbAwIJUUUUU==
X-Originating-IP: [183.159.67.212]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxGfbVUMMz-I1gAAsH
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.14
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
Cc: Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ioctl(KVM_CAP_GET_MSR_FEATURES) is quite new. In old platform that
doesn't support this ioctl will sometimes make the user confusion. For
example, when we do nested virtualiztion using host-passthrough model
the VM will has quite different cpu feature with the host.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 target/i386/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b511906e3..9688f7a167 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1916,6 +1916,8 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
     }
 
     if (!kvm_check_extension(s, KVM_CAP_GET_MSR_FEATURES)) {
+        info_report("ioctl(KVM_CAP_GET_MSR_FEATURES) is "
+                    "not supported by this kernel.");
         return 0;
     }
 
-- 
2.17.1




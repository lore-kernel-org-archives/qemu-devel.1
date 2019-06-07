Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF379C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF0120868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H09Eisob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF0120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMxs-0007F1-W2
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrs-00041p-9U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrr-0001dO-0R
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrp-0001SY-7S; Fri, 07 Jun 2019 17:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944666; x=1591480666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Afx3i4e+/e/6vVqAletdTzpjrs6vkjl1vDNfsdulAjY=;
 b=H09Eisobr0XzWBbh4VFAbH+iv2W1hyEvGJ5C6YxS59+9azuKrFYw4k58
 0woCFiRUfUFTvUE4yKKsTKB97jU3WOWwsy+hYjJYuv4tc2JYNScHk7Mq7
 iOqQ+JKcSdMYjUzHP6cE86U5H92kp3uRlWxcvh3bR5ZmaWZmjvFc1zkNE
 rvnQgM8OoL0aELQSETJ8rPBl0SgAyd3lrp3WtlCzxWInAmQLNyzsxu/59
 xQPmH1l+bs5BTURx+UGlY1AQRKACF+M+ZSsfFBWAvwBAMqNipQRJeMUZI
 5KYYUivnllFN/1+w9lEneqy2WV2T2HtGmQR+Iw8Up29xuANHCR8luOYsE A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014070"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:32 +0800
IronPort-SDR: ra6BvnqBX8778UlfAEYMntUYXA8XQ0vovUhQ5FgcsKCusc2TtYIvWBW8PZsPsZDm7VIxq+gK9Q
 HnbHWuUM6uFmvLlTMj9/S5mfaIv/SI96/2gb6md82Wxkj3UQ4CPvoWFDMdOdu+psT9Yt9qKwGf
 q8ZpvzSrq0Tudw9Rq9ss2LjtRcZq3PlIEDQmwurZFFce8/7tBSGxWXLWufokwIo3KOgxhdJtAv
 ZUGbS8RGVC9K0BtZsJK4SILzBhFIaGbub7KUGn/X5f6nFr1ioYYRzk8O9gJ3+ZwlQjvKKqo/fv
 GaqEG9+cvWzYy/NgE1CImxUl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:48 -0700
IronPort-SDR: nHsmjIEvIAJtTr++/hVhSrC7rbnrtlZeYMaZGur5QFqGFcfUZQwRCu4OXluHGHq8od4R/DVBL4
 vXoVT4SsoASJL/SRHcUBuMZNGTL/GXcrTCxJ+pwUczCuhp49rutrC9uaY+3+lIH+BNGSFhHGJ3
 32Ix6ZN1tLmlYv1rMbG001kQgfVjA+Tlbk6NS6ZnQ6mrDb9g9qF+lPB9hpEMdpYDCz4KXWuyqi
 Z96ltWvxuFnJemm2tdzgYmju/5rX69SHvLe67cvCXXARHSwjA0dCfW3Ef5Q/akO+AkMkQaCcx8
 OyU=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:21 -0700
Message-Id: <3148d5b7898b0ecae6140118d44ed7fcd5132775.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 01/27] target/riscv: Don't set write
 permissions on dirty PTEs
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be becuase it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b1bee3d45d..872835177a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -326,10 +326,8 @@ restart:
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-            /* add write permission on stores or if the page is already dirty,
-               so that we TLB miss on later writes to update the dirty bit */
-            if ((pte & PTE_W) &&
-                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
+            /* add write permission on stores */
+            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
                 *prot |= PAGE_WRITE;
             }
             return TRANSLATE_SUCCESS;
-- 
2.21.0



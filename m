Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1986FC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32C92063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YsZ4b5Hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32C92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhKi-0007PA-1q
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHf-0002Pq-7d
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHe-0006PK-C6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhHe-0006JU-3f; Fri, 31 Jan 2020 20:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519353; x=1612055353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hn+JFBDwfVKfjJc2+twO+WHy0Ld/QHjXy1vWrwX9v2I=;
 b=YsZ4b5HstOL7WpanTHc97mgA78GfgmG8eS2RVCsgVK1KY8YtMMoXHhfZ
 fPOJctnZXXxWjnNx7qqGyiywaoqzCmx2v8l9jP8KIfCy+TjdVdS8Ly3Ul
 mfxv8sSOb18SXcXXo7BlZjb1V05ROElW906oULkEQXeFNwFu+WjUUdars
 vSqE8x2nx8ENXl8Yjtr9t+7QEm1CNo59vNTb28AWse4xcE4OB3cLAV0Vv
 f8ZjDm7qY/S2ebNhc4Px7nYukToASdGmvja7l9IDpD/xQOpELdUzeklb9
 0ZepW/ISQREeAStlhLHci2SmQl4OI8DQdLfNNxAgIjP7trNY1A5H/U+4t A==;
IronPort-SDR: OaV4/ro6aLKakJoveL+W01eK86KmjfXfc6/rNlNgO5UK9i6VNJtk6yFT0vokrPj9YPAT7UlvDf
 rynpIl3iee5RMBORjVghT27TPHG0CWkZg8KDfZkEogiOjt3tizJVXRt87BlEPIyrWgIdixHAZY
 sSOer58rx8WSiZO56EIRHDRaiFS3w0o0INqzjXGFzcICMurJvxsGrgkvC7OOKcxrUYeYiBUb5N
 KowPZOY9dSRy3iKazD0vqJ90WHy7RdgYn0FiK6Dl47fA5Whrxnn3cLCX7CNLoxL8ZVXg/PgWVi
 ZCs=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872460"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:51 +0800
IronPort-SDR: kDQEfBUhasTutCvItueheC4Uh0CzqaE2knH9F4EHh/LvYxqlisHYkfBdGrsSQyKat9CBTn3Xml
 aSN9Ag/2qQ3CtTj5p0403JfS8zgvkHNbjdH+Sx7vWsNAOqnPqf8Lv2iOFLcb5lb8Yl1Ckl+s6/
 rduqhqc5bzbsUHzN0X+iTN4hsyVB5oshZnDRRMcHpJVYb47G8uy+hSPvJIbdUoDbwuD+3PyQ9u
 fNCe0oETEzjXJKSY431UiHNoB0XrPUkUCw8aRo0ugsfDMy8vJZKdzuVvXgtH4vCPZ3D9HPQ4Rx
 R7HJ28ZKLNV6CjTS6SJ+a2Vc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:00 -0800
IronPort-SDR: NkQA4UeR3UDM2jFdQwClKgHoU+uJyNAsmuBMxUYK0o8bJFiiPUJQF1i4RvsjGGp1qZ/apDriJo
 Ah0BfvWnYtQ3iHEIF0uXjplcqs5EzSu3LmfObJRU/KoVr2XYC+4nby6UN7OckrEHrDlPG/kqHH
 KrP0lE6GsXQ/pkrSM0IKzYrrmbMY5lKnN1byfXG2mdVw8qRJZMW2ty3+/m6dMV2zxwKah3pD5P
 8+yiIknNzLvaJwha+IWlqRq4hFVdJ6KnzMuowCgy2cV02ELKaqkwnyMs0UOj3M0zbuhP+BC1zq
 F8I=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:52 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 15/35] target/riscv: Set VS bits in mideleg for Hyp
 extension
Date: Fri, 31 Jan 2020 17:02:15 -0800
Message-Id: <7c15db86126bf5c4343de79dae5c95a2c964cd24.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f7333286bd..c0e942684d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -448,6 +448,9 @@ static int read_mideleg(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
 {
     env->mideleg = (env->mideleg & ~delegable_ints) | (val & delegable_ints);
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg |= VS_MODE_INTERRUPTS;
+    }
     return 0;
 }
 
-- 
2.25.0



Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B76206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B76206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD76t-0004o2-Mu
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zM-0005Wo-Od; Tue, 01 Sep 2020 10:10:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0003oG-DA; Tue, 01 Sep 2020 10:10:20 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCKO2-1kLORI2ayQ-009N6N; Tue, 01 Sep 2020 16:09:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/44] target/arm/kvm: Remove superfluous break
Date: Tue,  1 Sep 2020 16:09:12 +0200
Message-Id: <20200901140954.889743-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F0TpCvtnRA9SHKBw7Olb3gWaYAHJBjSIK780eap44uZXKk+wDi3
 TdPVdfQdMD6Sh2IUdNtTAV6990MRO8msMTwK/MZOew6q+PX/L80+lHK4RYzC+AvMQavhD3O
 99wJsMEnA+aoouiW+0ruI01HzUV47leT1QVDxPLdFKsb813MJjPae5lrhpYF1pJLqETamUL
 p2rDrqu2z5wdnp67ShhnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WSNz6tpE9yg=:wFk62DoJrKqasw67S4CXm3
 wZDfYZA4UlBtYP2aLE+gy14F4Yp5CpsgCzkWmR3jFSwsZnjFp5YTvNE5lgHIGNnnLCoaUxOtj
 M9CGa93cvs2SF/biIerdrweIkQa/WNwNM5fVWjfO62gweH7fbAc5vXnHE5+Zl4Bfy13Pk8ZrB
 lhFJrYMLJ6UjmL38RYq8zczDIKYpXNaivsGwFgBTYAF+zBrjiEHE7ZiS8jIB8BPz13kiIXhKg
 1dNrTbmKojeXL4Q92ygPxHw1s0D4P1x2MlOnATWvW73Mv2dSTjc0GWPHTAz/phK23T82SR+En
 v6xbqLirch/RIrIkIoiKZspoI2bWSghrAcZizrhKH4BHr7PxfAsr6Ezui3HbZYGUl1I7myP84
 E5DL+45hTgMf+pLLAg3OzgTcrEyy3P29OmG25b5isn1a/3duyyALb5/vxOqZO97XhWRyR9CVX
 /yZknDlsIvNjUPNXIzVDAWLgyg2/2vNJnX21d8CQW+C4lYIt4HL9TuJCZcCp5ujW4BvE1vJg+
 rwavfATUpyor5ihQ0iLNQ/1dms6Aiqpy7k8ckt2nhfEWysbdBy2RbhmcbL26EVvNZAcddmUXt
 XNGIyrTvLkzutWD0XMjIr56vU/IHYzC/8WE4F/gUij2GoqXuvHDmNZJv8F4m8n8bAJ7qfVX6b
 tPurIw1g2GVSJi/xzy5agJum6oQrV5MIbg0dGrD9++lSDMZ4cLDyK2PlaNMgj30JAciWfwNTP
 6J+Ig0DMt9yiDEwzILrU4uxcnC7OSFrV6vayxhEMs69eU1fHPDLTVXCDnMOpth5SF579tsXPU
 t/rWrDr2A9PH39+uuN2BnYzdc9KErRhC3IbGMBaUc5yMIKYMUe09EhWr4kuc68MSnI2Torp
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous break.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1594630986-36148-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/arm/kvm64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 116923790550..ef1e96028500 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -330,7 +330,6 @@ int kvm_arch_remove_hw_breakpoint(target_ulong addr,
     switch (type) {
     case GDB_BREAKPOINT_HW:
         return delete_hw_breakpoint(addr);
-        break;
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-- 
2.26.2



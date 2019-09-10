Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9EC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C952089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C952089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43385 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jLv-0003Qg-1c
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7v-0004d0-TD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7u-00027R-SS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7u-00026W-Jp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:22 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUGyh-1hgTKD29YJ-00REic; Tue, 10 Sep 2019 18:36:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:48 +0200
Message-Id: <20190910163600.19971-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TqnRmrny+VBJejcU8FarPvdXfnkbn9J5m5FZ5Ps8QM7oDgWSZ1r
 EqqE+cm1aOuZgoN5M1avIfIROAjj32cXAbiNWCnY2xV24IlzrLDk1F4tqKzHOzO+s1tdFsM
 UdN5i2CKJlWGhp49nV967Q8f/otyLIhYete8FWhkE5RrHQqp7eHfyhH4TKouy4ntucqfBZ4
 B50YzjbnVeUHnxtWYtz/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MkD7WgbsN68=:pT8d67nKJEn6QZI/RIPICO
 V7UFxYPUaB7fEAa+wAX++bGkqC7Vt1H4/hofP3MRvjcKf+D/fCzOkKGa3ugDkA4mWYYSrgmVn
 CocA6nqMNhJJpXr4XXxAGsQYV6oR7rUyfjEFj29hYLJN5jhjC+PNoz5MNT8XXUbdXV2TL7OJQ
 ciWE9jltG+IZmgrKl6QxpJzf9EgQH2DfEalWpF2rtHwm5ZIRcWKVNnpZCYnAv6oRIkLMIkqsb
 9VbOvpKM0otkmL900Z0FH+mTM1oXDtSM2Tq2+Woy0DuBG1CfbdOABKTVMWs4XIZfEOuAg4jve
 1weIcaYnvVYLS80gHRxD4PoBnYJ0IAAe1v3LiBu8hf5oalFvY5MAruBytLj8mKT/CvPackLlr
 FoxXoJPJ6nL2SgZAu22ery9RoTz3a2T412WV4M8Owf2IMKVp6t3JSAwXMEQoINY9hUmC7huXq
 gTamPsaSHxt7CBTcMU6LWPLTJ5P2nMTKmoDQmN4CjsiuxCyOtK5Kox/pKh+OD8llY+m+BXrkC
 loy1z/wUGrM9WV21mN5+clZxWF8O9GJ2N2sxUOag7Z4wDxcC6r8olnMBUhUmfOpIeiZ4xcYh7
 8WWimXeFoFUaWjHBysKPCnLIS7QN7MOfYeV6jG9rfaYQolsktJZq/P6fvXG+/eGfej5kGQNaj
 Knax3RM4mQmp6xIlvIElHqFNklBbvMhspB37urpWtEco2w16XyWZnsgHu6VF0Jxo4MILN4itk
 mNG3YTWZp9tmYnHR76NWrazWYh+MUY5epNVHeOZKf1Q5il9r11el2RKTGs1/2JnR8/bWLO0UE
 C2dnpEWFQZ9TqxTz2KZaO4Ps2aDpP6hW11FPi6YifofnHlHfz4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 03/15] linux-user: erroneous fd_trans_unregister
 call
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>

timer_getoverrun returns the "overrun count" for the timer, which is not
a file descriptor and thus should not call fd_trans_unregister on it.

Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190819185348.221825-1-scw@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8b41a03901d4..b42f59a32c8d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11847,7 +11847,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             timer_t htimer = g_posix_timers[timerid];
             ret = get_errno(timer_getoverrun(htimer));
         }
-        fd_trans_unregister(ret);
         return ret;
     }
 #endif
-- 
2.21.0



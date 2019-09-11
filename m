Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83FDECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C64021928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C64021928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wc6-0001D8-S9
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRd-0005zV-Du
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRc-0004Lw-E7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41639)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRc-0004LP-5r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:36 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdtO-1hneOe3lJO-00Neb7; Wed, 11 Sep 2019 08:49:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:08 +0200
Message-Id: <20190911064920.1718-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BhFz3JGYOqV2oRqgFfYhck60WR/r0kySBhTCOvHWSxF7Kis7fKY
 vY2LdwEoDwQuO+ZKuMD/I0S53u1Ka1bi2Nibue/ONBiSPUKE56B7bVwyHppeBJFZQS09tz3
 XlZh3yw+W1K+78UchimIMpWdaqs6o5FKjC3OFLYKS5DgyxIPE0rw2dDhjmK721uCNYP/M86
 b/J0Xh2NVDALJLnxJvDMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XsCRCjD72+c=:1Uao9+BpcdNnoZK+wH3SOk
 t7HRE4ZvMFQqQtYDF/gUH0byvVWGl3QEvDj5AFjZYk854GTC+8BR+5rIUmdWVE1N6Xg7Suw9w
 ChfVnR/kbol6ypoKErMZsKj4en9f9GKb7t3Cknk0XMSHQntB6ey/kG/MzZ/uUo08AwMlt9cPY
 45RQtVG+dxyhyhkMbjEoZPFBX4B5b1k9cYbXZ8Ef3eQZamHHqnCamUr4KybdxpSTEQfkV+6Ad
 TdF13sjcHAP+5r3xereYrThy3RVx393PT+B0PlApyF74FIM2vMpDrhB653yKPS5U0J8axNM7d
 dZc5lfdg3wwWRBuAfarizyCy4D4UYnhON5Zd8gIO0bQUVtB2/5npJQDgMDt/AN6vcxETCOUjF
 GElDgkMnULYKe9c+oZC7njDMugagM7cOnmb4kmwFjRVc2Mw7wwsXSR4zffmaHcs1s0oK7Ss1Z
 PNxUEaUUNbeD5FLjyQfT544qRTLhl5NOdB/6XSjWqhnlT3N6VIixsvaLHGe/9vQu6C7PrEOVI
 ZvgNdGAzl5J6mH/j0PFyIzk+q8dWs+dYVyUpeSi0/LnmFjtOL98VlO26Z5UKvnnODsyQkcqVV
 5VA+su51z+ZcRHHdYDfpjCN0prX4Ci8gds0+edEoNPyw3vnCreADyE5I2IuKtTVNKVJ7/9mX3
 mlGBP7yGe9vqH9k2A2uQ2X8ihZ4qq2ii+2/ovSK5t25lqusYnuwkdif9uji7ebs5aQKt8NKK7
 340CF1Tz9HrdDNUQfrEJvNTpTxs5pYbzhTVhqKfA5z6kwdIMuNQvS4hE6wFpFvFurGC2ifJ5A
 HDvPIZZAKhrRvS6OKZB9BF+Dc55Qec84YgMjFoBWP9P2ay1KL0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL v2 03/15] linux-user: erroneous
 fd_trans_unregister call
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

From: Shu-Chun Weng <scw@google.com>

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



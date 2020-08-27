Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439FB20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439FB20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBByZ-0003pv-FH
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBBxx-0003JS-6e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:04:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBBxv-00032a-Gl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:04:56 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7KG2-1kGfbr3nQa-007mk5; Thu, 27 Aug 2020 09:04:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix target_to_host_timespec64()
Date: Thu, 27 Aug 2020 09:04:49 +0200
Message-Id: <20200827070449.2386007-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G7OPZrBRQRQHcu2wyT9YPc1XscLC/AwcuwWuQiwmf1BNv3Ng/DO
 1ONMMaXsDCiuXW+RCX4DgQ8b4iPQZPkI0vY1Z7H53JYYdA6CsNACn4f8DRse+0cigo+FsRB
 YHBpYLYsnz6PFjEwX1liTUWftNxK59GrmNX9tHBwsI1BBTGk6UVYzuDnx0Ucuxy3wnYFksh
 N2deTP2yuPIm/qdoNfB/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZURAucVs3U=:jqWGFYK/MTnm4STATtTiQN
 Zhkk9JXVj6Ia+tAMTBuSrenIsQXqvJNHPoGX29u7qOEUcNHI3/yu6pJmvd9BgsaXOoDo77G+X
 g4gqagRl/6L3js24jxJO/hyVGWeVDsbNx7xdQB2xR2l5dQDEScwJKlA8FKFhyO2J5bs9gQoBi
 N1TSe8wjqS3q98lcNQJK2JKyV7a6RJQcj1lYITym03c9eUP9oZ5KkwMqmlcP9tmFKDffOwrU2
 a04H4sUZNnpkWDWUosnArLWRyYpe8R5c2eo1bKl+MT3A/QteJVgSPpV/orNcp7vvyc/ZWa1YJ
 t9CmiCkhk0RhzCerk9N7H2gJ/n76SYQSdPQgnOfDtI07zRB6QXJYMd0F3bv/01Hn2oA+4NA0C
 Onyo3dtjPV4h9GppiBTvBolxwPcXXaqzTage9gFz/8VikQ2kbs6F64TFJ0LA2xf6jrSn2JuuM
 oa6r8IbcErqIMjbU6rFor4xXnjC/m4WYne3gwvnT8SZwXnQ3edEmSCcqnS23dG3v76aXgBBqo
 SkUdworVw6c5Ho2e2BmCOcGeWD6wEqZPwaCx4ISmKFrdptAI2wmaRgc6Ic1Nn/IrGvBgLLi7e
 /W3pKGBRB5R11SL3qVl5KUZxNMAu2tUIsIx48c5QKJDeb5dqbHMicTUhPj0J7/1GPC7/chMBH
 fDTISXTH8miiSTgc/7rdent6UNZO+VzYyFbyqpPAJoixMJVz9w1IuK4z5SaS0LYPW6+qGOw5T
 o61S920Bhnt9TrSeinS8c39iJbAn+1LBcgElcAnOoEegtMSD9YK+EKFk94U15MPW15pRxaIZu
 cZ9Y7w7UlSvACQhqI66bRiGn0eqiwWI2pdCKQwNOxANsBMgdPThQCHqSxV4wS0qVOl8nTX0
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 03:04:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in 32 bit mode, drop the padding in tv_nsec. If host is 64bit and target
is 32bit, the padding bytes will be copied from the target and as the
kernel checks the value, the syscall exits with EINVAL.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c82b73e03234..9d7376734ad4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1253,6 +1253,8 @@ static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
     }
     __get_user(host_ts->tv_sec, &target_ts->tv_sec);
     __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    /* in 32bit mode, this drops the padding */
+    host_ts->tv_nsec = (long)(abi_long)host_ts->tv_nsec;
     unlock_user_struct(target_ts, target_addr, 0);
     return 0;
 }
-- 
2.26.2



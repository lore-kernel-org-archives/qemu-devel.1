Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A35C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96D620661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96D620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixrtv-0002Yo-2y
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixrsn-0001IT-RS
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixrsm-0001PL-LB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:17 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:55259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixrsm-0001HM-CP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:16 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MA7Ss-1irm0r22oM-00BaCo; Sat, 01 Feb 2020 13:27:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user: add missing TARGET_SIGRTMIN for hppa
Date: Sat,  1 Feb 2020 13:27:43 +0100
Message-Id: <20200201122746.1478003-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
References: <20200201122746.1478003-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X09yBxGr1Lqs0Ld5lGMVuy2X0kVCIHkH3ZD6fQtrzzwb/Zshez9
 AEjb59AnyYyfM5hPjR1JyxzjDb/bf7nwkoq5KtbGmG3yaJz9fAJMCcrpf2hAnNRQG/a+fah
 fotAVTFCDdKeZo+bovBo3kG6K3B45PKqyJxFN6Qpw78kgK4hjDZWw5kB8NLP18USO1FyyQr
 cBtpicKTb12HeVU19L/GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BE3DhtHtJEU=:Vy9S7757BTJY4ZgGWwcXeF
 d9HHYJxH9PHcfzrRIfmVcIAbwQC6R8NHu9IUKwA9ihXJtfxp0bfvX50b8gmkz5W/BdPKVUslz
 hngw8EhFGqMBnJQZTg+fB9XtfQqNPge4e7y8SdtBBuKV3DL4pHugcIvPANnAeLI4D2ryIKF/g
 dx8cr94+5Io/vYxYKH6WKUGpPESSFgzdFwMv4HthbqQbrSuz3uLH1BURjbniNH4x9mTRClIpy
 J1Gby8Z0Fq4Q58xpYgZ1OMGFr75aPQYOq2stLa6NXR6NeJ/Tggzb8kkKDtTN4dIW9oRRrr/LN
 w0fxAQDcjvsj6Z4dPXkxhJNZEZWLifsoxnwIxkjllWT+DSXQFVaSvhosKog91ulH2cmFAAL/1
 VZFepHlbxei5yNg9smAOCPyp3wOmNnLks2DP5s1uaxwvvfOXWMw2wtuFQTetKWyK7S87JdUbC
 NgE/hU/OGlc9WLFbIYJhVJMV6aEtvbekwCpm0wRU3TiqsX0Y3YhZPkKzhYPlrHAloyf4Bz7hx
 nxnwNj6LRPBTWmKIJzyUKcPKtiGjd2heh2evB157DHfQydPEm3ZmDzr8RCaaqi/cS/Sfbu7vb
 iGtMSJ76r4fZhb11kzFNuuQMhgKQ5ZLpwgMIzhcVNmy0sZiCZoJ/EU+ku5acHlxsdOVm3ypwF
 tJpwHoVkih8I6zEUrIjKOXgSe/kk0Av8h7fRTYXu1hLIOMP994V8/J+pbGf3VtuBTk3ZV/hHg
 Fkpjex5O1JDuxe3zFdOVLauYJJcrsZKv75FgP1H4WTQeDXSYKZ17q1i0rrB2gvA4od6cF7l2g
 +ucOwcw/X0hjJm0P1Wb+p1x3nImO0i7wWvtrp2erkKR9OdfIaXdETvLngy8vofOP2QLKO/n
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This signal is defined for all other targets and we will need it later

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/target_signal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index ba159ff8d006..c2a0102ed73d 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -34,6 +34,7 @@
 #define TARGET_SIGURG          29
 #define TARGET_SIGXFSZ         30
 #define TARGET_SIGSYS          31
+#define TARGET_SIGRTMIN        32
 
 #define TARGET_SIG_BLOCK       0
 #define TARGET_SIG_UNBLOCK     1
-- 
2.24.1



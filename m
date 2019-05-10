Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA97C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8297A217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8297A217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzqG-000127-Pg
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:21:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlS-0005n0-S7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlR-0001k5-N4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlR-0001ii-DY
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MyseC-1gUZiW3QZ8-00vxYf; Fri, 10 May 2019 09:16:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:54 +0200
Message-Id: <20190510071557.30126-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w4DiPT0rlpwkrUgcMs+GMeorSsNQ/oJ9Frm964ubNxmIn1O0f1W
	BXj45bxElxelYiqLUVq3KVTAhVDhO16HRaInuILt8qLeUKl6vJ/mHGFjo24ec+WGDxSTPV/
	NKGtx/oD+5EGkfXoXWbg/nZILfkZaeouMq9DMAiJmsXg3VohTsLScWTANP4zDKSrmNzr1lG
	tY9ly58UuCFbuQhxlNZdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xdnVbWjJwlA=:q0YTd0qRepEjYvFFCgq7HB
	J0gHoXYhJkSqY8heN5mhreg7b26QLP4E67+7WHKg2UoGUc16NAiY73ufTmM1OSCsL5tvjUwWn
	JWAj7/t+mBBHJ+gzOLciw+mkjpa7zFFqFx6jHV81ckAra8LcKhlze6uoA3F+mG1sfNnvtx5F2
	Y2v04zzKLsBkm2rlQ6wfk94LpcBsmnNMAxszQGyWOdz7IDWp+GTfvUckLaDmUBlF3CRNQUWqB
	kavNuC3cfIFxP1hPTemlHwBB3gmo//uv2/e70nw4UJAMLBGloBOk1bulYYDNeeGwoE3JgZB0i
	Nu3c/Mw0QXQ1qUFhXCAIxgoNFtE8rO1tjQmzB43Qn6qS1Dq+Roh3vKDI/ObpTDoHmy0Cocuq8
	wr2coqdDXxkX4hn1kFAx//trUhTc/5eQjMTrQeCEuXcA1Q3/driM5xxN6lbzyRZ1SjWa8xxZz
	/zooYNYqOKCEuoy9DFZTQm0LxjVzgFH3b0u0ug5vGrkXG/oVTfjQ8mQiKhkx8LT5lDzfaFxPG
	T/fgVyG0qEUIbyLfXjbuwMtkhFid99nhgQ+xTvXRslBDYTHLdSU+KI3mnVMlcgntzWl7UkTYL
	cpyE5JOhROs87OTnO1pNsarGYK30rESwEnATM7sImUZRNE0Q8K8Upsf9CizxYuZcRdDXi93Nv
	p5SdK/wsNuZHL48hn4zszbZQxG7aPzFbwZY/e3H/xPQAxLlQFd3OSPYxJBXPgQXN2PEI8fvq9
	hrWwz/yOfmu6rGiUDHar2z0mgwl4UCOqZnY76w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 4/7] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Erik Kline <ek@google.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Erik Kline via Qemu-devel <qemu-devel@nongnu.org>

Signed-off-by: Erik Kline <ek@google.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190423222005.246981-1-ek@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ae8951625ffe..37501f575cdd 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,7 +178,7 @@
 #endif /* CONFIG_USBFS */
 
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
-  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
-- 
2.20.1



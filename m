Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B1C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4529214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Y0YaGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4529214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qWo-0005d6-It
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUK-0002mw-Ai
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUJ-0002S7-6Y
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUI-0002Rt-W9
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id q17so5683789wrx.10
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KlFoUbPbPZiP4pvhxHBf1+0jcfgH410uCz6LOEH3SZs=;
 b=I/Y0YaGMILHA8UZK4Cx19K1VKhwsD8BSDBaqYNyBlbLl5qVWfig5ItERbLSbN4MIoq
 +Pu+m/KgukqIuml1QGrY4cbJ+zvoTnbkMaDR9VXAMmhXuXQ3hbtlDD/OaJBnhAwjPvhO
 QotlZfvGpH0W1D99RU/nKevKTe29VsBmTslDqNW5l6cfl/yx+RW27024doFz7Zk0nC6p
 +m9ezyBy0ojOpTo1y/jQRc2EQsEeC6m7sJxPsIuqIwXHAsoAthU7pkDzZ5Gpwmrn3CG/
 6exSTM3cIe3BfR1YbbYlMywikfEW5KsNa0o295IgEezywHCCuZpvu50pcDSzCdewbIUO
 0wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KlFoUbPbPZiP4pvhxHBf1+0jcfgH410uCz6LOEH3SZs=;
 b=V0cctJugNUY9dXv3dV8GHMt9l3yE+rUu8x7BXIB3fX5otSUOs6lQ3T1W5aUjVbc5Gg
 iOOPfyreKLWVXMqh6LszCNfKSMNXAz6KmqUSaGqABaYZwtgngRZDp91rhYF0QCvo8akB
 djyvL7coNqcApgFVWaV7fMbh1Deh1SZeYxKhLSGSHQlhk73Sce/ilQoEA+AGsvO7Dgz0
 0+J0Wh+8M1xd4Vw/TbyS2nMI/9Ijoh+9FWO6MXU4PNZBbc8HasIq+JXN24I4gPKuILjj
 6NTOqFZqzcpVbRCtHyzx1p5gVUdf0wXzcSNhDjwBXIvAy2mb4mcX7SJBf8M8iTQoEKhb
 KoeA==
X-Gm-Message-State: APjAAAWpnmi8wTCm0yBxqvD56hI3XoExgIqlH2qAMczgVUBggAc0VKGo
 unSJUcFLHjiAAo/gevfs8Rgyk6X8
X-Google-Smtp-Source: APXvYqzJpiaaFMMWtYgRwiyozx79yQbkQBC5a/RaGFDlHJb8+HLiHlinx6rs3NocvZTqvukEmfAjxQ==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr13961871wrr.90.1567923349925; 
 Sat, 07 Sep 2019 23:15:49 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:39 +0200
Message-Id: <20190908061543.25136-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 4/8] linux-user/syscall: Introduce
 target_sockaddr_nl
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
 linux-user/syscall.c      | 6 ++++--
 linux-user/syscall_defs.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8b41a03901..5128312db5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1494,8 +1494,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
         sizeof(target_saddr->sa_family)) {
         target_saddr->sa_family = tswap16(addr->sa_family);
     }
-    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
-        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
+    if (addr->sa_family == AF_NETLINK &&
+        len >= sizeof(struct target_sockaddr_nl)) {
+        struct target_sockaddr_nl *target_nl =
+               (struct target_sockaddr_nl *)target_saddr;
         target_nl->nl_pid = tswap32(target_nl->nl_pid);
         target_nl->nl_groups = tswap32(target_nl->nl_groups);
     } else if (addr->sa_family == AF_PACKET) {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0662270300..fcedd0d0fb 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -153,6 +153,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    uint16_t nl_family;     /* AF_NETLINK */
+    uint16_t __pad;
+    uint32_t nl_pid;
+    uint32_t nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
-- 
2.20.1



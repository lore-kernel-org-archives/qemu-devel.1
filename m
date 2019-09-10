Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E931C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125682082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125682082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jJn-0000nQ-Jl
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j80-0004kd-JS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7y-0002CR-Gm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7y-0002A5-6m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF3U0-1hwkmW32wy-00FUUn; Tue, 10 Sep 2019 18:36:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:56 +0200
Message-Id: <20190910163600.19971-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:41RhpoLHz9r9zbIIkATbA9d5daLDxfC5+TdTSDHQbYs+HxMMKo3
 UzcJn/SstI7UDyQfDAyimjgR9H8fzpYYYhDV2pHkYgwF1YGsEArLwbCkfJoqhv/OG0y6Ikz
 FdNTGYs1B9Nv+ZommiPtzu6KSTvPxH4L9dWGeBQCFYeQFqCMTu2jzvvOmzDDTgmPWnvHGap
 PYpWIZrDtTx4v6ZMYgT2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RrCpcRTQj/s=:S07j2V9cPurv4HCJh4KUb7
 8r9O6p4FjHJBpPmxo3LJtelJ6U3AuHfOsOvG54bAi04pXaif0Y4cW79yfTJmqguSPYxLLj/qz
 b4isb/sgATjqF5MfI5TYAKEXY2L/5Zv0zsauAdY/RW6INGom3ZCvyLI2BJ+7tZCb21pzWkhRs
 UbPpYAv8sLrg09FeRbGqi3MOgQIc3tH5fn6Ycrp8kHsIxKh5fzqD1a5IcHLunKEAxvVAMADEQ
 6TkWX7ZvjjakgIYL3KtItirMa2EP2FC4JqZUOeKCxDVzYv9G2Xn1N+w0Vyww8vmE3W6bJyi3u
 46CpRKZhr1AxjywJoXOlz13o5/0UNEjo+1RIhLZ3qWXvqHUzhA2tnKvx+OXQnO0hiEYpRsTHg
 oxA8m3gG0GyKRMfsNgWkQxOwmRIIQT61a+Pegqt3w25wLLsIVOhDxsjxFz60nXpW4Kb1ZjO/X
 KQY1c0K3MXDxevfVyn8E41bUouXA1ZBL808YKTppf8G7neMrvHPQGiqZHddP61e9V+VVYkxuw
 Mld5FMX5pzHkcIaefl0uWThQXt9TFwUbrskVh+HPiYOxwZSW5BSExVwnR4XHYEghVtm6l9O7X
 j9HVmfimHK89cNn9MWNoR+8n9ZHfZoERwqc3i5hKYCgNRxbBb7IhcQ1ivtVB3G01dKjYXnVYf
 v6lYVohIus4TLrrp82gvNUIaMHdjdR0rRrQ+EhAZgpVtFiF7xxcnxpOO74oYqaubxL74O0yt5
 pTmnJJUCE4adY3VB09rtmp0UKkuWqxt/UQKPkHXL61Dr+HSAL+9KMpzQeP/l2X6NfaTZnd8YR
 4ROW9jUpd99k3sslFhLwRThjcTEJ0xIJp3urVgIrSlU0qyGMsA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 11/15] linux-user: Add support for RNDRESEEDCRNG
 ioctl
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
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

RNDRESEEDCRNG is a newer ioctl (added in kernel 4.17), and an
"ifdef" guard is used for that reason in this patch.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 3 +++
 linux-user/syscall_defs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3281c97ca263..cd9b6f9a8d45 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -246,6 +246,9 @@
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(RNDZAPENTCNT, 0, TYPE_NULL)
   IOCTL(RNDCLEARPOOL, 0, TYPE_NULL)
+#ifdef RNDRESEEDCRNG
+  IOCTL(RNDRESEEDCRNG, 0, TYPE_NULL)
+#endif
 
   IOCTL(CDROMPAUSE, 0, TYPE_NULL)
   IOCTL(CDROMSTART, 0, TYPE_NULL)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 06622703008a..19a1d39cbc82 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -850,6 +850,7 @@ struct target_pollfd {
 #define TARGET_RNDADDTOENTCNT  TARGET_IOW('R', 0x01, int)
 #define TARGET_RNDZAPENTCNT    TARGET_IO('R', 0x04)
 #define TARGET_RNDCLEARPOOL    TARGET_IO('R', 0x06)
+#define TARGET_RNDRESEEDCRNG   TARGET_IO('R', 0x07)
 
 /* From <linux/fs.h> */
 
-- 
2.21.0



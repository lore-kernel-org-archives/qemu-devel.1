Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4362073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhVdmDnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4362073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKjc-0003Mg-FS
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jWK0B-0005Ut-Di; Wed, 06 May 2020 09:22:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomas.krcka@gmail.com>)
 id 1jWK0A-0002xX-Mh; Wed, 06 May 2020 09:22:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id v8so4964733wma.0;
 Wed, 06 May 2020 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Us1PV4ZQD0YBiRRgGIJUVnrUvxrw65Sm01g0XkQNraU=;
 b=AhVdmDnLEpAeIGzYShwsOTKOH9yEGrIZg1MQxu4XfB/4dOlC372PspBbnEaiNxSe8b
 iBdEkqhzT8D7k9opPBf2flokaSBjkgrl3zUJxgtyGD9804WZG83hMVYll7I4oonkAgNO
 qdL2AbdenuVfO7fsPPmXS7F4BbuE7iZaxvy1PkJ0GdX1QYP/2K0H6s7TvSikC31B1fQn
 6osriLdnkIJyLLFDBihK9ZwfHjMyr1eCi5taA0HFRhtrmhBOQC0Du7cFOiGBqx6ykUUW
 kTzgmLMyTPGhkbX2LAlaavuaQOLvyNrJRsWdgKJzMFIMUShDNzhL++Jvbiqv3Qe6IMdG
 +MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Us1PV4ZQD0YBiRRgGIJUVnrUvxrw65Sm01g0XkQNraU=;
 b=kkGG75RtgR1fzfSkVUcLz+kALD6zIxuuYAAmjVgeju67ENJL6BHadOMncKi69Y1/hH
 Rw9UrR4YubYSP98O52iE9eZizaRzL+YAKAoukZzxljNLinlPeQyYObowatuQ7HfuOmtl
 hmOxFNxMhNYbf3bU2zSTgkNdGIBCDysLcTLRoD8OhZzyC6SRfgFTGcw+1rmNw+YvBvww
 ZtNjvkiey3Uf4WS7bt1huC8pOwt9BGMf5S+yPD7EVqL9/vCgNNGR9LW50o89FBzO7Ow9
 2dfGSIbU9ITwnQ3TuGhNXLiScbia7TZ+KEaa3hUbZvtZ7cRBeYn4fELfYUmhm5IJ10WH
 1xKQ==
X-Gm-Message-State: AGi0PuZyKcMjHkCVTwoFh9CZGn19JZbl6T4GigrGF+EIc8Q4Psn/L7cb
 VMNgLwtnjAkXmvtGIzLmyPuEvLJkXznJIo7W
X-Google-Smtp-Source: APiQypJIpbccrAPwImDG1ekxrG7j3WehTNF8G7Go0SS8CTcPfxJXN7JgoU7iBb66ymmbSCxfwkK+DQ==
X-Received: by 2002:a1c:9989:: with SMTP id b131mr4334469wme.176.1588771336872; 
 Wed, 06 May 2020 06:22:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:8070:e292:7300:cd4e:b210:1388:63d6])
 by smtp.gmail.com with ESMTPSA id h74sm2185392wrh.76.2020.05.06.06.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 06:22:16 -0700 (PDT)
From: Tomas Krcka <tomas.krcka@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: add do_setsockopt CAN_RAW_FD_FRAMES support
Date: Wed,  6 May 2020 15:21:14 +0200
Message-Id: <20200506132114.76406-2-tomas.krcka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506132114.76406-1-tomas.krcka@gmail.com>
References: <20200506132114.76406-1-tomas.krcka@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=tomas.krcka@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2020 10:08:27 -0400
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Tomas Krcka <tomas.krcka@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
---
 linux-user/syscall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 88d4c85b70..f751ed8b37 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2141,6 +2141,19 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             g_free(can_filters);
             break;
         }
+        case CAN_RAW_FD_FRAMES:
+        {
+            val = 0;
+            if (optlen < sizeof(uint32_t)) {
+                return -TARGET_EINVAL;
+            }
+            if (get_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                    &val, sizeof(val)));
+            break;
+        }
         default:
             goto unimplemented;
         }
-- 
2.17.1



Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21457C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16912193E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmU+4mRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16912193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCw2-0006CS-2w
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCuk-0004CG-D5; Tue, 14 Jul 2020 00:51:34 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:41222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCui-0004uL-Mv; Tue, 14 Jul 2020 00:51:34 -0400
Received: by mail-qv1-xf42.google.com with SMTP id t7so6908330qvl.8;
 Mon, 13 Jul 2020 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6zfDC1IpCS6Uind9hNMhnPD8YUtgy8op4476VImHmB0=;
 b=JmU+4mRrKv2vFERIp1+TDI/G3Bc/dUkgyDk0toYhWLr/sPQkt4/OFuEqW7eVFLxc4t
 mLMIeXa9sCQ70egy1Q9HtGDM9p1UiDDujUzwnGeVKoc/YrBNgqJsTVah0vqPAUb/HxVp
 db7KQnFF0Gc8kGvzncqdg2IFcmI23GGa/nfAk3AJUfC34M86rWfd5Bf7TGRzSRWFUOIE
 NT7zanEqE0SWF03y74MyLQPT7qfRzuIMDiAAcbxHRcFDHN3Wxp0IcgZ19ZMe5gQWteJT
 B7isXYgGyYEQPg2QNV9Mec6FmfHtjRTHT4RGrFSRJFtPDPrGKbDaVqgoivbtvygktulY
 lYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6zfDC1IpCS6Uind9hNMhnPD8YUtgy8op4476VImHmB0=;
 b=rr1LLYCK/Obf+Zg8LBAnkqzMrrZPByYU/PfESV4x3HvgWHEfB3ZrfCKSpLZrlRg45Q
 xkONbRQHdvEi++GTSPRun4CHZYdHieBaAhE/B461DG4mxZDOyaoF/jld1VIYIrFELF0f
 ClZENHnZJlBBhTzizheDTcHKD66xluW2gkJTRJGjvGVffKFthbcXREOuRI50c/xKB4bl
 aQjBICoM6TFomV2nTVPRXuFj+wftiiJHMW3jjIGZ0fa6xdpwdQw3/aaJYL1xC0bpfIOW
 scfhyZNyuY8WYE2Pe2OK4fRK6ihKqdTZhnmYx/xP/vb1wk2xPdVke5QjLC21nO1Ahfcu
 9bkw==
X-Gm-Message-State: AOAM5310Uw+/zrSK54c5QiQoFUeG2DasAT7nz/e84f3EsJeh3hwiwsWX
 4/jj6sOiWFweKaFYsjZNKM/DtNrr
X-Google-Smtp-Source: ABdhPJxzp+zxTrtYWZIZbL/7UlAfrKJXrRmyWN2Z64knfWKEfzgz1+8npMB9yCC81FvuIt7+OoOxqQ==
X-Received: by 2002:a0c:b712:: with SMTP id t18mr2776144qvd.205.1594702291258; 
 Mon, 13 Jul 2020 21:51:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g30sm24139571qte.72.2020.07.13.21.51.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Jul 2020 21:51:30 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] qga: Use qemu_get_host_name() instead of g_get_host_name()
Date: Mon, 13 Jul 2020 23:51:14 -0500
Message-Id: <20200714045114.29319-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
References: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=flukshun@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Michal Privoznik <mprivozn@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

Problem with g_get_host_name() is that on the first call it saves
the hostname into a global variable and from then on, every
subsequent call returns the saved hostname. Even if the hostname
changes. This doesn't play nicely with guest agent, because if
the hostname is acquired before the guest is set up (e.g. on the
first boot, or before DHCP) we will report old, invalid hostname.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index efc8b90281..d3fec807c1 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -515,11 +515,20 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
 GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result = NULL;
-    gchar const *hostname = g_get_host_name();
-    if (hostname != NULL) {
-        result = g_new0(GuestHostName, 1);
-        result->host_name = g_strdup(hostname);
+    g_autofree char *hostname = qemu_get_host_name(errp);
+
+    /*
+     * We want to avoid using g_get_host_name() because that
+     * caches the result and we wouldn't reflect changes in the
+     * host name.
+     */
+
+    if (!hostname) {
+        hostname = g_strdup("localhost");
     }
+
+    result = g_new0(GuestHostName, 1);
+    result->host_name = g_steal_pointer(&hostname);
     return result;
 }
 
-- 
2.17.1



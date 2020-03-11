Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A5C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA43D21655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="WAFQ7Dtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA43D21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0d6-00017E-03
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aH-0004X7-LV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aG-00036R-JK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC0aG-00034G-DO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id 11so1903959wmo.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=WAFQ7DtuG/qez7AE0Fv/S0S1knqoJH5Ekmjkul7RbNswktSaNxg2a09vIesnQ12HEC
 f8wTPzgXX6elXvXX9va2WJ9ml2eYpAiiLZ/IMoyYldSVCIMnnLr69X6OvH/5Qm/tJYMh
 lcpWclJgRMRR0d3H/R127BkHtcEn0ded6zi+MiXIKaCUmhi6gYLBu9MlUCSMWp6ufKOS
 bv6Mm9F3GqDtNNjztBW64xOK1TlYVUhlEgVYcNAJBD2OZGh5ngH6qvYtFOTxtl8uZFB7
 QowttBDEQevQYjGWFHsrph9WZjEz4AjrtDqw/VK5zO2zu4HQEWrqy7KVl4B1tbF6Fg18
 oJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=fnSgL0rtbGE9GTC0p5er3LQt6qHxvhArZiz0DrVGfCSPQOUJKxIyw/poUKUJbb/D14
 FyM8U/ZP/nS9Mu6flwu4RUsNwResiaPZLpOBcIWH2t5WpN/X1iiwJG0oepE46gs6yhgo
 2t1BVlcdQWXBft2gMXP3v2WpoKXu0AVDQojw1IXQq4+kWa5/ikiXezbkpXr1+FO6Jwfu
 loyb6oGzHw0KhI/r9ZKKOXUHZ7MXkRNN4m8+aM7WG7EgOKDIYkUzFierNrU3ZlUHbF36
 jiHz4StX5ChFiFLFb+RefTwmTaJzeXHV+l14eXPOFxeNzeTvsP74vvw1SlU9arqVux0S
 wwIQ==
X-Gm-Message-State: ANhLgQ03z9MYxciE869V33xmTI/Z8I5SxtrXtvj9YRG6zvUCuffzwYB5
 uU7qYYje8C9nc6kbs4m0LutED53LWp4FYA==
X-Google-Smtp-Source: ADFU+vteUVcnFxFFap7IB/b/mUOcsgw2fMnfhtg3G0KDq3qwXrsJ4e22e58RiKOGw8C6QyFZF4qoDw==
X-Received: by 2002:a05:600c:4107:: with SMTP id
 j7mr3653442wmi.169.1583930135314; 
 Wed, 11 Mar 2020 05:35:35 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id o11sm61480696wrn.6.2020.03.11.05.35.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 05:35:34 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 6/6] tap: allow extended virtio header with hash info
Date: Wed, 11 Mar 2020 14:35:18 +0200
Message-Id: <20200311123518.4025-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311123518.4025-1-yuri.benditovich@daynix.com>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 net/tap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 6207f61f84..47de7fdeb6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -63,6 +63,14 @@ typedef struct TAPState {
     Notifier exit;
 } TAPState;
 
+/* TODO: remove when virtio_net.h updated */
+struct virtio_net_hdr_v1_hash {
+    struct virtio_net_hdr_v1 hdr;
+    uint32_t hash_value;
+    uint16_t hash_report;
+    uint16_t padding;
+};
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
@@ -254,7 +262,8 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr));
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.17.1



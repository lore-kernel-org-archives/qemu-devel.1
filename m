Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB340C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B788B206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="k974/6fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2bA-00083b-SE
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Ww-0007Mv-2b
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Wv-0003OR-9i
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so1729395wrx.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jsJ4UjAj5wqZiTgR+FddDr2mcT22TfIQNXUXRnn1z7Q=;
 b=k974/6faPgYqwiHt8f1nR6Inu2Dx5EUjNNC03ls0y0dytMlvkcSTxNOBjObL0fbYZs
 DVegcvc2WpO4pkG05yoyZN4EBFOGz5rxUjnTLkqVm3igMwOVmnKjUnj406J0dQUL3GUi
 Rw/lvwt0js2NoGMcg9vgS1QwI+MVDn82gJ6xsmvEV8fEpQgIIBiLdhKetYF8tBTHwRPL
 QogFNwI3PpcOyBr4/n1GFOOtbEL1s+QSs3Ojid1EUNEr8U4mTB8lRq6aF0itYMtOBKnD
 ilh7UVOYTSppE8qWAahFgcjwpi8bLDnIyAqiXowsjaidso2E+l/kTcxt3HoPqNMl8XKg
 iYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jsJ4UjAj5wqZiTgR+FddDr2mcT22TfIQNXUXRnn1z7Q=;
 b=UG8QcvmnEQ1U+QQGMxmuStZkr646EjFqo+9f3rzzUN/H+0QDNYm+OEaWX9yS1d4+vi
 PVkDsM4iwg/RiVm5uP6MDpTqQjv2TXd6HEON/5+ebGhMyaloqL56t464c5TkErqWbAEK
 mSFVDB5tym3ZOJtutyetKTTjq4LXnbvYT3c9iubkJUDHyENsgEPAiieLSS4yn/3yZT3R
 5oiEbSE1p9dlvLvMQZRvLHL0Bysb98oNP/OSEdS3S55LZFNadAosD6w5/MlsqSMWt92w
 K0cRvfwHsbx2mKSUYDldTHFJzvhlyphuWsHnRnwvc1MGYRaBlzk4PC5/1wMODoojyqN3
 wkMw==
X-Gm-Message-State: AGi0PuZSPb5DUhDkG6pkzctT+473FVRTkv8BwZjv9ysyA28O9JpkmwPK
 EbphYPt6/z+ev02JZ9EeJGunEVuAVLPwSw==
X-Google-Smtp-Source: APiQypK9plNgB9S26MkyUpgBf4jPoQZVjZw98H9JJZwgb2gzd+Qv4mc5E5lGvi3hx2KT6nx+68md1w==
X-Received: by 2002:adf:d091:: with SMTP id y17mr2761767wrh.418.1588942503797; 
 Fri, 08 May 2020 05:55:03 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id a8sm2852375wrg.85.2020.05.08.05.55.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:55:03 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH 3/7] tap: allow extended virtio header with hash info
Date: Fri,  8 May 2020 15:54:48 +0300
Message-Id: <20200508125452.7802-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508125452.7802-1-yuri.benditovich@daynix.com>
References: <20200508125452.7802-1-yuri.benditovich@daynix.com>
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 net/tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 6207f61f84..ca48f2a285 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -254,7 +254,8 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr));
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.17.1



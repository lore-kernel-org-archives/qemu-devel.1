Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC24C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681D020656
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIZgXrZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681D020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY0e-0007by-Tr
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsM-0005f2-8h
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmA-0002t5-JW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:56 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmA-0002sg-EF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:54 -0500
Received: by mail-pj1-x1042.google.com with SMTP id ep1so8068919pjb.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2bAHX0FXOgqRwz29p5ya1CXvQIHb2CLin8kXdVB/0KE=;
 b=LIZgXrZnUx86XNNP0wmHAcrNw9/JIZ8Z/K+g4m7VRaHAmOxfSZCyPu0eA26cNr146y
 o7pf4ACxMyylsjo6uGEODbNQv8BRy46PhL70owQw/xwCKefsVPclpEamrqGo72ehYh+9
 v63wDQiT5CznqvW3e78uI6rd3/N+sk3gekTAk9Ai4rTTvwCGcYckKvWPtFjd9xcw1oOG
 8R1NnTguMJFxf9tZ09BhOA6+IrzVhQlaOh9GYKE9/yZf9zK1SwVLEIg5oFO2RFCUDefS
 13vpeM20b7IeXPytkqCO5Efyk0g/6IAoInedl5KOOFZshV6zSMntUF6MhlF1jpnMUsy2
 W+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2bAHX0FXOgqRwz29p5ya1CXvQIHb2CLin8kXdVB/0KE=;
 b=WJMSp3WnIiicw0kmXEAUL0jiCFFeWfLrISiy53+4QcJQFtDce7Wul9pDKJzZum6SzW
 94vtSk0y8+Xo1ZoMeCRx1K1G1OW7fjExw+vj4uWe6u3vL7KWTNX0PwdLv2qxnmgXvW+4
 xCjfN8gfvg4kM6lBdFy4HvmRMwg/ygKBuiFnegPT92gk7kYCfjfpu6Kz0OF/g9lJIFwj
 070roNI/YUMpO3cpIxZKRYf4EhpSwwfW+uw59VlIWP70Q8OISIIAEvs7/S/knoHyQ2af
 YTaJ9vlBlUUC73SL9YIQgRME2gWEdh2P0hKCYh8nmsOWj/s3s/TgCaruhJdnw9Rk7A8R
 B/Iw==
X-Gm-Message-State: APjAAAXJQ04sYb3VJzhaHCyGqEpuM3yTJsP52P/70nnXaiFmLvnX/yWD
 i7J6J3E498GmVDpI+rgTOpQ=
X-Google-Smtp-Source: APXvYqyvpP2N7hYAzxx2bd4M9VJ+Jp8Kjxs/E28fT/8KVvvGyoey0uyI2syTr1ITSFDcJg6CMebg+A==
X-Received: by 2002:a17:902:7290:: with SMTP id
 d16mr32584601pll.340.1574762933671; 
 Tue, 26 Nov 2019 02:08:53 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:08:53 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 03/18] net: core: export do_xdp_generic_core()
Date: Tue, 26 Nov 2019 19:07:29 +0900
Message-Id: <20191126100744.5083-4-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

Let's export do_xdp_generic as a general purpose function. It will
just run XDP program on skb but will not handle XDP actions.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/dev.c            | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9e6fb8524d91..2b6317ac9795 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3648,6 +3648,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
+u32 do_xdp_generic_core(struct sk_buff *skb, struct xdp_buff *xdp,
+			struct bpf_prog *xdp_prog);
 int netif_rx(struct sk_buff *skb);
 int netif_rx_ni(struct sk_buff *skb);
 int netif_receive_skb(struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5ae647b9914f..d97c3f35e047 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4461,9 +4461,8 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-static u32 do_xdp_generic_core(struct sk_buff *skb,
-			       struct xdp_buff *xdp,
-			       struct bpf_prog *xdp_prog)
+u32 do_xdp_generic_core(struct sk_buff *skb, struct xdp_buff *xdp,
+			struct bpf_prog *xdp_prog)
 {
 	struct netdev_rx_queue *rxqueue;
 	void *orig_data, *orig_data_end;
@@ -4574,6 +4573,7 @@ static u32 do_xdp_generic_core(struct sk_buff *skb,
 
 	return act;
 }
+EXPORT_SYMBOL_GPL(do_xdp_generic_core);
 
 /* When doing generic XDP we have to bypass the qdisc layer and the
  * network taps in order to match in-driver-XDP behavior.
-- 
2.20.1



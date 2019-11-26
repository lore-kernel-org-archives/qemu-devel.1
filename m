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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA4AC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011442071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0I1EGJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011442071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYCg-0005Wb-SF
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsL-0005e4-Ja
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmQ-00037J-BC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:11 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmQ-00036b-2i
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:10 -0500
Received: by mail-pg1-x542.google.com with SMTP id e6so8732569pgi.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o7wWeRbc+tNqQMSjrOB4Aqcs6TIYjdNZ6xF+Z6+tUq0=;
 b=T0I1EGJ6YTSRSu/Y4XLTUBBYnqBS9LwqseER/BjzdXl8Q7YQ6BBhOS6hWPwJ+Fampz
 P7EI5RxePE3I3u7Y94Tky0n+nFE78T2UBuBrF7foiUu5ODFJMPS7xZL9Attd9J/fv2xk
 YC0mrtwZW0lEhmUYXkLjAnrzjGf0MLJJzOGH6wypDpR4PUbQQZUzKRmWBcG+SeZ9cW79
 sSdTVoF36tW8MK07iZfRmuRxtHw8eS3BBMGKOv/L1m+aD66CZK50R2dRXBlpOSt96TbP
 YzvoGyvxaN5aONyAay/kSX0/Rb7Ga8eSzdNDD3OD5e5IZ1t55ny2HbvmNcgnnY5mr39+
 5zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o7wWeRbc+tNqQMSjrOB4Aqcs6TIYjdNZ6xF+Z6+tUq0=;
 b=GMGmW5Y8m7INysfbiSg6JqAFJcDd/EUovNOObRPxIOvJxlNBkvTPRExjm8doau2/6N
 GMLhYPMfU8zCb47CIaXGnPHxC5o5QOl38uNwp6vOBXgWtEdpsRmYr8lF3/dD5lDC0oaE
 BMoDcplzh1JzCe0OTZFcc/M3s02Nfr8SeQ0ZZvMx2sCrvinOZV6zy/wCB6WDIPgvKmCj
 rLqhLhThhnnAeqYsZpXo/fI3jeK+pIkSgdLxVNUwht57GBG+dGxnuytQix/jwkGNaruH
 KOUtWjO0yRrlfHvvofpBn83gcHEM/bA+kKupqaxTOT2HiCfY77gTu3IpyZTZN9rTiPJq
 cwLQ==
X-Gm-Message-State: APjAAAVLu/Hw11cdMCl7u/04C2FsNF5lyOAjj9T29VHkbKkUgSVTALby
 vrMrA+JxlLNhkYT4OAeYRf4=
X-Google-Smtp-Source: APXvYqwfaVLiFIs0iXc/+SHQsi0c/jFNHsDcCU5mOA5Ky5UmlUqcVt7e8bS0r/y9o05pZ3I6c6EV8A==
X-Received: by 2002:a65:4342:: with SMTP id k2mr38951684pgq.63.1574762949130; 
 Tue, 26 Nov 2019 02:09:09 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:08 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 07/18] tun: set offloaded xdp program
Date: Tue, 26 Nov 2019 19:07:33 +0900
Message-Id: <20191126100744.5083-8-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

This patch introduces an ioctl way to set an offloaded XDP program
to tun driver. This ioctl will be used by qemu to offload XDP program
from virtio_net in the guest.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tun.c           | 19 ++++++++++++++-----
 include/uapi/linux/if_tun.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d078b4659897..ecb49101b0b5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -241,6 +241,7 @@ struct tun_struct {
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
+	struct tun_prog __rcu *offloaded_xdp_prog;
 	struct ethtool_link_ksettings link_ksettings;
 };
 
@@ -2256,7 +2257,7 @@ static void tun_prog_free(struct rcu_head *rcu)
 {
 	struct tun_prog *prog = container_of(rcu, struct tun_prog, rcu);
 
-	bpf_prog_destroy(prog->prog);
+	bpf_prog_put(prog->prog);
 	kfree(prog);
 }
 
@@ -2301,6 +2302,7 @@ static void tun_free_netdev(struct net_device *dev)
 	security_tun_dev_free_security(tun->security);
 	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
 	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	__tun_set_ebpf(tun, &tun->offloaded_xdp_prog, NULL);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3036,7 +3038,7 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 }
 
 static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog **prog_p,
-			void __user *data)
+			void __user *data, int type)
 {
 	struct bpf_prog *prog;
 	int fd;
@@ -3047,7 +3049,7 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog **prog_p,
 	if (fd == -1) {
 		prog = NULL;
 	} else {
-		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
+		prog = bpf_prog_get_type(fd, type);
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 	}
@@ -3345,11 +3347,18 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		ret = tun_set_ebpf(tun, &tun->steering_prog, argp,
+				   BPF_PROG_TYPE_SOCKET_FILTER);
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		ret = tun_set_ebpf(tun, &tun->filter_prog, argp,
+				   BPF_PROG_TYPE_SOCKET_FILTER);
+		break;
+
+	case TUNSETOFFLOADEDXDP:
+		ret = tun_set_ebpf(tun, &tun->offloaded_xdp_prog, argp,
+				   BPF_PROG_TYPE_XDP);
 		break;
 
 	case TUNSETCARRIER:
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..21dbd8db2401 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNSETOFFLOADEDXDP _IOW('T', 228, int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
-- 
2.20.1



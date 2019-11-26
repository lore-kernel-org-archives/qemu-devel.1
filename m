Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D68C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BDE2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtApj9X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BDE2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY2c-0002Iw-5t
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsG-0005R4-VN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXnO-0003cI-GV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:10:11 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXnO-0003bh-AT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:10:10 -0500
Received: by mail-pg1-x543.google.com with SMTP id k1so8729059pgg.12
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jdQDv4S8OWRFK8BJ5NYf9HpYfCnOIJYUleYQ7gA4ef8=;
 b=YtApj9X/cp+10E3jJdzMh0RcIPpc4CopknMK247+K9YhmjX7IaHFWp+tcwyfTXgE1K
 gearHC/Oqv3chiy+cx5zxAlKbAL4kS39s+2seSdFMdf1o/FAw+xtkgN6rgtw7LvxFk0x
 dk2nfC7QJRhmLMf8fDIBhaLSjx4piMarDrUDqnoiEKNP03RJxZ5M2xdlytCoR0FUDVM2
 aVW8Sq5kbWBuxjoE05KD0QmF2fcj8PI1zAkB44AVQblaOYQQLK/tT1NFDl65Z6YQgt0D
 GjVP38TtY8UMwsYUVBKZvbhp08TZ25UDZtPXpeY4aupwLgMabEkMR4pwI3m2xdpvx7zE
 merw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jdQDv4S8OWRFK8BJ5NYf9HpYfCnOIJYUleYQ7gA4ef8=;
 b=rt6MeYu5oH+BNH1DocbBczJHFzBYVaq/FordK01kPgcuQ1EOR6xo+pDJ1mmIXD2Hy4
 T3DroMtX4mq9fe+yLuXKs2SPGlH28WhZMPrXNcn6ZuM0NnEyU0fQbbQ3nERXxbQefQcP
 Vp4b3wsUg/FJAg63eBMGXnuIguzru2glGPykj6Bbb+qqLZUbVg6cLwVB71OECPXrWIOs
 afph7hrvPR7JW3B8l4BLt6tOFfJ0elvpinfBllrlHVT+5YmZpqGj2wVlUUwVd/N8zh02
 yQ7eC+CIL4hsmxM+ctrQ4IU8zEgDBgl6z9GhkPJwezRU9lAwN7872e48Y60QslJZtPSW
 T9eQ==
X-Gm-Message-State: APjAAAV/8FtUSACID8peLYSetdokuO8yDjHetf07b0lxldWU3FOejHzN
 Ni2xBmr/qMiJQNUkYnmf/gM=
X-Google-Smtp-Source: APXvYqyG5wYFvtz/3LCmlX/xi0PtGiVDiGiK1KoXwfOJBmKbLfebzWsYO5JtfxZWx6PW1f5qA8Ftsw==
X-Received: by 2002:a65:4346:: with SMTP id k6mr33984016pgq.349.1574763009508; 
 Tue, 26 Nov 2019 02:10:09 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id h9sm12059065pgk.84.2019.11.26.02.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:10:08 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC 0/3] Qemu: virtio-net XDP offload
Date: Tue, 26 Nov 2019 19:09:11 +0900
Message-Id: <20191126100914.5150-1-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note: This RFC has been sent to netdev as well as qemu-devel lists

This patchset implements XDP offload feature in qemu. The successful
operation of this feature depends on availability of XDP offload
feature in guest, qemu and host. When this feature isn't available in
qemu or host, the request from guest to offload an XDP program should
fail.

Patch 1/3 adds support for libbpf in configure script.
Patch 2/2 enables offloading of ebpf program.
Patch 3/3 enabled offloading of ebpf map.

Points for improvement (TODO):
- In future virtio can have feature bit for offloading capability

- TUNGETFEATURES should have a flag to notify about offloading
  capability

- Submit virtio spec patch to describe XDP offloading feature

- DoS: Offloaded map uses host's memory which is other than what has
  been allocated for the guest. Offloading many maps of large size can
  be one of the DoS strategy. Hence qemu should have parameter to
  limit how many maps guest can offload or how much memory offloaded
  maps use.

Note:
This set directly modifies virtio_net.h header instead of
importing it from existing kernel headers because relevant changes
aren't present in kernel repository yet. Hence changes to virtio_net.h
are for RFC purpose only.


Jason Wang (2):
  virtio-net: add support for offloading XDP program
  virtio-net: add support for offloading an ebpf map

Prashant Bhole (1):
  configure: add libbpf support

 configure                                   |  23 +++
 hw/net/Makefile.objs                        |   2 +
 hw/net/virtio-net.c                         | 157 ++++++++++++++++++++
 include/net/tap.h                           |   2 +
 include/standard-headers/linux/virtio_net.h |  50 +++++++
 net/Makefile.objs                           |   1 +
 net/tap-bsd.c                               |   5 +
 net/tap-linux.c                             |  48 ++++++
 net/tap-linux.h                             |   1 +
 net/tap-solaris.c                           |   5 +
 net/tap-stub.c                              |   5 +
 net/tap.c                                   |   7 +
 net/tap_int.h                               |   1 +
 13 files changed, 307 insertions(+)

-- 
2.20.1



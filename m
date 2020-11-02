Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D382222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="bHXdgUlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D382222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeT7-0003Cb-2B
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQw-0001WR-IQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:00 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQq-0006hN-Uf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:19:58 -0500
Received: by mail-lf1-x143.google.com with SMTP id 184so18646639lfd.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ceOm0Xxf/LJg7f2HRgjqVHLIfEk3x6v7meMsg/XEr9M=;
 b=bHXdgUlBKqDAeYVIYMTEuTUT1QPGBC5FoS4ISB+8MnnOliCOziWgpoNX5T4Q92pahM
 UscpfvyEWJVvA5OByRFBQZ5u2TnuEu7cswnuOkA0iintkXmmxYoO4v8E9NhAPFyGoOh5
 wxv514fxLlMLbdyZ122ca2R3WnP/MJAn4fHxLJpICFiyARkjk379q1XdLmeaKbacF7Vg
 PxnRo7SwaOhyIFjIjEK9saipRGFYXW9b37aYsDn+g5izlkWUUV7wnEoZphEHiT0XPGnL
 GgWkZfqIxpoOv9gG7oygB9bd318c5yBR1ITyy80XykA+wLcb50wqYATHVw4X8kNKVQHM
 iXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ceOm0Xxf/LJg7f2HRgjqVHLIfEk3x6v7meMsg/XEr9M=;
 b=XqD+H2K4qB2swsd2LkX5GMezYnAPIx7Hn3Mlre939oN7HMUWUmWVvnT6l483BPIESt
 Tmnqtfui/iX372t/zWHKpraSC8OQkLL7a8c5Sh4QToTfR4PJ2S94FLDGP31/yEpcUEwQ
 ltFPR22yIQJcWwl0LSywdkRKVt+Q/RaX88iGkVXe/vYfoh0nxJYWpncKy529UvUpZA9v
 c4gJ/GVYdPx0ZiL/9n/xmq7fcDh82ewCKFysXyKdctUOktqq2TKXGFrZtHtih0AB773z
 +leDJ9sTexayK/0qLmZ3HN8mQWuX3ndKfiTap/hSm78gielWRCr/gQnFx/WG3i5FrgCx
 bEUg==
X-Gm-Message-State: AOAM530zSO5aUGd2Dcy21Dtq7j8U1IqP7Oix/393k1sSbpWyrb4t1AX3
 QlgCBBmQCZyj4/Ld3Zh0MRaztg==
X-Google-Smtp-Source: ABdhPJwwz9DsqK2bITAqMEcHJMog+brLdpS9fvO3zYMJdqbwuxz9MlDwUmW16jTiBLL6Rc0nHR4BsQ==
X-Received: by 2002:a05:6512:47c:: with SMTP id
 x28mr3456181lfd.321.1604341190582; 
 Mon, 02 Nov 2020 10:19:50 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c6sm2527007lfm.226.2020.11.02.10.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 10:19:49 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [RFC PATCH 0/6] eBPF RSS support for virtio-net
Date: Mon,  2 Nov 2020 20:51:10 +0200
Message-Id: <20201102185115.7425-1-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::143;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basic idea is to use eBPF to calculate and steer packets in TAP.
RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
by calculating packet hash.
eBPF RSS allows us to use RSS with vhost TAP.

This set of patches introduces the usage of eBPF for packet steering
and RSS hash calculation:
* RSS(Receive Side Scaling) is used to distribute network packets to
guest virtqueues by calculating packet hash
* eBPF RSS suppose to be faster than already existing 'software'
implementation in QEMU
* Additionally adding support for the usage of RSS with vhost

Supported kernels: 5.8+

Implementation notes:
Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.
Added eBPF support to qemu directly through a system call, see the
bpf(2) for details.
The eBPF program is part of the qemu and presented as an array of bpf
instructions.
The program can be recompiled by provided Makefile.ebpf(need to adjust
'linuxhdrs'),
although it's not required to build QEMU with eBPF support.
Added changes to virtio-net and vhost, primary eBPF RSS is used.
'Software' RSS used in the case of hash population and as a fallback option.
For vhost, the hash population feature is not reported to the guest.

Please also see the documentation in PATCH 6/6.

I am sending those patches as RFC to initiate the discussions and get
feedback on the following points:
* Fallback when eBPF is not supported by the kernel
* Live migration to the kernel that doesn't have eBPF support
* Integration with current QEMU build
* Additional usage for eBPF for packet filtering

Know issues:
* hash population not supported by eBPF RSS: 'software' RSS used
as a fallback, also, hash population feature is not reported to guests
with vhost.
* big-endian BPF support: for now, eBPF is disabled for big-endian systems.

Andrew (6):
  Added SetSteeringEBPF method for NetClientState.
  ebpf: Added basic eBPF API.
  ebpf: Added eBPF RSS program.
  ebpf: Added eBPF RSS loader.
  virtio-net: Added eBPF RSS to virtio-net.
  docs: Added eBPF documentation.

 MAINTAINERS                    |   6 +
 configure                      |  36 +++
 docs/ebpf.rst                  |  29 ++
 docs/ebpf_rss.rst              | 129 ++++++++
 ebpf/EbpfElf_to_C.py           |  67 ++++
 ebpf/Makefile.ebpf             |  38 +++
 ebpf/ebpf-stub.c               |  28 ++
 ebpf/ebpf.c                    | 107 +++++++
 ebpf/ebpf.h                    |  35 +++
 ebpf/ebpf_rss.c                | 178 +++++++++++
 ebpf/ebpf_rss.h                |  30 ++
 ebpf/meson.build               |   1 +
 ebpf/rss.bpf.c                 | 470 ++++++++++++++++++++++++++++
 ebpf/trace-events              |   4 +
 ebpf/trace.h                   |   2 +
 ebpf/tun_rss_steering.h        | 556 +++++++++++++++++++++++++++++++++
 hw/net/vhost_net.c             |   2 +
 hw/net/virtio-net.c            | 120 ++++++-
 include/hw/virtio/virtio-net.h |   4 +
 include/net/net.h              |   2 +
 meson.build                    |   3 +
 net/tap-bsd.c                  |   5 +
 net/tap-linux.c                |  19 ++
 net/tap-solaris.c              |   5 +
 net/tap-stub.c                 |   5 +
 net/tap.c                      |   9 +
 net/tap_int.h                  |   1 +
 net/vhost-vdpa.c               |   2 +
 28 files changed, 1889 insertions(+), 4 deletions(-)
 create mode 100644 docs/ebpf.rst
 create mode 100644 docs/ebpf_rss.rst
 create mode 100644 ebpf/EbpfElf_to_C.py
 create mode 100755 ebpf/Makefile.ebpf
 create mode 100644 ebpf/ebpf-stub.c
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 ebpf/ebpf_rss.c
 create mode 100644 ebpf/ebpf_rss.h
 create mode 100644 ebpf/meson.build
 create mode 100644 ebpf/rss.bpf.c
 create mode 100644 ebpf/trace-events
 create mode 100644 ebpf/trace.h
 create mode 100644 ebpf/tun_rss_steering.h

-- 
2.28.0



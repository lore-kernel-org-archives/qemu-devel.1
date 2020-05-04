Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23416C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56EB20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V59QG0At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56EB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXiW-0007Gk-2u
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgW-0004m9-6c
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgV-00040u-CB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=klu7jOgPZnmAvr4m5ImzTW9UcFF3afd6WKxqzkcFYbg=;
 b=V59QG0AtmVCAlodH0n1Vz4s78N4rFMbiu9JzILPTl1ngvoAMadIzgIc92YWCd4g+fpvzQE
 iRGm6a2wv1EAYqCb4SGeqkaVhtMv9l7BO2hFaz+ou+6FKhV4LxDHaeQQXBqrpH+5hwSNWv
 UtNn86Kq/BbFYgbuEHZ1fL9KmEn2E7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Y_jWJp5iOpmfh1fvYth_TA-1; Mon, 04 May 2020 05:46:45 -0400
X-MC-Unique: Y_jWJp5iOpmfh1fvYth_TA-1
Received: by mail-wm1-f71.google.com with SMTP id d134so7117880wmd.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tzaN5CD6F6HqrJGq0fewd6Owcd5dVuWuiBtcP6diU5Y=;
 b=K7TbN62ok3xxhb/+fpvBN2Nc9R27WEzQafINKp9gWf+hYp+Y6FRfPrRybw9oCB3rAM
 9MUjaMSrEwkvHRPGaq/XMDPN1DzOPx5OUXOoiMpFMGxGMfyK1LD/iqcN06D3Earas9fk
 WWDahTpbzuHhI4R+CSp/zmqlIcbByCQIXwxHYBr8oYnZh6neqrl3KuHCAI411iAzpGiX
 gX3zj0dvwTQHKwNWqZbtXgo7yl7CvzGUHBOxBg/5nz+Xycjm2c+SoFzWr0hACEsPfgyy
 uMH5zqMjyZCKMJ54Xkf5X8aiiEfl0rYbFqo5bV8VsWZpQifUHBfHcxag82K74fi6Ed37
 JGvA==
X-Gm-Message-State: AGi0PuZLFhYvofGhupGB86Bpur0xGWnTv54Sl+8IJ9WY3WWRxN1ZEZW/
 TlTeCj2uECiBw0c81ROlRsR/SG4bGK6SJkkXP8aKe65Ci1z377Z51Z2D+s8MoaHD8+EM3DgHFyI
 WbhWr7RlcQEKnCqc=
X-Received: by 2002:a1c:bad4:: with SMTP id k203mr13449901wmf.15.1588585603678; 
 Mon, 04 May 2020 02:46:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypKANGuWOvUKowDtTM0DLLTvfh6+/FnLbuatkQOjtWTQvzARrodIA46ppMPirdQZbs97qfS9KQ==
X-Received: by 2002:a1c:bad4:: with SMTP id k203mr13449889wmf.15.1588585603502; 
 Mon, 04 May 2020 02:46:43 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id x18sm16789559wrs.11.2020.05.04.02.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:46:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] block/nvme: Align block pages queue to host page size
Date: Mon,  4 May 2020 11:46:35 +0200
Message-Id: <20200504094641.4963-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The most important patch of this series is 'Align block pages
queue to host page size', it start fixing an issue on PowerPC
hosts. It is not sufficient, but the rest is VFIO specific,
so I prefer to send it separately.

The other patches are documentation I was writing down while
looking at the code.

The last patch is about the emulated device and writeback.
Marked as RFC as I don't understand writeback/dirty_log_mask yet.

Philippe Mathieu-Daud=C3=A9 (6):
  qemu/osdep: Document qemu_memalign() and friends
  qemu/bitmap: Document bitmap_new() returned pointer
  sysemu/block-backend: Document blk_read()/blk_pwrite()
  block/block: Document BlockSizes fields
  block/nvme: Align block pages queue to host page size
  hw/block/nvme: Make device target agnostic

 include/block/block.h          |  8 ++++++--
 include/qemu/bitmap.h          |  2 ++
 include/qemu/osdep.h           |  3 +++
 include/sysemu/block-backend.h | 26 ++++++++++++++++++++++++++
 block/nvme.c                   |  2 +-
 hw/block/nvme.c                |  4 +---
 hw/block/Makefile.objs         |  2 +-
 7 files changed, 40 insertions(+), 7 deletions(-)

--=20
2.21.3



Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560C420781
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af8sPFw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560C420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Mw-0008RU-Ky
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dX-0007BW-Qz; Mon, 29 Jun 2020 17:48:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:44143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dV-00083p-IW; Mon, 29 Jun 2020 17:48:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id by13so4443688edb.11;
 Mon, 29 Jun 2020 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=NFWVTv3Xevsr6Yc2Iwq7oB+vU0KJ3iuVA/LFJxOZkPs=;
 b=Af8sPFw4Aq+imBgXTlloT3kUTTB4VKxTU1LIbgHmpxs16qEfrIpK6ADVJc8lyQsjf3
 uQJnQuJc4RH1FOQZvaxPqzleKgHTH5eeTEMJmWKYfKkzhINwIexM1cW6yRzBM7QxpoVy
 hcgkriVU8g6VHXC55NbNlkJLkHGCbshxLCVn0Y39+cQIbT77Tt36WHouts2FnU8WIO3V
 92tKwkAnq+yfKx/ZhlCe3nvJETQ+iCsJ9QdX4hRT8VGiwQJx7tmTmwnGMDX77HW+xEJ8
 HrOPR1MDTnIStsenyuiPRnMS2G3Qmz62MI3tx7E9Uxgd9AVopzzmBpKpxN6lkXNrmwhe
 UGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=NFWVTv3Xevsr6Yc2Iwq7oB+vU0KJ3iuVA/LFJxOZkPs=;
 b=ovoyU2jLxOmMddWRpel8ABn7bf7hwJyE4IzlTOObGm2wp6qlHM2WZK2mSWl7Jurzi3
 +KOaz0lEDv03bfcfV7DSo4HWiq9vIZ1j3xIlk6qoGk0/c/dSd5DRo6k/uTr8Hh4/Cj+V
 BvieLIoMXhQhryE6hPp1G2bh0oU7rrna6RAsq4V3D5H6FXSqu+ff3dIUX/Dx+D6oIG5y
 GRqAg/7CNdONXCIM8HLBMPFGV0srM6PKEtQ1O17DPnRPU1DLaeYoawXDkY2fRPaOQJ4Z
 J9oJ9DyUvn5mGpHltOsyvR5S8HqYmfLGttP2kkfBjv4ojyl4Qn2HaKz+2xDnlbS/aUty
 nLvQ==
X-Gm-Message-State: AOAM531aC4Kzi8RODYcIESAe+Fl/7PZTcPu7s4MKXGgRakWwdCFRyHGZ
 jFbizBLHlk6C8PtFM9fagMitvqQ1pxNcxN/2JEm8FGVz3OiQ7A==
X-Google-Smtp-Source: ABdhPJw9cXQGkoYE2PZjl9QoWT0A+5JpZJqS3DL3XPdUcMBIMmNIVa/XkXH1IFVLc5bkv2RkHf/KZfGXlkaI9dpKKxw=
X-Received: by 2002:aa7:d792:: with SMTP id s18mr20233615edq.7.1593467299000; 
 Mon, 29 Jun 2020 14:48:19 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:08 +0100
Message-ID: <CA+XhMqw9BGjkRrMdQmhjHjPge2Wq_w01=4Q+taNErMJH2B4gDA@mail.gmail.com>
Subject: PATCH [0/9]: haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:17 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From fcdb25804af98329b52a04e7a4e5191135aac4f6 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:36:32 +0000
Subject: [PATCH 0/9] *** SUBJECT HERE ***

*** BLURB HERE ***

David Carlier (9):
  Enabling BSD symbols.
  Enabling *pty api
  Checking mlockall symbol presence.
  Checking sys/signal.h presence.
  Define SIGIO constant with SIGPOLL equivalence,
  Including endian.h for bswap operations.
  Skipping drm build, unsupported.
  Skipping sys/syscall.h inclusion as only used in qemu_signalfd anyway.
  Implementing qemu_init_exec_dir.

 configure                   | 36 ++++++++++++++++++++++++++++++++++--
 hw/xen/xen-legacy-backend.c |  1 -
 include/qemu/bswap.h        |  2 ++
 include/qemu/osdep.h        |  6 +++++-
 os-posix.c                  |  4 ++++
 util/Makefile.objs          |  2 +-
 util/compatfd.c             |  2 ++
 util/oslib-posix.c          | 20 +++++++++++++++++++-
 util/qemu-openpty.c         |  2 +-
 9 files changed, 68 insertions(+), 7 deletions(-)

-- 
2.26.0


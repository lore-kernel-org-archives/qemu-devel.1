Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F0C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF054238E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwPbkHmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF054238E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOoS-0001Dk-Tp
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhX-0004Rd-Ig
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhQ-0007OF-09
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A0P7UnhCzybN9pds7m9xqtgc4CEwYReNmOJhDlKVEug=;
 b=RwPbkHmYtTjGaxDkP0AIoJFHQvlkKh4kzQRIOchQl9CLOE8MGc+n+swBQAzh225gSYAqO6
 tkq36RNwUfNmCDTDQpDDO4oEPP3gKN+SlMbpyI3PV7RGN+hNYn+svgU1UNfDx2oopUOGUl
 YqOAulEJW2v8nieuAN7tdaB2tfaRT+Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-hIR0e-EXM8-irzkDxjBYhA-1; Mon, 21 Sep 2020 12:29:52 -0400
X-MC-Unique: hIR0e-EXM8-irzkDxjBYhA-1
Received: by mail-wm1-f70.google.com with SMTP id b20so170616wmj.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A0P7UnhCzybN9pds7m9xqtgc4CEwYReNmOJhDlKVEug=;
 b=Q8QKXN66e1kzG8qg13kIRlU9B+28Skprynu8AO+KC1XMfJJ7B5LeFAaedJ4zQJrCGy
 znLwcI29Y/Foy9sELoTHa8YNz7c30q0uyO9irR6WjSt8HWvkTujfNdzFE25EW83QhMmA
 W5KztQE7kC7k0Fg7flhhLqNYApjrfeP+2z1KYpD+upLbaYCubP5SUcsfXRtuEKYSTug5
 LiCUw+9cik44dd9GqGVqahdw81INOOVcg/B+tObIVzKjUM957Eeg5QPdQrt0dja6KQed
 0BGLO+7v3yclyElgzWdOrN56YPoMnyb8bQ+4DDGoLw67HCQEwBBhY2iuL1ErrRbwmIY2
 WONg==
X-Gm-Message-State: AOAM530DFLEpIPw+lKTA+/vZtdTg+yrs1DQDAOelsXCWpJJ7T6tl5Yd9
 6kJy7KLHLAi3jPrxw6TJ+9dSjYpv5QnO4qjfeJlF6O+SUbTZ/Uv5odLmxuZbPS+YDF/MIP/hx/+
 ZR6SGppzO3OauPUo=
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr576407wrw.378.1600705791221; 
 Mon, 21 Sep 2020 09:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7h56LjbiNs0twU8+qpdPav20F1l5Yiuj66XVaxT9ewuUVHGGlYJgnUfQ4lTYRi9udPgoSGw==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr576382wrw.378.1600705790873; 
 Mon, 21 Sep 2020 09:29:50 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y5sm158055wmg.21.2020.09.21.09.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:29:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] block/nvme: Map doorbells pages write-only, remove magic
 from nvme_init
Date: Mon, 21 Sep 2020 18:29:43 +0200
Message-Id: <20200921162949.553863-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of mapping 8K of I/O + doorbells as RW during the whole
execution, maps I/O temporarly at init, and map doorbells WO.

Replace various magic values by slighly more explicit macros from
"block/nvme.h".

Philippe Mathieu-Daudé (6):
  util/vfio-helpers: Pass page protections to qemu_vfio_pci_map_bar()
  block/nvme: Map doorbells pages write-only
  block/nvme: Reduce I/O registers scope
  block/nvme: Drop NVMeRegs structure, directly use NvmeBar
  block/nvme: Use register definitions from 'block/nvme.h'
  block/nvme: Replace magic value by SCALE_MS definition

 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                | 73 +++++++++++++++++++++----------------
 util/vfio-helpers.c         |  4 +-
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.26.2



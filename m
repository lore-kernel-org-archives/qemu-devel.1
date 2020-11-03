Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F28C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B042022243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXn4LmLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B042022243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlr7-0007Q6-DT
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljj-0001sZ-UG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljY-0003Yu-Rg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UNTQy5SDYPPLuyVLdXXbAU1oGT3Kn/JCtLpzCg+Pi90=;
 b=iXn4LmLyxX50mq1Xr/KZgM7orXPipUmiCiE3khUvjkRukFMPU9+x2K/QflVCu2dIoxyKFL
 ToZuE4DYMUJH1aDjjyYMaI822n5d9x0eLP8aOSQZcN56X6ty3Y6/DnzZF2uUQ7SmNgmVsQ
 AfZX+j5UirMtB2kJhuJynrJm43B7T/s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-fi54bxP5Mo-ZpFgnu8xkYw-1; Mon, 02 Nov 2020 21:07:37 -0500
X-MC-Unique: fi54bxP5Mo-ZpFgnu8xkYw-1
Received: by mail-wr1-f71.google.com with SMTP id u1so4945883wri.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OSjmPQQZh9zVsuDlJUw7DQSDgx+s5QDnJ4lWNVN/ZkM=;
 b=M3vyc2b1+QWV3tvK9iVoAL/atByUh1EEaOSjC/DiCLsJtUNyoDkhjmuFdEueBJjUZY
 KRudIq9soIWa3uyZ/CnKM++I1nwPASRzXHFcOxxFz7XkxvbFrzBM1EEXdioZbmB7/PhG
 fJIeA5YFfQGwzPEvD6/ypNzqLkUC9Gv6IJ7BCZTeycb4yK5rb6l3JtzPCa2oFEZI0PPg
 FV6pTvWgSazJoabBPv+4P6EuK6iXEWWShqj9+d6bokPO5SIKBfu82uwkO+pscVyRUtM6
 E6qGiTprOL1Z+nzBlFdoHr2JHF9oQTFqhHEdrxkLMY7KtMC5hiKQjMmt/N5NoLt5VFt7
 iLhA==
X-Gm-Message-State: AOAM530MKyDX2BLPQRegSI12rA62xdJPcOtv/4I0XaqUnCNwlB2TFKBX
 t4w5ymPhKvJhoL0EX8NWKlGOCucBKlefwEsI7srYFFkwotNTb65TtLvoitrJT5bNVHRhCF16qw9
 r/TjSxCKA6uITVdQ=
X-Received: by 2002:adf:bb07:: with SMTP id r7mr24725956wrg.150.1604369256533; 
 Mon, 02 Nov 2020 18:07:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU8tX6I6cp62PMaN6FVsu24xlKYBuFj4iHxIfvfGBx8aSqQPVk9Hvf1nez2lwLYMy+mV7CMQ==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr24725932wrg.150.1604369256264; 
 Mon, 02 Nov 2020 18:07:36 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y4sm1218479wmj.2.2020.11.02.18.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:07:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 0/7] util/vfio-helpers: Generic code strengthening
Date: Tue,  3 Nov 2020 03:07:26 +0100
Message-Id: <20201103020733.2303148-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:=0D
- Extract reviewed patches from=0D
  "util/vfio-helpers: Allow using multiple MSIX IRQs"=0D
- Added "Assert offset is aligned to page size"=0D
  which would have helped debugging:=0D
  "block/nvme: Fix use of write-only doorbells page on Aarch64 arch"=0D
=0D
Missing review: 7=0D
=0D
Based-on: <20201029093306.1063879-1-philmd@redhat.com>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (7):=0D
  util/vfio-helpers: Improve reporting unsupported IOMMU type=0D
  util/vfio-helpers: Trace PCI I/O config accesses=0D
  util/vfio-helpers: Trace PCI BAR region info=0D
  util/vfio-helpers: Trace where BARs are mapped=0D
  util/vfio-helpers: Improve DMA trace events=0D
  util/vfio-helpers: Convert vfio_dump_mapping to trace events=0D
  util/vfio-helpers: Assert offset is aligned to page size=0D
=0D
 util/vfio-helpers.c | 43 ++++++++++++++++++++++++++-----------------=0D
 util/trace-events   | 10 ++++++++--=0D
 2 files changed, 34 insertions(+), 19 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D



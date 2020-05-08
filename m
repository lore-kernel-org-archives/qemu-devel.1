Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B93C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5904A20708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK/MlbsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5904A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwSY-0007Qs-Gs
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRU-00067Q-HO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRT-0000rp-QM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iHeGHQ3CjfamZeouPv/1W6zmvc4lyJbZtZlNXRjWXV8=;
 b=LK/MlbsTRCe4MXrtTl8NiZhNij8teXH1/wjAkxyLgaXFGLwrx+5TqmwUISomYUIGf2ghO2
 hef4iY4FjmYh5o6lZyAjSVS2YbHjh0TejlEZnIYtoVXxhq5cGNwPVTZE1QcUbzMvBe64VW
 kiDXhZpi2V94wwqVvnEYmSsvB9A9Q8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-1d0mIDAFMvOjS8AXGkJ-og-1; Fri, 08 May 2020 02:25:01 -0400
X-MC-Unique: 1d0mIDAFMvOjS8AXGkJ-og-1
Received: by mail-wr1-f70.google.com with SMTP id a3so403737wro.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 23:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xyc0Czgga+Rr4c6WxR1kGKetMFvmJEzyEAhcB0IsToE=;
 b=TA/i4tAaCr4Jl8HQ5Edfzg2gjnPftFPE/2Z6Oj7Y4hPqE3luILa56Ll5lnD4sSX1Zd
 udrsDeyDSrYAlHmonffXlJFivF7vAeAo/BQOFAEROzWQjJKvy5dTBM3/7dGjR7O3Avfk
 R8rQFUHQiv0PYW0SFCxhgW5PoYXqT0QkCP/iLyP1BTgkr2CWEXxHjimUlu1abuL1URgF
 bSdcB9TlZHNZ0QQKEM00/vZMgdqGvIPSVil0b5uBE5Cz94oOv36Y0lVBMopfaTOEO4Ef
 RJxTORpaib1N7TrLoqhkudKNU/Pk/SdAptDf52q8jEKQAATZOFalzdzlYwANw0ZBJ9vo
 +3OA==
X-Gm-Message-State: AGi0PuaBmIyFAWHfbIwuUmeIK+dju+a5lR/zpk6z+Yn6rZ/KoEUFZsm2
 P2aTBJQgUQfOy2NljyOvKn96ckt/qIUmW69M/uS5vp2wtDxY1vXen56NnSGpADVXCs0T/yF5tnP
 U1dkhA3wAr0qCNTo=
X-Received: by 2002:a7b:c147:: with SMTP id z7mr15296014wmi.52.1588919099973; 
 Thu, 07 May 2020 23:24:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLnEe3H3LcVeithwji8aLeepTr7xRFarwz7OvQpZL9N5GP1KgHkWCQD77Ujm5ctdozvRG2/zQ==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr15295978wmi.52.1588919099654; 
 Thu, 07 May 2020 23:24:59 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id i1sm1278619wrx.22.2020.05.07.23.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 23:24:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe emulated
 device generic
Date: Fri,  8 May 2020 08:24:52 +0200
Message-Id: <20200508062456.23344-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the NVMe emulated device be target-agnostic.

It is not clear if dccvap_writefn() really needs
memory_region_writeback() or could use memory_region_msync().

Philippe Mathieu-Daud=C3=A9 (4):
  memory: Rename memory_region_do_writeback -> memory_region_writeback
  memory: Extract memory_region_msync() from memory_region_writeback()
  hw/block: Let the NVMe emulated device be target-agnostic
  exec: Rename qemu_ram_writeback() as qemu_ram_msync()

 include/exec/memory.h   | 15 +++++++++++++--
 include/exec/ram_addr.h |  4 ++--
 exec.c                  |  2 +-
 hw/block/nvme.c         |  6 ++----
 memory.c                | 12 +++++++++---
 target/arm/helper.c     |  2 +-
 hw/block/Makefile.objs  |  2 +-
 7 files changed, 29 insertions(+), 14 deletions(-)

--=20
2.21.3



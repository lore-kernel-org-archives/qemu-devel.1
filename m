Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F82C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6D72078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWjYsRTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGbS-0006FE-Ap
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGaT-0004aK-4h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:01:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGaQ-0001iS-Sq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y1vGmD/fvsXEOWa6wkRKs3aLydzIceOGg7Tbh5f+UXQ=;
 b=GWjYsRTrA+NnxLIECRMVdbYv0rX9n/OjSIMEmuL36MAooVd+C2d5d/Mmtc20YCUQh2dHe7
 uznluxpwZIPTOi4BwtjK7RhVkJ3zwmoGwPkbZO7xGDBqfqJ0ZTZzX53Q4BH1W0hQ2kH9Uy
 //26XvyVJxHD7EUN7bpJLF09yCgSWwo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-TV7NNE7GM3SmpBB4nZHg7A-1; Thu, 10 Sep 2020 03:01:36 -0400
X-MC-Unique: TV7NNE7GM3SmpBB4nZHg7A-1
Received: by mail-wm1-f69.google.com with SMTP id g79so551338wmg.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y1vGmD/fvsXEOWa6wkRKs3aLydzIceOGg7Tbh5f+UXQ=;
 b=GMfDkTWKeEB5mdqgAh9H6kUwRPtHMBYXZwFSvLnneMajRZOtzovLZw3p5XtYzPhloi
 A4H974sHcIQD0D1bwfJsuV/WPBCJVRQltqO6hBfXCNDjNVkmVUTVD0Lk8YVilGG61zhD
 t13G0F9o4jN7DUAAJ2fm2j0Nyr2gIZqZbWV61nwN1opHJweVTIrKOhnno8znsEsPgnbA
 lk3k+wjqLqMy9cBC8fhEsheWtX9dv5p8ZHVJtEkBipSQKCTt+bZTkEyj6Efq8bs8rWk3
 DSRiQ4ec9vd1hF9sELhLsBPi+/Hayf4KbsPTEvoRH5xpD4W1+snNrS/Dm0JOw6EYcdAy
 2UNQ==
X-Gm-Message-State: AOAM532VFq81t2YiTkjbunIUQ3ibkZTKQRV9fVpDLlPya2KL/uk4HjM9
 nd+jIhytkvBRUy2XZhp6cYyLCHIvrHjZu5PIk0LWcBU2+OvMnSpN0CdOHTnyUbltux+5xB5X+U5
 VkdWcamcHm21FEnc=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr7037172wrp.332.1599721294486; 
 Thu, 10 Sep 2020 00:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOgVJywoHM/rmr+qzXsusn/6m5n3bTGfi1VzgpHQxefWx1TwErPpn8kQ+0ho5qhfDSLK+sVw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr7037127wrp.332.1599721294215; 
 Thu, 10 Sep 2020 00:01:34 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c14sm7314726wrv.12.2020.09.10.00.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:01:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] misc: Some inclusive terminology changes
Date: Thu, 10 Sep 2020 09:01:25 +0200
Message-Id: <20200910070131.435543-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't have (yet?) inclusive terminology guidelines,
but the PCI hole memory is not "black", the DMA sources
don't stream to "slaves", and there isn't really a TSX
"black" list, we only check for broken fields.

As this terms can be considered offensive, and changing
them is a no-brain operation, simply do it.

Philippe Mathieu-Daudé (6):
  hw/ssi/aspeed_smc: Rename max_slaves as max_devices
  hw/core/stream: Rename StreamSlave as StreamSink
  hw/dma/xilinx_axidma: Rename StreamSlave as StreamSink
  hw/net/xilinx_axienet: Rename StreamSlave as StreamSink
  hw/pci-host/q35: Rename PCI 'black hole as '(memory) hole'
  target/i386/kvm: Rename host_tsx_blacklisted() as host_tsx_broken()

 include/hw/pci-host/q35.h     |  4 +--
 include/hw/ssi/aspeed_smc.h   |  2 +-
 include/hw/ssi/xilinx_spips.h |  2 +-
 include/hw/stream.h           | 46 +++++++++++++--------------
 hw/core/stream.c              | 20 ++++++------
 hw/dma/xilinx_axidma.c        | 58 +++++++++++++++++------------------
 hw/net/xilinx_axienet.c       | 44 +++++++++++++-------------
 hw/pci-host/q35.c             | 38 +++++++++++------------
 hw/ssi/aspeed_smc.c           | 40 ++++++++++++------------
 hw/ssi/xilinx_spips.c         |  2 +-
 target/i386/kvm.c             |  4 +--
 tests/qtest/q35-test.c        |  2 +-
 12 files changed, 131 insertions(+), 131 deletions(-)

-- 
2.26.2



Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4198C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D372B2184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+r6GNrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D372B2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQa2x-00075X-NM
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa1Y-0005h8-D8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQa1U-0003KD-KS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MeHSPirPXsHxU4y+2oaf1A36RDYhuNCiinC6MS1TIxg=;
 b=X+r6GNrp4+6EWr7z2EaOjlnYSX9X5MAmB/hkj0bmpIjCDD8n+LjONPgd47PXX2+bdLaYzu
 rPx89ZL/QkI4Wp74VGFYn1+Qh/f5nk3LqbxXpoKsCVjTyIXVJ2F25Z/1sHf/PDFPomklng
 rttmI4l/xUFnoPTVTQayDD728PcsirE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-cVMsqJlbNAuD8GsNfmyXMw-1; Thu, 08 Oct 2020 13:48:07 -0400
X-MC-Unique: cVMsqJlbNAuD8GsNfmyXMw-1
Received: by mail-wr1-f69.google.com with SMTP id 47so4154410wrc.19
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MeHSPirPXsHxU4y+2oaf1A36RDYhuNCiinC6MS1TIxg=;
 b=lew2G4FmL3u4SbZUBD9C0/30usSmRhCKQVuytzhlkVOGtn5bJVTJQxx5kC7Tbw5chC
 T0kqkm2O1QUxM4zQvZPJbSNPclWohoyO7asr0LeeOtG+i03vmNxfqrnIVjeqJ7nc+v0N
 ci4BY5rHP9XAH2l3lkY+mPsJ8ICYCaao/8748LbyhzisvI/D3UBRiGX5KJf2eHoaPTll
 K4GztHXXCTPAHQkwf7nLN9V2iBtDiQTAJ1fxRDPc4Do7nz7n7U3PMMiPPtiGFSA8T/bf
 ngiS7F4nK7EpEgm/7Xn44l+CjEF4Mm5o9/7MHTMGN3YKbezDCn83nPFvUVq7OPYX+Iqj
 fyQg==
X-Gm-Message-State: AOAM533Ni/5ChMws/RWsZtLYwNZn3y74KW0MnrRuu+UVhnpwB7e6ZWTD
 BqA5OBylDqciU+818Bq0A/MqPt3jA0QBk9ZmepRQj/8dWsHp0HlDAg9zGJJlJ/S1xt2k93Efyur
 oMjlRem6vv9bXSIg=
X-Received: by 2002:adf:9504:: with SMTP id 4mr11128355wrs.27.1602179285503;
 Thu, 08 Oct 2020 10:48:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCGjZ7arffDgo9HpLoAr2AittBAPG2v1iwQHfSyKc5tdu3Wd9Rs4TMJsxsZ/mSMpfikw7WTQ==
X-Received: by 2002:adf:9504:: with SMTP id 4mr11128335wrs.27.1602179285298;
 Thu, 08 Oct 2020 10:48:05 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i14sm9228847wro.96.2020.10.08.10.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:48:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] migration: Make save/load_snapshot() return boolean
Date: Thu,  8 Oct 2020 19:48:00 +0200
Message-Id: <20201008174803.2696619-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had a pair of patches making save_snapshot/load_snapshot()
return a boolean (like Markus recent qdev/QOM cleanup), then
realized Daniel already has series changing migration/, so I
rebased my patches in the first part of his v6 series:
"migration: bring improved savevm/loadvm/delvm to QMP"
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02158.html

I included patch #1/#3 from Daniel, #2 is my first patch,
and my second patch is squashed with Daniel's #3.

Daniel if you find these patches worthwhile, please consider them
while merging your series (or respining).

Regards,

Phil.

Daniel P. Berrangé (2):
  block: push error reporting into bdrv_all_*_snapshot functions
  migration: stop returning errno from load_snapshot()

Philippe Mathieu-Daudé (1):
  migration: Make save_snapshot() return bool, not 0/-1

 include/block/snapshot.h       | 14 +++----
 include/migration/snapshot.h   | 18 +++++++-
 block/monitor/block-hmp-cmds.c |  7 ++--
 block/snapshot.c               | 77 +++++++++++++++++-----------------
 migration/savevm.c             | 72 ++++++++++++-------------------
 monitor/hmp-cmds.c             |  9 +---
 replay/replay-debugging.c      |  6 +--
 replay/replay-snapshot.c       |  4 +-
 softmmu/vl.c                   |  2 +-
 tests/qemu-iotests/267.out     | 10 ++---
 10 files changed, 105 insertions(+), 114 deletions(-)

-- 
2.26.2



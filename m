Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E8C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F298721955
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ty1LAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F298721955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpb03-0005Ov-NT
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazk-0004de-Os
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazj-0006Ok-Ou
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hpazj-0006Mr-GD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:16:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so40091905wrm.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xlqBr8P9Gl3u7pZYDuzWptS0KZ5a7pEirokHb9KS5ak=;
 b=T/ty1LAHWrH/ydaWUpn24F4AEfxaQ/EUL4j483pS831hMVud6sNhRMTebfdd/ZIYGN
 BTJ60Csdy4olW1oFPu3EfDzZx20fcz30YzHj9LSG13LgGV3bWtwhOwr0YcR2WG03fvZg
 bGbT8SxxgmiJbPmg11JmCN+FmI/m4IX7u0ej4c/26TP7DGd6IwMQKqRsEGiIXETV+dlE
 S7+kTfL19IER+EMEGtXravaM2aPzixeQCB/BQJIqV/uWMelzXBIh+/fbBuCU08jS9vBQ
 eZ98yTJ5RxkLx3Vh69uY3xy5cF3bOhtbswoUeQsXMN8Ga0/dwzKueh9l687kMpwxcNCj
 gf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xlqBr8P9Gl3u7pZYDuzWptS0KZ5a7pEirokHb9KS5ak=;
 b=gR4gLCBZpFPw4NmNnVZYVky+5w0/CgJmTSw6kgDRVmlAvFpc8sNXYjO2CaRed9SdoK
 kazC+XA0etxXmb7XPn8dsRZ4rRktx35zQMVq/eKG9S0qrw8syjSOcxxh6kxhbmloGMgI
 dre5ObKQsYJVMuEPZ5OqqW7qwBExv5gxFT1dEfIdRm2gqvCWUMPkpArOMvTZAuHJCoH5
 kxtC+YcVSrYhUHiFJJ/UTz0JMdxpYb8gUWQFWrLKD2VNlHlt1byaSys43puCjCkCU2ut
 VhYCmYft0+JlEnXo55oaN5a+/QZz7WRFWR7aXsGACXLBOf3iXfygWPo37LS3wD+PbkzV
 38xQ==
X-Gm-Message-State: APjAAAVUF4ySwvILJlvV7+Li+5VG2VLB/gkKlcCPpi0rGIGLOMp9vhe4
 ZqkfRyI/u7XX2M5t/0BD8lbEcm316jM=
X-Google-Smtp-Source: APXvYqzlqPZcvh2d6PimTZR4qh6pRK1YCKjBf1IZ//OUsQ1f/Gtv132bZhsan/WxogUGIq444ypmpg==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr37144042wrr.5.1563812217469;
 Mon, 22 Jul 2019 09:16:57 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id o6sm77717501wra.27.2019.07.22.09.16.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 09:16:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 18:16:55 +0200
Message-Id: <20190722161657.8188-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 0/2] More fixes for QEMU 4.1.0-rc2
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

The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 20b25d239ab7a94bb8bff3d0f13a9527ee75cf10:

  i386/kvm: Do not sync nested state during runtime (2019-07-22 18:16:05 +0200)

----------------------------------------------------------------
Two more bugfix patches that came in over the weekend.

----------------------------------------------------------------
Jan Kiszka (1):
      i386/kvm: Do not sync nested state during runtime

Zhengui li (1):
      virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching scsi disk

 hw/scsi/virtio-scsi.c |  6 ++++--
 target/i386/kvm.c     | 10 +++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)
-- 
2.21.0



Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B682073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+g9RmLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B682073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrSV-0008Nj-4w
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrRA-00078J-7v
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrR7-0003Sm-Uj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:31:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so2635495wme.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jQ063gRb+k0kRFIEhtvk0c6u6SkEl/yxDeuOTl/cjbw=;
 b=Y+g9RmLqucKl0h2t5EQw9i30or8w6PslylmsfNRNZr3524JxcbEzlqr7YX/deGUuMh
 0oV5qnG611vD37jTp/K1U7KPPxCM5igK7Ehz5+KMZltZ3ANF2aMSnPax2eAgFkm/fq0/
 RxROHEJ4OM83+pPZXNnfHNIWPNP6+SzHIfDGaNULWRzeu0qc2Ut/8XnkruceHgbhIKt3
 VwakkDPrjC3IFTKvGnFV0+VDA3FJ9D15lLGW0w7z6YiodNEVozTnhQBQ5cOAaUdlyRfQ
 3dh2lfitzl0zMO1U0Ep0giVZZWFna/hHW+3RnvlKDzi128XkWu6LHKn3pGL//m6PzF7i
 FUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jQ063gRb+k0kRFIEhtvk0c6u6SkEl/yxDeuOTl/cjbw=;
 b=DyWhug4y4X1GGdM8UvzitbLhljj2u8dxQxPcFDyuHgERQhOx++oAOa+Ab7K85qdvLM
 ZyKdG3TpUS54JD2IzBZ6oblcdpbPzENTTZbn45L5Jkzu2Ly2+HVmojP5j99IfihB03Rw
 nzt+ugQksxRDLtgMiY5ohM3UAwFphSfQeqDBgK55qe6lirf/c8eymEG/hTmsPWgiQ2us
 NXvXxfp33tzRIU3jLE1DONevXcd/fQE7nTE347gsrcYcUTqR+nEQ5k5/UfdJNlZwjBxI
 ljK1WuMy2ZKxknwxdtU9gxjxhFNrAbD/o84u1VjMEenJuFly2x5w3jW5Wrt2BKEKoYC6
 CNig==
X-Gm-Message-State: AOAM531LA8SudhLdXDb4IBF6d/TYZXaPZTBchGprPb5Kgt8P8P0f7yW8
 NhRrb6ILtxKN76yVLGRzojNVwn8X71U=
X-Google-Smtp-Source: ABdhPJxvEqF0skxbC756qz0ny3Wu3s+wGJimKvilz66lbA6PM7xetobeWEGv0Fi2XUTyvN5fLcsBdw==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr3861121wmz.124.1595334716301; 
 Tue, 21 Jul 2020 05:31:56 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s15sm3523323wmj.41.2020.07.21.05.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:31:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1? v3 0/2] hw/isa: Allow 8/16/32 bit access on ISA
 bus after CVE-2020-13754 fix
Date: Tue, 21 Jul 2020 14:31:52 +0200
Message-Id: <20200721123154.5302-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Surgical attempt to fix the issue, as we are in freeze...

If such kludge is tolerable, it must be reverted first thing
after release.

Fixes:
- https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
- https://bugs.debian.org/964793
- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
- https://bugs.launchpad.net/bugs/1886318

Philippe Mathieu-Daudé (2):
  memory: Allow monkey-patching MemoryRegion access sizes
  hw/isa/isa-bus: Ensure ISA I/O regions are 8/16/32-bit accessible

 include/exec/memory.h |  7 ++++++-
 hw/isa/isa-bus.c      | 14 ++++++++++++++
 softmmu/memory.c      | 12 ++++++++----
 3 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.21.3



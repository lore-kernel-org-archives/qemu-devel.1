Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB96EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84293206F1
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMg7VBZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84293206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUxhj-0000Bd-Je
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jUxf0-0005N6-Cl
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jUxez-00075i-Nx
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jUxez-00072I-BX
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id r26so4058226wmh.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HUD0SuMNa88xB0dJSQbDHE1GElfranAIV2uPm//UqC4=;
 b=eMg7VBZG7+/OuFPTjkIGVoWOTDxUis75YQW9O7BvkrNt8HgFzB3aC4o+6XdLEe5Ql0
 jPIY6VYr1rxY39vO3jXf3j+0z1nIgz26dCgTTEfheHiDe4QZ4ilOIfDnDZFcUzTczXtv
 upMRWsSbOXL8fOcdRtI0Yr4avWPBEwCe6tCUe4maeD4+KMWscsIYIqiMUUZLL1ldIjE0
 BoJ8qzcW+jJdfLtlS+pFdxdWLBi0Ovq0JW7N161FVV74/ujRMGSNz00eMUTLD7TCsR1N
 9Qk0ONXMtspd4tRgytPUb/RcsdtC56Ds8eMxu3XNAWJitBWb+KrNMJ6ixe2jhHTQ84Ld
 s5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HUD0SuMNa88xB0dJSQbDHE1GElfranAIV2uPm//UqC4=;
 b=qoZwCsPxFA37jNdnBKVt7cIxQrMIkZ+u8GBsg9cdjm2DaHlcJQcq2deE5s5iWu5yQT
 OMCITBFMgrxj+IwBkvF+vo+HMIDKvWf+RNtNlsyIQRMkhPsltOUFjgMXhprwb6bB5W1A
 2p2T9os/BjqTTQWZ+4QuFh1eBxiHZ4fKBN+dHPVjTEmexUJCoGBH1zzSRl8tSfE76rxM
 W7hzBkhRScq3BKaxN5eAh+pu02vOWxL5XmhzoMB8euhvtkPn5QZsa4PGZGCLK2BqIiQF
 89eIYPoSBtv6GQaxkdJ7irooItdOPhfFuZ/FNNxUvJ9YghU8N2hySMceKNpdBLaQhE34
 u0yQ==
X-Gm-Message-State: AGi0PubVVTttntYjMF6DnAmQkgsM4oKffakzPiYB1kmLPjper3t21+8J
 VgP7SL2QuK6GXT33yyf9d5uQV7mhYc4=
X-Google-Smtp-Source: APiQypK7HiAL7Jsq38dcHjVqaSoLnRWXlVuAdg7xdnHDG9KSwLgsHtPMkq2ixAKPxUkIQlwFS3LCEQ==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr6239056wmf.189.1588447125728; 
 Sat, 02 May 2020 12:18:45 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id k23sm5378441wmi.46.2020.05.02.12.18.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 02 May 2020 12:18:45 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PULL 0/1] RDMA queue
Date: Sat,  2 May 2020 22:18:41 +0300
Message-Id: <20200502191842.27250-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::332
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
Cc: yuval.shaia.ml@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a308ec7:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-04-30 19:25:41 +0100)

are available in the Git repository at:

  https://github.com/marcel-apf/qemu tags/rdma-pull-request

for you to fetch changes up to a5cde048e865da81fdc9077f3af28a43bff78d35:

  hw/rdma: Destroy list mutex when list is destroyed (2020-05-02 21:31:17 +0300)

----------------------------------------------------------------
RDMA queue

* hw/rdma: Destroy list mutex when list is destroyed

----------------------------------------------------------------
Yuval Shaia (1):
      hw/rdma: Destroy list mutex when list is destroyed

 hw/rdma/rdma_utils.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.2



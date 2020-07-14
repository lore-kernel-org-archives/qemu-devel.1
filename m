Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4CBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADABF20656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlDMNOG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADABF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO2m-0003nB-Uf
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1G-00010C-Kw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1F-0006o0-AV
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so23004033wrs.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y2dIkhXwauk37xMdhkkJ9e/ItFEhGU6WfFRBFAYlpdc=;
 b=KlDMNOG7zyZqOz2OyZSfsvJe/7ILG+uCV9+h5A3S9B0ejtYkAyy8c/XWAhbZQchX1E
 3kPvUpYDsPqSYxf0DuIBn5YzM6xOFid/V1dVif285KVI0S2LEW12UlBKZ7Y1q081VsiG
 XcL0BVLQ+op3o3q2jk8bkAtQa6lG6wE60DdakIE1okp/pIA8BxXrKLiuu53WLFc0gw87
 3ci6KVPJqQ5itAg/n5R79s2fbuCtRSN/SLGNE9SJeK7ke966X6LkTo8ofehpDsktyrkZ
 F1zTk/rqerrG/NsXS/Rz7by+UrMwN6XVyU+l+m2UHVIUjEcfKQtoKTJdEzr1Jw3EWUhl
 Pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Y2dIkhXwauk37xMdhkkJ9e/ItFEhGU6WfFRBFAYlpdc=;
 b=mI/MIAUAbzPzEQLSnkyk9E2E3V3Uz7UZty0tPWiRrgHJ1xdgA7a8TyFqafJ8Hglrfm
 +maqJdQ5ffyY6Y6Mtse4eiCAryyCDiVAKnMJZ70cvRKJS8/P/393aK7YQhIfLxkpuSlZ
 W4emMn1LOWxRhGYbSFAblImsr6MJyPDqTgbNCkLZQjCIerfuufu5usXis/r2hBUBl4L1
 MuPnxV6eh9MfULwEXNCMlxNRY0N2GjZ2whYQszsZ/kymHA6W9llBPhg96RVjjUS9vCas
 8omVP6IReIy/b+yxZKMRJFzpXFSX43Blun1MQzCQcR8T+8CZxYvU4A8elopUTHCTfGOn
 0L0A==
X-Gm-Message-State: AOAM531VCMr2stHaY2ldLdb7pDyOfbxNRFQWBze2Q3RSFHN/Lv+YRUfe
 AtL4BkgqC9xK0ZpPOQiArbToYlR5KFc=
X-Google-Smtp-Source: ABdhPJyN9cm7+VfZOnuJcjWA1Xbog7OLpdEYNGT63Ckh5Jv24zRPXLHmnA5+lrInv/njop3eKiCxSg==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr7454942wrq.0.1594744979283;
 Tue, 14 Jul 2020 09:42:59 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm6474380wmb.1.2020.07.14.09.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:42:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 0/4] misc: Document qemu_find_file and fix memory leak
 in avr_load_firmware
Date: Tue, 14 Jul 2020 18:42:53 +0200
Message-Id: <20200714164257.23330-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the memory leak reported by Coverity (CID 1430449).

Philippe Mathieu-Daudé (4):
  qemu/osdep: Document os_find_datadir() return value
  qemu/osdep: Reword qemu_get_exec_dir() documentation
  qemu-common: Document qemu_find_file()
  hw/avr/boot: Fix memory leak in avr_load_firmware()

 include/qemu-common.h | 14 ++++++++++++++
 include/qemu/osdep.h  |  5 ++++-
 hw/avr/boot.c         |  2 +-
 os-posix.c            |  3 +++
 os-win32.c            |  7 ++++++-
 5 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.21.3



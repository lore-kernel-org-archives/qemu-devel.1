Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA44C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D900F2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoLQfk9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D900F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNOU-0005rs-2N
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNi-0004Xc-Hr
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:50 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNNh-0008M2-1a
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:04:50 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np15so7734748pjb.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0fj+9OSIzqOgrjYudjKKmObziku4vlYOK5JBdWSngHU=;
 b=WoLQfk9J3rb+xuksyX5wkc16U12BQ5udCw5borsjy4Ust+iAHfdHRMtNPAcu3HU2xh
 EO8ENf2hPF+kJiI8v4vX846bUGrJ6BIEefnVMsCL50vSPfGE6K+knZkxoeu8BK5QQPq/
 5/dnhab/LIyQFGE/vIhstBvelPvVP84iijOlXzPGIRQ0u9S4vbUJ+2aGti3O38FtUerG
 a3uvRbnXe4WYdBeWMc+e7TJpdfrKwaWQNYmOwtsytlCBiHPbf6TMGgcgafrxLJq85wLr
 e+T1IrcTdH3VwTHQkjstnUq0gj+ng+E4XAx75ibpdfvaHSST879iLubXcGmfTrzPNPE6
 Kbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0fj+9OSIzqOgrjYudjKKmObziku4vlYOK5JBdWSngHU=;
 b=BLLSXlDhMZHanAOeXO1jhwvLEEgashlK7HRVwU4eUPLtMvdnUAnf7aHB83FzTWma5h
 cs2KUg+cjiEjyOy+NEMr8rnW+DfCFsLcXjIam55vyncxuF3E2Wg634LAawQS6EI6Cs4m
 FgV3P33jY8F1wTTQ2zzMaFR4TR+MyvtKIgSR6zz+FXCbGWLfSLyX0X3xQZ9xHZIsusBX
 NlDWj2FmkkIOSxFWMyIZ9WGjj0k6WThqops85qTuT4v+VgXxODY8LoqaAS7J8zQshzOQ
 7mW5mXm/ZKcArzWxFN1greIhmMCTfgqQYALqUK+c2eHPUuUw4ddv69R2bflpkepFXdCj
 liqw==
X-Gm-Message-State: AOAM5330Tl1uQ366mEHYAxZS7vubheTYmcdOIDl9g8fwMpwuvassH7hR
 uenAMBTshsfc2JoHACVL5/vmzWgTkkYwMVsW
X-Google-Smtp-Source: ABdhPJynxlTYp4cfzasxXAqDNQeLW+fwK1AgqFLSpS+on81ObNg0zH5iY6S7PGr7BkDY7PLXpdlNsQ==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr764726pjv.179.1599509087216; 
 Mon, 07 Sep 2020 13:04:47 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 204sm8713098pfc.200.2020.09.07.13.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 13:04:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Misc meson fixes along test-vmstate fixes
Date: Tue,  8 Sep 2020 04:04:28 +0800
Message-Id: <20200907200432.2418-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=E8=8C=85?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test-vmstate can be passed under win32 too=0D
so enable it on win32,=0D
This is based on Bonzini's upstream tag along=0D
=0D
Yonggang Luo (4):=0D
  meson: remove empty else and duplicated gio deps=0D
  meson: Disable test-char on  msys2/mingw for fixing tests stuck=0D
  vmstate: Fixes test-vmstate.c on msys2/mingw=0D
  vmstate: Enable test-vmstate on msys2/win32=0D
=0D
 meson.build          |  6 ------=0D
 tests/meson.build    | 11 +++++++----=0D
 tests/test-vmstate.c |  2 +-=0D
 3 files changed, 8 insertions(+), 11 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


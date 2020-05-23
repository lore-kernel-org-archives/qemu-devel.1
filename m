Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517ABC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1230B2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGyC1SWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1230B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcZcx-00082J-82
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 15:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcA-0006mE-UV
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcA-0000aA-8C
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so13592922wru.0
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZDaUtNNctqDAyC9eXZ5DKRMbv6GEwxHReQkMLXjljqw=;
 b=bGyC1SWrLeChB34M4JtTzNZUyeDkMTEiGk/cGjf0B+gYvHCuIeGv+L+2o4Krbz3RyM
 JLiqU6S4WUTvjrt7wu5d3Sk9LtSelnTlHNtZgiJIBUglei4PKpfjfL8iV3ypOw2CoJrs
 oJb69Hzb1KG0bSZgz9pwCpXPz2hj3seYvoT/J2+iNZZbTcSQexxPLFadqjVKnBt/wp0e
 tIwHZbPXI4trUaM23rNUJ6/exE9/Kx6O+nEAvodM3KiCmAO7/GJmC3M/YVD8kfYzniaE
 uKGP1reajl1hNRoZ4Gu8yZeXPYrS1VU+0cA1ZTL5IvUcmLbgmM72QeXE6LZjjaJDlbMj
 /+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZDaUtNNctqDAyC9eXZ5DKRMbv6GEwxHReQkMLXjljqw=;
 b=ivoWkdf3gnBsXAB6ROxYHJ/E8GqThtBz8C2ROo5JHkeLQUvwL7kJHNoQe4hYD2wQCs
 euP2K2ZfYcKRbyFrLHut/s6m1KizWCrPLrjVd57L+d00SpSYqtlIDohvJC0QIcGRJSK4
 nG9o2fScev9wghGtNJNPZqPVQYdzr8l2ZPo+F13ECUaf/V+2C7qMp4Qms2r0AsVSYACd
 6gnYQEIiPbym4umiBZqPtQyAvFsFKcOSoIMSIbMUAaphfYdpTxVVBBFHeDY/x9JNQ4JD
 yAMdOU1QyuuMGxeynsWXXi0E+wBjjE/enymvxSRzcZVIobzLnj7dApJSff5EsVDQXRXI
 3jlg==
X-Gm-Message-State: AOAM533kB0HL1diedKdJbhuXfm95uAcV/6Ygmny0YJoqHkMtxZ9Tmrhm
 lLYcA+5ZJR4I6t+ulBzBF9o=
X-Google-Smtp-Source: ABdhPJwtq0mbf91XNL2HUXtMVBrDFOhMYqn1jHg3G2iqWpMiIBGsLxOttXMdbBfndgMMuz6vJwad4w==
X-Received: by 2002:a05:6000:47:: with SMTP id
 k7mr7748651wrx.233.1590261320720; 
 Sat, 23 May 2020 12:15:20 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y185sm13370681wmy.11.2020.05.23.12.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 12:15:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/3] hw/display/artist: Fix out-of-buffer accesses found while
 fuzzing
Date: Sat, 23 May 2020 21:15:14 +0200
Message-Id: <20200523191517.23684-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix various out-of-range buffer access in the artist device
emulation. Bugs found using libFuzzer (docs/devel/fuzzing.txt).

Philippe Mathieu-Daudé (3):
  hw/display/artist: Check offset in draw_line to avoid buffer over-run
  hw/display/artist: Refactor artist_rop8() to avoid buffer over-run
  hw/display/artist: Check offset in block_move to avoid buffer
    over-read

 hw/display/artist.c | 54 +++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 17 deletions(-)

-- 
2.21.3



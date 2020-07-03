Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F24320772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5x2pbNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F24320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNB3-0000dp-EA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN6z-0003cc-26
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN6x-0006iJ-49
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so30572236wrp.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dwHxgRpIhgy32L2UboBlwqmEEDE7UdGELHgh689+HHI=;
 b=C5x2pbNoUsjYAJR/IeEcCn3nGGauTVM4zcjUv4iqxVATPZJfZlB7DIEOismAOK97mL
 e+AvFL/8koPgoouYtpOGvN36buTF1She00QXOelQaElL8lxLtc1DIwm//w8jRhOen731
 RW7MNsZbSt4Efs608EyRtZQPz6dmUHvZCgJ/wWylfLp7fRXyowVPrnFIFx3OP+Z2Pd7i
 I9etJZFEuhm5XbMwITwJXRJeCdKXanDTw2MwNVBRMpjZmBT5P6OlOj8ysiKsN9z/avxR
 SXQdTxmWkgNGT6Mr6YhcM3H+pRCNTpZkwijMvalb+vntzjGtQtDBBLBe9p0l1HnGbhGX
 n3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dwHxgRpIhgy32L2UboBlwqmEEDE7UdGELHgh689+HHI=;
 b=t7EFmgzlm0oLaha4Oc3t/sOvCxuLHHBx9KeW2MHRrUgGxBbsvAG30hyQxjAik5d5jb
 0Qu3WtLtLPFJHkfdsyyz00qvFcBMbnUHqWzMNcyieJc8xC/gFIeWOQ1mrQTw0v4lnSng
 z6De+iRFf2VvJ8HSRcIDjSAqcgV98xgMWyT0ZpztsFDRYw/H4uz16YO5BqB1HDgRcoAL
 sbktoP5LWOxSguslR5CaQQlCJMYyU9WkSe8i3Rh6/VToEJTzSxot0EvHUfUSkIWzMJ9E
 BtjX+nC9gt0aW3EmZqfD3tXPV1afYOdpaME6kjtv+gtxQAy/rDaQYrgq48Z87ZT8HGEZ
 IA6w==
X-Gm-Message-State: AOAM531pecLzQ1jyZmHwO9DbblnwN7ubn6wM6DVz2sEvDFVx3oXC9gCZ
 QTUOTKHesekRaLkU6vA9f42zLRn73w06yg==
X-Google-Smtp-Source: ABdhPJwMY0ZZkwk3JC3c0OaRzkykJQUBHVngw3R1EfPKquJWHQfoHbEizRKFInfKcuyDUHM/yJiOnA==
X-Received: by 2002:adf:c142:: with SMTP id w2mr35234593wre.337.1593788176589; 
 Fri, 03 Jul 2020 07:56:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] Build fixes for Haiku
Date: Fri,  3 Jul 2020 15:56:05 +0100
Message-Id: <20200703145614.16684-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset is essentially a resend of David Carlier's build fixes
for the Haiku platform. I've taken David's patches and put them together
into a set of emails threaded in the way our CI tools expect, as the
easiest way to get the patchew robot to run the build tests so we can
check they didn't accidentally break one of the BSDs. I've also put
in the patch from Gerd that fixes the drm.c issue. I've also expanded
on the commit messages for all the patches so that we have a record
of why we made the changes if we need to look back at it in future.

Assuming no issues turn up, I'll arrange to get these into master
at some point before the 5.1 release.

Thanks for reporting these problems and providing the fixes, David.

-- PMM

David CARLIER (8):
  build: Enable BSD symbols for Haiku
  util/qemu-openpty.c: Don't assume pty.h is glibc-only
  build: Check that mlockall() exists
  osdep.h: Always include <sys/signal.h> if it exists
  osdep.h: For Haiku, define SIGIO as equivalent to SIGPOLL
  bswap.h: Include <endian.h> on Haiku for bswap operations
  util/compatfd.c: Only include <sys/syscall.h> if CONFIG_SIGNALFD
  util/oslib-posix.c: Implement qemu_init_exec_dir() for Haiku

Gerd Hoffmann (1):
  util/drm: make portable by avoiding struct dirent d_type

 configure                   | 36 ++++++++++++++++++++++++++++++++++--
 include/qemu/bswap.h        |  2 ++
 include/qemu/osdep.h        |  6 +++++-
 hw/xen/xen-legacy-backend.c |  1 -
 os-posix.c                  |  4 ++++
 util/compatfd.c             |  2 ++
 util/drm.c                  | 19 ++++++++++++++-----
 util/oslib-posix.c          | 20 +++++++++++++++++++-
 util/qemu-openpty.c         |  2 +-
 9 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.20.1



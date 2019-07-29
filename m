Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 02:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5062075B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 02:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg26UHD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5062075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrvTv-0003MI-1Q
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 22:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38771)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hrvTC-0002ZJ-H4
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hrvTB-00052S-Mc
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hrvTB-0004yv-HR
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 22:33:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id f5so18600011pgu.5
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=9gJggCxedKYtm0PrgdTUNELvKjtyPZ6sH2MvoawgiKQ=;
 b=qg26UHD1LkyLvY6a7UhiBbtCA+fNUdFlI0Ivr/EIeB94KeZfLGkDxWliFP8kUzbbvP
 za8ptEDifLGXXiTMxbkdOuuFkd1rgKXIk+DhJz3/OTW6sT5MQJAiGOK9bWatUYLXeCv4
 QVFj72tKI6yPEdrQCJ8Y2kCNeO91eVX3pYPbm9zbqXXRs4LGo3tiBMU6MVOukIU4AseC
 tQ1jDuxMaI8C6Bke5B2Y8Ux+cWY72PJnbTUOqpIr6LEbRVSs8qYrg2hRwcYqx0qi4J8u
 RxsR903RCM32DKTvxdcIzIzYwV7oKpSCMNITYDRvNRgjda3YpLBPD7x48W/3VTsoU7rf
 EsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9gJggCxedKYtm0PrgdTUNELvKjtyPZ6sH2MvoawgiKQ=;
 b=VuUBN8OnB4MBNC8P4rnShYJthfQJQXLn1MIrQAtEqCaw1SsXxworfb9zuuJxDn5NjI
 /9sdDsu6Zf5YRypS6PUtQMDDG0Sx0IY7bJiXU/IV6HEGCxhrMsJDKeR0+Fj4zcSKOvH4
 DkV8WA6KY9whK5pdK78DcsmJ8+17dllLI/HKUqdcpSrP5xQSTuDET5HA6FDax+ArQtNw
 ximjGDRP3mbwpAO/27mzEZAaxvKYh8Nom6orleVby7yKoGF9khDM9EYXDF9DxTvx5Ppk
 ARljNL6ECi2XHm94FToPHmGFQ8XHemsYNiBYMz0WGN91lyglhXC9rNFXXg74vMJ/LKVe
 2Jxg==
X-Gm-Message-State: APjAAAUN3JtgT1PoSRcoGSjJTshZu2INrdR6I/IqeUuesfM7Er2nh+fp
 pryAUszko32MGZq2gMkr89A=
X-Google-Smtp-Source: APXvYqy5fOo1ku7DH3U4Irar6TRS4VD5un3jYsrDbKwH5ywu+DCGZtnF2SVircmpEUoGOWgRURW0gg==
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr34935354pfq.25.1564367580117; 
 Sun, 28 Jul 2019 19:33:00 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id m9sm103281519pgr.24.2019.07.28.19.32.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jul 2019 19:32:59 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Mon, 29 Jul 2019 10:32:51 +0800
Message-Id: <1564367573-6327-1-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 0/2] add speed limit for multifd migration
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently multifd migration has not been limited and it will consume
the whole bandwidth of Nic. These two patches add speed limitation to
it.

Ivan Ren (2):
  migration: add qemu_file_update_rate_transfer interface
  migration: add speed limit for multifd migration

 migration/qemu-file.c |  5 +++++
 migration/qemu-file.h |  1 +
 migration/ram.c       | 22 ++++++++++++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.17.2 (Apple Git-113)



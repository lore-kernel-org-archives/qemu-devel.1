Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9089C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0F52087E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dajVL1mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0F52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPu1S-0005tx-0n
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 16:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.turek@gmail.com>)
 id 1kPtWn-0005zi-RK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:25:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brian.turek@gmail.com>)
 id 1kPtWm-0002Pf-Ak
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:25:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id v12so147049wmh.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t3EWFtYWy1PxrutwWixMHjNhMppH8NW5awcdMGVYfFc=;
 b=dajVL1mK+BaLvDHq0A1APC3AKRo2ljyolEK971j8wpMbRhL+vZnKn8PXqAU3/+zXeX
 Ri8Cll7okZtYUh9mXg2e15OL6Ti9NuSsS5NtLSpnKp0DmiIIV8Y7tapBhT4fCipLp0jt
 J+e4LXp2hPRLi4Xci308nBEfNgYZVc+Q3tHXwC699q4+v2zqDhUgwfWdoaF/87vhIc0Y
 nH0M2t5PhHbAxrijQOFxuh6mU3Gir/77NsbnnhZpSbnDzZacsEGFZx87qzzIo5j2Bk3k
 PV53vIJ7ytreTiy8p0yTVmvW08PPYwJg9bb4oEx/oJdjTv0vy73J6iaIH86jaR0tMYRC
 89nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t3EWFtYWy1PxrutwWixMHjNhMppH8NW5awcdMGVYfFc=;
 b=eKowW/i3VhmpeQ3PBpQ0ppUye579UcoFjG0VMmWfXuZJ8Eyo41JpFNkLX7NIP2Hweg
 2W2ddZp0f7NGPkcq8tnuDn1f+4IxK9o9/rKlKgL++5T2Fr4DHdVXQl1OgZHai2Ib76Lo
 joAR3AT4MqfZtEqkgqUMz+goDh008OTAUreXsrkGJbgGHpwTwv/ShcI7N/8HAmP46oab
 ByqxwFKoP5BnY5TrLJ/B6Kz9t90B+QX4Wvq4QuPCaYdFBMV678GRZ/zZd0m0id6lExLJ
 zV+6J/ur8sk6mT19ee/YA7PVrfPhfi43FG4486n+ubAyXEut9nt1XZ4OZy7l64G29ECd
 o98w==
X-Gm-Message-State: AOAM531VgsR33dewrv1uv+miyAaHgpz0arGDyzQsPuY+2FeCaSl79U1r
 hKtG4xp4QlClK3U/u6JPiDYT5Kny4fTN4i/F
X-Google-Smtp-Source: ABdhPJy/z+5W9dR+K2E0qa6yckZv47v6UOGDSRkKeUJd8niKy4fGXBWFsLWKrnyyxpQsYYo0awmOlw==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr6600521wmb.160.1602015938360; 
 Tue, 06 Oct 2020 13:25:38 -0700 (PDT)
Received: from localhost.localdomain
 (cpc75556-harg6-2-0-cust35.7-1.cable.virginm.net. [86.3.36.36])
 by smtp.gmail.com with ESMTPSA id o15sm5402131wmh.29.2020.10.06.13.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 13:25:37 -0700 (PDT)
From: Brian Turek <brian.turek@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] docs: Clarify formatting for 'fmode' and 'dmode'
Date: Tue,  6 Oct 2020 21:25:01 +0100
Message-Id: <20201006202501.81537-2-brian.turek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006202501.81537-1-brian.turek@gmail.com>
References: <20201006202501.81537-1-brian.turek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=brian.turek@gmail.com; helo=mail-wm1-x341.google.com
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
X-Mailman-Approved-At: Tue, 06 Oct 2020 16:56:11 -0400
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
Cc: Brian Turek <brian.turek@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Explictly state that the 'fmode' and 'dmode' values for a fsdev/virtfs
must be formatted with a preceeding 0 to be interpreted as base-8.
Currently the code will parse a value like "644" as base-10 which leads
to unexpected behavior.

Signed-off-by: Brian Turek <brian.turek@gmail.com>
---
 qemu-options.hx | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1da52a269c..b92f32005a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1492,12 +1492,16 @@ SRST
     ``fmode=fmode``
         Specifies the default mode for newly created files on the host.
         Works only with security models "mapped-xattr" and
-        "mapped-file".
+        "mapped-file". Must be formatted with a preceeding 0 to be
+        interpreted as a octal value (e.g. 0644). The setuid, setgid,
+        and sticky bit are all ignored.
 
     ``dmode=dmode``
         Specifies the default mode for newly created directories on the
         host. Works only with security models "mapped-xattr" and
-        "mapped-file".
+        "mapped-file". Must be formatted with a preceeding 0 to be
+        interpreted as a octal value (e.g. 0755). The setuid, setgid,
+        and sticky bit are all ignored.
 
     ``throttling.bps-total=b,throttling.bps-read=r,throttling.bps-write=w``
         Specify bandwidth throttling limits in bytes per second, either
-- 
2.25.1



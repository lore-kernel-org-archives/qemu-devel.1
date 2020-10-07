Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A27C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBCF20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkop9QU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBCF20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCBY-0008OY-DA
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsQ-0005P4-1H
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsH-00016Q-0P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id t9so2793732wrq.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jw2XViD7O4aJW7QX1xeSFbHvlMihOtMa7tjoEe+WHc4=;
 b=mkop9QU3Ex9u5Q0pMdRWTo8+Eb5jKy+BmEuRqeo9aS7IxbfGeeyo/p6XnfyqqjZmdH
 SZ5EJKqSHZN6mBDLFoLRbCrb6EZfSvwq+5t3Z97nmm+2jIxUD186btFrmrEY6BMr+nrT
 0OvzD6D7gLJteRdsqjn8dNeD3mrRU5+6wueTycE5pZ6pgm6lhdYVU4R+kyZXFPKxbyLj
 47ORUiR7meANFRa+8Ip7M3wn40ELIF9i9IbX+xGbR5QtbN6QxIipzmCqf7kbJT1jk0Vl
 YZDgh6597wanmWwBJrD8EWtkGOfu4ofnAnq3pVWKucjbBV2nzEPvFQTFsnbgcCrJ48jz
 bupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jw2XViD7O4aJW7QX1xeSFbHvlMihOtMa7tjoEe+WHc4=;
 b=JzwVpqoyr0L/KLrNMpV8LPlZ649UmhfHhoaBnsiRGWHqLpUThYPHtiof2/yZIWrqqk
 RiNORFT3fstbjlgsl7GWWu51cwXVXFlZGiyQnBItU0eRtYb0Rl2zH+M1azHPwxZVGTj8
 4cpPC4Q4aEw9eci2pBB/VnMt8dtDH7+BRP9wQwYYxM9nvUyNIdnijRRAdqQttByXp9CA
 l+oSJO9H7KVgPK875YGFvFholIOvUoWNoSUCNnEW9Kq6qLO5KR6PtYf03qhC5Pf6JotJ
 9hELAXWJ2CEZT6x5/NWhisPOJ80VAtSE9NWtjOJ7+5bKqqI5QUEV16Nlt70ESaBi9Ld+
 tM7A==
X-Gm-Message-State: AOAM533B7xHrhvmsPLE1jiblfZfm7fV1Q+1XQTX0yzdVGHgQElmfuHUi
 NJLxARU+5NnKZCKaiGj5m2iMJg==
X-Google-Smtp-Source: ABdhPJyLZikolK0mNTKpV0K3DJAbKvV4PlPHFa0yJrmOpopfVQnyGr0j0+xeu4/7Khbk3BiFeGXBKg==
X-Received: by 2002:adf:f707:: with SMTP id r7mr4347962wrp.413.1602086463067; 
 Wed, 07 Oct 2020 09:01:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b11sm3541132wrt.38.2020.10.07.09.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB27C1FF96;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/22] contrib/gitdm: Add more individual contributors
Date: Wed,  7 Oct 2020 17:00:24 +0100
Message-Id: <20201007160038.26953-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 David Carlier <devnexen@gmail.com>, Finn Thain <fthain@telegraphics.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

These individual contributors have a number of contributions,
add them to the 'individual' group map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Helge Deller <deller@gmx.de>
Acked-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Acked-by: David Carlier <devnexen@gmail.com>
Acked-by: Paul Zimmerman <pauldzim@gmail.com>
Acked-by: Volker Rümelin <vr_qemu@t-online.de>
Acked-by: Finn Thain <fthain@telegraphics.com.au>
Message-Id: <20201006160653.2391972-3-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-individuals | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index cf8a2ce367..641169fa63 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -16,3 +16,10 @@ aurelien@aurel32.net
 balaton@eik.bme.hu
 e.emanuelegiuseppe@gmail.com
 andrew.smirnov@gmail.com
+sw@weilnetz.de
+deller@gmx.de
+fthain@telegraphics.com.au
+vr_qemu@t-online.de
+nieklinnenbank@gmail.com
+devnexen@gmail.com
+pauldzim@gmail.com
-- 
2.20.1



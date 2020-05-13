Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54434C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B88206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="pFxwudbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B88206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp9j-0004l9-91
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jYp8L-0003Gj-A4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:01:05 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:43538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jYp8I-0001kA-Pr
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:01:04 -0400
Received: by mail-lf1-x133.google.com with SMTP id 188so13221704lfa.10
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8eaL6sPQ21vZ9azxJ8jMvNfe89B8y1f0ac4mSBlAOR0=;
 b=pFxwudbjQc+Iv+bDdYiyy0R90sy5RSCxBnalP+eaNkaViivVuGGdzviFWyzwp7gKkZ
 7GFvUHXY9DI/YdKy5CH+p4bBVH/dEhNQBBHfBq8ag77BbX0ruvU/+AJv/xSwC13eVfHt
 ZO8I06d1lRJS8jNUN8O/uMolkzTD+vMkOpywqW1WX9CZtzAUmZjLNyZATdnXD+0iJ5V/
 O2R9qOdrwifaLfD1UqcFifls6K1ZLmJId5rmK8G/flF2Dd0norNyiQgyY1uN/OFc7Dtu
 HBlqo6AOKEwq8m9RkanSwiI82J+lXl/js/7wxFLr3J3CMMYGeDTfuf2hPnuk2a8aQ9mF
 /Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8eaL6sPQ21vZ9azxJ8jMvNfe89B8y1f0ac4mSBlAOR0=;
 b=SnWK9eU0lm1MzcjYKOVOd5M7bvtG7FBJ7n+UX1jtk7rKzBlwkygnDWOGyuz78Xfjzj
 XI1mV908RSvzMGZGmBL/qd4rhPYW90307auo4kVQFpsmM7z0JOehEzJ5hDYbk8TddfjE
 iVHtOzmYV7o0YpnmmqTXhiUZ0V4EuEC8s35EG6Qt2tmDbPdOX5UD8YxHB8HGABsSIo6D
 3e1aRlvSwYraPPyF8jG00+tDnRHX62gu+5F8epOMycCo/rUFfH3Nk7PGZXB9vdU00j/8
 +gkcKfKuq4NbpAPvpXxe9BqLYLH5TjEcDyPo1rnKWQB1/nnQjJ2nBgewEF8T1ly/sW5t
 0LrA==
X-Gm-Message-State: AOAM531O7PLwr5wKexef2LcusY946rbDM/bBU1RO1N7CasoQg0kUyC3W
 QzjrT/d+6Zx+gISnPoF2vawGJTs/XsqOYQ==
X-Google-Smtp-Source: ABdhPJxuDKz0R5sVVlX4/1Yc2a3kwypGau2FJ+fYZAbzwUjk8rDtOwraEhLpfN8RV9i0TsC57eYnOg==
X-Received: by 2002:a19:d55:: with SMTP id 82mr17898886lfn.89.1589367657787;
 Wed, 13 May 2020 04:00:57 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id x11sm15734897lfe.6.2020.05.13.04.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 04:00:56 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] e1000e: Added ICR clearing by corresponding IMS bit.
Date: Wed, 13 May 2020 14:28:51 +0300
Message-Id: <20200513112852.1464626-1-andrew@daynix.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x133.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Added E1000_ICR_ASSERTED check.

Andrew Melnychenko (1):
  e1000e: Added ICR clearing by corresponding IMS bit.

 hw/net/e1000e_core.c | 9 +++++++++
 hw/net/trace-events  | 1 +
 2 files changed, 10 insertions(+)

-- 
2.26.2



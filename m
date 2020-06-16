Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2C620767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8drelST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2C620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Ou-0005ar-4c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NT-0003dL-Sd; Tue, 16 Jun 2020 03:51:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NS-000844-4y; Tue, 16 Jun 2020 03:51:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so19697879wro.1;
 Tue, 16 Jun 2020 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CMGZ8HmZIZlFe+EGA2xhdq3yGzhcCaWNcKp3HY+yM/k=;
 b=l8drelST4J485o7YCO6ppUAgvESbk/nw0xzGesnIw33Y78ManT58+5luzQ5airxIzL
 W9SJ+0MldslH/WLb9TGA/jTT4dPnAppXb9uG+ymCBmlCnRTURl7xBa8OgQkwroBK4iJQ
 eyUl5s8h/pR++TmcxfNvsMXFUYc8EnUlS/obfO2rUdu+QLAzAKq2TYT1by3pgLnUrGXM
 cXmXxuiSzYwG/jEtu4UGmmX9YcbHx65JHwZBetOmSYAYu8jNxG+PCRnQYsVi/IkHQVbW
 9GUzEcPTv+Ma0ehxoa4DMR/QWa3xVmon6XBoOlJdL3cMlKYdUccqiqK84u//m1O9/py4
 1mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CMGZ8HmZIZlFe+EGA2xhdq3yGzhcCaWNcKp3HY+yM/k=;
 b=svYMNyr/c5YmUMedgu4+iuHooiFFJDbfu5n89M0b2iMgvp/DMZCFTK38fb0Hom4lmV
 oUpzHQCO5eUS4F6DMf6BR0BNNxrwgRNGgcO34GZFojsLqYoWMazYZ1ixRReEavZ0olrd
 MB1DM+Ivg4bec3wXPACyCXq3Qn2eOa8U8BfVfMLHk8zMm50Bk0oLeRrNsxXpKT1m4Czn
 2NNeOAv4/kvRjlj7gjvkpBsTVZEUtjhbVTVW6l26yhPgCtxGjevpqhUZ5J+rXAlQrHCl
 OAt6ORWA3H+R5OGGy3CIwxnFTMw/v0rqPqkJSzGWgqP/7OfAaa/d0M1miOrp5rAqeEr+
 nCxw==
X-Gm-Message-State: AOAM5331JOhalVKdfX2C48Gskc4zv1njJt0vZ/Z5yOwwM0ZoUHl7IMqo
 fpNnZp2w7snG1zd1mrPkEctb73wo
X-Google-Smtp-Source: ABdhPJw2Xui4tCl06OEgMD7UGeAi4esroBAqUC0hJGZSAxupGm8JDbdSKe28jnhq05ocRWUlMU0Uog==
X-Received: by 2002:adf:a396:: with SMTP id l22mr1640024wrb.24.1592293883830; 
 Tue, 16 Jun 2020 00:51:23 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] misc: Reduce QEMUTimer pressure by using lower precision
 when possible
Date: Tue, 16 Jun 2020 09:51:14 +0200
Message-Id: <20200616075121.12837-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains few patches resulting from the notes I
took while reviewing Mark ADB series last Sunday, in particular:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg712078.html

I have another patch for hw/input/hid.c but I prefer to hold it
to test it more.

Philippe Mathieu-Daudé (7):
  qemu-common: Briefly document qemu_timedate_diff() unit
  block/qcow2: Document cache_clean_interval field holds seconds
  block/curl: Reduce timer precision to milli-second
  hw/virtio/virtio-balloon: Rename timer field including 'ms' unit
  hw/rtc/m48t59: Reduce timer precision to milli-second
  hw/ipmi/ipmi_bmc_extern: Reduce timer precision to milli-second
  hw/watchdog/wdt_aspeed: Reduce timer precision to micro-second

 block/qcow2.h                      |  1 +
 hw/rtc/m48t59-internal.h           |  2 +-
 include/hw/virtio/virtio-balloon.h |  2 +-
 include/hw/watchdog/wdt_aspeed.h   |  2 +-
 include/qemu-common.h              |  1 +
 block/curl.c                       | 15 +++++++--------
 hw/ipmi/ipmi_bmc_extern.c          | 19 +++++++++---------
 hw/rtc/m48t59.c                    | 31 +++++++++++++++---------------
 hw/virtio/virtio-balloon.c         | 14 ++++++++------
 hw/watchdog/wdt_aspeed.c           | 24 ++++++++++++-----------
 softmmu/vl.c                       |  2 +-
 11 files changed, 60 insertions(+), 53 deletions(-)

-- 
2.21.3



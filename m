Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E350CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD5721D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD5721D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLmNy-0003QY-2h
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iLmM7-0002Ve-6R
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iLmM1-000711-QP
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:53:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iLmM0-0006zT-Cw
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 06:53:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so8759740wrw.9
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 03:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W2X2+p4yXGg673dZzLo4v5KRbArsIomA3vjkmTiCugk=;
 b=nBU87U3ZarfmZwJRZH6qD8W/GQkNuapdQTRNOZKmNkytLvfkdqhZ6OnsHDjL22OcUD
 UU5rNKroPy279nh/JjAcb+QXzrmh7ktf5VRMmt+VocHiFXyKyFtwUv9vmPkHsl9zeo8I
 DzMu0+OphCK6/TRjsGuWWTT6+aLRh8i3+4uhgVDclNObcDtdizt1O7TJXo1Wmn9qqCGC
 v8UangmkpRlS9oV7BiYi3m2wkSxcS0ehNCwD+abxOjliMh20Q/4ZCIAJ0V6Y2tbPdZa8
 YhWw2APKG40mt9ch+rBB8ehP0uXpeH3gJm6DQJz4f6G1xilhSwQUz/zI2hdW6u6ounTN
 fC7A==
X-Gm-Message-State: APjAAAUENeoaclmsVlqMxTFWZ0Fodh4C17Dg+Sclnju1d+zKL3NngEm0
 fKssJABxlvEURhzFoG/u590ACgssjDAnOA==
X-Google-Smtp-Source: APXvYqxea+z9D17dwkqlqCYDS/QxSXM9w6m0IZ8TcSilq2g2hgvNXovfv7UJZLkUfAfkI10kX4Rq0w==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr11805856wrs.193.1571482378372; 
 Sat, 19 Oct 2019 03:52:58 -0700 (PDT)
Received: from thl530 (x2f7f4ae.dyn.telefonica.de. [2.247.244.174])
 by smtp.gmail.com with ESMTPSA id u25sm7512310wml.4.2019.10.19.03.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 03:52:57 -0700 (PDT)
Date: Sat, 19 Oct 2019 12:52:51 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 8/8] hw/m68k/mcf5208.c: Switch to transaction-based
 ptimer API
Message-ID: <20191019125251.360db802@thl530>
In-Reply-To: <20191017132905.5604-9-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-9-peter.maydell@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Thu, 17 Oct 2019 14:29:05 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> Switch the mcf5208 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5208.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

This patch seems to work fine.

Tested-by: Thomas Huth <huth@tuxfamily.org>


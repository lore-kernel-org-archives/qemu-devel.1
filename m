Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E4D2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9DmlfAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E4D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipGC5-0006Cj-IC
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 13:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ipGBS-0005mq-KC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ipGBR-0004LC-Mu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:35:58 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ipGBR-0004JF-HW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:35:57 -0500
Received: by mail-pg1-x52a.google.com with SMTP id b137so1974007pga.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 10:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=APH/Ma4g1nw3wGoY79dquePdemNvmfvGHZu2u2NXTys=;
 b=L9DmlfAjXaUv4TRi3h4W3AIixzDMfiKhmRJlCnDCmKpJtjX+wutSEzBp/B9vmzteD1
 +sx0LkBFy3bqvFdg7LojcYSrb8UAzzfsKxcVx912TXATTh16wwRHjB46qudu5DeB8p7l
 7ATIm1hpox7HaL5MXJYO+uBzeWyDb/fItGOa7rhHU9krTTiFy3Esf4VTUMD4DyxxoSDE
 D2K25VsEwwUYcpp79QXHjlYailrbMXvZMoVA7s6HodyTkgR1/XBI+qWqnTVUv4kAffiz
 nGTW6vL2LIII3xdSTOzBljlO8XgEL3atRiYKhbnvwuOIXDPUqb969UzE7Xv43jFfEeYq
 /SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=APH/Ma4g1nw3wGoY79dquePdemNvmfvGHZu2u2NXTys=;
 b=TBrYErTbFU29RWXGLmtSEuiF5AQN5fWLPRfwdWrOy+AZPjLrh9ADF43nVwyLRjzmU/
 CcDAkxITObFygMQzf7SxiJn6+FBdzH796rWyShRgFeITx3U1AQjz8E2N64oV54O9TpCQ
 OGjV9xyco2SH2OsUaW6z+dz4wAv+B1ED1oxCMOR0b7++ojsLvKX3yGM/mwXK6nia9BJq
 wU3ZmPaRaiqUALIGFDZjRugBW2/oINbL2UQb1TBbIZtB1H9VIKUN9vHd4MwYo0eV/cFS
 Hi0dyPrmntq1Rew9cB7GsdylfJXcoFU3NNlEZnvpPFuWYf6vSEFnwb2g5+qGFBGQ31ru
 eysw==
X-Gm-Message-State: APjAAAXYM2lANDEX0Ry1r601CgyLK0XWmUsQEHs0qjg/b29C6ASWuIaz
 LD6w7BuzPP8AL4WLMOmISZ/ZiMji
X-Google-Smtp-Source: APXvYqzb5ITkQ0SdZa+xChvLHvhA4gZCyx4gxJ2Z23fI9qPT0Hel4Up2Z0QZi0qzt8mn1Fzt5EcRRQ==
X-Received: by 2002:a63:3404:: with SMTP id b4mr6631589pga.438.1578508555529; 
 Wed, 08 Jan 2020 10:35:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a9sm4401042pfn.38.2020.01.08.10.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jan 2020 10:35:54 -0800 (PST)
Date: Wed, 8 Jan 2020 10:35:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Subject: How to tell DMA controller in qemu to terminate transfer ?
Message-ID: <20200108183553.GA5608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am trying to fix DMA support with Exynos4210. The original commit
59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210") doesn't
really work, primarily because it assigns wrong interrupt lines (no idea
how I thought I tested that).

Problem I have right now is that the pl330 peripheral DMA in Exynos4210
depends on a signal from the peripheral device (here: serial ports)
to end a DMA transfer. To make this work, I need a signal from
exynos4210_uart.c to pl330.c to terminate the DMA after the receive
buffer is empty.

How can I implement this in qemu ?

Thanks,
Guenter


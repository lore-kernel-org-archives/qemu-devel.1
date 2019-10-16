Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBEFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B2A2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="U5PWcI3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2A2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhZN-00058y-NR
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQU-0006LN-Kl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQS-0003rF-Em
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:25:10 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iKhQP-0003qK-HD; Wed, 16 Oct 2019 07:25:05 -0400
Received: by mail-qk1-x743.google.com with SMTP id u184so22373796qkd.4;
 Wed, 16 Oct 2019 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cP7wYXPS1LIP0QvJUqyPcWVisGTLgBxAvOkjcnJYZTw=;
 b=U5PWcI3gn+bq9MQR5PUH10Pv8w+eFBRpCvZWKJRqFNHkmqXVHNlySUjTlyNdLHBN/K
 QkZ2EVvb0CX8yYkHvvCM+qco487KaVCs1YPHly6G4VH2W8GNFULVUmdRhbzJW7sCYKPr
 ivJnWNKxFDtbVRmDb/bndF3u0SVziYpFcyUx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cP7wYXPS1LIP0QvJUqyPcWVisGTLgBxAvOkjcnJYZTw=;
 b=X8ToXMid9+/Zi0vySLgcYWIVXjOHo421aFfuWheY4qOEZtKf4z8jqNwR+twYo9uqw5
 1iJd0dO9n8jTWX53mUCAxHYMGP/lX6hBcYNr9G5VWcdxS655Wk3NhCLrSqJPVA4hGbxE
 0NERGBkPWR4/RFP1FiVd6HRmctvlOac0EI3t5jx9ZMIzhLWb1cU43jBGNv1v0xmgz6jf
 PtC3wMtIUZV4qDNUIhfjwMAxbG9ReesxOq1HM0iRt9NfGT/avpS3lXtWXLTg3joSheRV
 FZLxnpjQr6kxzj3oFyHsVA1xlRYG3QvwQDWuXPnXnc744nx/Dp+3kVqXWiZVXr4IdsTL
 gSPA==
X-Gm-Message-State: APjAAAX7NgN5A/LVr2MbwD6TbM5JXS7jh8GeH5YyRZ8n0F3aI6G9Sw7z
 jkshwGb83rBgrPA8xGDzFy305ZRgogxNuNS8cLo=
X-Google-Smtp-Source: APXvYqwFlhb2tguRcC2g4H/W7nrH3ukEAKlxGnmqJGSfzQZcmXbyzMua+ISqyEYunlPHvmqZbvi4PrUmgsz5CaAowOU=
X-Received: by 2002:a37:d87:: with SMTP id 129mr40610041qkn.414.1571225104884; 
 Wed, 16 Oct 2019 04:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-5-clg@kaod.org>
In-Reply-To: <20191016085035.12136-5-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 11:24:53 +0000
Message-ID: <CACPK8XfVdYNy45mnVx_4Bq00iaFjC78w-F=omw1Db0wJ-FU7xA@mail.gmail.com>
Subject: Re: [PATCH 4/5] aspeed/i2c: Add support for DMA transfers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Eddie James <eajames@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 08:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The I2C controller of the Aspeed AST2500 and AST2600 SoCs supports DMA
> transfers to and from DRAM.
>
> A pair of registers defines the buffer address and the length of the
> DMA transfer. The address should be aligned on 4 bytes and the maximum
> length should not exceed 4K. The receive or transmit DMA transfer can
> then be initiated with specific bits in the Command/Status register of
> the controller.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>


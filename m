Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA2FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABBA2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PGe0yM5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABBA2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhTg-0008RR-7I
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQ9-0005v1-HK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQ8-0003kG-Lw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:49 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:32833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iKhQ5-0003gg-PP; Wed, 16 Oct 2019 07:24:45 -0400
Received: by mail-qt1-x844.google.com with SMTP id r5so35555085qtd.0;
 Wed, 16 Oct 2019 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cl/I+V8biwfMluFTh5F5IRiQu90LJCJeh5Z+3MiwiHQ=;
 b=PGe0yM5Wi8/f8EcBmTdhs+ABdM4noPfe8zNXd2fOqvD6zbITDAabblpzHJ7EyEz5ZC
 pj9JeQ+nRrKsXt11HdsJ9/Pu4paNcNdLBxjF4RlqzjYhqrAxiw/O5aHJY5doMxg41uKQ
 UxZcnXO4MYVlrez18o421X+Yd/VJpflH9usNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cl/I+V8biwfMluFTh5F5IRiQu90LJCJeh5Z+3MiwiHQ=;
 b=AUcq+Z+sb5qGxpjdltF3ZWdStHf4rn7omjSL3U8Euz6ACjOTsKjvtPVoGeZZ8AoHy7
 Q+LNz/n7Xmp+/TWmnvKAA+dSfkziBNWaEYZUZhpYa+24qgSJFQBraqS37WRAffheV3Cq
 8XIBqNxqeWQNeDmcni+w+xlklB+9ih6xDnBkJ6pHnkPNRmM4E8zsqypAyJYLv9532G8Y
 Be0Dy8VE+6wSyNtQSnWuc/AuB8l6UojziqjDqem7LGaC8R175FKot16dDyqy5g3TPW6N
 lH6GKnXjy+3JAfGvYBM3PWBZqX1bXTRjGcQg5EZkFiBeB5/a3qfx/jAn6LRdKtyqS36y
 AirQ==
X-Gm-Message-State: APjAAAVS0Y+Pze/B+Bu9Z+FP0/3yeyDoIYk0lR0zKx1BUjE9zJCOmAqd
 HkVEAlnuCl4MsCdpD2qrcIlO3CNU2/PKH1WNEFs=
X-Google-Smtp-Source: APXvYqx+3dyNqUrxCkdxgV92FSgxjEcixisXpBnEWkYuK++IycJ6UkxmHyG2sKLkbO7r1z64rnFyPAqz97+M2IViAq8=
X-Received: by 2002:ac8:5252:: with SMTP id y18mr44129384qtn.220.1571225084835; 
 Wed, 16 Oct 2019 04:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-3-clg@kaod.org>
In-Reply-To: <20191016085035.12136-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 11:24:32 +0000
Message-ID: <CACPK8XfbUmzu+swDuGm8jNLRUWysVqMEcox26QcEhY1xQDYg5w@mail.gmail.com>
Subject: Re: [PATCH 2/5] aspeed/i2c: Check SRAM enablement on A2500
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
> The SRAM must be enabled before using the Buffer Pool mode or the DMA
> mode. This is not required on other SoCs.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>


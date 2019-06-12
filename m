Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2539C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8D42080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Th8DICMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8D42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasXC-0004TA-GA
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hasOJ-0004M9-2T
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hasDT-0001mu-Cs
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:38:20 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hasDS-0001mA-Bj; Tue, 11 Jun 2019 21:38:18 -0400
Received: by mail-qk1-x744.google.com with SMTP id a27so8979221qkk.5;
 Tue, 11 Jun 2019 18:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vxmca2q3EKXZcvXmBIzcFl5QyFAwVpQHZGukW1tpFX0=;
 b=Th8DICMUwoqU8QReefe19VdCJnzBWJcubCki0JkbERigeJWcdZ7WJm2JH/2hiSbA5Y
 C+aqLHVy/8ojwX9vmkKAgTcB9PGomEpCHTmg7a2HfE+J2UeUkp0IbVzfZgCaYsQHadq7
 dMja2MZNmb1CkqqDOjyv4tsc6ccM1FHNGyIcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vxmca2q3EKXZcvXmBIzcFl5QyFAwVpQHZGukW1tpFX0=;
 b=pnOm/KWzin6H/3lfRuui3Pt6NWbRrb3agNzDyTUoSTZYrJHoS7MPK6+hLi/c4KImRs
 oj1QKd6K+ZjBcuZXzk2ewejeWvC6HfVa3cZ9kkUFzSNcLhGFP7gogsV/5uQ+24PToVMO
 fDRuw0MSntZqX+bJtv17WluaU0VNBhEjklA3458ZPieUihDFKkHTVLmEZI+V8eyCPM3Q
 ve67zFCtPzgQ4DQkeZDii06LTzNYhi5BngS3sm09tGn3N0fjhIrp+WvxfW5YmA4fiYmJ
 2zlmoxG9pMFNGgwqSNklrgEvrG6nw1zaWppCiUdn/orRebrlBCXyHtdpUFdaWkJsm5wc
 7B+w==
X-Gm-Message-State: APjAAAWHhJU/tdrzshHkG/2Cy3CGCyzvgILC0cpZ3ZNDqEwMBKS6ChHv
 i8Q7W/5Ts/kcf/IaQNQdk5vAkQ2xb61N3jExBs8=
X-Google-Smtp-Source: APXvYqz3EfgvNEXjNrqD5GHhQMwCe+VQr+aXUYHvvGRwXa7+YNIsHz4YOL19BPpcRpkpgrdlARZcWpW1dF6RoztoqUs=
X-Received: by 2002:a37:a743:: with SMTP id q64mr62295320qke.236.1560303497735; 
 Tue, 11 Jun 2019 18:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-17-clg@kaod.org>
In-Reply-To: <20190525151241.5017-17-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Jun 2019 01:38:06 +0000
Message-ID: <CACPK8XfB7x1tamZa+epxBzwkrfovW6qBrNqokk3jYtLa3dxwFw@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 16/19] aspeed/smc: add support for DMAs
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 May 2019 at 15:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The FMC controller on the Aspeed SoCs support DMA to access the flash
> modules. It can operate in a normal mode, to copy to or from the flash
> module mapping window, or in a checksum calculation mode, to evaluate
> the best clock settings for reads.
>
> The model introduces two custom address spaces for DMAs: one for the
> AHB window of the FMC flash devices and one for the DRAM. The latter
> is populated using a "dram" link set from the machine with the RAM
> container region.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

C=C3=A9dric is our flash controller expert. This looks good as far as I can=
 tell.

Acked-by: Joel Stanley <joel@jms.id.au>


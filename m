Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28292C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E945324676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXblH9DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E945324676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUvZ-0001v6-4n
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUuu-0001Lk-Iz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUut-0008Rf-Fe
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:07:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUut-0008RF-9C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:07:43 -0500
Received: by mail-oi1-x241.google.com with SMTP id d62so16170670oia.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bdwlrc5shnHF+9VVf7Bnm9NXmem2iH268QCSnX+MexA=;
 b=BXblH9DGPDm62TilZeN9vXHnp3bWhh+H3fYBrWT+wQYgtq5QG/qLRf7615VtoNgeTj
 YjNFVjO666itTTiTB5bVL/fpfPR0UKzMV2EDJC2NWrKnuY+klLZ+MS701gLhR+D4jE8X
 A5+KvqVgW71qjT9P3ZoPo2bF/HwPL1q8dE5bZRL2tzlVd4caXBQbAiaJ6wAD+42/EqOa
 c8MHPlh7ECrs/b2A0iojbfV7VKPRK1GSKmMUk2cMXJwE5k8Vu5XU71Ujj520sWfxcPM5
 2VcAw8+fqVFKqTCvA+ufQZCwisOp01U1+StCnzruM3/zCnPRhB85tPENiGPdSEHfZ2il
 +7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bdwlrc5shnHF+9VVf7Bnm9NXmem2iH268QCSnX+MexA=;
 b=EYIS19r9IBVjFmYpbIGojrnW7qVWVJI+SP/JHfabaSg/ExjXAgRqWUHfWVeeor829k
 Y2ljpJQHXiRS7w+N1Rnz8V1iRulOkVHhLmgmQmJh+U6gr+8qeuDaUuC2YKtupI++kRrq
 cxGeV3vu8RSHyXqh43EJUgwFnNWoh+G2bxOClH90SAbzAZyLxbfYefwCbC1wxi9oHkhK
 LIG33IZZQ3jKu0KJPZk8HzrX5tMlc4PXacxHFbBiJcyX5im/8jwvSEAet2TSlSVuZ+l1
 kBsO8b0lWJLQRBpjQZze0gZftoeclpngzj+PWBecOeqtUfd+6AkqfaJ1yAFhHXAZOMO4
 fUjA==
X-Gm-Message-State: APjAAAXYtYztRTrdqLO9aI1StLM00g5pD7g2ooancuJgSa8vMktP4AOY
 JfoY9nQgaMHCaOzvqWlIi5vl6bSQF5n7YNUsW04CXg==
X-Google-Smtp-Source: APXvYqwBb/fOW8VL4P5J7R0Sjkk8XoRMFJKWVGgTxCr3sY9RKOheT8MSgyR+46DLqpEQPRjheKPYtIdcvx3PugRsPGg=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr5991522oig.163.1578326862258; 
 Mon, 06 Jan 2020 08:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-7-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 16:07:31 +0000
Message-ID: <CAFEAcA_MTPuvHvijgeFkeLu2e96Tn90iAop0Lp5eER=7QnU_Nw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] hw/arm/cubieboard: Disable unsupported M-USB in
 device tree blob
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 at 11:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> We do not model the Sunxi Multipoint USB.
> The Linux kernel OOPS when booting:

> This is not critical but confusing. To avoid the Linux kernel to
> probe this device, mark it disabled in the device tree blob.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I'm not sure if this is a QEMU anti-pattern or bad practice.
> I know we prefer to be as close to the hardware as possible,
> but here the hardware is not changed, the dtb is. However
> this makes the guest behave differently. At least we don't
> have to manually edit the dts. If this is only annoying for
> acceptance testing, we might consider manually editing the
> dts in the tests setup().

In general I'd definitely prefer it if we avoided editing
the DTB for things like this (we have very few boards that
edit the DTB and none of them do it as workarounds for
buggy/missing device emulation). Is it possible to have
at least a dummy implementation of the controller that's
enough to make the probe function fail more cleanly?

thanks
-- PMM


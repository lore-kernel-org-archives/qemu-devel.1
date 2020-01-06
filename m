Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBBC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4620731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIFvaJDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioW9M-0000Tq-UU
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioW83-0008BM-NQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioW82-0000ri-Hx
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:25:23 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioW82-0000qk-Co
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:25:22 -0500
Received: by mail-ot1-x343.google.com with SMTP id p8so36131711oth.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=79nzsff85wB3e13TUvSqzK3wGM7lE7VNcNli7I7WCR4=;
 b=CIFvaJDgL2hEqGnW+cHBNBSUQG+XBXWDdLTglOqHcZ1rKtT/IUyJXH1UplVcMALpTd
 frkxVsTaL1AZKJN5HK8SetvWyWD/zsE4r9e/L7jG7xQqRH3Qj9r63RRKSEQShzN0Lo6N
 fgsSCObG68qeEkjaX8qDaJ3xSafhPXWCQM1jb+o51QUbUMYNCnFc2V5wzk5cBZcwvUth
 2vdif1s1OJVoEmmoOFBeO+6RHeXSjIz3vWy4sDN9vZZAGpsJ+mwJhtNw3SHCvBjcb6yL
 XmA5Sntyv9ifDSkfCMfKGqyZbkL3+ncXaHhkaBxJkxoZdiqVK8SE+UyAfbzFO+HY/vT4
 F4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=79nzsff85wB3e13TUvSqzK3wGM7lE7VNcNli7I7WCR4=;
 b=f/Cq3F/pO7Z/PRoYd4ngnuXhZ5Ls7IuDFNVAePp0fnd8NQ1MuJy+NoM6199DastsPE
 RUT+M05dFvy0B1AgLvjbvku86ay8CR3W7XGIfhRHf9vfZuumbrdDzAzIQ7Zs8mNKyWPc
 5E5651D+pmhqjg0cd1JGA+WXZeuHw/M4xm8XDnkPqwZ7qAqb3kN9XAq8bTDTMl4k+wqn
 KZyk+a+UgHvj2mr5INeie3VCJ63P71cpNrMiotyk+sS7iveBrRqLe4Wq9MDWDT0s/PLk
 nYNrobl+F8493KQOaz4prASainMd6jGGbppv5NnxPf4lR8Zt+JdTOFMq9o3H9N3hLBaE
 EXkg==
X-Gm-Message-State: APjAAAWKxc4QznF+PEx55JXcuygGlEi+ruG/VUAxfyaL9mhCq41iqNy4
 VS0WySeBZcx3QMKqoSE6GfCXg+ANEGInRLoOV13yaw==
X-Google-Smtp-Source: APXvYqwAebEj6mFylf7mE8tYz/l4W8yzrk327pr9i9GMhR2JfdboUaozZHkhTqwCIIuYmLCnVbkNV6z/q6L1DUnsf4Q=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr108557360otq.135.1578331521414; 
 Mon, 06 Jan 2020 09:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru> <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
 <b0587d24-c7f6-ff1f-9527-ee389bd25b1f@kaod.org>
In-Reply-To: <b0587d24-c7f6-ff1f-9527-ee389bd25b1f@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 17:25:10 +0000
Message-ID: <CAFEAcA9ZrTgPBxBq1rBo0u4z2SB=YHpWx_WUuycXK6pahARuXg@mail.gmail.com>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 17:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> ARM bootloaders are also embedded in QEMU's code. See hw/arm/boot.c.
> You could improve a bit the definition though.

Given an opportunity to restart from scratch I don't know
that I'd do things the way hw/arm/boot.c does. The initial
idea was really simple and straightforward: 3 or 4 insns
which just set some registers and jumped to the kernel.
Fast-forward a decade or two, and the complexity has
significantly increased as we added extra tweaks to deal
with SMP systems, the GIC interrupt controller, boards
which need to do some extra odd stuff, CPUs which start
in Secure state, 64-bit CPUs, mangling the DTB, booting
multiple flavours of image file format, implementing
various 'firmware' functionality and APIs, and so on and on.
Insisting from the start that QEMU emulates what bare metal
hardware does, and doesn't get into the business of faking
up the behaviour of firmware would have been a neater
separation of concerns in the long run.

To the narrower concern, yeah, on the arm side we
just embed hand-assembled hex values in the C file;
this is mostly to avoid needing a cross-compiler setup at
QEMU build time, but it also lets us hand-patch the
binary blob at runtime to fill in addresses and so on.

thanks
-- PMM


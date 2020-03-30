Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BBCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E87320716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrcCVuRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E87320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItxT-0001s5-GA
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jItwN-0001LK-Uz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jItwN-0000cj-2R
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:54:55 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jItwM-0000bv-Td
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:54:55 -0400
Received: by mail-ot1-x32b.google.com with SMTP id t28so17849825ott.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f0XZKp7UaU6v7svJUEZhNxHDpb4583C5hftl9AMgL3g=;
 b=GrcCVuRoPX9rIPPtL+qKW6Y0aFJvwZZddEmYwRc9+AKYYFuYQ7jJmNjhOnnJOI/K03
 4/DKIjVuSEJgpQIui3BSO2F6uhnAK7pUw/lA/MiwzC8o6fOaM8Z4pSVTj40xV/BwSWOz
 53o8JkDGnlSgraqsrEf0N6FsQFNaxbYdJxAO2l0uD8ZfHLwfPoQXi/MG48cGkGLOwbnL
 ukE/v0+1sxYSGEntn0xBaUDbKCAm6gso+qm13VYwuXMRETEOZans72fcNdWkT/XW72H1
 bZvDA+A+lgBtiMzc8UrBD51bQ0exIxzJp8pRbfQdNaegwrRr3if3qIEkvCR3er4L3t/H
 c0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f0XZKp7UaU6v7svJUEZhNxHDpb4583C5hftl9AMgL3g=;
 b=sbsH5syl/YZmWexjW5teuCgQ3LDmNWjDGSN3cXorF/AUysLKntJnnqbcWWwWQc0kOq
 Ygty7+X+yyjtYoZZNTwmiy1UhOVXpbGCfISE0vzdQi55xHQBG1Rk0WtceccnG+StFYgf
 w5eTvarsF+ZmXutAix02wY0+QwJKOYpwuF9gFNPsDzvJG4g8XMn+Z8AGg3ORHgmsNZ1U
 yWgfDJXm7vbh8XNOGI3a1dOE9+invdWWH4z+9+Z8m9BYjpgm90ixUT93R909fz7mrdLa
 P7xMNZ3PTblfsQlkZHhujmo8tmiYReRn8VnmRd7KTrmMZsQKsP7F4uDzc2cDXGtgaKk7
 qjPQ==
X-Gm-Message-State: ANhLgQ35J6cdsH6N52R5dCzwSgMQ7DA7HZI73XbZbEoY5lhBkSmHisLo
 DW7OjIdu1LuCYmnZqYgUzNthHj7prZMekhUzRgp1sQ==
X-Google-Smtp-Source: ADFU+vuNHdsFxh4IDGfeXkKzyLmPCBZBrlaJSLL/ooVpwCuvWF0HAyab0zBcEwTFIqRKMJTx4OVwEQjBxl43Byz+hrY=
X-Received: by 2002:a4a:2a09:: with SMTP id k9mr4209755oof.64.1585572893822;
 Mon, 30 Mar 2020 05:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200330121345.14665-1-f4bug@amsat.org>
In-Reply-To: <20200330121345.14665-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 13:54:42 +0100
Message-ID: <CAFEAcA9uQyR=cXvmBNieuqs6uRvX4WywToQ-uEVKw17qq3dX8g@mail.gmail.com>
Subject: Re: [PATCH-for-5.0?] decodetree: Use Python3 floor division operator
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 13:14, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> This script started using Python2, where the 'classic' division
> operator returns the floor result. In commit 3d004a371 we started
> to use Python3, where the division operator returns the float
> result ('true division').
> To keep the same behavior, use the 'floor division' operator "//"
> which returns the floor result.
>
> Fixes: 3d004a371
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> We didn't notice it because only the RX port (which uses the
> --varinsnwidth option, and got merged very recently) triggers
> these problems.
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Ouch. That's a painfully hard to detect incompatibility
between 2 and 3 :-(

thanks
-- PMM


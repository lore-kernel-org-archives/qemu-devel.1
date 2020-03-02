Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7538C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86092217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmX0Qdrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86092217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nDe-00075b-K9
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nCs-00064g-Bs
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nCr-0000AE-Cr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:42:10 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8nCr-00009x-8p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:42:09 -0500
Received: by mail-ot1-x341.google.com with SMTP id v19so10124916ote.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qnpikZpenghZcvg8TrA30U3uz97Cyec/8QNbVbuXg9s=;
 b=cmX0QdrrtGLVM+0d3LzUiB9SAAkxaO9YYqmgROfsaU02BFIkljru1uFTzxQi2pzZZD
 OqP16LUvmVe014+Cl/cWMWKcZJ4vmY04XbXGkwKd2eK0CX/u61iXI5zhGUsU1yllbm98
 fOlMgMP6q1pQBntlXqgIjUsQB5xqKV0ldh3Oan0RJHWmQZneycAIJ4IREjVuQJSZEh0L
 RyvTvDExblRVOnx4bMjhi061Cas+YlXCEjWpGbTTgoyMwJOrUWADW2FC4ZBfCD52Tw+c
 VXfrcTpes8ZCJBsCGL8lO/YONrSNfhbOFjfijoaJl5rpi1V1Sw3W7UdTH387l2qo+2DE
 RQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qnpikZpenghZcvg8TrA30U3uz97Cyec/8QNbVbuXg9s=;
 b=RPzEevGA9u2fG9LnS3nokbUEGhB7LGewO5KEz4uot30NGWWHpJpz+8DvlZ/C94PZxP
 j+0rWUKZiZoubDQugEymYYd46g21I/1YYOtsh+NZvGDENVt1J/0jIv2RtU3nlDZDmVUN
 K8Q2eXPFGQNhdahBiMPh36Rp0kM6z7dP0mR45NAVbclFM3TE9VxFV8Mb9n3S0aS1lKK3
 g/PU7tYhdUvZGmOYoibuisQbsgtDvZ1byji/ljS+/dkAVow155O4kfPHtsDbpWoUQUKm
 EP7xvepKOiLrKtn1XytGt9kgN3p2mDFlXvIZdI1qZg0+Ad4Wr8sVvYZ8Z4fpnlW/ZxIV
 uJMg==
X-Gm-Message-State: ANhLgQ0SePmnNwEgk+nfgSc1XEAo6epGlMC8yaBMRzxGDpm4WEy3t7Yu
 jcLIWaVIm8Jx5Hgk5J+31Wkq63T/cXnBMzjSD1/68w==
X-Google-Smtp-Source: ADFU+vsSK2yNjZY8uXY5oGujvKlpv+iUdd19uXXLe2eKfIRv8IC+cDxImN42WQjA2ph0IkDkNVwjFW25SF0ddkOMj/8=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr5379982otq.91.1583163728437;
 Mon, 02 Mar 2020 07:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-4-nieklinnenbank@gmail.com>
In-Reply-To: <20200227220149.6845-4-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:41:57 +0000
Message-ID: <CAFEAcA8u7F=F7VFsUUWm5PR+tqWk7ptS1tjjo2gAF+cBqjd25Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] hw/arm/cubieboard: restrict allowed RAM size to
 512MiB and 1GiB
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 22:02, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The Cubieboard contains either 512MiB or 1GiB of onboard RAM [1].
> Prevent changing RAM to a different size which could break user programs.
>
>  [1] http://linux-sunxi.org/Cubieboard
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


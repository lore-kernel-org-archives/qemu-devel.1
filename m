Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C951C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC0920578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/NaAKLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC0920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiVu-0000Q3-7f
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsiVG-0008J0-Hy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:58:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsiVD-0003W5-UT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:58:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id j18so42251973wmi.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jvLidYTk3Gwk+8RiJSnhs2zD4i65Sr1+CzDXLCD0Iuw=;
 b=e/NaAKLgASeagYNbsRUxfqFMmbFFxUkHfgwH7Wzx0jtqYahcwYXZBmS9gZ8SMbZpfr
 6NHHlFjyZgd0DU4nPgG+o5CCVBbdOQQrpA1H0m2fo4LAJJLnwJtuW9vZee6jOtPvaIPP
 72TI7zFCeq3mIQyfFndbYwTm8j877mG9wp0nOuwsFQRQpmHlCjy9dSxQMgNUKZRXmgQn
 xyBYjg0vIpu3n9I1D/6a2YkzJy7+yphCLH255EbaCs7O1eppDt9087I2StmsNpBOUqgu
 3hiNFW4SZXPJ/VQYj2OQD8DvB0+r99ZY4Xuu22ct5XS86PRoCvNWMj8MBch1O+LIPLih
 EXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jvLidYTk3Gwk+8RiJSnhs2zD4i65Sr1+CzDXLCD0Iuw=;
 b=JexNnsCkFY25a7g0ky0F2NjyBAQ07x7j5hpdPxdUJCvInP3KiY+0M43fcsUm223J8A
 RXmkb8QQWgEo0549Fs+bn3fAJMvuZDKOj3FuPGlIK8QrK5wrY2NHwck+Zgaxp/UsghDx
 ZxnXOXWYzewKLRAXdOZCeci75sSbcf2azyZ2snP5adq8JTjraNGhMsNWJ6mWXuvZYrLE
 LOVHaNGwBrRoVcBLKWjF0z/0VTy+zJ0UGNRkvWThtpDBk0bOH3c3t1FCvnYqTND3dF/J
 I2O+7vVsZJbBClEIPEHe8ZBLN2ODqakuTFqFwWwIjr2d5B3P2dJOZoVTtQoY/oW1W7o/
 oLVw==
X-Gm-Message-State: AOAM533gElbeAz0kRrJhvP6Za+ojn1AEjLWrn8bcRuvWhL75sRrPe3sk
 WNcbJLy09Ewx8Y4L8VGsOUsSfw==
X-Google-Smtp-Source: ABdhPJwUf05BWVZzcEaK7gfjY0YSZFrV14V1pOsZH9K4oyBR8phLwfcu66PjErfnaZwnAK3pcswi+A==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr2673332wmi.99.1594108733976; 
 Tue, 07 Jul 2020 00:58:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm2219170wmm.15.2020.07.07.00.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:58:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EE921FF7E;
 Tue,  7 Jul 2020 08:58:52 +0100 (BST)
References: <20200601171609.1665397-1-arilou@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [v1] docs: Add to gdbstub documentation the PhyMemMode
In-reply-to: <20200601171609.1665397-1-arilou@gmail.com>
Date: Tue, 07 Jul 2020 08:58:52 +0100
Message-ID: <87fta3pxhf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> The PhyMemMode gdb extension command was missing from the gdb.rst
> document.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Queued to docs/next, thanks.

> ---
>  docs/system/gdb.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
> index a40145fcf8..abda961e2b 100644
> --- a/docs/system/gdb.rst
> +++ b/docs/system/gdb.rst
> @@ -87,3 +87,23 @@ three commands you can query and set the single step b=
ehavior:
>        (gdb) maintenance packet Qqemu.sstep=3D0x5
>        sending: "qemu.sstep=3D0x5"
>        received: "OK"
> +
> +
> +Another feature that QEMU gdbstub provides is to toggle the memory GDB
> +works with, by default GDB will show the current process memory respecti=
ng
> +the virtual address translation.
> +
> +If you want to examine/change the physical memory you can set the gdbstub
> +to work with the physical memory rather with the virtual one.
> +
> +The memory mode can be checked by sending the following command:
> +
> +``maintenance packet qqemu.PhyMemMode``
> +    This will return either 0 or 1, 1 indicates you are currently in the
> +    physical memory mode.
> +
> +``maintenance packet Qqemu.PhyMemMode:1``
> +    This will change the memory mode to physical memory.
> +
> +``maintenance packet Qqemu.PhyMemMode:0``
> +    This will change it back to normal memory mode.


--=20
Alex Benn=C3=A9e


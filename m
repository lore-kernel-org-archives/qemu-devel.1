Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33897C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25A8206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozGlnR8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25A8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGqI-0005vR-Cn
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFXz-0007xW-OQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFXy-0008JH-NW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:29:35 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFXx-0008Hv-Mm
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:29:33 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so6107640oty.6
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2Yzv5Xveobx+eBUxsnVw67hztizIW+3C2SXpKxGaDxU=;
 b=ozGlnR8bZqcf4D26sD/TAzQBXj2oK0ZCFIJGSuFogeAaLHPq8maW6DUvYPnjxfN4Rf
 EvMIWUO6sI6Tv4tDgjOFjfJP8T2FelTTep1/D3pdwHk57D7mRj5m8nLomvSyA+LOYVr6
 JtcLBaxcW4U4OyyshjGFKMh5CCZhzqKPkgLsM4YsqNfp46e9KiNkYCuGS4OO1bp0F0ug
 +AU8Y212F9DmF8Us1AeC6l0L6LU6q9v9JLGImOJWCUx4X5ZTrDyyOssxS3nNE57MPC3+
 xJcS4E3IG7ZOZ/yqTqElfuNgxw0UdELz8ZjKERi6+lhnClcdfhHfRrHoQ+E5ZLidBlDw
 IxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2Yzv5Xveobx+eBUxsnVw67hztizIW+3C2SXpKxGaDxU=;
 b=JObCdLPPCIHL5aOAHv1oPMEXHCyMIMqbbRK8FyRNf3vYIHM7fu6b0yiwr+dtn7LYki
 yf5MK8Sawcm5g9BTZp4Byyi9y3seCPLgb4IdOSa8VYGuKufirr3hMOpMqgX4pyIHPbD8
 K1ETxPOck3Ze5Bo3AEwyflepLhNjfDBwOv/mwO/bFVtHzGwmFBkKWZtmPep4315pc68+
 oo6dZoT+cvEeGyvjOxf5KRP7zzBUC/Yqu8Rx8ZV9xmp/4BghrHSuaJK2H6z45UV4OZ7r
 nkGaNcHgr/pqgITfpvHM/ieaBge2rvVKTlVhDyLfk92raVS9WE0wn0EUgttZag2ceUrv
 uVYQ==
X-Gm-Message-State: APjAAAWCFgEqNASEfQcJAheFMebs2HtWjBV4SJORZpv+QwFiXLr1s7Mc
 ESI4ZogDRQ6fo4NUwjMYlBdwDTV2f3do8pY5qGUiEg==
X-Google-Smtp-Source: APXvYqx7ADnxQQd2CUTKfZRlgeADallzuH7gsnzL/2RWBJif6Y+L4dcK5VnOh/+pYwlvxXY7o9ruYzUI7U7UbPbY4jU=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr11796431otg.232.1575646171756; 
 Fri, 06 Dec 2019 07:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20191206122247.7507-1-alex.bennee@linaro.org>
In-Reply-To: <20191206122247.7507-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:29:21 +0000
Message-ID: <CAFEAcA9S51DWqysHbO42CjOhZBMA4qwN2zT+isOmWFtH5G8N3Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> For system emulation we need to check the state of the GIC before we
> report the value. However this isn't relevant to exporting of the
> value to linux-user and indeed breaks the exported value as set by
> modify_arm_cp_regs.
>
> [AJB: the other option would be just to set reset value anyway and not
> ifdef out the readfn as the register will become const anyway]

If you want it to be const it would be clearer to define it
with ARM_CP_CONST... I'm not sure what an ARM_CP_NO_RAW without
a readfn or a fieldoffset will do on reads.

thanks
-- PMM


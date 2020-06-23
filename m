Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732F5206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrzaNYo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732F5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfrp-0002X5-MA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnfrG-00022e-Vt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:08:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnfrE-0005Nv-W2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:08:50 -0400
Received: by mail-oi1-x243.google.com with SMTP id a3so18372954oid.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M3hW7WRp42UpwG72NKBm3smYKhFioVF4VBZeKMtkEJc=;
 b=LrzaNYo+jZEMYGt3waUChB440CSSUC6u4cZavtcKxx/K6dN6SwbrIG9FQITGb7LZNm
 ZWEnKN54ER3iffAr5QHqeF9Fa1i3EL2CfDaiL7Y1LTe9pjwiS3QN14PmKFwuSsx1vzua
 HG2ZpKYq9CzQ46VREeQkFviUIY2dGv3ZIWo9EbMQkPayU5FTHz/tNKRvtmC9e0axLYug
 JrdvD7ZFkeJBLy1q2djxnhnE+dNqVueebhU469LTsYhLULakSL3Ek8MhFIeanQt1MLpw
 Qy9fr8Uv2onoHSbnMX+FOpIiClzKc4vRijjM0aTRrn+BHQvgCXE9XKqwjLbXDn1CJ3WC
 UXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M3hW7WRp42UpwG72NKBm3smYKhFioVF4VBZeKMtkEJc=;
 b=cKwi6GSMUEWLY4YceloGX85Wuy3ceoIQi6HV1kgGSC1fL3d8Qz46LWYkS9Xhs4NeoP
 CbF/t3F9e9b+CcCSW0i+CVd1UnPFss0fstokMcCCKAmSW4HB8XcX+ytV/ZmvLaaAnRQ5
 lnHCVIiT3awuL3+wnrAMfSMDbcHmcgB2r1+BKHt1z9nP3M8NK1zdUrzmAzMWS1k1dz8R
 So3M8eUx6ETcBO/PvoIh6wj8GlSudmXe1j/u8zNDJbqlSA1tLmR5VD64EUpXSmftiOL5
 Zy1SljcSBaGT5pgDOe5TirD12tp4892ZGLTw5wuw1OzSSs2HQrb2KBiQGl8lUsXyU0PV
 YXRw==
X-Gm-Message-State: AOAM532Wh+DCfjdhSjg8P/lastWp+P2klM8PrsdNUt+m3I/OIpSWgHwe
 gKTJjJYckYi8NtwV7w8VNW2FgSBNymjWndQYMEZt2w==
X-Google-Smtp-Source: ABdhPJwxczce5QAXUzhylJSFNZPf8ftcpea7bapk2/tAqf92ArOw2sPuS7vZvF3Bc1+6aTPr1i3IoMPhAwn5WsRMdJE=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr15615242oia.163.1592906927646; 
 Tue, 23 Jun 2020 03:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
In-Reply-To: <20200529072017.2906-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 11:08:36 +0100
Message-ID: <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 08:22, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.

I somewhat belatedly got round to updating my QEMU patch
that uses this new fcntl() flag to fix the bug. Sorry for
the delay getting round to this. You can find the QEMU patch here:
https://patchew.org/QEMU/20200623100101.6041-1-peter.maydell@linaro.org/
(it's an RFC because obviously we won't put it into QEMU until
the kernel side has gone upstream and the API is final.)

What's the next step for moving this forward?

thanks
-- PMM


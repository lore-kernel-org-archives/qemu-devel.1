Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F224FC10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C37213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf5vYvpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C37213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD7fy-0002lO-Vx
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 09:17:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7ep-0002Np-LS
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD7eo-0002Rr-HD
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:23 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD7em-0002Ng-Jc
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:16:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id a6so8407294oie.5
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mXmHNYpKBI7HGne+BLLX6Xiqzh46cTvKOtQ4QuCI4IQ=;
	b=Zf5vYvpCgLF51Skuk0O7xjfRRSgNlgcnz0YZM1ORs6PKwJZDohwBExhhmbl6J9CY0f
	Z2a5xGqzFp1600aiw2OVWsPcQ4HiE+XUDgnRbck5uv5Fd6DNN7Tj59tFuPZWXjsjsMij
	4Sr77VHNInS9ZJk1mwy3JOqNu4PgEKRTHKdW8L5Bnh5uYS5w69enVOhBCeolkskfjZdJ
	5zhn+IURhqI5dsXFdtwvFc+MeL/CjAdGV/4TBF7e7CT1RbsjGVVL+WM06O+5DvrfCaJp
	a4/079k+DbSBXva/PPawpSE00/oq6UBq0AAR1fTCSn1vOAUmSU3K/kUBf/g29Z66qNGn
	YxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mXmHNYpKBI7HGne+BLLX6Xiqzh46cTvKOtQ4QuCI4IQ=;
	b=CYwo8c8kCSXwrxBhMtTQ9hJTBAhyDTBCWROwlNDi1brPjGdvx1M5DhbykqxrOudTzD
	kCduJR6Hw9kt/BL974Rn8Xx3wNMpY0oFKyRt5qW3Qpd/Cz7TqKwyQva1sRgopLnjcopA
	HlyfegBuSJ7XJH1o14CJ+yQf7WIZAIi7b69OGrwG1Pkfq9z8av1SWkQE1g1mgzWeOeYD
	t/TBGa/IVOe1ItGA+roY49eQ0hpxzPXNuFTkbmXem2pMsOmRF4fHVQwOqzNb/ABK6rlb
	Ty1B6xrpY0OZCePJ0G8aKU9Dl65JZ6WY8rOfSg7CaleSQQ8Iz8tBduayDJpR3MP50vFD
	4t9Q==
X-Gm-Message-State: APjAAAUmTIsqzid72/Sja8/AZid2PnOXNV0CQh8JXD6Pdf/bKRilgthR
	qs6+n8aH1+5drCDySamEUfuktPP/IIS1FttmMN1Ydw==
X-Google-Smtp-Source: APXvYqyNLOw0h30RH0ymNIV7wDR5XkwZcuCObbvrEDm56LzsYgV9+RWgILU49sd0m0EFpqjoe4x0XE9F36s++knLHkQ=
X-Received: by 2002:aca:e054:: with SMTP id x81mr12845735oig.146.1554642979512;
	Sun, 07 Apr 2019 06:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:16:08 +0100
Message-ID:
 <CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
To: Heyi Guo <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wanghaibin.wang@huawei.com, qemu-arm <qemu-arm@nongnu.org>,
	Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407131608.r_r8zJeZb3iY4w4w3vCFbjcMBmzy6Fc5I4y5GHKKO1A@z>

On Sun, 7 Apr 2019 at 09:19, Heyi Guo <guoheyi@huawei.com> wrote:
>
> This patch is based on the discussion in TianoCore edk2-devel mailing
> list:
> https://lists.01.org/pipermail/edk2-devel/2019-March/037986.html
>
> The conclusion is that we need an individual UART for UEFI runtime
> services to print debug message at runtime, to avoid conflicting with
> the system UART. We cannot use the secure UART either, for we may both
> have Trusted Firmware and UEFI runtime services running on the VM, and
> it is not easy to keep synchronization between the two components.

I don't think it makes much sense to keep adding UARTs for every
bit of the system software stack. We don't have an infinite
supply of UARTs on real hardware either -- how is this handled
there ?

Also adding new UARTs to this board is awkward because of
the weird choices various bits of software have made in
reading the dtb and picking a UART if there's more than one
listed.

> @@ -713,13 +715,23 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
>      if (uart == VIRT_UART) {
>          qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
>      } else {
> +        const char *status_string;
> +
> +        if (uart == VIRT_SECURE_UART) {
> +            status_string = "secure-status";
> +        } else {
> +            status_string = "uefi-status";

Where does this status string come from? The "secure-status" one
is documented in the device tree spec and has a well defined
meaning.

thanks
-- PMM


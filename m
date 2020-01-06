Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B23C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6A0206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2XPk2nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6A0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVCx-00088a-QF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVBp-000785-7Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVBm-0004RH-Vj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:25:12 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioVBl-0004Pk-7z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:25:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so72343867otd.9
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=afpvrfThuHYg4jvcUDkMYQ9/0em1fUBxDS67JQzczDM=;
 b=B2XPk2nmWqCmEhy+zsy3/Sw70ozhA1MqTmHJdJ06PFUjjdOC/I2syh4w63xmnR8RQL
 HNg5KUCmXrurjQLFsMcKcZho8mLbNKBIe7MQF0sxQPcerOa4gLPw4oIIKMBB2ZUcdp6W
 1c8av52oDwwqb4AXPA/cyEypAWvIus6VnnZRolCe7di8WkR/JFoezA2xVuAR/wMQuHEq
 oZ7wsn7sK5TMxyIZj2RU1a/mxMhL+FtJ01fWaI7EV1+X6gkHs7WCgZhkk5qEdYHXi4wi
 /HfAad8TXk9puE2WXiHZPFo9Z4FvbgAChAUv72n3yxacWVsfx7MdeGywcXWtv9lfcNYt
 bPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=afpvrfThuHYg4jvcUDkMYQ9/0em1fUBxDS67JQzczDM=;
 b=igjOUue6qrE4XxwIQA2jjS1Jg/rF1iKzrbTOBiyux9VsHTRDygq7APznrTlDYDo6Od
 HaFriY8zFdRDcoYnAT73OidmsHFyZHyNhWPyepLsyUg3SQwcGghfb5Aqyve4aKUHdiq6
 zWPgoUNfM6efsCzNO0OuzDQziU9dogFJG8SnM4A01DZ7UW84sxJ663fagHc0LWNWKLae
 +bkoMa6qBaJCqOjpETyMXkTtH3ug/wMG5nemk5MXPIqWmt1tM9CnSC2dcsyu4zUiI6Jo
 MfrQXadymXZTxytIrBp1S5MvAZ01pcy0fZ7zsu+O+MkhsVdVA9/jmREIz7TFCnm5PFB4
 QanA==
X-Gm-Message-State: APjAAAUuLT8lHFkcz/U1auaIc9RX2BDt6A+ndkmY1zr1QC8Y7aF/teUA
 CjjkT2+5KobXZor4HDvEV16W2dQw43XYY1HJu6fp5g==
X-Google-Smtp-Source: APXvYqzrGPqV03eM86GcHlvV5FL77lBAEEVCEv6kggvhQFxcjINRG8RzfOCxT7IeyMH7rKtg9MHxL2lixMBe0zmlUkA=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr117537473otd.91.1578327908218; 
 Mon, 06 Jan 2020 08:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 16:24:57 +0000
Message-ID: <CAFEAcA-Zv7VuC1=SZHsbecisThLyDthuB+GMOpYP9j_9P3iboA@mail.gmail.com>
Subject: Re: [PATCH 0/6] hw/arm/cubieboard: Few cleanups, add acceptance tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 at 11:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> After looking at Niek Linnenbank implementation of the
> Allwinner H3 [1], I looked what is common in the A10 [2].
>
> Add some tests before modifying the code further.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg666809.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   tests/boot_linux_console: Add initrd test for the CubieBoard
>   tests/boot_linux_console: Add a SD card test for the CubieBoard
>   hw/arm/allwinner-a10: Move SoC definitions out of header
>   hw/arm/allwinner-a10: Simplify by passing IRQs with qdev_pass_gpios()
>   hw/arm/allwinner-a10: Remove local qemu_irq variables
>   hw/arm/cubieboard: Disable unsupported M-USB in device tree blob [RFC]

I've added patches 1-5 to target-arm.next (but not the RFC patch 6,
which I've replied with my view on.)

thanks
-- PMM


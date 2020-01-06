Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E775C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE2F20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0TL7stu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE2F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUiP-0001s5-Fa
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUgs-0008Ph-8c
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUgr-0005Zo-7p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:53:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUgr-0005ZD-35
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:53:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so72193909oty.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7GSEr8UfRwrftY7BRG7tqzF/K/y3mxVtkrxfAfulGGQ=;
 b=F0TL7stuWDIa4JvtZbhwuXQ+nWQuU5fAdymP1bPoa+uBwDCwJfFwvJlNClv1E27FAS
 5IvskgJtJreXrDwGcohZy9oqdu8tDEPOPlB62CgtG2m6NNEyF+lKzs1aWEsnvvKM8vve
 S153n8pjGUB9BIAKO9UcFMBMrPTycEXwNuqrhabP2/Ik14tYSxmgmH/3uJs2wlnndokY
 MJP8Vryh1A+fgCsAY5JlDO3+bINkBSzYbrWlkWd84KhswGmHhDh81OsEhvH7rdgyMcbs
 IHsK2hcd/DnZ4a5tE0UymEyBSc54REk1FZX+W7RqsJ93egHO9S/Aa61V7aP2ygWUK3Dh
 A4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7GSEr8UfRwrftY7BRG7tqzF/K/y3mxVtkrxfAfulGGQ=;
 b=E5BuJizlAOHTti3eDRRos+eybXeHzeYSxEAuIRoPbfGsXZcw93MWXRhDcWzsz0e5kW
 g1pQG6GHMQOh5dI5/V/IY0bK4QtuA9qKaxEGK2/onrcPiDPwHPM+xI4vRuxVSAB/ppkw
 1IfeqyD1KB3wy1z5ynNwCHwiux7xLl1XI5sbdOopSJXMuhPdbAP+/tNJlcJdrw2H7Myg
 7GHW/z0TIkM2fhGTWV6NCvPDDPnoM/UR67R18K3X0v6eqPexUAteaVfx9IQuGBzaBPIE
 lbmPsvOlg37joGVN5U2f8SiD+C9u2qe3hHvVEauySNwhb0k+7o5CIdSCJtGDYI2Q28Dy
 XEaA==
X-Gm-Message-State: APjAAAWjlwS7/jPk6HGM6gjr0CJuwZp7Nj5n/TKHJJ6gyut9qBxLLAgq
 q29qXamGaRJiFff+88WDqv/QfFjCbOPm00lv+802ecz7rlo=
X-Google-Smtp-Source: APXvYqzDeZS8hU7b4sHbf/WbsOVLB1pY6DxAc+SKoQzGs74uWefFMTN3X1hM7Zs8qcMJWEEzUjYusIJL6SHjt3ku8Xk=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr96918396otf.221.1578325991470; 
 Mon, 06 Jan 2020 07:53:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576658572.git.alistair@alistair23.me>
In-Reply-To: <cover.1576658572.git.alistair@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:53:00 +0000
Message-ID: <CAFEAcA9oe-gKknzuNZYWeCyPaL5uokhDUW5FxLGf=LmBv74ggg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add the STM32F405 and Netduino Plus 2 machine
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alistair Francis <alistair23@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 at 05:22, Alistair Francis <alistair@alistair23.me> wrote:
>
> Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
> Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
> and machine.
>



Applied to target-arm.next, thanks.

-- PMM


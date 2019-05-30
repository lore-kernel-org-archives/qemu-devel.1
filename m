Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E3BC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BCA24940
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cadT/9j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BCA24940
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWBt6-0005jH-Js
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 23:37:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hWBsG-0005Pc-5j
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1hWBsF-0005sB-Eh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:37:04 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
	id 1hWBsD-0005mE-FF; Wed, 29 May 2019 23:37:01 -0400
Received: by mail-ed1-x544.google.com with SMTP id r18so5942275edo.7;
	Wed, 29 May 2019 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4eG+VP0ofgFTRUD96ocaiDBqUmzcXIw5Kumk2DTsAjo=;
	b=cadT/9j5INN3q10RicMlUsKTN/PpYo9/s4qZP5XPfRmBZOmLKFYTiUjUeakS6nZiwm
	cS16MOiSXgTur5T3+pOFWxXrbjNm/qLei6NBpfmtnf1ProS98m6uZxZ2Kjvx/xvH/tIF
	UOi/ZGa0lHOKnuNsvsvjkpe2WgZhppFcpP5Tf57ZlyAOwweM4BLKdcpiCwl+mEQqUDXW
	XJBVYCUEK/XI0roYjM/9EhdoHPOhpb/c3UqcMDiA5mGIrOXwlZ8+dkJGu3e2cmXIfP/8
	5a38UPOAPEOnEfMQk8qZQyYn3P5AqeXGcxZ8lJ2IASM4ij5SgMExNxsX9j9vHpa2rfaf
	hQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4eG+VP0ofgFTRUD96ocaiDBqUmzcXIw5Kumk2DTsAjo=;
	b=SIGXba7ZbID2ejedboMFmQxxU+dI4vCXHt6nc3mBT/A9a5Br/euGiB5tl08kQw2yHr
	xir/KuXvLMGRetvnUAGeQvRnufmEqbOoqY2n2SRQJyBxbygVc0879uOU8vu+mm0+H9JY
	aMddrkFejL8uD7PzQtDXuo5R2Tlf76h2e2xU2/OIPP+7jSDYn+hI7XZ2raNSl1hg+9U6
	bRQ5av6p2VgozDzeIo/lw9HMdaEpXWlE0vX1Co/4FSqPP/J8LGGF2zgG9IzSRqGW/mm0
	JuwSAEtZK3h0xSeSXh0ccqbngAwPLhhwAxPgJWwfj0XDuAj8wcW8pHnbDFSvTRDXUFRg
	rhug==
X-Gm-Message-State: APjAAAVUQyNLudkMBwOQM6xxa9KOS+r+LXV4iG1DrOtT7bxvC4Z0bTtz
	m4D4A20NIgxRqx9yw/PKFl/NK1rc04joU6VBAAQ=
X-Google-Smtp-Source: APXvYqx8Tikl0eEw5GmO5NSNwSH+0RcMLRAJ2nRJEiCHzG5Nni8jiupfT6nOTgSbj+69eVRbt8EibqMhYGHP7Y6KWOs=
X-Received: by 2002:aa7:c554:: with SMTP id s20mr308892edr.15.1559187418048;
	Wed, 29 May 2019 20:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
	<CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
In-Reply-To: <CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 30 May 2019 11:36:46 +0800
Message-ID: <CAEUhbmXLr3zXhbphXRvqfyW1FH9qo3yoPwnFoRoYNtbwkrBBKw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range"
 encoding
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Thu, May 30, 2019 at 11:14 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 1:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > The largest pci bus number should be calculated from ECAM size,
> > instead of its base address.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> This seems ok, can you maybe explain what this fixes?
>

The logic is wrong, as the commit message said. With current wrong
logic, the largest pci bus number encoded in "bus-ranges" property was
wrongly set to 0x2ff in this case. Per pci spec, the bus number should
not exceed 0xff.

Regards,
Bin


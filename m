Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB96C04A6B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832862175B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 00:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7kXoDaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832862175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPG5C-0007xO-R0
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 20:41:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hPG4R-0007Wx-Uc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hPG4Q-0001mq-S1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:40:59 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hPG4Q-0001mR-Me
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:40:58 -0400
Received: by mail-oi1-x243.google.com with SMTP id y10so5755969oia.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wpdyIx6fw8GcocafXBGJR+mi5onmJJCGWxlKTOW+9cw=;
	b=M7kXoDaSChDHQyGM/Z0w6BvME3UjnXNAOesbOF5SCt71qPTDeDKQre8P9tntJffASC
	B+v8WsE+zXAfTO/toWA155+0QL6fdIo9U+dOeCIHhahxpuz0i73hUWD+wgy1PkZS9CuC
	7iG9snPPp3nCIlS3GL0zNSwKo/jPAxfCChQSz8KOoy2EIpJWcmgmDcK6TC4buZqimDvM
	teQavb1c1+KGXSY7PIdEVQ3obHWghGrDDThYtmQ/YgH+E5Aq79B0kKUdylJGWNJpj83N
	Ayvj5gnSwX9WxE8bdW9Yd8JBxqrJ3ajPTsu/kLfzVuujbGOSbo368vHUoYTPBV1PhcVx
	7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wpdyIx6fw8GcocafXBGJR+mi5onmJJCGWxlKTOW+9cw=;
	b=No7Xcm3LQ2wkbZzmfmVTpW6manTiIthEnMcA3E/nYCiTuB7493A5aCYhA1EpwFEwjC
	WrjN0e0pLv4p7O6xkrQabjoXCwZrBU7uGMUv5jRpPvAHqbbUQhqh2U5oylkRLdU6VA4Q
	SEc/3NPSIuQPjSmDaq1WrpHolRwu2R002VWfw1kAEYI2CGw96iCw2MBSTZhZIi9VU7X9
	ztn7NACA5hmzYgSI3kUpf9F5DiaJ81PV0hjtw2b2HyQwYNEWnUB3NZ+7ZpuNl6rH5fhQ
	0q2AFiqVJkywr08X7L7abRIIMwtNFSN0uth5Pj8HR5f+t5GpZU16JFbNT7zm95PLkTQK
	L0iA==
X-Gm-Message-State: APjAAAW+8JCVgbmOMU6hIgNQ+aYi6ZF3HDjiLq+fT+lF1kLKHOkL0HYI
	DV0tB9OcgWrPXlDlMhlrB5G0D8Y8LIvlGVpncRo=
X-Google-Smtp-Source: APXvYqxoZf2RkHabm5uPrAn6svP20vc0FpeoDBeCASYme+WO+M7G0HvZBnO0ARn10rr9DmiykVs/2k+cVyuLuTku5Dw=
X-Received: by 2002:aca:1807:: with SMTP id h7mr3007451oih.150.1557535257384; 
	Fri, 10 May 2019 17:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190510164349.81507-1-liq3ea@163.com>
	<20190510235318.GO18465@xz-x1>
In-Reply-To: <20190510235318.GO18465@xz-x1>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 11 May 2019 08:40:21 +0800
Message-ID: <CAKXe6S+8yL7=trJqcXmCe+Z+mNabBP-6q3bzW2zEyoen=wM0Kw@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 0/3] hw: edu: some fixes
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=8811=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8A=E5=8D=887:53=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, May 10, 2019 at 09:43:46AM -0700, Li Qiang wrote:
> > Recently I am considering write a driver for edu device.
>
> I don't know why you wanted to write it, but there's one (though I
> don't even remember whether it's working or not)...
>
>
This is a simple device, once I used it to debug and  make clear some
hardware-related stuff of PCI device,
such as PCI interrupt routing, interrupt linking device, interrupt raise
and the process of injecting.
I think if there is a driver, I can do this inspection more easily.



>
> https://github.com/xzpeter/clibs/blob/master/gpl/linux_kernel/edu_device_=
driver/edu.c
>
>

Great!

Thanks,
Li Qiang



> Regards,
>
> --
> Peter Xu
>

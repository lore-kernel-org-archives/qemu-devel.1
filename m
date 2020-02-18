Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE4EC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFB320722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFB320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wO3-0006eC-Kt
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wNR-0005pU-Nx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wNQ-0005oD-RC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:29:01 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wNQ-0005o6-Nx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:29:00 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so8945965ywc.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LMU0TbuonwK/4gbdQQ5ytCm8TdvdcK/pDctICBh9Vig=;
 b=VzuieIlgzqwyamkUfnKEwTGmpfZh5cyTbzxmpRGgYQ9QcU0IGYI/QnwXS5m4yMjkqx
 wm7vOX3e9Uc9KKmhmroS04hT5pH254W8eEUkIGUpmBkvp9OVwZOpW53C0+tdPUKTGX+D
 ZWXmMIo+3/poKgHtZjG2NRwKwC9dBOBblMDhSPQq3GOExuNAueJbZI3EbZbdHoaO4drF
 iOU+KTDQcg/MEAhPPSqSN1sQ571hvomXcZHCBC7W3mrb51f2DF1rSU/gXNtoVaB3G55M
 I8m0emNqUplbpAby0Nz2g6chhP/LjfzimDXKMfUNMCMdyNSnlDiEjk2cyfXrICVaAw84
 Dsfw==
X-Gm-Message-State: APjAAAUYnfVasZOkLOgzlIH2p8uNhR3fWbcoxYhiGCLtw0rwvmZQpW/r
 EQmDTrVAP1BxSXFb5u/PY7rxqPIq4PUY0u9A0po=
X-Google-Smtp-Source: APXvYqxCz+A/WNgHAxJ/5YRIL+B8Gh04GWZT/bUOb6kaYftOX3MSZ6hQ1pqYyD90sKqbuIz0nhD5xXaXiGDx3B4EhE8=
X-Received: by 2002:a81:4f8b:: with SMTP id
 d133mr16267541ywb.368.1582007339900; 
 Mon, 17 Feb 2020 22:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20200213234148.8434-1-f4bug@amsat.org>
 <20200213234148.8434-3-f4bug@amsat.org>
 <CAFEAcA_4=ZoBwV+X-k4ZSfNqrvDqt=hi0aetG4GFBUxXEeZBBQ@mail.gmail.com>
 <CAAdtpL6SLwxRqij30PHZ=mZuhbPcT7uTvSM+nm1ihcjhGbnRsw@mail.gmail.com>
In-Reply-To: <CAAdtpL6SLwxRqij30PHZ=mZuhbPcT7uTvSM+nm1ihcjhGbnRsw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Feb 2020 07:28:48 +0100
Message-ID: <CAAdtpL58jg9U98j2-chswY6QnFCL6S1uz+L1iBjSFBeK8Vc9WA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID
 1419393 & 1419394)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.68
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 7:19 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On Mon, Feb 17, 2020 at 6:37 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > On Thu, 13 Feb 2020 at 23:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> >
> > > Fixes: Covertiy CID 1419393 and 1419394 (commit 18092598a5)
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > I think this also fixes CID 1419387 ?
>
> Ah I missed this one, indeed it does.

The description is erroneous, I'll respin.

>
> > thanks
> > -- PMM


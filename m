Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED9C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEF524673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ja/MbHg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEF524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4q6m-0000cM-Dp
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4q63-0008PU-PG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4q62-0005ur-P1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:58:47 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4q62-0005uW-JQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:58:46 -0500
Received: by mail-oi1-x244.google.com with SMTP id j132so28432205oih.9
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lon35ZY8fN86OXpLl8BYxtaO42UUGyrhZG1CSigqnFY=;
 b=Ja/MbHg+LK0tIm/w05TbS5dsAh44fnHzmOKQyUYkUPfSctlc5eo9SisVWXQcFm1gpJ
 YK8Txk10coxoU6NOmpKQvktSzKK46eVj2z1Ublwr4vtrClLJDVlRPKNIrn9wYRvJD9J8
 Hx3/8HTiEElfknjRcisdfrkywAgYGhQKvtIU3uJGOdSKTNg5Yxf0dP1QI6kaUEHDPxfy
 blxZQjRyEgkPsHzXvgYxWluthuN8bH5brMIsdY2M9oIeQ7Y1MfxQ8XucqqpmKwVRMAqV
 3X3o8Vz85EU2yyspMi2Aeb01sdHkMLaCOOZA1Hjmm/8xMk5KpjxOfk7Qz/46CV0TwlG3
 0eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lon35ZY8fN86OXpLl8BYxtaO42UUGyrhZG1CSigqnFY=;
 b=rx7qAGAk8Ih9LscQSQR5EMmSoMTOEcqjbugQED59cc+wZY2leqdnPRsquHW+dZ3nwK
 EI4D/cEdDVuUnekuPULbXPCX9THQVWTNHMjhGMQOStb5cJbXj/ssIuuU43IUFjKFoVII
 w7x33GODzCwWu9N6Wy+6jJk9T7Lb0pRPZTht82ekvmehrNBRtedRGSICnOMJQszfC4mL
 tG7epc3foficfBBBLwfg7TqGu5j9LFJD+9Nt9SgCzgdTnUAeSMpuqsvlo3sTaL5OdV60
 LdFNpWbJxDmTlMWuZPS0ykmX43wuIe0blmYTCwIxLO7ivy65xf/5YvXkPnHggT5WoKE2
 cwTQ==
X-Gm-Message-State: APjAAAX4I5DA+gHxdvrKMxu9dRvT2AaDrxKBo1yEfvppCVAyfzngQLG2
 TzpQ16ti8C4tsZ33ebRij5ZBiuK7ROeqJsmgmIbMZQ==
X-Google-Smtp-Source: APXvYqzcyvtcpqEFYDcyfzbJddXtu22VgOGBlA5cjj4/1fFs7wZ1JVyzENr6Im+byV6ezXLNEGlleyaOpa5waVqf1A0=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3058563oiy.170.1582221525725; 
 Thu, 20 Feb 2020 09:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20200220155834.21905-1-changbin.du@gmail.com>
In-Reply-To: <20200220155834.21905-1-changbin.du@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:58:34 +0000
Message-ID: <CAFEAcA-hwr+0nXmUnCgW4U2dnn64-TWUM+4LE_bS12toR-RJBw@mail.gmail.com>
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 15:59, Changbin Du <changbin.du@gmail.com> wrote:
>
> Recently when debugging an arm32 system on qemu, I found sometimes the
> single-step command (stepi) is not working. This can be reproduced by
> below steps:
>  1) start qemu-system-arm -s -S .. and wait for gdb connection.
>  2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>     (0x60) for PC.
>  3) After connected, type 'stepi' and expect it will stop at next ins.
>
> But, it has never stopped. This because:
>  1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature to gdb exp=
licitly and gdb
>     think we do not support it. In this case, gdb use a software breakpoi=
nt
>     to emulate single-step.
>  2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>     breakpoint to wrong place (PC+4).
>
> Since we do support =E2=80=98vContSupported=E2=80=99 query command, so le=
t's tell gdb that
> we support it.
>
> Before this change, gdb send below 'Z0' packet to implement single-step:
> gdb_handle_packet: Z0,4,4
>
> After this change, gdb send "vCont;s.." which is expected:
> gdb_handle_packet: vCont?
> put_packet: vCont;c;C;s;S
> gdb_handle_packet: vCont;s:p1.1;c:p1.-1
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Certainly if we support vCont we should advertise it. But why
does the fallback path not work? That is, why does gdb get a
wrong PC value initially?

thanks
-- PMM


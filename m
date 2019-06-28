Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71066C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D5A208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8u0D9Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D5A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh05O-0003IY-G7
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 19:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hh04l-0002Zy-Jv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hh04g-0000Yf-KI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:14:36 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hh04e-0000On-6W; Fri, 28 Jun 2019 19:14:33 -0400
Received: by mail-lf1-x142.google.com with SMTP id y17so5018087lfe.0;
 Fri, 28 Jun 2019 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OFYiZGdEWpMn5mcWhx0/gj3Tt6NSfmRqYvudeRA7Dbg=;
 b=g8u0D9Pf/votEBl6PIgGQmLwHbCIWyAB1w1HNbf+nOESbsN8k24maugqj08p6sTa9o
 StN2bHomc0T+ZKPD8XHuPrprzOUjfdsONtuTSZe5YbnBcrh2Qjmqu8xLkKxeC9yia5Sv
 lvHNKgMMXRZZDYf5rKKQ0kaRXgBtVJezXDt843izojLdYQ1IffEizey9xNKpEi4Jwh3H
 bc9uvg1C5vy9eXLplT0J8IaLojpQOwpWe3AIkgcpgdjnriI9bN8UGVHhFdxpxPr1chQT
 hOKSbR/ZNF+gWUyDMqKFTSyzKgnm8NCdiJqi3TX8RNIu6vHytwkQpbYh9f1+J05LPGI3
 z/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OFYiZGdEWpMn5mcWhx0/gj3Tt6NSfmRqYvudeRA7Dbg=;
 b=F97S3wN5AYIesEf31AE0PvlhkB/EpJCNpVmQbP+4OJ/FC4oihToCsXb5P39JnkP4HE
 xdx+/v5ny+/1L3ddWh5D0uEiTu5gQ4bt8pi3REh7WgMozVhuy+OlR05SReXFjodSM77t
 4U/z24SB0QIo18adVreOTWzMy95b2LEnxCxslO1kBkpawiHSRitqtT9mMV+80aZ8hAQ4
 snPyVu4MzB8JUg48zj0sPNsNaYD4YrVbjuvTJb3oRAAONmrA3jWBk+kDWVywEJXTiTme
 J1yz4IlrsX4UXb0BKQOSvdnpXubwBrQdz7CokMJv4K3Op3FBxSg5KW5UrADKIir6ZxSc
 +SGQ==
X-Gm-Message-State: APjAAAUSiEGu1InYLy8IczZPLKOHoN5rYKd2p9IRkcOskoo/maaDd6nd
 QsSblGa4eIRlzIRQe8CwOWx1HakfxyyG1NtsB7k=
X-Google-Smtp-Source: APXvYqxqWbN0MY0ABDwMsnfRzLTGM1E8JYsVSDPAZfcrKFagoywTt0t0UQnLdYCnqov+aqiTxMtW+ifG9mKb6hkVJMo=
X-Received: by 2002:ac2:4990:: with SMTP id f16mr6018209lfl.93.1561763665453; 
 Fri, 28 Jun 2019 16:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-23-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-23-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 16:11:24 -0700
Message-ID: <CAKmqyKP0fp+M-L62EJcy4=rZaWAHsv_RHm-8gJWyqJZni=4hag@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v5 22/28] hw/block/pflash_cfi02: Fix reset
 command not ignored during erase
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 2:06 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>
> When the flash device is performing a chip erase, all commands are
> ignored. When it is performing a sector erase, only the erase suspend
> command is valid, which is currently not supported.
>
> In particular, the reset command should not cause the device to reset to
> read array mode while programming is on going.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-8-stephen.checkoway@oberlin.edu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 13f76fa71d..39daa95833 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -311,7 +311,8 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>      trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
>      cmd =3D value;
>      if (pfl->cmd !=3D 0xA0) {
> -        if (cmd =3D=3D 0xF0) {
> +        /* Reset does nothing during chip erase and sector erase. */
> +        if (cmd =3D=3D 0xF0 && pfl->cmd !=3D 0x10 && pfl->cmd !=3D 0x30)=
 {
>              if (pfl->wcycle =3D=3D WCYCLE_AUTOSELECT_CFI) {
>                  /* Return to autoselect mode. */
>                  pfl->wcycle =3D 3;
> --
> 2.20.1
>
>


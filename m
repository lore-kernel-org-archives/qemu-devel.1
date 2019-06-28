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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C16C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EEB208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI2swTpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EEB208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh01a-0000qh-UJ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 19:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgzzw-0008CY-4y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgzzt-0002XK-N4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:09:38 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgzzt-0002TA-71; Fri, 28 Jun 2019 19:09:37 -0400
Received: by mail-lj1-x242.google.com with SMTP id 205so7499833ljj.8;
 Fri, 28 Jun 2019 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h2/dTWL6ISNSim50zDi1d2/iFcfImTlrQallHs/IJkY=;
 b=gI2swTpc3hpHP2744lFkH+eduPtr/Td66q5JyD7zgyqEsmJM4IllGt1QrwwXXPVDFN
 Y0YRwOu7ngUC0Eelvge3UEUZH/Sj6fOZ9pgaqdNkxvPF9574QkAc3Blmb+kPHcZ01CjF
 vZ4CmO5cR4/fLYOtEeIYw2YJ782vJAZ5XQ04vbNKfIpTPi++kdmAjXXK9Kfi0X/vLOjz
 zdyQLd+0T/5iPmEdq5CKN2jPJyrV7Qh1sjALw2BGo7+K83hHWu4bXRNzCmFNNRoASxJV
 bE4rwhYiuQY8gTXUTaUskdFvFvijwVrU72BfJx9RR+V9QzjIUFF8Dy/+27NcMLm4TzZW
 Z47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h2/dTWL6ISNSim50zDi1d2/iFcfImTlrQallHs/IJkY=;
 b=CekWoGkPkHhZKV3OOMnQxhuX8bFLL7DbG8VwTYgdTJEe4hoaV7shmpH+nu7G4c028q
 YFGRc81kzsaUKyWOacvu+d4K/u1Lw0gOeycInt6bxTuwUKQyYYWwxQPsj8wBez5Sph+q
 nAO/WJC5+Et25gZAMNwL2bUctIMtJXq9At//muOYcu1lJxJQK2uE+eVDY83Lbwin5/+1
 peOehSczFg04tjxRp0K1rajO6JESuupmM1J7+e4MzNu/3acAEc6DjialyY07UfsePdVU
 wYLG/lX77IbCY8o4nxCSCTrCpIBg4P3UkE2YbJjv7l8fXYJEOM5FQSx3IdqC7Va6PF5Q
 1eeQ==
X-Gm-Message-State: APjAAAUvjD61Wb/2u3KorY8aN8WKRiX3dni+sG8SEcJYL6cBpi0cgVdz
 AagqwG2KG3G27sNAaWDSoYxEbioBhUu8b2OavAc=
X-Google-Smtp-Source: APXvYqySFBQsuNcgZ2v6yselz+Clb2qvATG/GmFcoxwGcq/5ti8AoRNHGmOuKDaNcGq9ZrCBVDBK1y+v4KCQrWgu7Xs=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr7722760ljg.119.1561763374865; 
 Fri, 28 Jun 2019 16:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-21-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-21-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 16:06:34 -0700
Message-ID: <CAKmqyKPCH3Qn=-0BQRBPYk4Ay8DgHvghtXpR93Tb-_JmfuQM1w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 20/28] hw/block/pflash_cfi02: Split if()
 condition
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

On Thu, Jun 27, 2019 at 1:44 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Split the if() condition check and arrange the indentation to
> ease the review of the next patches. No logical change.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index a0d3bd60dc..08b2bc83cb 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -309,8 +309,10 @@ static void pflash_write(void *opaque, hwaddr offset=
, uint64_t value,
>
>      trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
>      cmd =3D value;
> -    if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
> -        goto reset_flash;
> +    if (pfl->cmd !=3D 0xA0) {
> +        if (cmd =3D=3D 0xF0) {
> +            goto reset_flash;
> +        }
>      }
>      offset &=3D pfl->chip_len - 1;
>
> --
> 2.20.1
>
>


Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10527C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A5B20708
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqTd8HzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A5B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRqrD-0002c3-Al
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 01:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1kRqoi-0001ME-H5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 01:56:16 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1kRqog-0001TM-HC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 01:56:16 -0400
Received: by mail-io1-xd41.google.com with SMTP id n6so16432197ioc.12
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kleCvtmwZam83OYWW8grvNdQuz371YnsBAHBWQdmOuY=;
 b=KqTd8HzEO5OVHtJcx4+PljNDswQnMO5bsKYljlelKF0JbYRhJnmkH1AFo5gChUikQ3
 QinF1nVhLg/DWXuR0k6i5IFR+gnc+oC058VTO1R48GlVlAPzQwJUAMiajJsnX07owvML
 6BaT9fPQW44L5zoNTlHiAIOrsEwwLxh7ii9WMCTP7xf7A3RKpyPUdUEhTZ/iOE1AB+eA
 2KDfkkRfX0BOaqaZ99peKDrmVJ0PRQ74TkTAz28W8osrzkANDNMnoZFCLNzQylXHWeeQ
 Bsrt15eVvU9qxzTsBfMq3/upl728AKpzNpsB9tSSHiZ+gnyeCZ8V87FgUUPaMD7IJlzx
 Zg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kleCvtmwZam83OYWW8grvNdQuz371YnsBAHBWQdmOuY=;
 b=FlxSMleXOXZRI2nY3F5XhfqXSr0mcOc2+9wldK7gozOhzwWT97eb6i6NMSu0/t4cBz
 gnMpqhJs2R/WkNfn6EWOmlkwjUFiKdtTlEkAzBWG4dgQGBGfxboGtUsKl6kXUktt3tV2
 0rLnM/9AcV/kuPLCLe/Uw7oeK1L+sKuDHeAkV3+Q6nmtbjpuAdKY1tdPgs/bob3k1tTh
 Y8p9alYyoDSMbD7EZ6S+3rj6nTGdVHduuMnFbAJ5PUAMxXc1wtRA9diolsny8K3/7/Qi
 +KZwNThg3/ez5ywdV5AB1BCMwRKmYdNPnpZclXnHLIPYNtHTwzrscgQ/ycubpMaVFEjN
 P02Q==
X-Gm-Message-State: AOAM532+m/+CLpJkiHXNtNGvTCAKFN+57OkbZf2pK5tsicgPkEac/wbp
 a3QDlXaux/HF9BcqZTO5JyleBRr44r7DDjkOWRI=
X-Google-Smtp-Source: ABdhPJxSkdzf0zc/JADjHY/vh+6S0lP/NpceS7LDgcla1ijGAly5TkDRZ1CJ49B3wVOQ/+gDatGN5UEP7opmFMzE7Co=
X-Received: by 2002:a6b:1704:: with SMTP id 4mr15843488iox.77.1602482169205;
 Sun, 11 Oct 2020 22:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201004182506.2038515-1-f4bug@amsat.org>
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 12 Oct 2020 11:25:58 +0530
Message-ID: <CALHRZuoJpFNOJ+PDMPQvu4B+sCB3=3S03ieL99Y7tZwVmBS03w@mail.gmail.com>
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=sundeep.lkml@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Paul Burton <paulburton@kernel.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Finn Thain <fthain@telegraphics.com.au>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 David Carlier <devnexen@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>

Thanks,
Sundeep

On Sun, Oct 4, 2020 at 11:55 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> These individual contributors have a number of contributions,
> add them to the 'individual' group map.
>
> Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: David Carlier <devnexen@gmail.com>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Paul Zimmerman <pauldzim@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
>  contrib/gitdm/group-map-redhat      |  1 -
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-ma=
p-individuals
> index cf8a2ce367..b478fd4576 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -16,3 +16,25 @@ aurelien@aurel32.net
>  balaton@eik.bme.hu
>  e.emanuelegiuseppe@gmail.com
>  andrew.smirnov@gmail.com
> +sw@weilnetz.de
> +huth@tuxfamily.org
> +laurent@vivier.eu
> +atar4qemu@gmail.com
> +hpoussin@reactos.org
> +deller@gmx.de
> +alistair@alistair23.me
> +fthain@telegraphics.com.au
> +svens@stackframe.org
> +aleksandar.qemu.devel@gmail.com
> +jhogan@kernel.org
> +paulburton@kernel.org
> +vr_qemu@t-online.de
> +nieklinnenbank@gmail.com
> +devnexen@gmail.com
> +jcd@tribudubois.net
> +dirty.ice.hu@gmail.com
> +mrolnik@gmail.com
> +pauldzim@gmail.com
> +linux@roeck-us.net
> +sundeep.lkml@gmail.com
> +ahmedkhaledkaraman@gmail.com
> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-red=
hat
> index d15db2d35e..4a8ca84b36 100644
> --- a/contrib/gitdm/group-map-redhat
> +++ b/contrib/gitdm/group-map-redhat
> @@ -3,6 +3,5 @@
>  #
>
>  david@gibson.dropbear.id.au
> -laurent@vivier.eu
>  pjp@fedoraproject.org
>  armbru@pond.sub.org
> --
> 2.26.2
>


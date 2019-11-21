Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD6C47410
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D762071F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5H/dPHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D762071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmiH-0003I1-IF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmgp-000254-JB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmgk-0003Ei-PZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:40:07 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXmgk-0003Dg-Kz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:40:02 -0500
Received: by mail-oi1-x242.google.com with SMTP id d22so3178431oic.7
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZHEvuPcUrRRnnBUcjqoNVFX+hXEuBwKIKcUr3ROjNtE=;
 b=k5H/dPHOT0fk6WkAHmhkpdKpMjg5U+amO6Mj8zdgKwA91b0qktegODNz2Muc2fIXoK
 drmpWzVXouKiD2eYCqskRwbr01g02xXq/LWdlluDX3ecq35xazkT2r1WoQtSomiEOORm
 o2pzx/OnGKD/8ZkXKblz9GtZM58h+RQIGqJV5aiO4oyjV/o9Pv+kdsAJtkWATeSGkA+C
 aZhqx/6zftULV8ioRQaKPmgLUCrIRTkrO4QHEh7sgJ/nibBKWJnTZ9IjpWXAR04X0XQg
 kinKH1ZJvg1uludYTFKDegLQIY4/q13Qdif4jfkSNlYzjzmHEOB2xJ7wc0FIccXaCwPC
 7HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZHEvuPcUrRRnnBUcjqoNVFX+hXEuBwKIKcUr3ROjNtE=;
 b=CidotBNGzBgM/6YVPw4Yc9UBAX/3Km9ldjiAZJmoSakbrdV3JIyfwpMuQwKTQNhu8h
 ig5qTUV5jME+tcg+1XYeFDQ7jRwqJ/YbbbmVVHVxpPZMYTpparOybxSNliL6lnAoyiPm
 MhsL4rTBrhiiRUYfAxOJdblxu9NGZ9Nwj2+Tmso939AOZPGMvnu3bAO9w6vD++kcgxib
 cGtZstA1JrIMf8ugqhzyv5ymw9hiArbOdC6KytOywXfLX4M+SRVdIq4MDuVH2t/NsD9O
 4NDYNTwq1etMtpjQnvxtDSvMzjzqKcrClKXHC7JDccdU7PdaaYiz0ISxe06SMj4ZfZ+L
 B9vw==
X-Gm-Message-State: APjAAAUzqe4GV9iLUwc5gSSWjk8scB2qv9wDcqcvpNy7g5GdNPs+4a7q
 oHcps2F4TOmnT5wdlB0xHe87Yp2J8GEoQdJ32JbNZQ==
X-Google-Smtp-Source: APXvYqzvQBPSWzwRVeR4qcIls5BMbdMmuAFYWtyU1RknV4ptwh43kCaJd3MMBEUOLsNBZ+9tSZCrUyxGtbz6/d3ycR4=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr7705875oij.163.1574343601704; 
 Thu, 21 Nov 2019 05:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-19-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 13:39:50 +0000
Message-ID: <CAFEAcA-3VnjHdfUBfHKQKCm_BjHjCZrDCChm5ycxfD47m7sq+g@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 15:28, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/mips_mipssim.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index bfafa4d7e9..3cd0e6eb33 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>      if (serial_hd(0)) {
>          DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>
> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>          qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>          qdev_init_nofail(dev);
> --
> 2.24.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


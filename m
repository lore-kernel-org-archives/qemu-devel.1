Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F3C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320AF206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxsw3/A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320AF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia32Z-0001Wz-60
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia30M-0000Pf-4I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia30L-0002pr-66
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:29:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia30J-0002mF-6a
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:29:35 -0500
Received: by mail-oi1-x242.google.com with SMTP id 128so13080283oih.4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cVkrzkWqcgEKI0CFuGe2OQcbBZV1wgSoD4taVQijJDE=;
 b=Bxsw3/A58XuWAVAc3xrs/gVggRdq/1cF3b82dQqwUJjpFjZnO1jqndFK6rWCt/+JCB
 fZ4wFXhLUcuIXwTX2cKuY+k1g5V3P99qzTGU5nLxHRw2Nc0ve+KFvMuNQk7QrBZvIFJu
 uhwS0e7wTT5PsWw1pSYRsDUNBjeh8vemBhiQdhlta6r/MZWWYs5ODgSuEC/3SOcDLOHf
 C/ZaFmZh3RoNThK2H9aj9i8Jtqf6rqKVOoD95X6k7sM3Xj3LwBJRJH2vTMK3C8RsLpwG
 Kbd0lWO8nvyQrCKra4S3VHVbKBk9+beXDZLxOpOyzkPN8MIWs41Ps9MDt82Zc7Bj41r6
 aRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cVkrzkWqcgEKI0CFuGe2OQcbBZV1wgSoD4taVQijJDE=;
 b=JO0tqyxBqBXnIdKUYNr1kgzmSTmN69D2bx7I8zuUffOXOZJRsVvxE+hWXF1i76Ksw7
 KFwqf+hGhc8Sxz9R3dryQUFGkya2Y7LHf2LYAGBm+0FH/SAE+Yv6c6h24BYXZI7ieu54
 KVRh2m/TFvcq7a0uCMtUWiIzY4LMhTfZtBLAdMm5DVR3RXl0YYTI+DEaGdkpx1EZ4ctJ
 SLloTd6MXtn5bXyPW3iRj5XVe/dy/QHVcKnbDD3eOnNvK/mW4hel3Bjog4W6J6sXMtSa
 ZSlwsmq4KhRkfvIqJaORoESQHbP2RykTEDwYGEVujjm+KKSjyyLi6+DlcNvCoGqGrfnW
 LZww==
X-Gm-Message-State: APjAAAVe3TRX0yrnvPesc1zaxfAUxKiohwmMHXUtYHM2TumGvY5ZRJcJ
 MoA/q/nMN+HBUJPSK35xoVQ+jiht7S3jOdP48RY=
X-Google-Smtp-Source: APXvYqwtKlOU4PcuYyfWNEqk2hVFPKnS8lgxTmJDRwwv4gsLaA/QoESwoalYGhGc3Oa+dZZHgJJkgrQJz58ZVtkx+2U=
X-Received: by 2002:aca:d17:: with SMTP id 23mr5576657oin.136.1574882973057;
 Wed, 27 Nov 2019 11:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-12-mrolnik@gmail.com>
 <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
 <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
 <CAK4993hKFzOStiG=A4jybEXQWcdXYZMF-+gF_SHq+7vsB_P03g@mail.gmail.com>
In-Reply-To: <CAK4993hKFzOStiG=A4jybEXQWcdXYZMF-+gF_SHq+7vsB_P03g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 20:29:22 +0100
Message-ID: <CAL1e-=jfpkf5_KaG0YOBHP_SGA+7-q8ZZWpxaqfNHfQJoGdLKA@mail.gmail.com>
Subject: Re: [PATCH v36 11/17] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 7:48 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> too late :)
>

There will be opportunities in future versions. Whaaat, did you really
think you would get away with only 37 versions? ;-)


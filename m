Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4ACC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4477120721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4YwEUf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4477120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipsKA-00020h-EQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 06:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipsJS-0001Q8-K7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipsJR-0001pU-7r
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:18:46 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipsJR-0001kH-0F
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:18:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id d62so1516560oia.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6H86c0+pUidvGV948GX/ChwTHbD1XqxMISNA5HWOTdY=;
 b=J4YwEUf8hWBJGZalVELcAanxAvhiLB2nlCMEfK8zz3hOLoYFKCHVurgDDFaoTWdDQt
 Jv3zE7Zd7WmSFpowz/aMwjvRnbyPiCmasqA8FrkgsYzq8fm1seakQCxCHQ6Fsguk+eMl
 Is7EL1naqx8nNGyVwxVxVGfSYxOTQZ1AUdoKcKH/+3G1EbGEflLyZCdQcEobdR6a+NA1
 Wuv8vOqIDoUyt9lCflAxYMvbvLGNByh/pObFDhJ3yDu2vXsLxFQOQ1vN19GCd5AVqB50
 bVXKx9LCtjtOsEFngxLKJvENKVVM0CZQH/cmOSZvNPXhYoYjcDkYIcFbaSy2fZyk0x7h
 96pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6H86c0+pUidvGV948GX/ChwTHbD1XqxMISNA5HWOTdY=;
 b=DFM5UKeKULxFwZqE9/W3QUddsrjVI4usCW9G57QTa0dvBIaZcHjdd/n3dQgQDzmM4/
 dppgco/ldsxasMMMAtAf1qMabQGjH6brG3sVKyI0tOQe14KXlfkugpERdUCQdXOE8tkA
 mNAt4bcJTj+R+UDLdfp+EaF9Bw4GbARuyCYAPG+Np2EpmkznVBfUVIfmf9pqyhI3s1Xk
 blnWmwsrLC46RPZTY1MEhHHoKT6/8Fmffzl6BQxzV8TBWzm+ebgEoJYrnJyI2H10DhlK
 Qh5u7HtNIfQB1bF91goa5fFE2LpA2qJyeVQYLDKz164mhmRzcZrhR/Sg+mXIaHf2uNqi
 9EGw==
X-Gm-Message-State: APjAAAXrXwSPYxtOZXLMB9iYx+b6KZ+vVfXbwgQIFpPaooxrkwmJAd/S
 eR/uG/HyrRoKTidVzATM3Tk7obX79BPfHvXyu4dbcA==
X-Google-Smtp-Source: APXvYqz/afE6bhfY3DOJwEsvCXQwKSsNhROKCkugGyB3c0W5LSAvG0dtq9NPzOjhwpVF0nevJ8DBfR1VisEmnw2YKe0=
X-Received: by 2002:aca:3182:: with SMTP id x124mr1869540oix.170.1578655123693; 
 Fri, 10 Jan 2020 03:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
 <20200106144622.1520994-7-marcandre.lureau@redhat.com>
 <CAFEAcA8c3A_zXcHRF3kj9z3C2AtLLPatQ=h=NX2+Ywzj+OiyVg@mail.gmail.com>
 <CAMxuvazSBkowtk1p_tDFs+j8TJ53TfuCKjyBDeDVP3Yuj_uoEw@mail.gmail.com>
In-Reply-To: <CAMxuvazSBkowtk1p_tDFs+j8TJ53TfuCKjyBDeDVP3Yuj_uoEw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 11:18:32 +0000
Message-ID: <CAFEAcA-NgWGdaNMLneYMWTGTaxJgW6xs-E4oKyKnz+DTCGL35g@mail.gmail.com>
Subject: Re: [PULL v2 6/9] configure: add GDBUS_CODEGEN
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 at 16:40, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Jan 7, 2020 at 8:14 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > I've just noticed that this seems to cause problems for
> > the NetBSD VM, because pkg-config reports a value for
> > gdbus_codegen which isn't an installed binary:
> >
> > localhost$ pkg-config --variable=3Dgdbus_codegen gio-2.0
> > /usr/pkg/bin/gdbus-codegen
> > localhost$ ls /usr/pkg/bin/gdbus-codegen
> > ls: /usr/pkg/bin/gdbus-codegen: No such file or directory
> >
> > I think we need to install the 'gdbus-codegen' package in
> > our netbsd VM image.
> >
> > Maybe configure should check that it's actually got
> > an executable file before trying to use it?
>
> Sure, that should be enough:
>
> +    if [ ! -x "$gdbus_codegen" ]; then
> +        gdbus_codegen=3D
> +    fi
>
> I can send the patch.

Hi -- did you send this patch? I can't find it in my mail archive.

thanks
-- PMM


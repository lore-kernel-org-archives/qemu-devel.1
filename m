Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FBC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B71920787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFTISvY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B71920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREoI-00027R-Nw
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jREnP-0001EL-3L
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jREnM-0006ef-Oj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:48:05 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jREnK-0006Yp-Oi
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:48:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id r25so1766875oij.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tJu+dheAQXgGwmJsve9C9rYr4L0AwGPYVm54F6Li038=;
 b=nFTISvY3ym4cW2WUuJNuw29ZDY54qn9D5pBWSRwNIensLP7d+YKOxgN0Lx7/CrqeRb
 CFxMCuaWjYwhtB9iUVXS2u9/rTlb/tZGAiB/Se4O9SQi2x31/mKevpuVFxZLwXKAA9ge
 zueS4+sr2o/b3RzFaXmsq19Upy5jdVufBTS37LzGdWo2H1P0BBfWsrrI6ovc4fIF651f
 0U2Fl5Q+pxIKSH382IccEsRcBicg54AhvjeQO+e//HqH2v3l+OjaxtVeZyeycrdyvOfz
 F+m/HFDZoqghY+d5EKTpm7didenx/11DMPSLhf9uIib5U+wHQboAm9IW0o1KwYx9R7po
 ysNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tJu+dheAQXgGwmJsve9C9rYr4L0AwGPYVm54F6Li038=;
 b=AqeXWGcO8xiLErnu85nm6gTCxDeX7py660+FlKvrzzMxsrWXjS2mIgL7NxsVtLRg2U
 U9DUL9trabywPPD+Kp8jxBBDFMRN3nm4DS8VLGrI1aCtfcan2uDRtpxmeyUhkC7VxCvY
 KnYS66tLZjCH9iSINPVP2uvOwZfnILba/H7hqSHu+gHa+CiPxalYTCnCD8OjZfPCbNqq
 g/a56JdL/BpDVQett7WNaMM9gbMewZ+M3VPxTYPh1ueF4C/tnpJ7cDqNtZoSHwF5vs34
 +XA5uxPHmcQdniAHWxRSUoR61O0ABuNNJWRajvs5gWnR91vL+nU4V3QjUdY5Uz9xQl2J
 UqLg==
X-Gm-Message-State: AGi0PuaRRvjXE4F7rozUvANzanirebJncfYD8NgO/rgiPVu9A0vvNCHZ
 S1q8khTYlay/YlSOFMG6XvXz0fMim+VDKwLbo+qmOQ==
X-Google-Smtp-Source: APiQypIm4a6xzGr01Fm1jXQvTczXy3VP+yOfZENT9CpEQwDTxnfLLvXo29dt37Tdl+4D1YQQtMKkIeNU8efAdqjrYCw=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr6368777oia.146.1587559681331; 
 Wed, 22 Apr 2020 05:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200421170227.843555-1-marcandre.lureau@redhat.com>
 <CAFEAcA85GEfDiwo8a9r00x1e6a5d6UDw6LJiYPkm0EstMtccOQ@mail.gmail.com>
In-Reply-To: <CAFEAcA85GEfDiwo8a9r00x1e6a5d6UDw6LJiYPkm0EstMtccOQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Apr 2020 13:47:49 +0100
Message-ID: <CAFEAcA8Cy4LYO+44bTf82JHtuM13XiSvUhUE-mwbL97kd8Uh_g@mail.gmail.com>
Subject: Re: [PATCH for-5.0?] slirp: update to fix CVE-2020-1983
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 20:19, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 21 Apr 2020 at 18:03, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > This is an update on the stable-4.2 branch of libslirp.git:
> >
> > git shortlog 55ab21c9a3..2faae0f778f81
> >
> > Marc-Andr=C3=A9 Lureau (1):
> >       Fix use-afte-free in ip_reass() (CVE-2020-1983)
> >
> > CVE-2020-1983 is actually a follow up fix for commit
> > 126c04acbabd7ad32c2b018fe10dfac2a3bc1210 ("Fix heap overflow in
> > ip_reass on big packet input") which was was included in qemu
> > v4.1 (commit e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb "slirp: update
> > with CVE-2019-14378 fix").
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi; thanks for putting together this stable-branch update.
> I've run it through my test setup and it's fine; I'm just
> going to wait a little until I push it to master just in case
> anybody wants to speak up with an opinion/objection.
> I'll do that tomorrow afternoon UK time and then tag rc4.

Now applied to master, thanks.

-- PMM


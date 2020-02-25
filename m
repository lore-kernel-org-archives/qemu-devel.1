Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D08C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901AB21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOOmWsg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901AB21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ax7-0004pz-Ob
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j6awE-0003Ss-MY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j6awD-0007Ys-HA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:11:54 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j6awD-0007YI-9F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:11:53 -0500
Received: by mail-lj1-x242.google.com with SMTP id o15so14208028ljg.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tv/ywrzPiHaYpuFROaU2SIXkdS4zvdd08CRWbl//3rk=;
 b=VOOmWsg28qw87rR74SQwrROd9pKV3W7uojLjkB7dS+e3TM+bJAE55+BhOpuyRiXQwC
 fR8E+PhDgRWPsO0HGDWLEIUCG+lm5dBZxL7t69FxfSuwBkmew7JF+zMU3QHyiL00aC6E
 BYTHvJU0up4EwJzLsloEQgP6B4GIcci7oAQzbdU0YDwLWlCHr8jUD8VFKJ6I0j4pKdW5
 FeSD3PaXpOyAZV/w80f1UT4d4o6aZfU9UQ+K6ftaa96rAoXcMlTASHsxuSb4KPOh+qeq
 OU8orfhQqF0kxicjjqO0zKUSpmaSVhHaMuzQ+XkMggl1xt57nIQ7HKDVwsnAd0x0LJig
 8w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tv/ywrzPiHaYpuFROaU2SIXkdS4zvdd08CRWbl//3rk=;
 b=r0u85gKTCbnNWaraa6G9veqSaYbI4clxxmKjmkDi0hN7y2kYGLLq0KOMrmba6gguTY
 Uq2wU3xHHEzNzvBvJxRuRiAq00Kcrc/0bFyXgYtrX0OgEXv2x+wSKvplBCr+jy5uxMY4
 V+4+dcAM6X4utqiiU3F/Or4KmrK/RGJMMBdYC1Gl2CPdkqxOEeQJs1XXbFhiHYCtsFgC
 NMqojPPRwnvIsoUoqt1aJ156El4D5przzN/G2WHUR9DMz5BeO8JDg81gcF5S4DxOZvIj
 udoXXVlPcVdjH9KpyXG3ZrcJdR2Dk63Yrb0I23nn/UyXQshDT4ZhvIBndj/62pR4iR+b
 5Zfw==
X-Gm-Message-State: APjAAAXK3z5STlOgKe43TcVrHxC4Lz8PEHRW7YGtUl+OYbTCUECFmOaA
 OmXOTmt10OSkti5VHrsBOBsgPzmD75HKzo/Xtj7blw==
X-Google-Smtp-Source: APXvYqylmPOhcMYzOUhYCyNb4CelssiqLFGoHDNJrvHN63cnoMypoJ5y9MhwaASIfPinT4PlFATF47NjC82tqqE/FAo=
X-Received: by 2002:a05:651c:120d:: with SMTP id
 i13mr33560796lja.173.1582639911152; 
 Tue, 25 Feb 2020 06:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20200225124710.14152-1-alex.bennee@linaro.org>
 <20200225124710.14152-9-alex.bennee@linaro.org>
In-Reply-To: <20200225124710.14152-9-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 25 Feb 2020 09:11:15 -0500
Message-ID: <CAEyhzFvhbPbc6eBSv7+SfGqVquosuFbRmouwWKJ_MYLFrr8OWA@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] tests/iotests: be a little more forgiving on the
 size test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, robhenry@microsoft.com, f4bug@amsat.org,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com,
 Peter Puhov <peter.puhov@linaro.org>, Max Reitz <mreitz@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 07:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> At least on ZFS this was failing as 512 was less than or equal to 512.
> I suspect the reason is additional compression done by ZFS and however
> qemu-img gets the actual size.
>
> Loosen the criteria to make sure after is not bigger than before and
> also dump the values in the report.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>


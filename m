Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DADC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CA4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXLl8Up6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CA4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5ADe-0006aD-SZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5A54-000092-1F
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5A53-0002hs-16
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:19:05 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:42382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5A52-0002he-TH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:19:04 -0500
Received: by mail-ot1-x32a.google.com with SMTP id 66so2269597otd.9
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3+pfFyKwkw2/s79PnDUsgH9sZw9vPP3Wuha4iiIuBGU=;
 b=xXLl8Up6bcxD8WKw7KzqX41ZOxWt6X078FFrOsgxs42Ukkv9uf1wx3vzN8r1Fv6KhI
 h9Jn++KvFqsbx675HcinSZmDxxFgLwpLjDlCORBOepFX252GzwG404HV2KroZNEEh4Yb
 ZBhYHWrOaV8jSTC9krRq25QRYhmzkQQ+/ihG9Ge1GJsqomW9f8SOlTL0ZbsQhTfTVXsD
 setimczCK3cvYKCerdU8sVHTFv4qbWKyCiAGnq+RM0oEx5v/Czi9ekNevQWLMnMuEfDU
 8tbbD938S9Nx++H6wsbTGb1e8riw59sB5S5YhC+EBXqVSuDjbQcLo5UJLY8mNcHpofSy
 wMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3+pfFyKwkw2/s79PnDUsgH9sZw9vPP3Wuha4iiIuBGU=;
 b=fcGNhFgTAkCEM6ynUuYgVbo50Ngd+7c1iL1ZhJG0Pxj2OnkLOcDrentU2kgSEGsQG4
 0FvX9GSsi6QFV2iob+U/LlWrXthXg0gGGjvI/5Pw6D+XvGjRwm2RKdii86a8bVcc9hWx
 LzI8CBH/BgKqJ2dYpidOgJEMNwYqBDBr/ZP9uJoTPI0yeevOeFNV/AyiZQa2Ny3/NyPB
 8rwyjKN2DEPnHRPmZvjA+Hw0+vSSIP2e7jBV/DTKsBYYpj22MtzZf3zLrvVK5E1IrIy+
 YFm5rPh/9f03KZoCL42BarZmEssFU1lK/8R8ETuF3hb0h/qZs02BZqdjcWSBkTjtkUXK
 ahPA==
X-Gm-Message-State: APjAAAUNE74zdlhR7nlqRDo0TTMg64DUz2XsMdb25wtCjwIRiGHoLu6x
 XAX4w90V1Z0vPS5FFs08Iei/Av+kkwF2bce47aZSpQ==
X-Google-Smtp-Source: APXvYqzvsFJ74Rc2OHjsUYyv7c64joXR3LNIXcQGBWgH6U18WMhq36BnphxL9tDGoh1NbWUOh1s9qQOx1eURjYE5UkM=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr16488961oto.135.1582298343959; 
 Fri, 21 Feb 2020 07:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:18:53 +0000
Message-ID: <CAFEAcA97vvS9HNtE8kQQnSP08QigF3NiyZOVJT_PhJFzEQKrLQ@mail.gmail.com>
Subject: Re: [PULL 00/20] ppc-for-5.0 queue 20200221
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 03:37, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 7afee874f1b27abc998b8b747d16b77cb6398716:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2020-02-20 16:51:19 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200221
>
> for you to fetch changes up to 438bafcac55308eef4f9029c94dbadd2c7ac3bb7:
>
>   hw/ppc/virtex_ml507:fix leak of fdevice tree blob (2020-02-21 09:15:04 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-02-21
>
> Here's the next patch of ppc target patches.  Highlights are:
>   * Some fixes for CAS / unplug interactions
>   * Remove some leaks of device trees
>   * Some fixes for the PHB3 and PHB4 devices
>   * Support for NVDIMMs on the pseries machine type
>   * Assorted other fixes and cleanups
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


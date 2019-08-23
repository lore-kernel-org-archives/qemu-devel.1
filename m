Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7665122CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuTuPhyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7665122CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19sp-0002sK-K9
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i19ri-0002Rs-Dv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i19rh-00077g-7N
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:44:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i19rg-00076t-W1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:44:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id t24so6986314oij.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PfS9hCzGGB/7dSZv9pdsyVCMpI/ideNQb9ilWTuAU3k=;
 b=SuTuPhyU3c+Y/Mkzfxg7RvM3+Hsh/hPm8pKkBrUf2YVQfyKsu1foepRCzaPpist3b+
 gW4+BEWlOqDTOBcGhZeKm4U+ni+kIKmgbr3OhZUXHYFFfW+5fZj/ysVv30bsZ8TVPcLO
 CmDMpccyM2HwTSbKNFvn11g66xpf2tpKE60p0+RLYtGhVY4BWru3pyXHc4gxqxn7qjqK
 ENGIvJtIRUpbsSDLszm0HfQLsTXQhK8Jbk4peCnpF96kB/Q/ZazJCmMxbH4miC/95F0/
 zKdCMe5iXU3stLIIq/9V+RKUvjlGuvEMHPtdD9Fi4pW2f+F/oc9AQiRPHQb26oMwpTjW
 r9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PfS9hCzGGB/7dSZv9pdsyVCMpI/ideNQb9ilWTuAU3k=;
 b=dH5TAT/dDRgThyvpY8juVcqN6+PYSJX/WbVieWbg5AYobFpu1O4pmyBWdIG9H+XaZ8
 rlDDgvAl5rtNcpO48EXlB6nnfVUh/XBbx4AJAZWi2TDowB0eusBD1KLNZtPd1dgxZfg4
 mWnypIwNidE/eQNbY/aF+fxTP8wGNAvjHpE8gYkx6czKORLFBgFNVjnvUBoTAm6EDOwz
 F+xZv/JKaWoGImzLuhvzbrjB8YtONjrK3hhUMWU3gTrXq13hxMmMIhyUXGgufYwwzutD
 ePrKJxGDtfgMo8FFNoKg3Q6umvbd3tJiMKyyQuEk7wniRr5+TdHk3O9V8xYbC7yopAcZ
 oONg==
X-Gm-Message-State: APjAAAV+xHueCo6g4cWmEf9JGuiLobGQDWa2ktH+KF1x31r+4VSGJwUL
 aZXt/TZGTO7KaAbsf9fJA/ggvdA3dsT4XfU+gVFk7Q==
X-Google-Smtp-Source: APXvYqybZi7SrBIhs0UfK9tcgaP7P7BAI9x6Mr/LexFvbv7klpLc0T2EY3Due4/fyF5v8gmMqqQ6P9kkTw0zeVzdmBo=
X-Received: by 2002:aca:4814:: with SMTP id v20mr3239404oia.98.1566567867115; 
 Fri, 23 Aug 2019 06:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181109150710.31085-1-crosa@redhat.com>
 <20181109150710.31085-2-crosa@redhat.com>
 <CAFEAcA86JT-3jLV=+aqLntoe1jJr77VYvg1dWn9OBVGA6cPZmQ@mail.gmail.com>
 <20190822211636.GA23027@dhcp-17-173.bos.redhat.com>
 <20190822215420.GO7077@habkost.net>
 <20190823134054.GA3936@localhost.localdomain>
In-Reply-To: <20190823134054.GA3936@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 14:44:15 +0100
Message-ID: <CAFEAcA_dE20A+Ys4G6WSC+HfUGgQbYA65K=cmg7f3khwHWyHGg@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 14:41, Cleber Rosa <crosa@redhat.com> wrote:
> I see it being used by humans, so that brings a lot of subjetivity
> into the matter.  IMO this is not out of place within the build
> system, given that a lot of requirements detected by configure will
> print out their versions (GTK, nettle, spice, etc).
>
> But I'm certainly OK with dropping it if no value is perceived by
> anyone else.

I'd be happy with keeping it in the human-readable output
that configure emits: if it's the wrong format there that's
pretty harmless. But we shouldn't feed it into the makefiles
unless we really need it, and we shouldn't let the format
of whatever we do feed into the makefiles be driven by
the desire to print something human-readable in configure's
output -- there's no need for the two things to be the
exact same string.

thanks
-- PMM


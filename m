Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427A1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE9C22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ8EGEqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE9C22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNYP-00081h-HT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNVu-0005uO-Nn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNVt-0000Dz-NH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:10 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:34331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNVt-0000DD-HI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:09 -0500
Received: by mail-oi1-x22a.google.com with SMTP id l202so22099304oig.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xSdl2SeYHvgvJ5ZbpK7zx/2E11p/fPQL+s40eFSsUDk=;
 b=LQ8EGEqzFA8YglAYBIiVexBqTLiAfefgLc5Xf5Kgz5xPhzle0yB/affBBtTOehJ0Lw
 xsYilaK8o9N9n/42ptgV0400/3NkHls7ZjW07VF4OHbM69CVpgL33kNtVdJ9UKlUIDAX
 /IwcvMrYSNi/cbZ4n8V5lTyxgWhP3fWj9xExuEl2qzjpDjuvO7PPjLNcW97u6ukmpQ1e
 t40KuNLzejcKc1BMxmNNkJ54KjEHJXtjbfJhl2ok8R3uTGfFzjsynMO1QB7+9Uc+NGKw
 1+TAbVbwiC6tFBpELQVEjnBaaFLk0VZ34033uccepOkBp87vPaoAoHDm4ybNZ3C99mZR
 MDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xSdl2SeYHvgvJ5ZbpK7zx/2E11p/fPQL+s40eFSsUDk=;
 b=af7sAglNCJwgBvof/Vi4cjV15wVZ/mvd57yEJ5tUL55cQKvSLKdqjl70nJDjT7cI9O
 XxPVMy7Kx+z/X15vTTskLAV/1cDJhtOpPZkwtpel7OiZqqb/OneT5z7nlHUkBI53aS7Y
 CbLRx3AxWxQ48PcPW5WP9RLVZqeSGVw3c7BuumDnqRUojHNUzKnMhxW69tndijhtnhmq
 kCtuh6k77MxaiRvNcS1QQzKt4vGFgO8mu2bXsjTbM06dDooY8n5+Vv6gjEVfRh+hRdUZ
 WAZiLMPOW/SntHBFOd2tkEHNznQgdH/JXA7o2MSw7Gean4v0Iko3rAej5jRuKxQ1iGrg
 USWQ==
X-Gm-Message-State: APjAAAWDSRz802X04tJumdM80bmjxT1NYnWQ9RpV999SzPjEskEQMxNK
 dt0P+GdZXLFH22ge9e2LiyeCG/eCLPTVeRRc/L6m8A==
X-Google-Smtp-Source: APXvYqwgNP5MIpVw/5rAm1snLCPv4NXJXwbIovvuff5mFC9I2kFGW4CsRRuY+bRb6fCAc6srtSg/1NVOZJVZpOtg4gs=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr2136400oie.146.1574246828696; 
 Wed, 20 Nov 2019 02:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-17-marcandre.lureau@redhat.com>
 <CAFEAcA-dShnHHGEYrsmc+27aUrH7WUMn3=Pvn92B8XH=qtYFBQ@mail.gmail.com>
 <CAMxuvayKZXnkm_v5V1L=dE2-dJgMjcSBy0aufVjmGhLkuZW0hw@mail.gmail.com>
In-Reply-To: <CAMxuvayKZXnkm_v5V1L=dE2-dJgMjcSBy0aufVjmGhLkuZW0hw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:46:57 +0000
Message-ID: <CAFEAcA8RZFDv4njYWyhor3b75Y+N9NfJdkpGGj86gu=mCLoU+g@mail.gmail.com>
Subject: Re: [PATCH v3 16/33] serial-mm: use sysbus facilities
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 08:30, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Mon, Nov 18, 2019 at 7:09 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > Otherwise
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Does your r-b stands if I keep "self"? Or do you feel strongly about it?

Yes, I do strongly think you need to change that (see argument in other thr=
ead).

thanks
-- PMM


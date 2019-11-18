Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F387020722
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfGPNMW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F387020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhdZ-0001b7-0m
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhc6-0008Ul-Sb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhc5-00040I-VH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:02:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWhc5-0003zR-R2
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:02:45 -0500
Received: by mail-ot1-x344.google.com with SMTP id c14so7583451oth.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/T65KmuUv9KdpGF5zOQDRozywkHbk0CrYcHeiYnnPBg=;
 b=DfGPNMW2gRBbzB0k4kr56zhYtd98ylHty1567A2VSisu/DJBsOVweuUK0gI3dNCbDM
 CRfs4xMG9VtoEpfhP9F2lgkGl4h8pY6xDiFYS4o0a+NwEIOub9RzQ0Bkw1uQciwjuMTS
 dgIWDFCLY4qvy5IoLGb8dR2BrV3y/2pvELKHbixWCkYPlLr3ybRJW0HByrs0j2ZGRaVv
 EUF+McO0FVYSlfO7RCM5H8eO1Dfc9UieUSPg2IpzRwCbBIKfepojh+W5Tkx63EU2smef
 xlibInvSG5SlvKg6nRc7DD7lOfrRySKnKF9NisrlX5GdMbYgfsVIREPyATxMJsQrKb7r
 7IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/T65KmuUv9KdpGF5zOQDRozywkHbk0CrYcHeiYnnPBg=;
 b=g864ac8azMJLzwMI24kmtQg6fSnkbQSVwjraNLy/sNoCGUz4ku+zsXydBt2gm+0y/9
 QjA3V1G4d1xNaMRR74y+LOyPWtS6TqgIM3MWiZUJn7IYzJAOfJfst7Wc0tCD97eAE5UH
 sfjua/FetKjTv1TV75SaD4IhSDR/filDGGYkM2SQynpD5Wj68EzT1seu40QqNzEi9fsm
 gakyUsO38h/HSY+lt+q0Dsb+sZSqR+2JFW8N522r4ngLil/pe34sThJ+KyJIsGR+svqx
 e3b//w0wZMdLBGTkf1jPLePu2zmPBm8YP0alySZHHOLIvWvXrSBEAm2pcbOt0S5pmaCu
 fRDw==
X-Gm-Message-State: APjAAAW0vq8u2vX2lZqJ8NK3m0hJtkxfN9yvEg2oU50qwhUXoxw0y4yu
 Y0NSM0gqsMLzIlSjQtv0u+tg3zd1CaEhu1aIHfb4cg==
X-Google-Smtp-Source: APXvYqx5w1BwvHF1ENLqV9UQuSPy8ce0uvykdtzjunZN94UK478yYn4bV2c7YhsjFxIMKR7eElgwU0VbDAGiYxWbRBs=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr20742749oto.97.1574085764633; 
 Mon, 18 Nov 2019 06:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:02:30 +0000
Message-ID: <CAFEAcA8q7AHR2Azsy9C7_xynoGVtbX+nRPhJaq4iiu6krvuDiQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/33] sysbus: remove unused sysbus_try_create*
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, 23 Oct 2019 at 18:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/sysbus.c    | 32 --------------------------------
>  hw/i386/pc.c        |  1 -
>  include/hw/sysbus.h |  9 +--------
>  3 files changed, 1 insertion(+), 41 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D919820684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpmnPwzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D919820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUeu-00052D-14
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMUe9-0004DS-E1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMUe7-0004oY-Bk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:10:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMUe5-0004my-Kb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:10:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id a15so10569755oic.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h9GZbALSAwuBda1jP16mQLkmcx6KLFn06sluNqGEX84=;
 b=bpmnPwzb4kZ442RdWUZOxyaAAnPOD4wdEB+X9kw3RGjznKHMiy43A/0sZnYlWN+vFB
 lF1ORxh45h9RXLqU1s+MnoMB0cZKIy1Nfz/NccI6BnKBka80wFVzLkCVIHdGuciGDJix
 Ln13S+2fD5j1bYJ0UkwlHGlms4J8s+b29pGbLe/svBfyRLOtqFWZgbvLgz0nV4X3E6oe
 WAICNJkktmqaS8Q89jX6O2HOXDaupUOAsZG7x2J/ynY9OuhsEECFcF82G5ljHpSB0BNI
 MeKbojJQxR5Xn9Om/975Ikn++Ea+7aRxLNMIB/ryze3Hbfj7qUOGXzdq6vvit2LzE3ab
 NFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h9GZbALSAwuBda1jP16mQLkmcx6KLFn06sluNqGEX84=;
 b=biMnJksyN3gtDOKEPwzgUNgExlmNCQW5/MOeNysCEtefWG21nb7c08avbjeU9ipuMO
 2ezf6CH3Spk+sphyEK7x5zKziADKcHfg2yLJZa9TLtVvDdp0nINRn2IvzrhMbfJfRR57
 wk5Y6gjokbhQxdNMDZkJ66Q1Somzv3Dj1SScwdEV5DKp+rwsrG9qgczFXxSDbGTzPllf
 c1nz/iTsp0yieiO7X7kJtBWx+5A8X/joOQ+SSsRRISYX3D5yw1eKNYbd6lR4TqM/nyE2
 1CFIq77Ol6VLjfLLERdzaFmpip+WXrhxKSm4vTE6LeWROxn89uS1TpznJUDJk2RUxbS6
 PB/g==
X-Gm-Message-State: APjAAAUZ3os1FrplmiHrDrbw8/cpR/ikMbSLLj5wF/CpxJuppw2A4AjH
 jktz0TVwZvmolu1Dp23XHKwk2zYLrQGGb6OW1e5wLw==
X-Google-Smtp-Source: APXvYqyB/1MhnNfxI0rA9VfABISDSkvoDZciLkw4444n3Wnk9ZCHxTFwg6ybd2GSVjbbE7osqcDuRNq2r1PpH+Z7/PY=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr18803718oiy.170.1571652634590; 
 Mon, 21 Oct 2019 03:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-3-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 11:10:23 +0100
Message-ID: <CAFEAcA9Fce9sac94YfeSqfdOHF8cVqfbPax_YHSY-L6ij9og0g@mail.gmail.com>
Subject: Re: [PATCH 02/14] vmmouse: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Fri, 18 Oct 2019 at 16:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> While at it, use the expected type.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


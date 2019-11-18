Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F688C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B512195D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HESWmeMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B512195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWj9d-0004R7-7H
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj8V-0003Lp-7b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj8U-0001pQ-8F
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:40:19 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWj8U-0001oh-30
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:40:18 -0500
Received: by mail-oi1-x243.google.com with SMTP id s71so15667133oih.11
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X/qKHiGv8AHlwunNFoSi7Jst4DhffNtRK+oUrOvA1Yg=;
 b=HESWmeMQjj7dJSh2XpSICP1ltg+hHXEKNrNNW6jvhUZNcaYaVkCnFF/uHiRcNIv0xC
 c0yGbDqkepK1t09TQK46f1cybM5xLUuX9nfN339Okmbv5XR5DgU4UyiI6B+W9CfbL0MW
 A3tJHqOhgZOQ2mXIRJLbpL+nw+N0laXe3oChTDVdOUGyAtGsnTJ1hIPfk1LB8LncaG3Y
 fYFAeK8XQ+SecrCvvtDsF02p1SNtgrK0PhhEdJWsLXMLOsKVCn3oYq90J4Ilxx+VnYTl
 Nfe6VndWXg6SkjgQRJq5vi0kcpd9qVEO3yZPx37+iIo/uh/pHH2aUls1yq/pkY0xXxhn
 ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X/qKHiGv8AHlwunNFoSi7Jst4DhffNtRK+oUrOvA1Yg=;
 b=qNsBUUQhDZWbziH7SUDdgBYIxEgfwix5HAeRSnOWywiUofqulWuDU39qcjoOkjwovw
 zwktpwxDqu/PEjhIrRJr73mRg+YseTdpc2wvows9BhFaOVLG/Za3x0MQ7IKMwtQ5NP5E
 Od92UY7LA1VTk0Kq6X3ehq8rBfGjYI+sR/o20sibYiFYrxrFBdE1DtZhbWzAqdRWcYMj
 tcWfUV4CZl3c+2eEB2J4G3WxQDPtCHKqe2+11EH+mu5OLVVOCx//FFDX5P7PSTPe3OOf
 9cwrBBjHGOATMLDqEgfiGm0d4Knc7ysarWnLuaQa7+kl5cYIikwjBviASschiQhB30wn
 hF3A==
X-Gm-Message-State: APjAAAVUtDsNwZOLyxJUH1426kOHoP0VYJo3sl8nvG2vlxSbxKEBaUg9
 SG/6vtdgOcHHRQigJIQsKIP6JrkEhDhDdDZ261/xjg==
X-Google-Smtp-Source: APXvYqzeX+oTgwByRyAePop7OFowUB0YmPwx5rOctqpdB6z6JWjcfclxVHB4Rne6OkizZtMnOdASr/KG6JwXxPl9HME=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr20967940oij.163.1574091617224; 
 Mon, 18 Nov 2019 07:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-28-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-28-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:40:05 +0000
Message-ID: <CAFEAcA927BQw+kZxG84Y7tgKoiFepk+GSH3uqsUS1N95xCmyDQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/33] cris: improve passing PIC interrupt vector to
 the CPU
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Wed, 23 Oct 2019 at 18:35, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Instead of accessing cpu interrupt vector directly from PIC, send the
> vector value over the qemu_irq.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/cris/axis_dev88.c  |  4 ----
>  hw/intc/etraxfs_pic.c | 26 +-------------------------
>  target/cris/cpu.c     |  8 ++++++++
>  target/cris/cpu.h     |  1 +
>  4 files changed, 10 insertions(+), 29 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


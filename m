Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA5206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSAqaMX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAA5206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5s3-000434-2T
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5mA-00024G-EN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:52:39 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5m8-0002B5-At
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:52:38 -0400
Received: by mail-ej1-x643.google.com with SMTP id e23so1480856eja.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UZKcb+HZdFLYaQRova8iFL3RXzbeN/HyhhSZqXEiHg8=;
 b=NSAqaMX0OLK72R1tZkytkcOaNo7XRmXiYVW0OgN3tF7B4tt77LCYYoLrOCEAcBrmE4
 R1408x3VzhSQjgvMUg/LSSAJdjA0d9m7jkC59a3YryvEfduPQaTHCIoWGjfB7V2lOau/
 OBFgoceHImOtJ1t5gu6CuKIPJkMF4+JpQnCFoHCw/6dYcrc9byYoNTMIRuwia2T1RsxT
 r1hRy80YVeZ2FA40tGsNBPoQfYTYdngKlYJe+GYqRycOVkyy4W/gpnZ65wBk/JZxZncd
 fgdk0m/7sw3PBkkvUcT2aIMCmrZYhQz0UBJu/eTNQ99ZKf4GsG0WMh+bHEfhyAX3V2qr
 hh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UZKcb+HZdFLYaQRova8iFL3RXzbeN/HyhhSZqXEiHg8=;
 b=P6tzeQTd03HnRBcLuq76OziyRa0fePoptzQOJ9p0kDbWj0d0Ly9YuV7IgEUXkWRvvz
 WMONOyJmn3ncGwM0KFGtoI1iJk60Ap2FS69Qh9Tr7L/OSNkdgVfBlvMJypVTNg4IhXUt
 fdcg64/92vy1QtQ1t+oKxDoJkNbpXfWcEO0HOOVszRSlc2Ka8hWwA3GXdgwEsBIYG0k+
 UIkcuFxfPP9T+xyNdWvg9vjxp1YRWC+6rp1bRaJ0xfd7j18wUej5fU1hD4Ykz+YXGucx
 FSZL6yQPER0IIr4QvGT/ZfIUsKKyLChRNPsl4/kqDAF2jLungKaK9zSltLi0hmiJqHT4
 09Vg==
X-Gm-Message-State: AOAM531mdV6s3aXuBCt9cPhkcrSiKOmGz6jbw/i591bVb7nDVhxJEpLO
 BHiiDX8ENtuvY5DKLQ/l0nzjqZc4RakSALZxtb6MpQ==
X-Google-Smtp-Source: ABdhPJygZqFX/8oP0aO88XNLjrh73SUKGzCIlgF+kldSeXOM3EUhJUHmxmMQjx0ZR4M7K8aYNDRs33+s0GTwaq3CQIU=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr1292852ejk.250.1598964755078; 
 Tue, 01 Sep 2020 05:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-5-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-5-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:52:24 +0100
Message-ID: <CAFEAcA9VcT3jLosYZLfapM1hEuj_MLYd2iXWV95vAN+255Efeg@mail.gmail.com>
Subject: Re: [PATCH 4/4] tracetool: show trace-events filename/lineno in fmt
 string errors
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The compiler encounters trace event format strings in generated code.
> Format strings are error-prone and therefore clear compiler errors are
> important.
>
> Use the #line directive to show the trace-events filename and line
> number in format string errors:
> https://gcc.gnu.org/onlinedocs/gcc-10.2.0/cpp/Line-Control.html
>
> For example, if the cpu_in trace event's %u is changed to %p the
> following error is reported:
>
>   trace-events:29:18: error: format =E2=80=98%p=E2=80=99 expects argument=
 of type =E2=80=98void *=E2=80=99, but argument 7 has type =E2=80=98unsigne=
d int=E2=80=99 [-Werror=3Dformat=3D]
>
> Line 29 in trace-events is where cpu_in is defined. This works for any
> trace-events file in the QEMU source tree and the correct path is
> displayed.
>
> Unfortunately there does not seem to be a way to set the column, so "18"
> is not the right character on that line.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


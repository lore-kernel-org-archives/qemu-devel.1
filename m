Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF763C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1ED2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArFnuMhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1ED2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxlp-0006Nd-W3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juxlC-0005yQ-VA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:40:42 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:33736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juxlA-0002Cu-SC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:40:42 -0400
Received: by mail-oo1-xc42.google.com with SMTP id d125so2310068oob.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QOn/JFx0pi4TNqfT9QxJox6kKathGOZShCaDfcDbgmc=;
 b=ArFnuMhv39uQUMR7Gl83ak7F2djbRCyzMkbD00RkC+GL653xh3FIGw6u7T5iyusjYc
 1RqK0Yp3Jspvh8UNL7LusyJuKafjeIhgpBwhCrF1lx2sPgHUn+g109joBRchKRO0suoF
 DeRewJ0YaDEnBlXAZU/4vFS27KukSMTkGcU65XBO0ikaPOxX1l9OSUb0yWqNu2D5l5ul
 q0By1/WvPiF8wpKxGSvLKe1M+gzBTrRHd/qYObS0HTHUXBi96PYgbVDI/VBlMPMkRhhb
 ATUdGMCLbeuWTo0Z3BTxGzs2hCSoOAOISyrnTRfhpgaMJ7CN677CaQ96BuL1xlFvl+ZF
 Irmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QOn/JFx0pi4TNqfT9QxJox6kKathGOZShCaDfcDbgmc=;
 b=DH/B7ym3+F90YXRbhKHKIY8TkBtUJt+SvBsOOu3nIxCauAUR0yFckuhIKpN8114X+v
 cfOo/4Mlli711fuP0ZKOGmgJIRJW5aJDnytFn/pOCqXLU5m5pBJteYsr/r0OXmzp46H5
 3cnDj8ZeLx+CX6jaQEHFQ4TuC3Cw8Kj4qT+qrxNsPxHcZ4uetFEjlFtjgI2OWfROcBWO
 8wq+LGs/P4EFwWBMcFNSNbph6ixtsu02YvIGv+Ld4hCCrhNhGiyFTmn/OXYYfq2upcXe
 PHmtUrYZRVFEWDAXK4PhO3Q5JP4FG/K6lhxdQeqDZyJwpTrsfiz3uUR6XIaOKX12afT5
 vtAw==
X-Gm-Message-State: AOAM5312relMYEG4s21H2eOtuuziCFIvF3jUBjK8Drmm2Rqeah7LwamQ
 qNHCwqJEXeJykj9TDNdfb690qWOZTkX+YvHyJImlKw==
X-Google-Smtp-Source: ABdhPJwrKqvNx7KQBPhCGcPmjS811YFS7VpQxhMHhJ7lGQleJW6sJO+V1whkfyQA7P/ezi4Yo8tXvO6Ik6oaDQvh5Qk=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr48356861ooi.85.1594644039426; 
 Mon, 13 Jul 2020 05:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707181710.30950-1-f4bug@amsat.org>
 <20200707181710.30950-25-f4bug@amsat.org>
In-Reply-To: <20200707181710.30950-25-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 13:40:28 +0100
Message-ID: <CAFEAcA9Wx_gqSfuJkrf4GxEy4N5m5TQmNOe65vZzx5LjUmrWUQ@mail.gmail.com>
Subject: Re: [PULL 24/32] hw/avr: Add support for loading ELF/raw binaries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 19:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Add avr_load_firmware() function to load firmware in ELF or
> raw binary format.

Hi; Coverity points out a memory leak (CID 1430449) in this function:

> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> +                       MemoryRegion *program_mr, const char *firmware)
> +{
> +    const char *filename;
> +    int bytes_loaded;
> +    uint64_t entry;
> +    uint32_t e_flags;
> +
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);

qemu_find_file() allocates and returns memory, but we don't
pass this to any function that takes ownership of it,
and none of the exit paths from the function (either error-exit
or success-exit cases) call g_free() on it.

thanks
-- PMM


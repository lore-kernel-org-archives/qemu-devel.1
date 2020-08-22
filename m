Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE5C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CA42072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNqzEfrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9WEr-000302-R0
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9WE4-0002Ei-M6
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:18:40 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9WE1-0001jw-Ou
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 12:18:40 -0400
Received: by mail-ed1-x541.google.com with SMTP id m20so4171783eds.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hPwRXW4zmqimsF1rXbRonw/TPwj2MgH5J0yduwvBAWs=;
 b=jNqzEfrN6544f+QuHJDKmooTLKhyMU+jjwvoawSQLmzW+tVN+G9Tqy2jca6SmZMWNy
 PjNLx3pnAv/8CJsb8+Dj9ylTrRrcrFIBB1rSaoDJXogsoJARUEqUfMI3v1kkcA4PZnMZ
 LglfLf+6jWuBlqenwbZPS2ujjj+6m22SBBN92eDe4ox5befDBZeU4hqjX5cD7OVm5JU6
 kHppHxLtH3Y4ZlViCibOllPVpLHeNjSwAvod24/UUc7HZmwB6+DNYdGm2nTkZmViLIdc
 35eu+IN0qRxC87MEpFxNZs7SMhqduRk/8YixlGoxM5jzH8u7GNOOFRRFoIe/CQV2jTsh
 vCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hPwRXW4zmqimsF1rXbRonw/TPwj2MgH5J0yduwvBAWs=;
 b=E5GppYzc2tZgfQxhCrIWvErGY7lsmZMcIZhNHhFC0jLHpCtR9FjlElT8EGfb8qJ90E
 Oc65k9yPVa63nRqvJWZV8GrI0x1MPMYWFXx1InARlN7TvZNBu32Rbs5iqHX5C2f8QGBh
 gxHSVmNN30bjbwzKbd6z1j0/MZnAWOQZYJFP/Vcd8kFMp2a9SdOzeqr0RpTMxdLwA9Sy
 25MhO4TmwCfQgnoheKCmGGvd+Ge4BSq7Q+cOHzY1I2A0Qu+JG05Lz33G9om/ZltBajHE
 ZH7YPAeAPa9DTN6NMnOvjVEEHByyn2O8xgYBAZXwd8QeiIDdgGN3RdVFTriZMYwj/uxP
 wAKg==
X-Gm-Message-State: AOAM530j51cXyG+2XwAOoqCHx1oLJNUac27/r3PiC8UNy3Mbpvi1Ww1C
 io2PwBFVcr0o2JmGNt59Viuu2mfge+YTTO3atVU5OQ==
X-Google-Smtp-Source: ABdhPJyaJ/IblAMVcwnSLCdmP7GrXZE3LfBKtSmb5Jx8IxFNmoPR/sGQWugOfORMD7MsLF8SwYhUrUY/MhQg60Ol//s=
X-Received: by 2002:aa7:c594:: with SMTP id g20mr7635626edq.146.1598113116248; 
 Sat, 22 Aug 2020 09:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200822150457.1322519-1-f4bug@amsat.org>
In-Reply-To: <20200822150457.1322519-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Aug 2020 17:18:25 +0100
Message-ID: <CAFEAcA_VexUZ70aL+6ecf2MNoFCVtRfPOUJf2Z8DQJqPDJbAKA@mail.gmail.com>
Subject: Re: [PATCH] util/hexdump: Convert to take a void pointer argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <chen.zhang@intel.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Aug 2020 at 16:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Most uses of qemu_hexdump() do not take an array of char
> as input, forcing use of cast. Since we can use this
> helper to dump any kind of buffer, use a pointer to void
> argument instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> -void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t =
size);
> +void qemu_hexdump(const void *ptr, FILE *fp, const char *prefix, size_t =
size);

Changing the type seems reasonable, but it is still a pointer
to a buffer, so I think keeping the name 'buf' is more descriptive.

As an aside, is it just me that finds the order of arguments
here a bit odd? The pointer to the buffer and the length of
the buffer are closely related arguments that are widely
separated in the argument list order, and the FILE* that
you might expect to come first doesn't. "fp, prefix, buf, size"
would seem more logical. Not sure it's worth the effort of
changing, though...

thanks
-- PMM


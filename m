Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB742C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BEE207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdTVupi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BEE207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYFo-0007YY-7G
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYEc-0006Ba-CK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:42:50 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:42213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYEY-0006HK-Jb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:42:49 -0500
Received: by mail-ej1-x62e.google.com with SMTP id i19so7451985ejx.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nA/mgyo4bdJ6AprBPHyFO1GHk3Xz54ee1cAgbBU9P3A=;
 b=wdTVupi0JC0RUiWacLAdLnk6CWjqs7sGY55eq2HYksy6v88hMNROlm96+dff0MB2+O
 X3BWA+p5XVRshREp7cDpkstKS9Gh0ihAHbQqa49SbllaIL6O1XVO6N0EenZHCOPsMXLQ
 52YzO/ohMS23F/Fr6OMlc9gO8yYRxJsEG1dbD/COo1Bj1+tV5/EIDKf80LmjgePKoC/Z
 56LxiRTNPCTqziM8zbqd9gMYlV/8MSR/4SmhD2kIbAMOlM6w1onbYw86m2laBF3Bpyjf
 qXkeXkwchpccNRyl+b/DQYe3QRITC4+cD57qtIpaEGyc957v42zfiijT0rVd/JF7bXRu
 lulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nA/mgyo4bdJ6AprBPHyFO1GHk3Xz54ee1cAgbBU9P3A=;
 b=ttyhdf3z+b3RhjRj8WGsFZIr2945qzi4vdmQH3s4Oiz6VR7MqNlpYdr0gB9y51EOYy
 KECEfBHeUEdDbGIA8coghVtEx5OI3oKEW3rwAoohHeilSFYfYZCs0qeN3bCh1UqCRGPi
 GU0IL3iAlf5mJIH4FKvtDqLshKkFi6onbdULIQ4apIPkW5gf/aesnV84wI49iYo0AI/t
 2JeFqU6o6dy7vpMRS7UnnBnZ+0zsw2QBu32slaXbadcQVWsc7LElqIhl+saiC7t0VSHX
 WAhQzPFOk6dRWJfzhJ4Qd3mAtfcG/OYGvxAvOH/URGkS3KvNBc362J6CBg4BUrh7fpRA
 VjGQ==
X-Gm-Message-State: AOAM532/QBZH5FrfAxz+AZ/6CBTAXLc9w8TpXaggtKlbgNF+TmOXm6bp
 8UasYgfq4AfhMb3rdXaEw901Y+HTxxnK1xHXcWYeMw==
X-Google-Smtp-Source: ABdhPJy7NMiHnQCm7Y80pGLvBNTSLYgYOkopxcj9COzSMUTlRD+Fqx10qbB/8ME1zkReXsUenJolnd8KnN8Cwz0nGdc=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr14235701ejk.382.1604317364277; 
 Mon, 02 Nov 2020 03:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20201030144617.1535064-1-philmd@redhat.com>
In-Reply-To: <20201030144617.1535064-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:42:33 +0000
Message-ID: <CAFEAcA-8efmgL2_x=Z-9Bz1C2rR_LW02AfnMSLO29xLRhZu6MQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] hw/arm/smmuv3: Fix potential integer overflow
 (CID 1432363)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 14:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Use the BIT_ULL() macro to ensure we use 64-bit arithmetic.
> This fixes the following Coverity issue (OVERFLOW_BEFORE_WIDEN):
>
>   CID 1432363 (#1 of 1): Unintentional integer overflow:
>
>   overflow_before_widen:
>     Potentially overflowing expression 1 << scale with type int
>     (32 bits, signed) is evaluated using 32-bit arithmetic, and
>     then used in a context that expects an expression of type
>     hwaddr (64 bits, unsigned).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/smmuv3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM


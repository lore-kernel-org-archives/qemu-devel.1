Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60107C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900D2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJHvbec9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOmJ-00065j-DE
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBOlj-0005fV-Ur
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBOli-0006V0-Se
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:12:55 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBOli-0006UU-MB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:12:54 -0400
Received: by mail-oi1-x241.google.com with SMTP id c1so11511786oiy.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MukV8bwpsqSAxofwaBDyokC/kqbpn0QCRqVHMM8OanM=;
 b=RJHvbec9aEPIcGfdJiuJWKGbGiuTJYLyKOp+6XcLnr9TnRtVGySR/wVDgzE0tUNo4K
 5qziLvHwejDYnKqKt7HGKd/Po8SXg9kXJX5f2NGI3u2bNbPByoIX3RlpZ/H6f0P2YxTR
 ZxTQviwTOsQVwGgMj/L/8z/F6hAJPQpJEfYJ2Tt3l4TyIbfF1XhZ/dvyg6zm9xQqEykj
 UO+pIrKvYwF37ykfvahzoJ42megsIoqHqJ2K/zWzIiD9sm8y3we/Dmofv8OTSkgzj9yi
 EniswR8HQ5uK+yoH/EhPUazeYAl5cTPScKLjsNGUyVhg6pg3BsFT7AV0w4fARRylEE7k
 dN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MukV8bwpsqSAxofwaBDyokC/kqbpn0QCRqVHMM8OanM=;
 b=dL7Xk83AhxmG5YOYQXGZf2X+GdDcPXeIH4BDCRMUlD6Qbmq0dtZhv/PBrDziRsy+Ar
 eQImZaZf4C6H/oJwdQ4nbHJLlc14MvkrkNSW5ZiTmOQGDTNd8MdwtqQDCG0YINRgBif2
 hzDMNtwbNEZP5vrSmKdLqgBepOECF5u4U7qzbiO7il2Yn55Bt4tspePjgQAewhI7ciJP
 xNC5hSSSetzuRO3JmJlL5iCtug6Aw+N0+/UX5B290V/ym7s/0ynEE66g3HVnyiorFUkG
 Z8sT1FL6lSqrLDZ6lyjJIFHyoTzgopDXCgwFUJEDu+yX9mdVAIRatb+Vchh/rfW5rkE2
 CaAw==
X-Gm-Message-State: ANhLgQ2UtHf7CzySqVcIF2BaTgWcmkNLyf3pUVSbToPAjX8n+4CBZ7Ui
 +xKjdmwm86nEpxRkWF+ZqMCmAyWMBTfjkPOb0Fv47g==
X-Google-Smtp-Source: ADFU+vvNgAkU3h+0JOs2DFa43m4Vv+kmI2VGjdkBX/NG/BCZp2MZ//pLrHK3lafRdqx93U68AJ6afaS30zqCpnWllnY=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr730285oiy.170.1583784773544; 
 Mon, 09 Mar 2020 13:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
 <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
 <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
In-Reply-To: <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 20:12:41 +0000
Message-ID: <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 20:05, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> Ah now I see what is going on here. So the new rst files are ment to automatically generate
> documentation in various formats using the Python sphinx tool, correct?

Yep. Assuming you have Sphinx installed, "make" should build the
documentation as well as the executables (ie you don't need
specifically 'make html').

> I played around a bit with running 'make html' and using the include directive you suggested in
> the target-arm.rst file like:
>
>   .. include:: orangepi.rst

I'm currently writing a patchset which splits the existing
target-arm.rst into a bunch of per-board files in
docs/system/arm/. If that patchset goes in before you
roll the next verison of the series then it should
just be a matter of putting orangepi.rst in the
docs/system/arm/ directory and adding a line to the
table-of-contents in docs/system/target-arm.rst.
If you're ready to send out the next version before that,
then leave it with the include:: directive and we can
fix it up to the new structure later.

thanks
-- PMM


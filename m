Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAA320760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ytos66H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAA320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLm0-0004h1-QE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLl9-0004C7-3K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:29:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLl7-0003Q8-Hy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:29:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id k22so15169057oib.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qvB3s+7st933Cgbid4NgGohIcI3us5qbPlRZPMLHl1I=;
 b=Ytos66H9FDjcqwWrl7Kl0D2Lpx6y1lYMREtmVxNRbh+f/tE6yye7aljEm/7y5YUCYO
 f3lznl5X/O0L/uXlAJJM8RXbsc9JsyzZM5nZQXMZ/jJ829Xeote/hBkn6T6nfCfhKmqa
 CJvbkMJRSVhdy1YySD1PIkwgSuIcpeVF5rdxu/JlBEWJSpfOyp67NYMmYJs5kE0JTk5S
 9lPmSXTpMUW7sI2+vPEAiefSGdF9tswjuitNJYx0Uv6gzHjIsBbHeWhgenPDZ2VyDuU6
 VCBbF06K+VRKrFEU0kHAZEcpFrW9Zg8x3sseQf4UiHROdXw8Z/boCEvnh0jExeFuAZqG
 ayMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qvB3s+7st933Cgbid4NgGohIcI3us5qbPlRZPMLHl1I=;
 b=LaGdI4nPQJ0EWUdtHPiS93ss5sWih/m5h/azke7krNkDrfvQWAj/MwpdR64HNXlXll
 JcRh91QMesQm/LxdKlpx2kgmRIxgflvzKskaH/fKnCmNY2cT1X2P5nUwlpOZYlZjRu0M
 XkxtLi1/ervdVCUH6xECE6Bzz+tUSNpLF+RHwximRn9hGXjBtwbEIHiWlruulhZ8Mzn+
 9upbEsRdtDNdNiWURcI8bS4I6Vzib+oDxU/k3/AYSl1thq/Uf8Pgn0HgLWmFYdB7ljTP
 swjscUw3bv5lgfUNyxMOZZp9UbimZU6W6DuA/lJ9/q22rwZnO4AIQ/gAzvELQtKlXCKp
 oe1g==
X-Gm-Message-State: AOAM532/gpdqse4UGZMWO6SvNYM6UmM85em+H/pgJxzNUBpyGE//Mmbh
 lZW6mfYBycHGUPWgkKR3D0mrzjWCHKrA4y0UaH6ISQ==
X-Google-Smtp-Source: ABdhPJw5nE1LkDhFRk5gEBYiP93f3Je0yGZ4c7O8ABKY7/SbnZrmfmh+A3iOcs2ZSs+CN6oJWf8gwtnP1MMdctJKPGo=
X-Received: by 2002:aca:2819:: with SMTP id 25mr21127112oix.48.1593782980384; 
 Fri, 03 Jul 2020 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-2-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:29:28 +0100
Message-ID: <CAFEAcA85EKqKbgGv2c30Fb6UvBapon=br0ay_2sOMP_Dw79UAA@mail.gmail.com>
Subject: Re: [PATCH v7 01/17] MAINTAINERS: Cc qemu-block mailing list
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> We forgot to include the qemu-block mailing list while adding
> this section in commit 076a0fc32a7. Fix this.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


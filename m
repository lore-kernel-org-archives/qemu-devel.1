Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C28720767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQCiJdhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C28720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaL6-0005cH-GO
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jtaKX-0005CV-IQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:27:29 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jtaKW-0005ip-05
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:27:29 -0400
Received: by mail-lj1-x244.google.com with SMTP id f5so3289041ljj.10
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KFZNgl82kyfqd4YurG9bZV9onfue/bMo/SQgcpjROdU=;
 b=OQCiJdhXyncJLP7aivDQghGid7HQe2j3pMsL9Qm2z3jYSjqsoBvIZhwZX5Xt7lDXcx
 JoWNNgXLfjiVXxXhd1LdwL2V7jimihdaxOk1Cr77cncZC8Fxo4rBW2sEGAApzLDPUWed
 xIWP91xaY7cuKLOe8k9fJJ7awS/mH39zR/K7c/uZUX32YGtFCdI9Fr3XkwHi2yL7Uzaf
 UmbHM2/XGSIH7qmeIyhDCr4oOO0XlccHc1TQyxqMSslzN6Jq5x11kNjqqXhz/7/4dPAp
 VO8GqJtRh+DE8Kzw2JFNkrgyxfsH9AXHc4awLJejA533CxBaD3GbKFloSP/r8EEfIL/o
 dlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KFZNgl82kyfqd4YurG9bZV9onfue/bMo/SQgcpjROdU=;
 b=gkMBmK4sH2cQWn1gyNHyNpKZ8TioLWUDh5I+yr0kCTwZ/PctnHqSrU80806USMnEjJ
 E/Gdt6kUDUdkMf8HYQ+OTwc7tjAU6WKFGE7TaGmFRlRfwJEUq1mi5sxqGqFAEIl2gO7D
 gRkzmyODQrNrGde3lsnL8c0LMeIVJnozRr9odTfHuYZivaWzHoyQZa6YN8YIAMl2opF4
 1Bfr9bCYEwYgOZjVsoDMsog82xmtUkVYzzBZzADwRv23O6OOvwP0T2a0Qk+R81jDLywg
 EymJky89FX+bPdzkJk9KRVfDqYUmhNNG4rYZwrQjtzO44wvjnsDfYVsYlt7HWsFL3McB
 xwgw==
X-Gm-Message-State: AOAM532iCQ3QmneESsKevyNv9O45zN9yNowP69HWqSZe6EC2vOlVE2q2
 X4ha88KvT0lV3dTwT7FdWVOPHLrVv6EAhNsyuvGrbw==
X-Google-Smtp-Source: ABdhPJx016ufdfveBISU8AZIwtdPS7BeBEHFkd+QZfqci0A+/4zjhhSm2TIwUJj/0/xJAvkahzt9Pa6+JZktYNkVUnE=
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr27875555ljl.140.1594315645888; 
 Thu, 09 Jul 2020 10:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-11-alex.bennee@linaro.org>
In-Reply-To: <20200709141327.14631-11-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 9 Jul 2020 13:27:37 -0400
Message-ID: <CAEyhzFt56pRexLDh9ENPT=Ky7ehr_Z6BW4rAfKpqLm+VQ6-gPw@mail.gmail.com>
Subject: Re: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option
 to handle -Wpsabi
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com,
 "Emilio G. Cota" <cota@braap.org>, kuhn.chenqun@huawei.com,
 Peter Puhov <peter.puhov@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Thu, 9 Jul 2020 at 10:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Not all compilers support the -Wpsabi (clang-9 in my case).
>
> Fixes: bac8d222a
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/plugin/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index 0cb8e35ae407..dcfbd99b15b8 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -18,7 +18,7 @@ NAMES +=3D hwprofile
>
>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>
> -QEMU_CFLAGS +=3D -fPIC -Wpsabi
> +QEMU_CFLAGS +=3D -fPIC -Wno-unknown-warning-option -Wpsabi
>  QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
>
>  all: $(SONAMES)
> --
> 2.20.1
>


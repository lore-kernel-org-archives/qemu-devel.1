Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8294C20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8294C20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeZ9-0002kO-Ay
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNeAp-0004ym-4b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNeAn-0002IQ-Vq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNeAn-0002HQ-Mb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:33:09 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3959C05683F
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:33:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 6so1076197wmj.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=imnilA3lbvSojZROB8ERKcIG7XNz8EMO2/f4KNixz+M=;
 b=GYjl0TxOF1jP24pGc5jI8GSxYS+bVG8nMFS7dm5JPmZKe0utBu46xDjHByvn2bdBEj
 WufxRmrey0st1nsFNxuh5uwFeEdy+s3V55EFsqwmB+RMDRGrX6IzJ7hME2X5vc9rSvuL
 mo4ejIz+4om72UH6TMj9sx0gLc329Bw2/a3dh4RRaNGrkwoT/eAyUNbL4iekIqTLwz5M
 UafLD04WQyuMN+aOs4OMRj4z80exhY4MuZg134rb0rsz2f0d5cgpLYtKaK3Fv3266u4I
 DO2k0t/K3wr54ciBnttIGpQr46EPJQy02jRDT+OLG4nPVAC6r/ee11nbsvmOYgyyqEBC
 YK5Q==
X-Gm-Message-State: APjAAAV+wbOoHrRp5VpDvl+gesMp4dXlBcmgXuMBoMC5bXf6G8HDelgF
 FH5+pfdo8xXjDqmFc/ThEd/WAZJNyBxVE/zliprgVn+VElmBe1HQOjCHdEatNkOGD/qOShxVxPs
 x7BVm4vE8aAwXUr0=
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr5227321wmc.128.1571927587631; 
 Thu, 24 Oct 2019 07:33:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbFYF5RrO0vstHSeK+jr6YPc5Wy3bFz8ge1MhO0lovZSYMJ3w9ocQHKI/w7vvYwgbiEbgmJw==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr5227304wmc.128.1571927587452; 
 Thu, 24 Oct 2019 07:33:07 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id i3sm21116127wrw.69.2019.10.24.07.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:33:06 -0700 (PDT)
Subject: Re: [PATCH v2 15/17] travis.yml: --enable-debug-tcg to check-tcg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191024102240.2778-1-alex.bennee@linaro.org>
 <20191024102240.2778-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c4ea7902-b3ad-47ab-ad56-42f604473922@redhat.com>
Date: Thu, 24 Oct 2019 16:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024102240.2778-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 12:22 PM, Alex Benn=C3=A9e wrote:
> This adds a whole bunch of asserts which will catch bugs you might
> introduce into the TCG code.

Very good idea.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c43597f1331..ba3a8d4cfc9 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -334,14 +334,14 @@ matrix:
>  =20
>       # Run check-tcg against linux-user
>       - env:
> -        - CONFIG=3D"--disable-system"
> +        - CONFIG=3D"--disable-system --enable-debug-tcg"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>  =20
>  =20
>       # Run check-tcg against softmmu targets
>       - env:
> -        - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64=
-softmmu,alpha-softmmu"
> +        - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,=
arm-softmmu,aarch64-softmmu,alpha-softmmu"
>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>  =20
>=20


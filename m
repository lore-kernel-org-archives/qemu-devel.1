Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC49DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C114720673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C114720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFT7-00051O-Al
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFS3-0004Pq-Fk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFRy-00029P-Ch
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFRy-00027P-2X
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:07:54 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A0724FCDA
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:07:52 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id j125so130580wmj.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=98MVFa8VVafhQyEy86Cb3wBx8d+/l8jlJ3YSn4tWv+0=;
 b=pxs44SfwLQc1Jf/T5hFTMfkhkAK/ANEJ+Z+15lnX8mCcwFuJCQZfCGiu7T+99NKksa
 zu228GP8SN1SCUCqNadkuaMA4nBlV8I7QhSME+K6RRf4Jtd/ROWgTZpdSMeZO8DDgWOV
 rIMzCby1QjzAZDLynFr6zGPCDFIVdEhm1uBTvh9pnfNQ3mN/CtlRBykVJXUE6AKvofFy
 6oZ9cRsBNE3ytVCMQUcgdNnBthV1E0SKrDeiH4k83ESLyS//krQFhnNC1+jM86xCW+4k
 3EPWNfCGVR/lyzTYnjF2emRLqCN1LhZk659VKdAnid6mA6pTTnIIzESv3lRxRlwoNZIk
 yMpA==
X-Gm-Message-State: APjAAAV7mGgQQNCwh+HbdL50dTork9ByTpUK22wkzf8z+5upzZm77kDk
 C1Ho+/aU60itYgtFLD3owsW8SdNJ/hOYj/OmrHbudsVo4jxTO6T7mrmX0jW7Kxmzez6I5jYJpXT
 05w/Wewa2PlKlK9s=
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr292498wmi.151.1569449271224; 
 Wed, 25 Sep 2019 15:07:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx30bqPrDH7paa4uFbmjO5P1lgMQaDemX3akPkkj7fkqKLworia+rrwMpybs6OhyC7j/R4Khw==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr292474wmi.151.1569449270923; 
 Wed, 25 Sep 2019 15:07:50 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f186sm253460wmg.21.2019.09.25.15.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:07:50 -0700 (PDT)
Subject: Re: [PATCH v3 17/33] tests/tcg: clean-up some comments after the
 de-tangling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e90a11b4-5f68-79ba-b865-7ba9fef128df@redhat.com>
Date: Thu, 26 Sep 2019 00:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> These were missed in the recent de-tangling so have been updated to be
> more actuate. I've also built up ARM_TESTS in a manner similar to
> AARCH64_TESTS for better consistency.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/tcg/Makefile.target         |  7 +++++--
>  tests/tcg/aarch64/Makefile.target |  3 ++-
>  tests/tcg/arm/Makefile.target     | 15 ++++++++-------
>  3 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 8808beaf74b..679eb56bd37 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -74,8 +74,11 @@ TIMEOUT=3D15
>  endif
> =20
>  ifdef CONFIG_USER_ONLY
> -# The order we include is important. We include multiarch, base arch
> -# and finally arch if it's not the same as base arch.
> +# The order we include is important. We include multiarch first and
> +# then the target. If there are common tests shared between
> +# sub-targets (e.g. ARM & AArch64) then it is up to
> +# $(TARGET_NAME)/Makefile.target to include the common parent
> +# architecture in its VPATH.
>  -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
> =20
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Make=
file.target
> index e763dd9da37..9758f89f905 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -8,7 +8,7 @@ VPATH 		+=3D $(ARM_SRC)
>  AARCH64_SRC=3D$(SRC_PATH)/tests/tcg/aarch64
>  VPATH 		+=3D $(AARCH64_SRC)
> =20
> -# we don't build any other ARM test
> +# Float-convert Tests
>  AARCH64_TESTS=3Dfcvt
> =20
>  fcvt: LDFLAGS+=3D-lm
> @@ -17,6 +17,7 @@ run-fcvt: fcvt
>  	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
>  	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
> =20
> +# Pauth Tests
>  AARCH64_TESTS +=3D pauth-1 pauth-2
>  run-pauth-%: QEMU_OPTS +=3D -cpu max
> =20
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.tar=
get
> index aa4e4e3782c..7347d3d0adb 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -8,25 +8,26 @@ ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
>  # Set search path for all sources
>  VPATH 		+=3D $(ARM_SRC)
> =20
> -ARM_TESTS=3Dhello-arm test-arm-iwmmxt
> -
> -TESTS +=3D $(ARM_TESTS) fcvt
> -
> +# Basic Hello World
> +ARM_TESTS =3D hello-arm
>  hello-arm: CFLAGS+=3D-marm -ffreestanding
>  hello-arm: LDFLAGS+=3D-nostdlib
> =20
> +# IWMXT floating point extensions
> +ARM_TESTS +=3D test-arm-iwmmxt
>  test-arm-iwmmxt: CFLAGS+=3D-marm -march=3Diwmmxt -mabi=3Daapcs -mfpu=3D=
fpv4-sp-d16
>  test-arm-iwmmxt: test-arm-iwmmxt.S
>  	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> =20
> -ifeq ($(TARGET_NAME), arm)
> +# Float-convert Tests
> +ARM_TESTS +=3D fcvt
>  fcvt: LDFLAGS+=3D-lm
>  # fcvt: CFLAGS+=3D-march=3Darmv8.2-a+fp16 -mfpu=3Dneon-fp-armv8
> -
>  run-fcvt: fcvt
>  	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
>  	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
> -endif
> +
> +TESTS +=3D $(ARM_TESTS)
> =20
>  # On ARM Linux only supports 4k pages
>  EXTRA_RUNS+=3Drun-test-mmap-4096
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(via make run-tcg-tests-arm-softmmu)


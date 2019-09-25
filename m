Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB4420673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB4420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFWA-00079Y-HS
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iDFUr-0005th-RJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iDFUq-0005iR-Ak
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:10:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iDFUo-0005d1-5s
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:10:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE93A81F0C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:10:43 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m16so87510wmg.8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UUldIwW+IHzGQP9Y2UQxG8YyUqwLyaABNWdBtl6rL9o=;
 b=SLWQHTFE5/1nk48wU77AgWseTnYM03l9cD9l34Bgy1M8CUNIlQc1gslgHSjEKb10Zs
 4Na6I9pk03csErZQqTbvEjkD+z1nMIs6cz2Pmju4O446RTb62/gDonzAQemq2nRmqqHW
 bQ7ekPRRwXv4pdRRYOfV5LfbMxXqznW7ZVt/KqS1JiUjNdLF/DZ8I2xp034Zla0BVDj+
 zFhw9CE+gjfdLLQnZc3IN0XA6mrtcB5GcwgXhkHp5agGJM1v6Ke7kkB9O9/WaQ5lahZ6
 fY2mhi5fsrwf7EH4PNiE7Zcg25jMubS3wKsuLqvXQ0V0WNwIiQy2owV63qzCPZXOcZjl
 vR+A==
X-Gm-Message-State: APjAAAUt/rI71FJ1KWxmJDvMePpVd7yMrDL6JNg1OCzOUs0HL0x4XfTA
 IYQ2c7Bzby6Kw38qvulvLVMb350HSkrlavEonUQFg4SnbEq5Nyy+eQ0xkYphWNbLhuHV+jdfxz0
 DfsmFArocBIwhgdpH1BbqrEE3OH8o1iI=
X-Received: by 2002:adf:f00b:: with SMTP id j11mr351485wro.298.1569449442673; 
 Wed, 25 Sep 2019 15:10:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXgeHyCz6Cmr79Cc46v+TKaJcaoJRl1kwIpqbbFkmUMZR7dL1gDHjuTqy38t9l/DwqbG1R5355Kcg9xua7tRA=
X-Received: by 2002:adf:f00b:: with SMTP id j11mr351475wro.298.1569449442462; 
 Wed, 25 Sep 2019 15:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-18-alex.bennee@linaro.org>
 <e90a11b4-5f68-79ba-b865-7ba9fef128df@redhat.com>
In-Reply-To: <e90a11b4-5f68-79ba-b865-7ba9fef128df@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 26 Sep 2019 00:10:31 +0200
Message-ID: <CAP+75-X7Z4SfzXV3JGL+JvJi3iYTHVRVpYF-TGztF3WjKSn9bA@mail.gmail.com>
Subject: Re: [PATCH v3 17/33] tests/tcg: clean-up some comments after the
 de-tangling
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 12:07 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> > These were missed in the recent de-tangling so have been updated to be
> > more actuate. I've also built up ARM_TESTS in a manner similar to
> > AARCH64_TESTS for better consistency.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  tests/tcg/Makefile.target         |  7 +++++--
> >  tests/tcg/aarch64/Makefile.target |  3 ++-
> >  tests/tcg/arm/Makefile.target     | 15 ++++++++-------
> >  3 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> > index 8808beaf74b..679eb56bd37 100644
> > --- a/tests/tcg/Makefile.target
> > +++ b/tests/tcg/Makefile.target
> > @@ -74,8 +74,11 @@ TIMEOUT=3D15
> >  endif
> >
> >  ifdef CONFIG_USER_ONLY
> > -# The order we include is important. We include multiarch, base arch
> > -# and finally arch if it's not the same as base arch.
> > +# The order we include is important. We include multiarch first and
> > +# then the target. If there are common tests shared between
> > +# sub-targets (e.g. ARM & AArch64) then it is up to
> > +# $(TARGET_NAME)/Makefile.target to include the common parent
> > +# architecture in its VPATH.
> >  -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
> >  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
> >
> > diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Make=
file.target
> > index e763dd9da37..9758f89f905 100644
> > --- a/tests/tcg/aarch64/Makefile.target
> > +++ b/tests/tcg/aarch64/Makefile.target
> > @@ -8,7 +8,7 @@ VPATH                 +=3D $(ARM_SRC)
> >  AARCH64_SRC=3D$(SRC_PATH)/tests/tcg/aarch64
> >  VPATH                +=3D $(AARCH64_SRC)
> >
> > -# we don't build any other ARM test
> > +# Float-convert Tests
> >  AARCH64_TESTS=3Dfcvt
> >
> >  fcvt: LDFLAGS+=3D-lm
> > @@ -17,6 +17,7 @@ run-fcvt: fcvt
> >       $(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
> >       $(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
> >
> > +# Pauth Tests
> >  AARCH64_TESTS +=3D pauth-1 pauth-2
> >  run-pauth-%: QEMU_OPTS +=3D -cpu max
> >
> > diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.tar=
get
> > index aa4e4e3782c..7347d3d0adb 100644
> > --- a/tests/tcg/arm/Makefile.target
> > +++ b/tests/tcg/arm/Makefile.target
> > @@ -8,25 +8,26 @@ ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
> >  # Set search path for all sources
> >  VPATH                +=3D $(ARM_SRC)
> >
> > -ARM_TESTS=3Dhello-arm test-arm-iwmmxt
> > -
> > -TESTS +=3D $(ARM_TESTS) fcvt
> > -
> > +# Basic Hello World
> > +ARM_TESTS =3D hello-arm
> >  hello-arm: CFLAGS+=3D-marm -ffreestanding
> >  hello-arm: LDFLAGS+=3D-nostdlib
> >
> > +# IWMXT floating point extensions
> > +ARM_TESTS +=3D test-arm-iwmmxt
> >  test-arm-iwmmxt: CFLAGS+=3D-marm -march=3Diwmmxt -mabi=3Daapcs -mfpu=
=3Dfpv4-sp-d16
> >  test-arm-iwmmxt: test-arm-iwmmxt.S
> >       $(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> >
> > -ifeq ($(TARGET_NAME), arm)
> > +# Float-convert Tests
> > +ARM_TESTS +=3D fcvt
> >  fcvt: LDFLAGS+=3D-lm
> >  # fcvt: CFLAGS+=3D-march=3Darmv8.2-a+fp16 -mfpu=3Dneon-fp-armv8
> > -
> >  run-fcvt: fcvt
> >       $(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
> >       $(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
> > -endif
> > +
> > +TESTS +=3D $(ARM_TESTS)
> >
> >  # On ARM Linux only supports 4k pages
> >  EXTRA_RUNS+=3Drun-test-mmap-4096
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> (via make run-tcg-tests-arm-softmmu)

Err I meant 'make run-tcg-tests-arm-linux-user' ;)


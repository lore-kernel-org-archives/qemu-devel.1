Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78645C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404BD20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLyzJODa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404BD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrQg-0003I6-Go
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrPu-0002Gt-Ih
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:42:10 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:37877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrPs-000585-IT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:42:10 -0400
Received: by mail-oi1-x233.google.com with SMTP id 12so4552106oir.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ur5fmL2//NpBrO6ICFw2f2m5pVnQgDZZhEJ7nt1Tmk4=;
 b=sLyzJODaM9GEPEd3SHbkQKl5CBIJbOxinCOzmOe5hUoBELWkiLg6VjKUrEWkCB67kL
 x1PGIWSu/HNoTMk0E20sl7rpNg7pEDaEvQLmvDJxf5Yiuik+0km1IkBgeDIFh3vscTfd
 qmzNXUy4ACtXjVfrKAhzjljbqTINZm1LW4hRRG/9/F5917zbVhrNrfv92rT1g3XAC+Uo
 0pP1fVYQsPCSDt514matH/525o0N9pv/bgPY5C9bNjC9BAlWZgscj7DLB5qdwUUknA0w
 tU3zTEVmT4XXri98vYpqSna8O/Etwt2VJauTJGvkSkqq49VQIBVzQsdlDnir2r0zdWAs
 0zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ur5fmL2//NpBrO6ICFw2f2m5pVnQgDZZhEJ7nt1Tmk4=;
 b=ZGdgSggHEFoNRx+XU6qdWlz5v7IjnSNQNso4MDLOpICIRD55cohDeD2wTN3OZeZabo
 trzRDHDqACV7yc2U3aIQyIgR5a6cXW+C3ylrZzd9AMkG79heG3bomj2m03k0xiVp5ZEI
 7HIeBk8BjSgh+A72BCnaBNPtGH4r3mWpVaj/64YLSq2fej7oJApUn6Hkx7F+yyu0LYjK
 ZrrNBskgz+2ypL4ehWLXhwXUf7TTAQIONRQeKGEjk0oKsP2vK94UV06tyKBttf7/5UUZ
 KqdNcYHTeIe2kY1Vjg3ZAoX5+gJniAIdeXk1zBtRgMScXyp6Yet2e7XZJDSkIpBtoDRa
 nGPA==
X-Gm-Message-State: AOAM532m2VZ9yf2jw/xL8Z9QRNHKgbj7QoO4KRo0b11iVQUa7PylzWXn
 Fp+fiOUdI9a1MK0ci2gSPozXX7bxYZV+VU3Ev9bHvA==
X-Google-Smtp-Source: ABdhPJzzQ3aBZxk5c1hSm8oD50TfIJIPTYvaZT2VlTEkv0tGCyNWCUd8KFG7zan0c5FxAxsiXIU+jiHMKNbdYJrTgzM=
X-Received: by 2002:aca:1706:: with SMTP id j6mr3693500oii.146.1594381327400; 
 Fri, 10 Jul 2020 04:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200707181710.30950-1-f4bug@amsat.org>
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 12:41:56 +0100
Message-ID: <CAFEAcA85TE+W39fphhm77hNKmAJyEMmaTseDkL1t4gTkzzcbJQ@mail.gmail.com>
Subject: Re: [PULL 00/32] AVR port
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Possible false-positives from checkpatch:
>
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
>
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091=
b1:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-p=
ull-=3D
> request' into staging (2020-07-06 11:40:10 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/avr-port-20200707
>
> for you to fetch changes up to 0cdaf2f343491f60dbf7dd2a912cd88b5f9f899c:
>
>   target/avr/disas: Fix store instructions display order (2020-07-07 20:1=
4:15=3D
>  +0200)
>
> ----------------------------------------------------------------
> 8bit AVR port from Michael Rolnik.
>
> Michael started to work on the AVR port few years ago [*] and kept
> improving the code over various series.

Hi; I'm afraid this fails "make check" on big-endian hosts (s390x, ppc64):

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Davr-softmmu/qemu-system-avr QTEST_QEMU_IMG=3Dqemu-img
tests/qtest/boot-serial-test -m=3Dquick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name=3D"boot-serial-test"
qemu-system-avr: execution left flash memory

** (tests/qtest/boot-serial-test:24048): ERROR **: 11:00:46.466:
Failed to find expected string. Please check
'/tmp/qtest-boot-serial-sVGEXHI'
ERROR - Bail out! FATAL-ERROR: Failed to find expected string. Please
check '/tmp/qtest-boot-serial-sVGEXHI'

thanks
-- PMM


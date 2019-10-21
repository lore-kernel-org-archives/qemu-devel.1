Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A30D20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3ycSaeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A30D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZsb-0002Ct-Eu
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZqK-0000Sv-DA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMZqJ-00042x-4V
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:43:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMZqI-00042Y-Us
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:43:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id 89so11358695oth.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n5V0hkpRRSO03mPjVUoJC+HUPW/i9CGi8Wcaic5CS9s=;
 b=y3ycSaeU9hLQUDSOqfPcSVuTcC3tZLxwAnXan7/Z4WwvjuRwnBKWf0dR9IuuOncyTT
 v4mR3m/y36p2fCa/Pob/NErtXLcnbF/VpA2RK/S87ixJb5q6KiPw9hbzuQjLzYcNLPOs
 2jZ3RpG/ebDG4P3qlJ0YZtcrMszmOfGR7Yt37+/Ooi/yP0rJMPGyfnM+Yywt/SvOpqWD
 VzIDx8z6qWNpCTOxp8TyU0hcoRJcuq1GaDWMKJDonR2q8CpfkjSS+RymG9e14E2X6NyZ
 HQLlpqg3hGk1aWnfWbn27z9pGt/pOMLOtwrLVshRENPQreTJCodZ7vxWbUl9h7AW70dd
 UZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5V0hkpRRSO03mPjVUoJC+HUPW/i9CGi8Wcaic5CS9s=;
 b=klADNYb00oBVCoydxrWLg8+JTiDtwz0jWkhNTsbhdxb/GqI4ReqMXCDSgn0wzvk1FK
 R7IOWgD7tQ87MsuSFfvcI4YJaviY1FKwEIA4pHiAFeP+hdCYhFdZROtlxlTQPl8nRqa1
 fxonKut9YJGKHDQjAKtrTLbKPet1JfAdGvimhRxjLAzNTCU0j5DfpqzLqca9uQMviPcW
 fFg/1VqL0D4WIeZJGU8+lLUwWZRxym3kzF/fstIVUP6YlDp63tHvEJSnEvJZVdCdL80o
 Ion1rQZsrZVkaNr42KUZlDCFMLWcICsJZqSuxdjtTnaPyWhYlmfXNeHpcZ+xpBX0JakM
 wZHQ==
X-Gm-Message-State: APjAAAWnC648Q6paHM0FlxTAyGHd0kGWKrge/YVrVdGFcXDvLVH3Iuwv
 f+UJz5/pTula8vlHR+c5SUMpqbHBamB/AwdZdAStdQ==
X-Google-Smtp-Source: APXvYqzzqZ9dvD68QhKD9277TmjoeWVcAulWTrPqcukzfuGA/sSnnECf7fbi3BnO00NOhPuZUS7h1hEgoD80GIN+t2c=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr19819053otd.232.1571672613897; 
 Mon, 21 Oct 2019 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
 <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
In-Reply-To: <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 16:43:22 +0100
Message-ID: <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 15:23, Andrew Jones <drjones@redhat.com> wrote:
> Peter, would you mind running your test on the kvm32 machine with this
> change before I send a v7?

Still fails:

pm215@pm-ct:~/qemu/build/arm$
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm tests/arm-cpu-features
/arm/arm/query-cpu-model-expansion: OK
/arm/arm/kvm/query-cpu-model-expansion: **
ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:498:test_query_cpu_model_expansion_kvm:
assertion failed: (resp_has_props(_resp))
Aborted

This is asserting on the line:
498             assert_has_not_feature(qts, "host", "sve");

thanks
-- PMM


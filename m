Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654B320873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUYyULkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654B320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWyp-00023x-Fy
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMWw0-0000Dj-7W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMWvw-0000gR-ES
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:37:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMWvv-0000f5-Cf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:37:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so10798601oti.12
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mm5TGvUKEhtuKejBNL05RY4Uqnb5TiQAHsOfYFLXK2U=;
 b=nUYyULkrXAPihD8Q+0e47s3J+HadPwbcIBqxTAwtEThHUPtGhcxPqBRiUrrEC2CsYc
 MEf8XlgvWmxtgBH3jC3evESx3/93CqT73q6I9fQtEPWrOx+RRttOrymPsLZNKncgIVmD
 oARUaANgkwYcCa18XEh9fDIvsUU8LnJId/58LP843k6CR2x/NyRnVhGPexE2oXK60pA4
 CP+5pHUR/cnChMPnurHOfO8ncKjXbkRlbd0VUaocYCn7qMxuUYn281lw+XWBK1zh2B7G
 lpkqz/zQdUR3/Gc58GSvRbCVfkGi/678B/YaCczAwLadJTxBfG+Ll4X22BJ+tCBGcS6Q
 wMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mm5TGvUKEhtuKejBNL05RY4Uqnb5TiQAHsOfYFLXK2U=;
 b=IhlAdh8taNj0zAYSRFFGLBG9ueBzBLMS3rddYtdX5vtj3p06DBM9Ft6mOiOTc7Gy8n
 l1Kr6ipwmPOat26ssNNTuTnrZjFft4XDuzJScrfvHu3Prt6RqVlMZ0StJ7FgJxolUSB3
 u/M7sABkIvsHo/VKhOkZc97sbqDsvInp9Kyg4U16Fw6tR0fpR6B2AYQHYO2/buF5V59R
 EA1J1CscFOWOzYd8XK32gel4MynwYg9KNKdO2fJLCYF/5IaXI3bmwxA2r4gyBQoFeZ5c
 QQNUaBh682U2G9+s5TnnJahEOzqdwh7rwABURYeQ6XfHTYqMFSjGMzhAME9qFmWQ9sHS
 /1Vw==
X-Gm-Message-State: APjAAAXhI8TzUweXHnP66qgyZIfhKYVQ+P/01ygjzI5gp4d6L6KBWK2s
 tjlICxw9Hw3470G7eMNkvY+ImQ0iztYzcLCjsvXXwg==
X-Google-Smtp-Source: APXvYqzmRgilBJ2MK2CBZgcGYx+z/mLsUolk1WCKxIcgUOhpz1zhsJ9f+ynBAsyE65y+a0ZlWBKJS1YstnDb9Ik6RS0=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr8079621otj.135.1571661430117; 
 Mon, 21 Oct 2019 05:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
In-Reply-To: <20191016085408.24360-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 13:36:58 +0100
Message-ID: <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 09:54, Andrew Jones <drjones@redhat.com> wrote:
>
> Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
> This series provides the QEMU bits for that enablement. First, we
> select existing CPU properties representing features we want to
> advertise in addition to the SVE vector lengths and prepare
> them for a qmp query. Then we introduce the qmp query, applying
> it immediately to those selected features. We also document ARM CPU
> features at this time. We next add a qtest for the selected CPU
> features that uses the qmp query for its tests - and we continue to
> add tests as we add CPU features with the following patches. So then,
> once we have the support we need for CPU feature querying and testing,
> we add our first SVE CPU feature property, 'sve', which just allows
> SVE to be completely enabled/disabled. Following that feature property,
> we add all 16 vector length properties along with the input validation
> they need and tests to prove the validation works. At this point the
> SVE features are still only for TCG, so we provide some patches to
> prepare for KVM and then a patch that allows the 'max' CPU type to
> enable SVE with KVM, but at first without vector length properties.
> After a bit more preparation we add the SVE vector length properties
> to the KVM-enabled 'max' CPU type along with the additional input
> validation and tests that that needs.  Finally we allow the 'host'
> CPU type to also enjoy these properties by simply sharing them with it.

This fails 'make check' on an aarch32 box with KVM support:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
tests/arm-cpu-features -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="arm-cpu-features"
PASS 1 arm-cpu-features /arm/arm/query-cpu-model-expansion
**
ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:420:test_query_cpu_model_expansion_kvm:
assertion failed: (resp_has_props(_resp))
Aborted
ERROR - too few tests run (expected 2, got 1)
/home/pm215/qemu/tests/Makefile.include:902: recipe for target
'check-qtest-arm' failed
make: *** [check-qtest-arm] Error 1
make: Leaving directory '/home/pm215/qemu/build/arm'

thanks
-- PMM


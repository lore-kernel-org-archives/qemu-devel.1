Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7879C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922042082F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCk96Zrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922042082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XZ1-0003tO-OY
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1XYC-0003IN-VW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1XYB-0003V7-Pl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:34:12 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1XYB-0003Ue-JT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:34:11 -0500
Received: by mail-ot1-x343.google.com with SMTP id b18so10516534otp.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SC8tyGtOpHm57sc5gE2Q5QspKh0iTcK1s5Xp662IVFM=;
 b=TCk96ZrvyLxBaska0vmDd8zhDDHL32wBx+GpxMYTZh8GrXAN9fDOQBd1PEOty+f6T1
 vfDUvSX7ZHSIiW/dbUiu5BMA8AsYLDvPMAl3KLhhnRuE1TYR3JUUyzsXs9/FERrXgIQ0
 /h6Pefrk7ao03J/OG9iA2qBYvgOMpcFGgqXYgfHA21BfmH6nNBBSJsupWnyc35MF4cQt
 I8R7/t3gExWR92oy3Iq+GfwPHqZcUaB5OKtpOO6IHn8eA5fvKa05yhOpYh2QwK871uvQ
 /kYmRzNk5o1EnbkPGwBpLr5Rl4nVsGM4Zwf9kXtwvubhbFB1qChTuxErjCDDkSUp6RrX
 pe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SC8tyGtOpHm57sc5gE2Q5QspKh0iTcK1s5Xp662IVFM=;
 b=PZ9NJelKWAg1gf8hykdinrCnKBGOKzythrgT2+ZCaqu9VQSByNdhqIRJ7n2JC4yGlE
 losx4t17SnPLtRHAs8gezuyyzgcmjlViiYY/ZWUXdAlBkpoQkxRnRShVmvgQBzoQX0bq
 9YMeaW9WdPpI6Nxwv4JPs8jHoCvfETFvJJoSTF25loDi5CVPL38yPy6D5E/GO9NEgWEV
 KFUnkbujxgbB96jYhtI5mkukckvft2GoeTDPghP5Bq+Y1CZAh1uV/al5Baxxku/OdUQD
 izLT+VWdY9XlM2NexvlGWoJGuv1NQD7sWL0yRcp9XiSq7V3OAXg/eQZ9jjxiSNser8D1
 bIfw==
X-Gm-Message-State: APjAAAV6OsBv1SBB03nOC5LGM/KhJ/L6ldO0EyhhWE1NyhBpARF+dHSg
 aCJhAvH0xottThz16mysNjiZs8yIWikG7803cZ13zg==
X-Google-Smtp-Source: APXvYqxhAKVjdI+Q5/kjVBzMiDyMQfHBUGw1YvkgVaqNl4hsrZJ80QL4YuEgtGr+aDxrHsLz9SA+9eBupzonnI/zSlM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr5759307ota.232.1581435250516; 
 Tue, 11 Feb 2020 07:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-5-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 15:33:59 +0000
Message-ID: <CAFEAcA9rsncts+s4tVn4tY4zaMHKeqyJj1O4J=Ufx33fb=Nrcg@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/9] arm: pmu: Check Required Event
 Support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Andrew Jones <drjones@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 11:25, Eric Auger <eric.auger@redhat.com> wrote:
>
> If event counters are implemented check the common events
> required by the PMUv3 are implemented.
>
> Some are unconditionally required (SW_INCR, CPU_CYCLES,
> either INST_RETIRED or INST_SPEC). Some others only are
> required if the implementation implements some other features.
>
> Check those wich are unconditionally required.
>
> This test currently fails on TCG as neither INST_RETIRED
> or INST_SPEC are supported.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>

> +static bool is_event_supported(uint32_t n, bool warn)
> +{
> +       uint64_t pmceid0 = read_sysreg(pmceid0_el0);
> +       uint64_t pmceid1 = read_sysreg_s(PMCEID1_EL0);
> +       bool supported;
> +       uint64_t reg;
> +
> +       /*
> +        * The low 32-bits of PMCEID0/1 respectly describe

"respectively"

> +        * event support for events 0-31/32-63. Their High
> +        * 32-bits describe support for extended events
> +        * starting at 0x4000, using the same split.
> +        */
> +       if (n >= 0x0  && n <= 0x3F)
> +               reg = (pmceid0 & 0xFFFFFFFF) | ((pmceid1 & 0xFFFFFFFF) << 32);
> +       else if  (n >= 0x4000 && n <= 0x403F)
> +               reg = (pmceid0 >> 32) | ((pmceid1 >> 32) << 32);
> +       else
> +               abort();
> +
> +       supported =  reg & (1UL << (n & 0x3F));
> +
> +       if (!supported && warn)
> +               report_info("event %d is not supported", n);
> +       return supported;
> +}
> +
> +static void test_event_introspection(void)
> +{
> +       bool required_events;
> +
> +       if (!pmu.nb_implemented_counters) {
> +               report_skip("No event counter, skip ...");
> +               return;
> +       }
> +
> +       /* PMUv3 requires an implementation includes some common events */
> +       required_events = is_event_supported(0x0, true) /* SW_INCR */ &&
> +                         is_event_supported(0x11, true) /* CPU_CYCLES */ &&
> +                         (is_event_supported(0x8, true) /* INST_RETIRED */ ||
> +                          is_event_supported(0x1B, true) /* INST_PREC */);
> +
> +       if (pmu.version == 0x4) {

This condition will only test for v8.1-required events if the PMU
is exactly 8.1, so you lose coverage if the implementation happens
to support ARMv8.4-PMU. Hopefully you have already bailed out
for "ID_AA64DFR0_EL1.PMUVer == 0xf" which means "non-standard IMPDEF
PMU", in which case you can just check >= 0x4.

> +               /* ARMv8.1 PMU: STALL_FRONTEND and STALL_BACKEND are required */
> +               required_events = required_events &&
> +                                 is_event_supported(0x23, true) &&
> +                                 is_event_supported(0x24, true);
> +       }
> +
> +       report(required_events, "Check required events are implemented");
> +}
> +
>  #endif

thanks
-- PMM


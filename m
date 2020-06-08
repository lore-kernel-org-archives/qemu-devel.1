Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51836C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB0B2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxqV2PC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB0B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGrD-0001Wn-D7
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiGqS-0000vj-91
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:25:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiGqR-0002n1-5q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:25:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id g7so12354412oti.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GeGuSHT3wZCmA3munjpkH7vDl/dT5GBX8q8JpAyMUPk=;
 b=gxqV2PC2hzDoBPBrc6Ej305mse7y3cPHmHPCft0JqS23JVpkjtVfOT0/z0FyDA5yFQ
 5iK6MFk10dlZyS7e3b4lzh2XlgQTVjYbGtzk8IAohWvG3+KoXW9nAQ1Y1SN1sAVPy4FU
 MLfBbLmIzGmCQIbAYJuhXzC3A3XtPKZwcpGM060XevfvbqspMuXL0PxruWppF+1eNOPZ
 /21oXFnXRM5VWU0f53lfcZQ/aDyGvZfSV02F3ceNlkqH40S7mQWu1OiVC0rFX/XErmCR
 eg5MSOM0tYzwyjTPrc9LASCR75l7c137durJCOGnaWsgU1iHMRv1xEIpknStNRP4+ciZ
 +djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GeGuSHT3wZCmA3munjpkH7vDl/dT5GBX8q8JpAyMUPk=;
 b=AZVfl7KN0mSsLXIZuuSID5cRdOLtBw6AgwIbRgdiscScCVI+Pt8SeOwjtcLAk1i2I+
 YOYJs8V3l5/UNgPDzJcsBjXKqB8ZYQzA6nZpg0z7Ia3cAar6eo7mEORW492MY5De1ppR
 3HgP3sVXp/IkpyOU3iRxz7NUH8NmcTvkDNOlT5e86q6Tw63uioizGrRKcKqXA0PktEKI
 S2ANnaGyPXw33eOIWi91aSdTt1fjG60c/7LgT75usyASOvC73Ymk4bEyYWDa3VI9ZepA
 B9GG82piZWaRYiJ8O6cEElzUnRIVNoUTF1tcMtTNNjJJtKo+mGwZPFFbi+ivz5JzMoQm
 I7TA==
X-Gm-Message-State: AOAM533/ihjFZxLB2ICs3dZavFpPKVCRCni5XVAN1mrF1YoNXCnw96Jt
 KkPQ0JT2IPrtOm9maR8aFQwphrZwzcfRJKjMcWXXEA==
X-Google-Smtp-Source: ABdhPJzHEU6yttNAHa25LjOb3yaPWPoFWwQn5Pho6D/n6IGYvvrkXnNlnKh6yAQ+n5vRAGB6I1gYoE3amIah5my63es=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr4934173otn.221.1591619137898; 
 Mon, 08 Jun 2020 05:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200608114028.25345-1-leif@nuviainc.com>
 <20200608114028.25345-2-leif@nuviainc.com>
In-Reply-To: <20200608114028.25345-2-leif@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 13:25:27 +0100
Message-ID: <CAFEAcA_EUf+4NNr+=XNNMpf+p9v0AJC-EV4YyUZZB87ePASXvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] target/arm: commonalize aarch64 cpu init
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 12:40, Leif Lindholm <leif@nuviainc.com> wrote:
>
> Some basic options will be set by all aarch64 platforms.
> Break those out into a separate aarch64_cpu_common_init function, which
> also takes implementer, partnum, variant, and revision as arguments to
> set up MIDR.
>
> Invoke this to remove duplication between a57/a53/a72 init.
>
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>

I'm afraid I disagree with this patch's approach. All
these three CPUs are different implementations, and it's
just coincidence that they happen to set a lot of the
same feature flags.

Eventually the hope is that the feature flag checks will
be replaced with direct tests of the ID register bits,
at which point the feature flag settings will mostly
just go away.

thanks
-- PMM


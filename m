Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B32E214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bsk8kXkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B32E214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaPH-00084s-CC
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaOS-0007am-OE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaOR-0007Y3-NA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:18:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMaOR-0007Xp-Gw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:18:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id i16so11549388oie.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cEXmLrLOTGKJDPnqAGoAgVNhvpHJPDHl4lxsEKXEJLE=;
 b=Bsk8kXkKD4IWxdJhd29rL+XGIAPaw7KmHu9IHgic1EKEXeNoYrbZeQeUytZM3A9XXb
 gfGG/kY8/GkZwKfXh6UbHhKtym8A9CxJbPCHwESeP05iaT4b4TVNw+nmgEsI6KooBc5N
 c9Qer6aLZ7U4IRpLBrqRVNrUINt2By0REwOg3P8SlnBu4x7O300MaE7yu3Id/iwM8xTS
 xKVAA10yQ+pKNk5GU8UwpX0oSkZediduwGEIfxFzeiStD9UO3dVY6ByREuIM2rOhcmsL
 2wYXbFhnO3gx7IIaOpG7QuwnZgi4jw0OMLoEaNfEwG8FhqC+4lWofMv5iJd3YPdYKpBZ
 Vl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cEXmLrLOTGKJDPnqAGoAgVNhvpHJPDHl4lxsEKXEJLE=;
 b=BcakmDM/8/3m/tkQ0ObMmzQtZrNaIUKwuZEhzVKB3ZFD2LqOupNeCmzbq4dLOXnDRF
 xnREF8q6Au6naMpXlSH7QtsevF8aSuxhj3SjvdW0C7Qqzr2IKHCtyz8z2CFlRN0hiCAN
 k6kich38ao1Gla7s+clGPL4DZD9M4YIygrWjis6rdObumlC09o0oWTQsuXI/+Cyqeb1w
 SJmMnykwasi/hb5FSe2GeU0BatxI1UPW5CjwllrRHoE+w5QnCAo9pmM0+QlWER5ils7r
 3JeIxi6x9gLSNVAVqo9+NdjHMRb8TRf333FDUWq7tz6e6DrKAC9Uvk5pY8VWjsi8TcLs
 m0eQ==
X-Gm-Message-State: APjAAAUnaZEzfgsJJ9PTWDrPoW1DdQADbekgirSPKF+Bj5UAmF8WGaFV
 zjwC6Q4TqPbEgSS/F9WU778ZzbzHPHBAeQmq7/z5vQ==
X-Google-Smtp-Source: APXvYqwGTIaXASwydD//8FEXj2ivwVIWKNwFgB2xb5SNHrS5DvAB1udzm3EGH4hz4cPoyGxGN/KM0PYsa1xpepuXOFQ=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr19041250oik.146.1571674730634; 
 Mon, 21 Oct 2019 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
 <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
 <20191021142336.e4xekqlmqv5txu5w@kamzik.brq.redhat.com>
 <CAFEAcA-bezS5tSVB+N223+N+xoYYYHuSJmDTaRCJgO+4Y=VjdQ@mail.gmail.com>
 <20191021161226.mnm6eomghb37xlby@kamzik.brq.redhat.com>
In-Reply-To: <20191021161226.mnm6eomghb37xlby@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:18:38 +0100
Message-ID: <CAFEAcA-vHmtCi3HGqpu34sAaNxGeQwS_+0yZ5Hr4SbnGm+rjYA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Mon, 21 Oct 2019 at 17:12, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Oct 21, 2019 at 04:43:22PM +0100, Peter Maydell wrote:
> > On Mon, 21 Oct 2019 at 15:23, Andrew Jones <drjones@redhat.com> wrote:
> > > Peter, would you mind running your test on the kvm32 machine with this
> > > change before I send a v7?
> >
> > Still fails:
> >
> > pm215@pm-ct:~/qemu/build/arm$
> > QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm tests/arm-cpu-features
> > /arm/arm/query-cpu-model-expansion: OK
> > /arm/arm/kvm/query-cpu-model-expansion: **
> > ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:498:test_query_cpu_model_expansion_kvm:
> > assertion failed: (resp_has_props(_resp))
> > Aborted
> >
> > This is asserting on the line:
> > 498             assert_has_not_feature(qts, "host", "sve");
> >
>
> Oh, I see. It's not failing the specific absence of 'sve', but the test
> code (assert_has_not_feature()) is assuming at least one property is
> present. This isn't the case for kvm32 'host' cpus. They apparently
> have none. We need this patch too, then
>
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 14100ebd8521..9aa728ed8469 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -136,8 +136,8 @@ static bool resp_get_feature(QDict *resp, const char *feature)
>  ({                                                                     \
>      QDict *_resp = do_query_no_props(qts, cpu_type);                   \
>      g_assert(_resp);                                                   \
> -    g_assert(resp_has_props(_resp));                                   \
> -    g_assert(!qdict_get(resp_get_props(_resp), feature));              \
> +    g_assert(!resp_has_props(_resp) ||                                 \
> +             !qdict_get(resp_get_props(_resp), feature));              \
>      qobject_unref(_resp);                                              \
>  })

Yep, with that extra the test passes. I'm just rerunning the
full 'make check'...

thanks
-- PMM


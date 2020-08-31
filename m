Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB33C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2BF206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSFumeiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2BF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCowv-0007jl-4D
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCovH-0005CG-CN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:52:55 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCovE-0000Ls-2z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:52:55 -0400
Received: by mail-ej1-x643.google.com with SMTP id b17so9870809ejq.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZG4mEf3mw2LldYqTv17dYwa9Wjjf+ZQLxvryr99ssQ=;
 b=OSFumeiBKc+QoK/T7nH7ZuJ+7ecc4ATRJh4gjXqN+qdiNWXdHBDbAyckzDH4WcfkVE
 7rFiEqxuA7amXuTgWvc2L1RLvkm7WeR80EtwNSFTnJIwYER+tVv98wFUwPJQ22/7ema9
 dtw2r/5eih4LbmzQS+pkX9RuixVahNEdVQjIhSFSFB43mndwCSORBTj0WVkrHMx0GSiU
 HMRsMVkTy8IViY2KlyQoJJeOjHrkhKfvUp96zJ9OtjCXYAQ+ZjRvbHfWXL1Adcchc6T9
 qCyE5q5NZMdUAxkDz7BCWU0tyO/jnlVLJe+wLx4tc8pDF9pgYDrQlnaHpvSevy6VL7nT
 I+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZG4mEf3mw2LldYqTv17dYwa9Wjjf+ZQLxvryr99ssQ=;
 b=RvXm0ToLrpDZQyQVQ+sa5l9PRrSnTeBxZYj+w4hIumrqHCGjUHV2nSKfaRyVS0QAnv
 UFSoZJBT1GxAfsSqqCJvN8QyErWpM8cWS1E3uL3hkeygw/kKH+fxQjD0fzvHNXhN5m7X
 wPmBajmfM2Pp1I5PFLdipCzV0FooC0nPHy/09Fyv9XWw1rxPRkYVGes2lYEzheA02aXm
 2181kIcaM6YPtwK0Hnj9maPJchT5MP6KFUipICulqKvqsZRWiuDvKGxe5J/uHvJN+3vc
 9Yqh9heYCwTdeahV6KnHr0BIQGpjG5e5gas/e0fxWqm3TbpnrFy7BI/KSbiidWR2Gno5
 Jlsg==
X-Gm-Message-State: AOAM53213wqqYfJIstQB2SjnyPLdll+xecrSF/CKnx3efPgRDgww7hK+
 5O/hOw0ByZRyxZnevPyUJlfJ/ve2G4DHGKFnrKn+6w==
X-Google-Smtp-Source: ABdhPJxIiPWnxXMQpCiqqu1N8Mme9Stf2qt0uqGj5xC/i2CUKXNkiTaU+64xVwzR0m7zLdY5+J4WLRw2oquRjZ+ntNA=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr2223485ejr.482.1598899970530; 
 Mon, 31 Aug 2020 11:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200831172314.GA4940@habkost.net>
In-Reply-To: <20200831172314.GA4940@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 19:52:39 +0100
Message-ID: <CAFEAcA8QawQfy1qOpf5T-Oqj_14cOCfPQVvEh5vL-FAug3pL1A@mail.gmail.com>
Subject: Re: [PATCH v3 00/74] qom: Automated conversion of type checking
 boilerplate
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 18:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Aug 25, 2020 at 03:19:56PM -0400, Eduardo Habkost wrote:
> > git tree for this series:
> > https://github.com/ehabkost/qemu-hacks/tree/work/qom-macros-autoconvert
> >
> > This is an extension of the series previously submitted by
> > Daniel[1], including a script that will convert existing type
> > checker macros automatically.
>
> I'm now queueing the following on machine-next:
>
> [PATCH v3 44/74] imx_ccm: Rename IMX_GET_CLASS macro
> [PATCH v3 45/74] mos6522: Rename QOM macros
> [PATCH v3 51/74] arm: Fix typo in AARCH64_CPU_GET_CLASS definition
> [PATCH v3 52/74] rx: Rename QOM type check macros
> [PATCH v3 53/74] rx: Move typedef RXCPU to cpu-qom.h

I've just sent reviewed-bys for these ones. (Wasn't sure enough
about the other two.)

thanks
-- PMM


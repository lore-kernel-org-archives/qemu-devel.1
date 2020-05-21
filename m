Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED08C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1657206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qr5eVhrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1657206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnti-00047B-UO
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnt5-0003Hf-Bp
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:17:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnt4-00017s-5W
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:17:39 -0400
Received: by mail-ot1-x344.google.com with SMTP id o13so5945745otl.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2JI+Av1Ovo2Syn90E3yCfRxColS1heXQKpbmWHKc5mI=;
 b=qr5eVhrZKgNcCTxo2cw5TwmNixVz2X7nCMEZGMJ/Ytb7vjvxurwRnEmFDT4wBqyETl
 ikhQZHmdPuRpAdhlRus7cuhMn18mxjLMJSEiPEiYwkKPdbBcHZm90ZhKTQQFiphp9LlV
 yQE7KWXMzzRaJvf7jT9E1rRAraPPJVJ9+bzmON5cCXStzYIGe15DJyDv9VJowfiaYEV8
 L880byA2XxPvAcDx82ZToeJ3pphSz93Al6yVyPBpc75jxyaxhMIc4NcMo0DKP5SHmiqp
 j2MfUuv7skQ7Zpb3yMcW3iROgC7PoR5r2HApOLZ82g8TyMTqpwidEmpUoRt8t4Ilw3pB
 IP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2JI+Av1Ovo2Syn90E3yCfRxColS1heXQKpbmWHKc5mI=;
 b=eBGUBpIBi6hdi7GFMi9kuLtGpp6YqKXB/5TueONTkxnceCNc4x2afXFGm7F/w9vy9J
 cryp1/PA1bPLMwY1sDz4fBrzhVp6BRIxlcPsArQDodox1fj8+mphLc9jhXOIoZM7bvE6
 dTRvxmxC00IUlo9g012fPIiKB+E7yCqqszgVYsaXtrbs8rQNKuyCamglpxobHE4bqpba
 eIPQPJwIRBy90iNaYZ/tK0GJp4MkuUrg+QvyfciuZ+rKI4NAZPrtIMB5NPe2wbn8w055
 HGIMoH9Q7tNu/6Jzt6feGqzkYerr1yxpT0WgFBE3M3Gy5+dIv2eOexLfMfFuHaciT6BH
 5Csw==
X-Gm-Message-State: AOAM5314Gr3BXs/Mj7JjuCRjXyWfWb7wMnYZQ9ejHh64v22+UKwBeHdL
 nZUcBQfumMfaoS6n1YkjWSy9D8UfZARARLwq0fS/vg==
X-Google-Smtp-Source: ABdhPJysgULySQiLXWT3hJmux2EYHVB9nJ9n8LlprzaAyLVM1yPWbovOysKAK/ixEHfjtlX/pTks3EuP4ZrWXUFm2Qg=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7266133oth.221.1590077856885;
 Thu, 21 May 2020 09:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-7-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-7-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:17:25 +0100
Message-ID: <CAFEAcA9UampZxo-4Z=6+LKkC9HLrdGYT5AcLyiGVYvgU5VE+cA@mail.gmail.com>
Subject: Re: [PATCH 06/24] armv7m: Bury unwanted "ARM,bitband-memory" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> These devices are optional, and enabled by property "enable-bitband".
> armv7m_instance_init() creates them unconditionally, because the
> property has not been set then.  armv7m_realize() realizes them only
> when the property is true.  Works, although it leaves unrealized
> devices hanging around in the QOM composition tree.  Affects machines
> microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.
>
> Bury the unwanted devices by making armv7m_realize() unparent them.
> Visible in "info qom-tree"; here's the change for microbit:
>
>      /machine (microbit-machine)
>        /microbit.twi (microbit.i2c)
>          /microbit.twi[0] (qemu:memory-region)
>        /nrf51 (nrf51-soc)
>          /armv6m (armv7m)
>            /armv7m-container[0] (qemu:memory-region)
>     -      /bitband[0] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>     -      /bitband[1] (ARM,bitband-memory)
>     -        /bitband[0] (qemu:memory-region)
>            /cpu (cortex-m0-arm-cpu)

What does "bury" mean here? To me it implies "they still
exist but we've stuck them in a hole somewhere and covered
them up", but the qom-tree delta suggests we've actually
really deleted them?

thanks
-- PMM


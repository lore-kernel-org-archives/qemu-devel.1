Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605AEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F45F23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7q6ccXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F45F23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSKl-0002gx-HD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLSFT-0006p1-Mg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:29:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:38003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLSFR-0004AB-Qm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:29:27 -0400
Received: by mail-ej1-x62c.google.com with SMTP id gx22so4792554ejb.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IVIflwmg26TQtwhmOLRoQOyiEv2XvlNXK/f3J/Af+eA=;
 b=B7q6ccXloJ6ZrhgG29oBXSwrxc1/YSscYUVi4hNSmkmLo8j+1U7VutItcRiItFN0Ux
 d6Y0Y0IPsZSx2DtQwYFjFdeKJ7+HF8TU+W4QRjI4K9Ugqrf2xAJ4QzGcthxjHvATmLXs
 b4KoH5oM60Js96l6r+EJOZg94F//5zh1VQrKJwZJeNifaRTPr1o14poyMa3SJi7y1NpC
 OkOP1Spxh+ZNQRd6bYi4etWOhW0LGX+ykBrDFHCW4/6tmCs8/gYlYKMKKrUtGDPqGe7b
 G6waG87mwCs428UEDvATZPWlTsmSWn9NdG5MX9cbAlE1Z8V85wxhKo+fXwiWkjsbIXNP
 hRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IVIflwmg26TQtwhmOLRoQOyiEv2XvlNXK/f3J/Af+eA=;
 b=ucp9QlGka+XD4oG4E4CpGA05V4XPzcB5fY5Lgu8rGi3o9iT9ATo3WBtRNY0k22D5TZ
 NEBzfPJ4R0dl7EXCNFeSrwTAd7r9875nCsarMCSsyxiJzfv9LHp5yA9XPZNkmEACx3MW
 zqc6+FSZcvJIsB61JNlOSqSqkfFk8pi+do1icJ24v98HzrDY5PROmm7DhF7JqcV9jOyN
 caup8bEcTQzRMp8lEvVWVyVDkUjgiQ55M7MNHQ90E30cHCnfK76YHCyI8ANZGXu2OmBK
 6rSAsfVapkIs3S9aP9HRuCMcn0KB1SZKUcqTo/7pbZc7AevjbOT2jT+uNxGbC7je+Wzy
 mrOw==
X-Gm-Message-State: AOAM532hxQcsfQrX8wSpFVkb0aNnuHGawjYVwWEUyfGgAiMUeMGLrHSN
 O7L28lCC/IUhCLmayxFW0lzxbx7/8UNFJGc+A9r/Cw==
X-Google-Smtp-Source: ABdhPJxfyoo3DyWYPcwTtNRn+2yG/ohaOc4BBQ5LaCjDQA2dDsaSOTo4GkfK68sAt71TT2HnjjRB9qUgjo10sIEEp14=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr212135ejv.56.1600957764033; 
 Thu, 24 Sep 2020 07:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
 <20200923164029-mutt-send-email-mst@kernel.org>
 <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
 <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
 <20200924072329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200924072329-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 15:29:13 +0100
Message-ID: <CAFEAcA-zucDKCoyLXX2xG+W9yhM0vZ2nTGMMm1wu6=EGgEQzNw@mail.gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 at 12:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> I dropped the last patch which was mis-squashed from there and repushed.
> Not a big deal so either merge that one or this one ...

I'm now confused about what tag you want merged. Please resend a
cover letter for whatever tag you'd like me to retry. (That's always
clearer than just informal email anyway.)

thanks
-- PMM


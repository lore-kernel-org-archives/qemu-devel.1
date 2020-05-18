Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B55C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876A4207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esvvk8uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876A4207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jad3o-0002LM-O8
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jad2s-0001N6-Qg
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:30:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jad2q-0002Nt-Dy
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:30:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id 69so3028723otv.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o/GPKSYYNOf5fJUKvBnddpNIXiQERov0ePibcKwRAYE=;
 b=esvvk8uEE7eNEISZBQqwfRKzzMVqGxhNzrzureWb1rM13fbgpVmtOykXSRAN3NbM6g
 3m6ZgGJ3DbZwK5pJy8JtN4ddo1lUN+pRz4hyRllAKHXN1kRi6r84ewHgoZSrLcubzIXp
 rJhLDSm4jOK433VsnUjexKE3zl79/DEx2wR3o55pJ6aE53CYUIJogVsrRXECFZlgojB4
 TWC4/pgcamfvFF7qyaulB/KFdGEK4jxfSt6RGjT0JiDlssr9e/r85eA8j2hwnHoE6GOj
 s90pZ8bK4Sc55JvKh76OYZ3GO2bjrmi82K+myep1hjw5mE+oEiN0o/qs77rBoOjXwhdK
 Fg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o/GPKSYYNOf5fJUKvBnddpNIXiQERov0ePibcKwRAYE=;
 b=fX7VTfnDi/d3PDWdbYUEj5sRWLWuqp1GzXTx37ZqK4hY4i9w04E4Jox13hKU4VI3qz
 Pe1yx54xBKE4sP2BrMOMBz+2XVmYLO7VAE/F1/P8GVm+YO7ERX4kJhRlMWfpKHtjFsZp
 JYhJ7eUm8Ifd8xcp18X5ytvkFO3OtNjrWNXANpbZZmVPwin/tE6K1uBrlEaNc5hodeOL
 sf2aRmS+8Y+aJwqt5LnYFZGeoJQ2ovGZqABgfjJeanCifHrSOoCRsHf08HjBRHhgtTos
 8mY5LVLM2PtwS4gfE8Zv0kkPMjGxf2KY+Sef7Fxm1Zk7mx5/z2AwIhCbostpuHBIG8i7
 wvbA==
X-Gm-Message-State: AOAM530RkIC/YbIM3NvvwlYOgN496L4vTDMzz3/b2PKVOYQX/xZ6/HKi
 +XwGdvpRWVOKfJ8nKwEzpdgIBaf3avQh1ZaM7s2rPg==
X-Google-Smtp-Source: ABdhPJzg863Xh60q4sXHopskuO05qCErByugik6ybr9WOQhEuok6efNrlmJr5ENZWxyi+Y3boVGctP0R9VPgChzkrUY=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr9904865otb.91.1589797851126; 
 Mon, 18 May 2020 03:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-3-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-3-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 11:30:40 +0100
Message-ID: <CAFEAcA-FKUHyG=bgJqPG49WZDXV8JGQqqZXOw49C8_h9mYS5iA@mail.gmail.com>
Subject: Re: [PATCH 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
To: Markus Armbruster <armbru@redhat.com>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> xlnx_dp_init() creates these two devices, but they're never realized.
> Affects machine xlnx-zcu102.
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing these
> two devices, yet nobody noticed.

It depends entirely on the implementation of the device.
If it happens to do nothing in the realize method that
matters (eg i2c-ddc has no realize method and does the limited
amount of initialization it needs in instance_init) then the
device will (by lucky accident) work just fine.

We should really ideally have an assert() in the DeviceClass
reset that the device was realized, so we can keep this kind
of bug out of the codebase. (Last time I looked it wasn't obvious
exactly where to put the assert now that we have both legacy-reset
and three-phase-reset, unfortunately.)

thanks
-- PMM


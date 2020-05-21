Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A244C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6753A20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPyZGO7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6753A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbo2r-000347-FI
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbo2D-00025l-MG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:27:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbo2C-0002Zu-FA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:27:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id o13so5970457otl.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zNkvxVtiRkGzdUD+43gNE5K/dPhNRL79M9e1gRdK9wQ=;
 b=OPyZGO7mShvoZF44ZRcNovwQ9jiMHH1aPG8VRzqm8xiJHuekIGgG0EJWHlLZ1oghl+
 lhOYfwj8p3ehIqj0YvJzVU1lDOmPwj4ZTB9qYkP83rDiAMV+KFX29YFaKoroBuodC07J
 LKnwmF+V6TIqAhuxcKKRDJULBGt5ZSsJdK5QZ0fmL9n1wf9RfQhB4jcOrthdQLv62oR0
 J7q9cAvTRITfP2FRVeH3w1tIyP5v6K3uTOVDXnZrI12eAo6mO2/t9+zzZtgAeEG+lC5O
 I9UjebIZtInxRs3gxkwtGiLxpwYJ8c0+jDtkNo480U/ThqTtGYmXo583SmuMICkcLWHi
 rgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zNkvxVtiRkGzdUD+43gNE5K/dPhNRL79M9e1gRdK9wQ=;
 b=dcee6INP8HpgbfSd3kY2Eh9mhQQ8GqSjMH9iR+GrgpWQSc9E65CPzmDK2SGVxyUfOb
 LdESAycKKtBGQlg1+tOsD+IU0F5xg5kx4aJSSb3qZRFRKwd+H3viwiLOlohNNuuCf2VW
 BQpAH83cQoKgTOtqPzd1oyRFT9WAdhLlR0QNFbl2IHJRP4aqalTbvY2J3pwV6psAfw+C
 7dfnxNvwGZflD3I/DhXGsUFy4ZSECGsN8NtNXS/VKmZ7Nx1NSxpk/DJDXh/ImhiD+VfA
 7GoVrCjYV4KIj9U4/SKcsVf0JcjmDJtoua+qlteFfYLOBhe9ZAI5R7jKwxIZNqpIlL/7
 VPYA==
X-Gm-Message-State: AOAM533M+mwyRq+UgA7BjUmuKBqKpoBzTFjj2PwARIwpWBy/3SPPScFt
 lWXMK8lsHwW3040g8gtKvAtu03ip0TAqUQyzJmMCOA==
X-Google-Smtp-Source: ABdhPJwDb3qbCvtCDNLqpz36yM7qpRRVf2p13pKwpV5U/NNZ6WHC5UMMgWzvnzMUPM6Hz6+eWn1LQZgF/UXDzUAtoAQ=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr7907020otr.135.1590078423007; 
 Thu, 21 May 2020 09:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-10-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 17:26:50 +0100
Message-ID: <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 06:12, Markus Armbruster <armbru@redhat.com> wrote:
>
> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
> Affects machines mac99 with via=cuda (default) and g3beige.
>
> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
> Affects machine mac99 with via=pmu and via=pmu-adb,
>
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing these
> devices, yet nobody noticed.

Same remark as elsewhere: the devices aren't missing, we just
got lucky that using them in a half-initialized state happens
to work for these devices. Could you update the commit messages
when you reroll this series, please?

> Fix by realizing them in cuda_realize() and pmu_realize(),
> respectively.
>
> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/misc/macio/cuda.c | 8 +++-----
>  hw/misc/macio/pmu.c  | 8 +++-----
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index e0cc0aac5d..6d4d135f71 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -523,15 +523,13 @@ static void cuda_realize(DeviceState *dev, Error **errp)
>  {
>      CUDAState *s = CUDA(dev);
>      SysBusDevice *sbd;
> -    MOS6522State *ms;
> -    DeviceState *d;
>      struct tm tm;
>
> +    qdev_init_nofail(DEVICE(&s->mos6522_cuda));

Since we init the device with sysbus_init_child_obj() and
we're in a position here to propagate any realize error
back up to our caller, it would be nicer to do this via
setting the realize property rather than qdev_init_nofail().

That's what this patch from March does:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg04260.html
(we seem to have let that series drop accidentally,
probably because it was halfway through release and
because it touches several architectures at once).

thanks
-- PMM


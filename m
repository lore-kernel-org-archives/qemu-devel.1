Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6662C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703452077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mP+UCBgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703452077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq9W-0005jl-9D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioq7k-0003aG-2t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioq7i-0007bY-0v
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:46:23 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioq7h-0007aw-RS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:46:21 -0500
Received: by mail-oi1-x232.google.com with SMTP id z64so11596398oia.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ag51UugIS/CYNRWjM46vwlEZpfuT0F8y5cDLIO3+1M8=;
 b=mP+UCBgdzvplQg1AnAtbI3wZNvO5a+wy2J4gwrMgR4tz0HkWjUTz7OTkBlbZFWGEFk
 LV2YfBs6YblPOMncuFFoiCpvdaaVUuXQel74Mf4xFjC+iw9d2r6J/TJ6rzbVzkyAF7+8
 SgNm2wXZEk0Q6K7ZI6t+pjkvzPQsSATkoZh/Wf8A0FGvBPTHos0hfCCbnnl4uvB6X+wk
 SxDfFCrUzi7QOsnnJ6MkoAD4geXq0WXkPqEZT9wTcf6XdIOns1NATwN52cWH+38X3bGj
 ub1Xr11Hek2qP9+23spFOFK818z/Pdv6TzFbVeVA3XWtKz0WKKYvJRZhwjk2pV+26XOC
 MMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ag51UugIS/CYNRWjM46vwlEZpfuT0F8y5cDLIO3+1M8=;
 b=YTyN2H7RGvlo2R7eBgee7uqsTrfh0VXY+4UC79261zuN0ZRGjsJVrmSphpUqZ1Ga0b
 mMBPj27gmxLa+/t04K684vtuumT+E7tqqTrODYjlHoUHhxPPmgPG/PSnICkK06fTE8b4
 yIGo9E4JuAj9IaE6LQ0+KBk3XWq5k5kjDyW6gbssUAP9Ws5mwk6RzwFnfq72xZzNZZJh
 l2N8+KIR80B8XPweZttUeAptNijsTLUkDoZOJebSvegs/ypW9PKiwUdX+p1SxFvcBRFp
 cRAra6UZM9VfBdqx9tFM2Q92gK2iRo44vJP/S+gOtqyJ2eBZ5HRbRiMtcWdkbIgJwjfK
 BoPA==
X-Gm-Message-State: APjAAAVCDHzDcIpmRugBXX8Gayygxt79y2H8E11d8wXdKexwcE8VerUf
 3yRJ5sSi72Ms9d/9KG61npHaf/6xcJe8/Gi3RH1Z9A==
X-Google-Smtp-Source: APXvYqw93KACrdvw4Z6UPYu5sAaf848o2Nd17xbirMGoA0n+JdcocJnOFu+5Wm8cDRA+xSQ9k89Skr0B19at6z9MpY4=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr67917oid.98.1578408380730;
 Tue, 07 Jan 2020 06:46:20 -0800 (PST)
MIME-Version: 1.0
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576670573-48048-30-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 14:46:09 +0000
Message-ID: <CAFEAcA-qbxVxR6qWRjPjfXf+XQzoA=D6LfhDJ2Do4LfZALZ-EA@mail.gmail.com>
Subject: Re: [PULL 29/87] kvm: convert "-machine kernel_irqchip" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> +static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    Error *err = NULL;
> +    KVMState *s = KVM_STATE(obj);
> +    OnOffSplit mode;
> +
> +    visit_type_OnOffSplit(v, name, &mode, &err);

Coverity complains that this call uses 'mode' uninitialized,
which seems correct since it starts off with 'value = *obj'.
(CID 1412230)

> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    } else {
> +        switch (mode) {
> +        case ON_OFF_SPLIT_ON:
> +            s->kernel_irqchip_allowed = true;
> +            s->kernel_irqchip_required = true;
> +            s->kernel_irqchip_split = false;
> +            break;
> +        case ON_OFF_SPLIT_OFF:
> +            s->kernel_irqchip_allowed = false;
> +            s->kernel_irqchip_required = false;
> +            s->kernel_irqchip_split = false;
> +            break;
> +        case ON_OFF_SPLIT_SPLIT:
> +            s->kernel_irqchip_allowed = true;
> +            s->kernel_irqchip_required = true;
> +            s->kernel_irqchip_split = true;
> +            break;
> +        default:
> +            /* The value was checked in visit_type_OnOffSplit() above. If
> +             * we get here, then something is wrong in QEMU.
> +             */
> +            abort();
> +        }
> +    }
> +}


thanks
-- PMM


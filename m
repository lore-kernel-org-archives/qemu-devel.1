Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD18C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4783121736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxP5Bnpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4783121736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialIP-0008CU-FM
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialEK-000633-Io
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialEE-0004as-WD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:42:57 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialED-0004Fj-MH
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:42:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id x21so19730968oic.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hir47yhQPKRg9uBcGPhzpCqfbh2WTx7BBtpOVbhG8cY=;
 b=GxP5Bnpf9WlXqOpFyh9MPZZVj1aSQKym71N2kswkkfpBIqLm2NCLh+A7W3svvaF/pI
 uZDsfVDfwjBpslELCZlT9miubNos2lLopDWppZ8UJb0bGEkN2BJrZoNs70+XvAHyAvm+
 Qyu+doUA42/TTmkLQl7QdL0AVT/H23wPwysd7a5ZlnoU/ocpdX+rJINdky5XUcyAcKnK
 fKXj7srWJ0KnWtCuRevOKWS/OL6LuSCZzAZi77naGRK7RO0uHc2h23FMCxR4pg82p2EQ
 6FbHA2Chv3usMP1/tpEAEaQLvL72epbtwI4oU3vdU6T3HcMyEs0e+4SbT4AZTx6sJgl2
 6/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hir47yhQPKRg9uBcGPhzpCqfbh2WTx7BBtpOVbhG8cY=;
 b=iM8/m3ggbcrK4bjDLlEDqoic7IvtLVR3cyVmmAZeVt78syn0nnn+KYGlGi9YEwJY53
 A8RS11SKI2MpZNtw/skvoQ4EWA0HU9YtVnr/xFzDRYcdof7R8i63IMS9SuaqYWoT0S1o
 tXcW3lmWyEIXwE5yKwxTReeiAsNwjoFAobQvfqwEkHU7agX92CJ8G9BXDfceWCSMjVJI
 kXqDTjlRDKhy17ar1sskbSbk60Fnwm+ipBECQXymX4IIpRJaL+sSX5sb8OyAXzBChYjO
 ya40FYNPCDxvLnHOhXDbfbDH2/Jt/369Y6PenyXgUkNywFSM18DC5w1BWoTktWy6/HZg
 0t5g==
X-Gm-Message-State: APjAAAXTGtEzTj6HvOsb4E/iX0z/MZ5CKAfzTpw7RqTtwgJFf6HkBSKe
 tW0rNctGy3OJ1ssFBBQ7d77vYIwhNYoX0lwivOx7LA==
X-Google-Smtp-Source: APXvYqyZ5iTnoEwOD4YWaBj+aK39iysEl/HYD1V20oNwZ8espKaKrjbEXRgkE1wXqU3J9BNny1fscORdmHZYg2fv7AU=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr11120249oia.146.1575052969960; 
 Fri, 29 Nov 2019 10:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-9-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-9-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 18:42:39 +0000
Message-ID: <CAFEAcA9D7UUkNJyWAiO_EM6OQ8JPH3J1Ko+6q8C+3ZKNg-SuxQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] hw/core: deprecate old reset functions and
 introduce new ones
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Deprecate device_legacy_reset(), qdev_reset_all() and
> qbus_reset_all() to be replaced by new functions
> device_cold_reset() and bus_cold_reset() which uses resettable API.
>
> Also introduce resettable_cold_reset_fn() which may be used as a
> replacement for qdev_reset_all_fn and qbus_reset_all_fn().
>
> Following patches will be needed to look at legacy reset call sites
> and switch to resettable api. The legacy functions will be removed
> when unused.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>
> I've removed the general helpers
> + device_reset(DeviceState *dev, ResetType type)
> + bus_reset(BusState *dev, ResetType type)
> because with several reset types, all devices and buses will not
> implement all of them. I think it is preferable to define a
> type-specific helper every time it is needed for base classes
> implementing the reset type (eg a device_pci_reset(PciDev*) for the
> pci reset type if add that).
>
> So device_reset()/bus_reset() symbol names are not taken anymore. I
> don't have a strong opinion of what names should have the
> device_cold_reset() and bus_cold_reset() function added in this
> patch. It could be device/bus_hard_reset() (the current
> qbus_reset_all() comment mention we do a "hard" reset) or simply
> device/bus_reset() or anything else.
> What do you think ? Any better idea ? It should be consistent with
> the reset type name but we can change it also if cold is not what we
> want.
>
> Note that if we don't settle for device/bus_reset(). We can drop
> the first patch that renames device_reset() to device_legacy_reset()

I think we're good the way you have things in this patchset.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


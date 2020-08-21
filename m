Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85606C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAF4207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fD/BsSYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAF4207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93Es-0008KU-IR
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k93Dr-0007Md-UB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:20:31 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k93Do-0002Ji-Tc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:20:31 -0400
Received: by mail-ej1-x643.google.com with SMTP id bo3so1473152ejb.11
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iZM0f53tTZvOsiU8zw9GifFti7zA/ofjtEtJ2j3dFJ0=;
 b=fD/BsSYBstwKm7BTyDr6we6EdnEV1E47o4CMuIPK4HwshRnxBUGPkQqdQ19mPl+ffz
 Ut8uiYQHRozfeicJ3f8W6A/IJzP0X5nylaVbyX0RrKj+vNNk8xOFcJFk2QUJfCp44W7P
 ugZjyLiwD/wPBMjRU//P1mpIYfCJZf5NUc9H6hXhZvG6Frig5+d5Ug7mola+LfRcrGr3
 4NIY0AlwH+ZVT3PsHyQvUiGRRZ7bUNkeKyJowxUax2Ue02VKhlidX6eHqdHoL64wv6Zy
 JISu/EkNSh39lmtNheipoGh9aI+RNT+Mh07thdS+bZIaSkWFguqyaD7SDSWcBSCnH+9Q
 mXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iZM0f53tTZvOsiU8zw9GifFti7zA/ofjtEtJ2j3dFJ0=;
 b=JNWlBNhlcuVM+aXkphoIBFFgu7T8J6WVunvT4hP/nODxZwQNcMp86jL4WPa8alBxcc
 XmfwbLOfaNL+6kuePfp638kZ81Y9PMzsHuJrqKpxDPKZ/RMLIFPbC/0xJief8S0jdxJC
 SP4EMlJyAqFyMX8AXBI5LqO/Qga0Gxh8i+27glfPr7jesRnIpsHGpAiyA8mKs97rrZsi
 xSCBZwdQMYRwnYRnYw9M4qUHYxYEtZ0mNbhclpJxz0DlCpsiyzY+fthevOzmgQCpTl77
 NDytNjbYdhQEkQNuve4pld9S/cRgeilq++VXUKFPQ+ALkANHG0HzqJSTTNtkbIXZRdiD
 jQaw==
X-Gm-Message-State: AOAM5303qYHR4k1jJJTS/RnJm/AudvggOHpZk5wEZbIiikLoKw4JfjhZ
 66P3/q985+F45ftCZDonL2IJDf1lujWd772qYa2OLA==
X-Google-Smtp-Source: ABdhPJxIHlTTggr58qOtS0T/ft1uvSRnsw1bi1I6em/+e/avcua84/PK/+n32UxGeV9yYF4lxBdp/cAcs098NrsKgpI=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr2106121ejn.56.1598001625295; 
 Fri, 21 Aug 2020 02:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200820215529.GH642093@habkost.net>
In-Reply-To: <20200820215529.GH642093@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 10:20:14 +0100
Message-ID: <CAFEAcA-WvKaZWkEF1kP9ai2neic6FJVTvVe-p3RxwKU7OhBSNw@mail.gmail.com>
Subject: Re: Suspicious QOM types without instance/class size
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 22:55, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> While trying to convert TypeInfo declarations to the new
> OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> where instance_size or class_size is not set, despite having type
> checker macros that use a specific type.
>
> The ones with "WARNING" are abstract types (maybe not serious if
> subclasses set the appropriate sizes).  The ones with "ERROR"
> don't seem to be abstract types.
>
> WARNING: hw/arm/armsse.c:1159:1: class_size should be set to sizeof(ARMSSEClass)?

Seems like a bug, yes. Here the subclasses are simple leaf classes
which (correctly) don't set class_size, so the abstract parent
class must set class_size.

> ERROR: hw/core/register.c:328:1: instance_size should be set to sizeof(RegisterInfo)?

Bug (we haven't noticed because the only thing that creates them
is register_info() and it does object_initialize() into an existing
struct rather than trying to object_new() it).

thanks
-- PMM


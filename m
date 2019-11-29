Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C02C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4792158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiIOUEdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4792158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialB0-0002se-Mk
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ial83-0001W9-41
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ial7x-0006Lz-Se
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:36:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ial7w-00068O-Nm
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:36:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id x3so981649oto.11
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wheawXht7WgF8Gt4GGTrhtQ/+VWwWJoI38JiF2ABqCk=;
 b=aiIOUEdbOAwtWBrCSfhUeDcqsdqF/90GAGvyHzmKkQOX7w/tibrBArDot4aVpG4K3O
 E6iG7LcdNwlHjcrbycZAUddrzdUtBpG1LaOYZds8UesgCckImrU0f//7Sh0m9pFSj8Rz
 hbj1cwBcz202MtxrzEbJgvUvnZvjrUv+yLMTlkzDkZjgeUOanP3MqcoBl/8pADGqrk63
 nC5C7tLyi3K7wVJXml6wJN+Upegx0nhBvO8OOeq7/k3GNtSf7XQ8yBXE9/9ncO7iutwq
 9z38htnGMEGP9v8e8E52D+VeRNy4+FW8yVQRB1GR772qmX5sxNpfM37ng2S9fXAV5NC2
 rjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wheawXht7WgF8Gt4GGTrhtQ/+VWwWJoI38JiF2ABqCk=;
 b=c4AfzmGCVAmTYIAEQ3l1jd+LNaDwK8+hwo0nuZtELr9QGfy55a02G6j7dhrEpbhqPJ
 gPORxaDJoCArOJU/xLWpcSIqgYdQrvSXil2qD1nVckErNpqLqonNrXHZn6zAMiJBpmNC
 BKlhlE7HbzbJBKgFRhdn/FjLCqBganZCSC7K+Kecwly5yvvH5sH4F8guLCEgZY4sBY17
 T6TXwX3ym4BLcR07DZ7pdN1hkeQQc7iMrXSe576Q1ryLDfkJzwCC+QFTvdSdR08d56dy
 Loz5nwduakgkaXOra275pJyM8iZgCb2j/PgwpStDj7POvZt2/zlg1j3RoL8uDCNH9Ebg
 gtLw==
X-Gm-Message-State: APjAAAV5RS/LSEHbYOpFMudNlMhWqF7/balj2b3PR5jrnJoEmBKDLe6J
 9lzzxpYt66Q8+L74ITYW9djJ/bJVQPeqTsrVBXYE3Q==
X-Google-Smtp-Source: APXvYqy3Y0tJmj8W3j451zjoPJc56CqWD5rqZycU6y+ok8zO1/NyiAPV/as+mie0G5yAPnS59jXqjX2lchcu3jmSp+Y=
X-Received: by 2002:a05:6830:1583:: with SMTP id
 i3mr11313362otr.221.1575052581790; 
 Fri, 29 Nov 2019 10:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-5-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-5-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 18:36:11 +0000
Message-ID: <CAFEAcA9z_Tu3jEABbRVgoZfw=_6RDm8MOQNOYh4qwmQzJjBAgQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] hw/core: add Resettable support to BusClass and
 DeviceClass
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
> This commit adds support of Resettable interface to buses and devices:
> + ResettableState structure is added in the Bus/Device state
> + Resettable methods are implemented.
> + device/bus_is_in_reset function defined
>
> This commit allows to transition the objects to the new
> multi-phase interface without changing the reset behavior at all.
> Object single reset method can be split into the 3 different phases
> but the 3 phases are still executed in a row for a given object.
> From the qdev/qbus reset api point of view, nothing is changed.
> qdev_reset_all() and qbus_reset_all() are not modified as well as
> device_legacy_reset().
>
> Transition of an object must be done from mother class to daughter
> classes.

The standard terminology here is "parent class" and "child class".

I notice you've used mother/daughter in a bunch of other comments
in various patches -- could you change that to the more usual
terms, please?

> Care has been taken to allow the transition of a mother class
> without requiring the daughter classes to be transitioned at the same
> time. Note that SysBus and SysBusDevice class do not need any transition
> because they do not override the legacy reset method.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


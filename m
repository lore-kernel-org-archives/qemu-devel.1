Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCBE208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 19:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7JoXk/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCBE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialci-0000j1-3k
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 14:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialWt-0006Mn-Ai
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialWp-0001aM-TL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:10 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialWk-0001Dn-I7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 14:02:04 -0500
Received: by mail-oi1-x242.google.com with SMTP id e9so26884539oif.8
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PwstR7XPWAEau24OphkQepHt5ecvZPpZxm+5ZCeHSyk=;
 b=y7JoXk/bAgn6toKzBevyaiA2FGizDQDWvVb9YovZa6Az9Zihy1ZpTg8JP4ak7xWpfU
 9pPmou8OHTMCyLiPE6YhQLO3DxQKaSUefMO1K8lQBf3PYbbMmOWa26LFyxXgi+ALrKXu
 NOFIXAkF3SnEElKrdNlxIB4NpuKg8MPSnSCv0udbYr6gx6Rv3g9RU4k6+dedy0Gx6u7m
 XVJcaL/864F1B9AALlEX0datsb5mFh9nLOfPVoX5gLYBvEU2ujZlXRiY+wns8oc0fo+v
 SiyJnv2KXKjLcbXNaNK8p8u6mRY5KHJFSP218c+DW98YZvHVE+i1fX3cwzlMyPexbpea
 2kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PwstR7XPWAEau24OphkQepHt5ecvZPpZxm+5ZCeHSyk=;
 b=eYQg1oTyjf0noAUq1yqWCVbcTIT6CwR357Dlr4ZhxJbygP2F8Oj7sW4wkl2wN35Hi9
 8pRZC+ku40mpKmjJn7FxTtxHRT1PaFaZotxJjK8vQn/pBmh6SF8CbfGTf+ArHQjm2vGC
 Kwus/1FWs3oZjcGgru4NKhfZzfXSzgMV49Mr12O9D+rBSJpvgr1ua3MdhLwv4lXcUhMm
 4dBjBEKMQ3xc6XIJyx6qqq1FB4/WDTQT8q6v9QzoSHVrxq5l6x3UyKYQOD2lSAD231jY
 lUEz5SUXhl4eRZql3HvG0Ak/Hb7SZpgc/HhNLinHugp4R3uOMwgEsBiMYvhHCSEljUw9
 7pvA==
X-Gm-Message-State: APjAAAUEjZCjMxaDEBU3dHlCxgTQ2cQWbNBXVqmqFNsBQpIvnLog7wHv
 Oxl0g3k2qgB2dImLWa5+M4huP2+CRKGbRRppfZ+aew==
X-Google-Smtp-Source: APXvYqyAWuS2HXmxJ94LCibyIc4yhdAH8VZwe7xzhILDtZkgi4pTk5m9riEs4byijIbORsechD0qQky7q3hSEEt3OBE=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr1999749oih.98.1575054116608; 
 Fri, 29 Nov 2019 11:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-11-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-11-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 19:01:45 +0000
Message-ID: <CAFEAcA_TJSSoqd+gCL=r9b_W4mpFyWOOb0ouLiXP5k16L0TOZA@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] vl: replace deprecated qbus_reset_all
 registration
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
> Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
> the sysbus reset registration.
>
> Apart for the raspi machines, this does not impact the behavior
> because:
> + at this point resettable just call the old reset methods of devices

"calls"

>   and buses in the same order than qdev/qbus.

"same order as"

> + resettable handlers registered with qemu_register_reset are
>   serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>   qdev/qbus_reset) inside this reset handler will not be masked out
>   by resettable mechanism; they do not go through resettable api.
>
> For the raspi machines, during the sysbus reset the sd-card is not
> reset twice anymore but only once. This is consequence of switching

"a consequence"

> both sysbus reset and changing parent to resettable; it detects the
> second reset is not needed. This has no impact on the state after
> reset; the sd-card reset method only reset local state and query
> information from the block backend.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


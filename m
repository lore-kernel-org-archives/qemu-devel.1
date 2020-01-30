Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E7CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF0F20678
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wV9Ej5Xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF0F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAqO-0002A8-SC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixApW-0001Ds-R3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixApV-000269-Ol
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:30:02 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:47027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixApV-00025X-KC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:30:01 -0500
Received: by mail-oi1-x241.google.com with SMTP id a22so3603273oid.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4wioudhsqRfXAnPkqTKpbZgYcWOMQH6uDpQnmGy2X50=;
 b=wV9Ej5Xvam5YHKzWwXSja3BjFcBJOkuzMwqXezDcdn0+YIiIe5fYzQrCkqoP3i87uw
 xmkbTwDqXluWVMwJMVdX45yv51aLe1ANoh7/6+bLN1+pY2yIMPq32QSgiubSLr5fwPVr
 PpKsqnW/++VdPnaKFVW97Sa/OLrShZx9sxmWFz8hhcMxH1J7SBV25EYFv9pq/6W4oito
 Dc0pnaGuu7DAPlMdD6HX7imXGNLA1knZ6+0a4jREXXiHjGEMr9VBFql9HsACbkhmQSQe
 a2gX4gfyNEL6jEYM8vShCvjPsNVrntHpgJnVj29vaXlLU6zzfNSfPUbbtL0RpBxPFGpx
 ZyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wioudhsqRfXAnPkqTKpbZgYcWOMQH6uDpQnmGy2X50=;
 b=BPTBW/lTgKL/FAT/019KqOdNRHwg4qntofnxgpfYzkLAbXCJIO8158CmatC2iPpydT
 CBR5CNkReH7ppA1u4C54tuceSqikUMdU1r+rYpVfeSk/QaeJQAHOcx0yi6aPR2ordGYa
 zJWD/3YOYzHq0LqkL91671S9li0NnbItSqx6OLhiyh+6A2KNu4E8dfj9wRudnSWSbgh+
 pA+U902vk9DU227VphirWQ6F4zSwkhniWVuJsrW/muJXQx6CjHTsl3OVc00JsWZGBM0y
 OrAaW/z7+qAWibTtEV+C6r0g8T8Z6rZWVt1j8hXKrHpsXl3ZVatZFzkNz65qxQsPg1th
 U57g==
X-Gm-Message-State: APjAAAVhRLbjk9A+Z+h1/+uXBbd5GkioqkfPSCOOPD93zfLRbmHCtSlD
 /zqfK7OOcUlVSpIKktxHMByCcW2WQdgkbetNG1TXrA==
X-Google-Smtp-Source: APXvYqzw11a+K99HWBJfnEmeWpccUu7dBgmb6z2eIt/mOp/fZUQxtXkij1CehT7SGjSS9wciHInylP6mutORTUEXh7Y=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3114668oix.170.1580394600807; 
 Thu, 30 Jan 2020 06:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 14:29:49 +0000
Message-ID: <CAFEAcA9=fk+J1QdhvJxhpGOSviNb0eCUmHxhWjR8WCjvSLvqmQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 13:28, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi all,
>
> The purpose of this series is to split the current reset procedure
> into multiple phases. This will help to solve some ordering
> difficulties we have during reset.
>
> This is a ready to merge version. I've taken the few remarks of
> Philippe about v7 in account. Thanks to him for all the tests he did.
>
> This series adds resettable interface and transitions base Device and
> Bus classes (sysbus subclasses are ok too). It provides new reset
> functions but does not switch anymore the old functions
> (device_reset() and qdev/qbus_reset_all()) to resettable interface.
> These functions keep the exact same behavior as before.
>
> The series also transition the main reset handlers registration which
> has no impact until devices and buses are transitioned.
>
> The series is organized as follows:
> Patch 1 prepare the reset transition. Patch 2 adds some utility trace
> events. Patches 3 to 8 adds resettable api in devices and buses. Patch
> 9 adds some documentation. Patches 10 and 11 transition the call sites
> of qemu_register_reset(qdev/qbus_reset_all_fn, ...).
>
> After this series, the plan is then to transition devices, buses and
> legacy reset call sites. Devices and buses have to be transitioned
> from mother class to daughter classes order but until the final
> (daughter) class is transitioned, old monolitic reset behavior will
> be kept for this class.

Applied to target-arm.next, thanks (it seems the easiest way
to take the series). I made a few minor fixups for textual
conflicts with other patches that have already hit master.

thanks
-- PMM


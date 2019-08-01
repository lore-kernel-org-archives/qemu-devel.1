Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DAC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8F920679
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iV9MPvJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8F920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htBGD-0007qK-HJ
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 09:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htBFn-0007Ij-Gw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htBFm-0004O7-CJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:36:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htBFl-0004NZ-TP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 09:36:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id 65so53907310oid.13
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BH5EqTr/kV4VuIqOYRQmUrS+hUvcrPgyJv6kF1NH4ZA=;
 b=iV9MPvJ3bjFwPZZDqSSI4TaYTfM4n7fwy+f1Ca32decRD3d+rMG+E2BMB9VVLekskJ
 Bo5GBNZOCxorHN6N/Z7wB3wGy8KivJ7oKo6JhOysENEjvUXOa79dflNgGAe57hXA/MJD
 o/QN7PD0RT3s4nb4NaLliS/mSy2tRzP/AK/r7DKVq0/Ai4NlNLMC4uIsv2TbNw/Od875
 xeU4pGAOk0xb/o0VEtzxtNRuQ4PCITDJVvzf19AdBsTgrA7kn5KlaLacdz4YSbcSHPM7
 jha1frFtQTm3SyHjsGV779AqAKdweCJGFlhqqprl5iI2kVxXUa8he/RiWnQpDJw06euo
 ImbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BH5EqTr/kV4VuIqOYRQmUrS+hUvcrPgyJv6kF1NH4ZA=;
 b=QPPKqZe7xCE4DrkBnfGRNOU8DfJ+HAJCA8BUDR2Uq+yANdeCJwxzhQFaRNlwHvPlLp
 X//0KdYfPF/8lbw1R4I9+IfNUkhkdZqg8pD9ohDWee+MzGMqIt6p8ev8u+53eZqx99id
 RdPnhrpnGB6gD7v3RFy9EDRUOp5rH/b9oAPS0pkW0Ba57FFHSr9jOz62NslgklWySies
 e7zcXg4iLOHi23ISsYnx/H56iGCb+3R+UNd1KAEtFCr+BhhCa5mbnb+J4aOUG9MY1hyX
 dqsNgbD5W+mzbDP6jBP7+Is44JNbTzvNF9j2ZNvDkBTtfFbfA8i2TiC2Mwn6jaW5ArcQ
 /5kg==
X-Gm-Message-State: APjAAAX7uynoXh5e+0acu44MLifFy/ML+/4NYH4WlTsnNEPhbz9puwss
 G5UvtOxVkY60ST+9pai5FlFdvATqxFqurDrUDGMYwQ==
X-Google-Smtp-Source: APXvYqyzakUrmyme8XBNd4/09ZOkL21zw+lBnH04TMaLWfFfLEc4DekJSV2fI/6KIHba6+OfEBaOS/WH6InO2CHrkTg=
X-Received: by 2002:aca:4bcc:: with SMTP id y195mr4477881oia.146.1564666581059; 
 Thu, 01 Aug 2019 06:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-5-alex.bennee@linaro.org>
 <20190801132659.GJ5034@quinoa.localdomain>
In-Reply-To: <20190801132659.GJ5034@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Aug 2019 14:36:10 +0100
Message-ID: <CAFEAcA8P-UnF-z9mM-TJkBLOsZXiiAciOsHz3zykLDiWRfcGFg@mail.gmail.com>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v4 04/54] target/arm: remove run time
 semihosting checks
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
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Aug 2019 at 14:27, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> On Jul 31 17:06, Alex Benn=C3=A9e wrote:

> > @@ -8371,11 +8315,13 @@ void arm_cpu_do_interrupt(CPUState *cs)
> >          return;
> >      }
> >
> > -    /* Semihosting semantics depend on the register width of the
> > -     * code that caused the exception, not the target exception level,
> > -     * so must be handled here.
> > +    /*
> > +     * Semihosting semantics depend on the register width of the code
> > +     * that caused the exception, not the target exception level, so
> > +     * must be handled here.
> >       */
> > -    if (check_for_semihosting(cs)) {
> > +    if (cs->exception_index =3D=3D EXCP_SEMIHOST) {
> > +        handle_semihosting(cs);
> >          return;
> >      }
>
> Previously, this code would never return here if CONFIG_TCG was not
> defined because check_for_semihosting() always returned false in that
> case. Is it now true that `cs->exception_index` will never hold a value
> of EXCP_SEMIHOST if CONFIG_TCG is not defined (or that it is otherwise
> correct to return here in that case where it wasn't previously)?

It's always true that cs->exception_index can't be EXCP_SEMIHOST
here if we're not using TCG, because the only way you can get into
this function other than by using TCG is the call in
kvm_arm_handle_debug(), which sets exception_index beforehand.
More generally, we only call this function in non-TCG if we're
trying to manually configure the CPU state to simulate a guest
exception entry, and that will always be done by setting up the
exception_index to the kind of exception we're simulating before
the call. EXCP_SEMIHOST isn't a real exception so that should never
happen (you could argue that we should assert, I suppose).

thanks
-- PMM


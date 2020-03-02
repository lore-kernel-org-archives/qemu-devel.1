Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01341C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BF42465D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zp+Zv568"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BF42465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sY8-0003Hc-Vu
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j8sXU-0002qQ-6Y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j8sXT-0004x4-3r
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:23:47 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j8sXS-0004wZ-RV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:23:47 -0500
Received: by mail-lj1-x242.google.com with SMTP id a12so1151027ljj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S+Ojez42MO8FZVI6s02h3MHxLltZX3VAfffE1DTg1es=;
 b=Zp+Zv568rFAHJ2whj86pnqwsrOQCBG/cbPEKxgr0UUhtZCoK3kRXZu8WKU86DbMYri
 Xoj257pYG5IrfgYTVlz7rPAnG3AMkeUNK6fZY/4HNrWFF0DESGIIYbdWOwFW5jDy2oeB
 4EjyeVu3DNlQxK91E4HMkFD9X1Fxjal9XrJlKfecRrRgsokNtx2oT63XWg3574J+RWHt
 jjioZ1Fys7n9fENxUDWZmiDFjPOaUuDpTSs5IpIdwDalY6gBE0EfUIk0i/WSRAE/nzs/
 glAKtq3A6FOHgE2Q5u2exaTSk83kFHotpemWnO2BGH2DtpvobvUZP8ZaTvQCZUeNj1CB
 hy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S+Ojez42MO8FZVI6s02h3MHxLltZX3VAfffE1DTg1es=;
 b=LrGqlu1V6JdVDHbAbqsX5J2prueDeEUMhnMioDCgigUGLnZ8LSwWnA2cMh9jMt0Edv
 EqANod3w93UskKHPwmfGsqYKGk6B4eCIqFPBPPvth5tf3HhzdwOTnoS6DrhR9nl3Sayr
 7RO3JRhz4siZTfMYyPLz3/A15uqoATaHKQhg3Otgun7JJM0YNuS5q9GAk9e9I/9vFcY7
 AIsgGeWpaQxaAO6lKc7MZwI/zz9WustdPEh04bMIjwUymsokHNBfIKm9MU/0pApVRQvt
 H7Ah9+8AUyxgN/GAhuaWh3tqWkqPIuPi9LzaY8NWwKdXDUu0hRrBC6Y5j5PuqjorKPhb
 bpLQ==
X-Gm-Message-State: ANhLgQ0dAFwOA52iOrr7qKrPVVmR5oFTbckUCs/ADiyfsL4scjxSwbl9
 kz5Kghuei9UJ0iFdM7HZSpXSGVq6ojjDF2+uBqr4g707RLU=
X-Google-Smtp-Source: ADFU+vu08QURj4j5Pu9n3mpK4S90pD//rEGM0ekn34MVdonYvQDHkWc80BAqDgRoH886Wjc/34a7SKuzCT2p2DwHWGw=
X-Received: by 2002:a2e:b4b0:: with SMTP id q16mr482363ljm.43.1583184224693;
 Mon, 02 Mar 2020 13:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20200219163537.22098-1-robert.foley@linaro.org>
 <87fteq90fi.fsf@linaro.org>
In-Reply-To: <87fteq90fi.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 2 Mar 2020 16:23:08 -0500
Message-ID: <CAEyhzFt=KsNn_rdJegbzJ_PgNVb6oAVL3aDvaO2VdkrFQ1-Gvw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] tests/vm: Add support for aarch64 VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 11:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This is version 2 of the patch series to
> > add support for aarch64 VMs.
> >  - Ubuntu 18.04 aarch64 VM
> >  - CentOS 8 aarch64 VM
>
> For now I've pulled the first 5 patches into testing/next as they are
> obvious clean-ups.
>
> >   tests/vm: Add workaround to consume console
>
> I still have concerns about this approach but I'm going to give it some
> more testing.

We are happy to make any adjustments here.  Our first set of
refactoring here was
aimed at making it more pythonic.  Is this where the concerns are?

> However I ran into problems testing on my aarch64 box
> because of a missing gen-iso-image which makes me think we need to add
> some gating via configure for tools and libraries we need.

Should we error out in configure if the tools and libraries needed to build=
 the
VMs are not there?
Or maybe tolerate these dependencies not being there at configure time and
provide an error later when someone tries to vm-build these VMs?
Just curious which approach we should pursue here.


Thanks & Regards,
-Rob


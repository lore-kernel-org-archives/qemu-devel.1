Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4EC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C282C20640
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZ4Le9AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282C20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvDg-0000d0-Gu
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvBC-0007cP-0e
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvBA-0004p1-Gc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:53:29 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEvBA-0004oK-BD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:53:28 -0400
Received: by mail-ot1-x334.google.com with SMTP id g103so859218otg.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mL5NHdz+x0B9DdwEmJwp7gAH/NODZFXZmXNi1KIbZA4=;
 b=PZ4Le9AOzmp4D9Z0Cuq2cs/+urBMP2CplX6rjcOTeWQdF6TzvMMGlnyKZX7o7zPP7+
 gt8EIK321RZP51l2afDaTcMxo7WcVdekKCe/7PMgsNmisFjKLCrFkpPKzgj3rD3Syn+Q
 QHmrj9k853GlC2hDhMKPb2jjPBqUM+u4sjAhCXbMp22qBnhnuyGa7T8fHQ0DXgF4EJI9
 x/LfaGM2VJJiBi+SVSqHFjEa+nPvV2bTJckX5KJ6g4tp8V5q2DPMWvBWq14lVpOF7y2o
 J/dyph2RY4oy3Ihsmp1+L7L3KGgb6XL8JWvVB49e8MnMOJInWxUvbJILo822gqPkB6Y9
 x5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mL5NHdz+x0B9DdwEmJwp7gAH/NODZFXZmXNi1KIbZA4=;
 b=tCMneH7Sl3ibhUXNhyKC13CANgbVzBzJOX2rimJoBygbxb4xH8JjEDoORN1yXTZHAp
 SnT1y7zEkAGUHXQ0H8eEwb4F1Jio+tczXzgmWpM2qWFgojg+kLISRCVWaIv8xJyaCaH7
 3MalAYyWRMbRb1EXvYjWIA3/smEGGP058czQduQRFL1MgYPnGeIPyoV0sGEACVodRGHM
 JOx/BcRfTiJ+FCMhszCNIBFuJ48TKPb09JoOUTh4xDgCGcb7GdzkxKbHH5MT36mNsX/I
 ZgsIb7GUDYPc+KzQQRivnOMobdNzAupe3ByiYD4/0DOUw/AJxNel65rOZG81EGp+eFpH
 /fBA==
X-Gm-Message-State: APjAAAVuMVfhFVMwTFzln9DCyl4EKo4UQh5mMjpS/KE1hch2UxbfSb/O
 l1NDMGwUKJpcGf6TR59rZR9nMtT6vToIaReE+M8PmA==
X-Google-Smtp-Source: APXvYqzNvpBDrsCNNzujG3yX9LR7kZ15ofNG/vNtU8tS1CTgTNYA5pKP71CPT+8zANtZQyEXPJ5R37gOJY7CcYMfCd4=
X-Received: by 2002:a9d:562:: with SMTP id 89mr472262otw.232.1569848007287;
 Mon, 30 Sep 2019 05:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822104957.GE20491@stefanha-x1.localdomain>
In-Reply-To: <20190822104957.GE20491@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 13:53:16 +0100
Message-ID: <CAFEAcA_FLN=bpBr4RriqAOS9e2v2bkv2Wnqwm9Rwcm4oX2PteQ@mail.gmail.com>
Subject: Re: more automated/public CI for QEMU pullreqs
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 11:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Thanks for writing up this summary!  The requirements and possible
> solutions are now clear.
>
> We need someone willing to set up and maintain the CI.
>
> One-off tasks:
>
> 1. Create CI runners that offer similar cross-architecture coverage to
>    Peter's current setup.  qemu.org has some x86, ppc, and s390 server
>    resources available.  I'm not sure about ARM and other architectures.
>
> 2. Write CI configuration to run Peter's "make && make check && make
>    check-tcg && linux-user-test".
>
> 3. Document the CI on wiki.qemu.org.
>
> Ongoing responsibilities:
>
> 1. Triage failures that the qemu.git maintainer thinks are related to CI
>    runners.
>
> 2. Keep the CI up-to-date and runners online.
>
> Any volunteers?

I see this call for volunteers didn't attract any offers :-/

Thread consensus seems to be toward using gitlab CI -- assuming
we can hand-build the gitlab runner for the architectures
we need without having to block on gitlab fixing their weird
"build for all architectures at once" packaging ?

thanks
-- PMM


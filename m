Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBEC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EDB20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uh1YAiqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EDB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvBI-0007do-Nz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv9p-0006kD-1D
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv9o-00084r-2j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:11:40 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhv9m-00081W-8g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:11:40 -0400
Received: by mail-ot1-x32e.google.com with SMTP id l15so13204403otn.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tMjEyo8qv58hfnd/A1KtRyIqaXmhaHS/yWsWNWh3FeA=;
 b=Uh1YAiqyYjqYruJLmbPpuXECe/8mlwqc3oG2PUTUy+nvNB2UAtvYEiz0nAqBjRMviL
 Iw+/a9TpK+xM169mv0G2X2kEUJ0wO+PXwe1CA9lTNkRHx7S1wqox6eHAsUfqJWvI+5vG
 EtiEQj+omrZLJNcA4YnnlRUk8uxm0mMRv4jz8Sqnu2Gvk4cX9ImouwOGfpKZCWXCj16A
 8yGXhozikLO1HF/asdk41Jnm+wzKuQ/vF85kCMesoEPb0NGkyDsqgl75jJzonSvV/4ps
 w83Zy/s00KQKLcKX5ZPMTHNMAUje0zX/4mkEG9hYFyjjAMK6RDLy/3pTdJfLwCx/0SVc
 Z3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tMjEyo8qv58hfnd/A1KtRyIqaXmhaHS/yWsWNWh3FeA=;
 b=Ha0seFv3D9wo7tSKs4wTC9HqMlX6S9o5mRyzLpGv8lMkI/wMxTNgdFF7S40Y/62nwR
 grohJikwnIUU9t8+ja4WEMmH1UqgvpQQ22ay9m/AzInGAEB3/fJWKnXPC9jxemtdsPhI
 nyj9HRfymy7FqE+0wVYFpjhwbri1X0n1lrx45RGSD9yqClzat7DBq6QoUNI8nwHoy4In
 +xqYuuEh9tcvUa0CjqDH3gLkQl6IWh0fzjh1q+LAg+PJnbE+pcvfzczLsyiiIA2zn296
 F+yGSc7aWzgIBuC0NA7OIyQsxXNhUE5X7r+kH/cqPPKnvipKGm3IGtTKUzFPL5wgoPGk
 aVpQ==
X-Gm-Message-State: APjAAAWWGe8SRXeRna8c0sKaP8kjhgnXyXbnNIRqbcu9PU0wKqWMAp3A
 XzUDAGLDKa3SLhClpiAq6f7nHb7Krjf9v1Iud9AsSw==
X-Google-Smtp-Source: APXvYqxNn4uhKsQa3uqldLN+sEzR7vI8/t19MAKh6bfNSTc4o5LqdCf5LHsgPX8IzwYj4bMHyWe2lU6Qhty88fqRMKU=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr18301275otj.97.1561983096606; 
 Mon, 01 Jul 2019 05:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
In-Reply-To: <1399218244.1210557.1561982640362@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:11:25 +0100
Message-ID: <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 13:04, Lucien Anti-Spam
<lucienmp_antispam@yahoo.com> wrote:
> Further to my initial problem I noticed that TRAP #0 also jumps to the handlers +1 instruction.
> Same behavior can also be seen with ARM "SWI #0".    (PC shows 0x0C vs the expected 0x08)

Yes, that's a known bug for arm -- we treat "single step" as
"execute one instruction", whereas I think most debuggers will
treat "we took an exception" as a reason to stop the single step
and return control to the user, rather than executing the insn at
the exception entry point as the one instruction of the step.
(You can see similar odd behaviour if you try to single step a
load instruction which causes a data abort, for instance -- on
arm at least we will execute the first insn of the data abort
handler before completing the step.)

thanks
-- PMM


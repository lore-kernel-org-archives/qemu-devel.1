Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5433DC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1812120659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+UfI6S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1812120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYOv-0005qB-Am
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsYOX-0005Py-Ef
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsYOT-000786-71
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:06:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsYOR-00074T-2f
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:06:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id m202so48865993oig.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OOiyDRZtcHfT6hi5MfLUlQNhd6IyWWqtRGO5KzdX1lM=;
 b=O+UfI6S4ek5EX1eavRI6toVQNzKNlWWkXRA3/oQ00LpilKmBLpm/eoDMbyFHBL385S
 vbSBksTeC8DpbS3p4D76f33E2fAcpwXG+F7EnCjYnvSBHUh+U8xD4/snxswBq0VQ1Vju
 ujKZQxtYTcVpEhcqi96HEu49mRSDOKLod1Z6G89Ep3qM/b+B+AHCx7LbtBzwukOy6n95
 FI9RtUJHVXbRZqLaaMFVa+cvW4hy8cvMFaBQ4cVANaA7zOuvf88r5t7THLllC0msrZNg
 5WmxBvna3NKgBdmI75OMij0PofQMIlxkdXhB1NPpkfwgBcjl0IuFDbZwMtzq7zzAD0dA
 tO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OOiyDRZtcHfT6hi5MfLUlQNhd6IyWWqtRGO5KzdX1lM=;
 b=jZAMBbEmp51pxJrCvcW+CSMMY8PLAMW5oTblNs2ZKLioRB8dUoL+oRWt7oMfTt5qBI
 1QaEXlGuhqwzzQWtPyvKWdnjJCmnxgwDogQMfdK8vX1YZQ0A9Q2cALLcHGNT/OSOe+rn
 MG4yWPGw6kRWcpyqSYEYAJYB4yHhkWDgNeRpqH/aU9pKchsszSDMraYKb/88QeryJdp0
 D1cDbRunjtNx9BcqkV6ZTiSaXKPsNPmOLJJUJJw9vCdjrFo3C8Um0mfHjCE+Ha2L1wbY
 NUIoL18S8ciFjg73RCcABsGy23ZVahw/oX1MBeStXgeFTH7KjHFPYDv435fNop7x3dhR
 yOdg==
X-Gm-Message-State: APjAAAWydoqiuhBr6/mCHUOsb+tFX5kZq/A856gljb4h/HsC/XVrIvX3
 yw54HTCREGxKZO5uRF5TA3m8ATocoE+cs8ymD5lIkg==
X-Google-Smtp-Source: APXvYqwDQeJxfOh99aSkk1oKMHGT5KlbxdM2OmwW0mmNFLElsUABfuHqN+rQUIVRRBEcuZIz7texmW6y/0Gxya5Bu2I=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr55625450oie.48.1564517199499; 
 Tue, 30 Jul 2019 13:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <8a5c6ca782b64899b7d6fbf47e8e6869@tpw09926dag18e.domain1.systemhost.net>
 <1564017946033.57669@bt.com>
 <CAL1e-=iGAiPdsbeVjs=LJWT7pMQCO-MgriS8DJDXtXXQd8xYiQ@mail.gmail.com>
In-Reply-To: <CAL1e-=iGAiPdsbeVjs=LJWT7pMQCO-MgriS8DJDXtXXQd8xYiQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 21:06:28 +0100
Message-ID: <CAFEAcA-s6zEtZ73mBjw0S7r4+y=EJ=4jPqKX57rdTOeTvQCeRQ@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 1/1] configure: Define target access
 alignment in configure
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
Cc: tony.nguyen@bt.com, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 21:00, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Thu, Jul 25, 2019 at 3:25 AM <tony.nguyen@bt.com> wrote:
>
> > Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
> > defines out of target/foo/cpu.h into configure, as we do with
> > TARGET_WORDS_BIGENDIAN, so that it is always defined early.
> >
> > Also, poison the symbol in include/exec/poison.h to prevent use in
> > common code.
> >
> >
> Hi, Tony.
>
> Thanks for this new version.
>
> When one mentions "also" in the commit message, this is a kind of strong
> indication that the patch should be split into two patches.
>
> So, could you please consider moving "poison" part into a separate patch?

I think in this case the issue is more in the phrasing of the commit
message rather than the patch composition. The patch is
introducing TARGET_ALIGNED_ONLY as something defined
by configure, and the correct status for that macro is "needs to
be in poison.h"; having an intermediate state where the macro
exists but isn't poisoned isn't really a logical split of the work.
(The previous ALIGNED_ONLY didn't have so much need to be
poisoned because it was defined in cpu.h and so the only way to
expect to get it was by pulling in cpu.h.)

thanks
-- PMM


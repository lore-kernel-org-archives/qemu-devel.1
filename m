Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DFC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9433B20757
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9B2cZ8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9433B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJTgx-00008y-Mk
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 23:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <carenas@gmail.com>) id 1jJTgD-0008BT-26
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <carenas@gmail.com>) id 1jJTg7-0000pZ-Bn
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:04:36 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30]:41270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <carenas@gmail.com>) id 1jJTg6-0000fN-Iq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:04:30 -0400
Received: by mail-vs1-xe30.google.com with SMTP id a63so14933964vsa.8
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=juhyjxDRcYlvQErJ1mGGdiwrgHaBacs6wM7C3Ifo/Ck=;
 b=K9B2cZ8j2hAQc9maijkxGu99LNzt4vXD3dYcGyR85gGRUx3nEG/MvBTbZVtLQpV3S5
 0RP1bOG8R27Sip7aiWsB+WENmm8njyDr5B5JADCqiabaVoDCoRfcBxXX9ycE/y0JlJCb
 rRfjB8LKkzftZDQEos9aGPr8rODZEewtpdKR8YWbH1TwX9NYruHEkq16EXHwHtCuYEve
 wkBFzGPogGKo+3vOxmrv7GH2d17nmsyLD4JJZn+kIbODZMeRtB+zydN974OIdrJ7roMS
 xJJgfS/wzJWFojEHVkpyTGH0qdxGBzBY+xCjEhLO6Mz2VWLkt+M4zZe3kWvfXSMY1Num
 40Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=juhyjxDRcYlvQErJ1mGGdiwrgHaBacs6wM7C3Ifo/Ck=;
 b=XQbFfBcu1EIv7zelegFQzKg2swo8i7OGxcovIRWoBgYM/V45hD4+uFFqG+mMaGtb+R
 tbjc9bKAW1ZFjto/4Bf2dNfttTn9h6d8H2kkSXoNNhbuVc3hknoA1nyRZUWdvaFhNF1J
 oKgFJZ1y+ZVo5+4OVmN/+7BG5//fwkqhFTsidkUwf1UwFDiJPvZMDUANX32dw6lHfvtJ
 yui2y8ktT/I/sGGPghWm9LrLC4tgfgmW5wta4FMkWIA9en8Rkl72BCw3i7a7TplZ7BLY
 Xc7qXRabz+BmDAIm6aCOX+X6fH5cLwOGGDOKSY+DOz4kdKDtUCBosUevfywS1kg1z+Iq
 ykoA==
X-Gm-Message-State: AGi0PuZlOVa7yXusHSkO5jCs7rVl6MtDbBay8nLzP5NTFtva3DJS3Iz1
 GNrtUqN+7GvrLKiN+AQ2bF+2+3g787GCKnx8txY=
X-Google-Smtp-Source: APiQypI7wcH9vVmd9wUbfH72DwZJrR5lELUUCuigcxQ9jGHzQe0lHW1+bdFRooJdpW/yOFdpWtz75Wx7jzjdq53igqw=
X-Received: by 2002:a67:f404:: with SMTP id p4mr2347711vsn.87.1585710249884;
 Tue, 31 Mar 2020 20:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200331103758.370644-1-berrange@redhat.com>
In-Reply-To: <20200331103758.370644-1-berrange@redhat.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 31 Mar 2020 20:03:58 -0700
Message-ID: <CAPUEspgRLAyM21h3XaGurncJq9oDCGPAQ8S6zJTwdA31a3fFrg@mail.gmail.com>
Subject: Re: [PATCH] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000029425805a231f0dc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e30
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000029425805a231f0dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 3:38 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
>

s/in future/in the future/g

Carlo

--00000000000029425805a231f0dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Mar 31, 2020 at 3:38 AM Daniel P.=
 Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.c=
om</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Running configure directly from the source dir=
ectory is a build<br>
configuration that will go away in future. It is also not currently<br></bl=
ockquote><div><br></div><div>s/in future/in the future/g</div><div>=C2=A0</=
div><div>Carlo</div></div></div>

--00000000000029425805a231f0dc--


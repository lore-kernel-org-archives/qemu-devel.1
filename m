Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA7C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB4320869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdwaEiM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB4320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlsx-0003t5-F9
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSlsF-0003Ls-9V
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSlsD-0007Ok-Tp
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:47:10 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSlsD-0007ON-Nw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:47:09 -0500
Received: by mail-ot1-x344.google.com with SMTP id r24so2723786otk.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wWAEfbrY3X+B0yS2rN8R3NTVzMbR7n+8m3cG0suIljc=;
 b=ZdwaEiM0TbQpfOP8dDSO6AyAlnv1IJXQZA49Joc4of7o0loZa8j4eshRDPN9v8lZYT
 w1XbTVkgqbgQqWrXXO5qBX+5YVv+UuEX5YvwSgaw5M84nMZFe6GxQMYLEm80e9IMyDMD
 rfLHqmK4O1Iz0EyXMlhqVzjbjvNNP7lkwM+2TWdPohMTRghBzv8dxjkc5eH9KveAfv3j
 xao/6/Ek3IxU6beNACDO964Qo/kFBJnOcf5zvAHY4FNF11VOadVuHM1ZgGL65Yn56t+q
 S3/JP+ZnFdRccZ1vqvpHup8YfeF0oQZ9evPROcoHdm6W3pbChws0Dcbln5QIMkCLiqR3
 FQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wWAEfbrY3X+B0yS2rN8R3NTVzMbR7n+8m3cG0suIljc=;
 b=UnYTkBs55hKR3F1/gaVWrt/2xSYtuW1uUg8K2J4hUrhvxqWpkMkDsturUZCmRWUlxd
 1KapcC+0+HYhW6tOEDfo5juJKcNQIGLfPMk4HyI51W50FUMiZ+HgkyF0ZBAmso9EcITG
 YXlovtEnQl4rie5tChot/P/id6HvKcTrl0lez9jOFyYkGnYANrmzydbMVerGaNZ519Tl
 coIm9rRkZJ43bqQVAwWrNNLihMGpxEEbVCPGBltfG0ehIdh0l2FUboCcWDD+Lffw19W+
 tkNzDRm8uanEcvW1KcK+PyruUITBgxdCO3tIysgl6r7ou2WL30WR3oMevB5+V9nxSuPJ
 Onhg==
X-Gm-Message-State: APjAAAV/yKPIcPPd/PVtFPk53DERPauAymDo0ISGxekPo6VLzCEzKmWh
 lLr6PWGuh/kmWp7ZJuL3HMDApREAlR+EuicI7D14Lg==
X-Google-Smtp-Source: APXvYqyFsg6LxibE8FSkxHwFV+lBaRdr+OezcCZZpqOu5f8AXVSVi2WQUBTclE8rmR9z80ZFBcrf99hzVVsfHTLKzYk=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr665232oto.97.1573148828504;
 Thu, 07 Nov 2019 09:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20191104173654.30125-1-alex.bennee@linaro.org>
In-Reply-To: <20191104173654.30125-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 17:46:55 +0000
Message-ID: <CAFEAcA9SOok49C8NS-+kEZyk7EYS10R+RNmhprk2J=KB3bJQFw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] testing/next (netbsd stuff)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 Nov 2019 at 17:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Hi,
>
> As we approach hard-freeze I'm trying to temper what comes in through
> the testing/next tree. However it would be nice to get the NetBSD upto
> speed with the other NetBSDs. Although the serial install is working
> well for me this has had a rocky road so if others could also give it
> a good testing that would be great. I've also disabled one of the
> regular failing tests for non-Linux targets. There are other tests
> that still fail however including the tests/test-aio-multithread which
> asserts in the async utils around about 20% of the time:
>
>   assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
>     "/home/qemu/qemu-test.nS1czd/src/util/async.c", line 279, function
>     "aio_ctx_finalize"

This is unrelated to your NetBSD update in this series -- it's
one of the persistent intermittents I see on the BSDs:
https://lore.kernel.org/qemu-devel/20190916153312.GD25552@stefanha-x1.local=
domain/t/

(though the failure rate I see is I think <20%, but I haven't
really carefully measured it.)

thanks
-- PMM


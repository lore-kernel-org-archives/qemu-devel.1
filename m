Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC70C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F7E207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0Z58UKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F7E207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8p6X-0001d6-TA
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8p5q-000172-Nq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:15:18 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8p5p-0008KB-07
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:15:18 -0400
Received: by mail-ej1-x644.google.com with SMTP id qc22so3634658ejb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HqyueAZanP82uR8ZbxI19U2lugwiObwSRZof5+d18Gk=;
 b=e0Z58UKHQcaLVMwykV/48k4fagreisABt/BmN3V9iSrDo7QdaErq8Y5eTYqn5dOLQF
 AVKdB/eeR+ZfJyq1X5WBAmA5OX5E54tmWPle68L3OcqgDNn2VN5S42tpvTZ2NqUNmAS8
 4igKkXsMCevFF7bTO82Ezt+yq3B0UNK97U3+yMEdKum2myLEICpzC2EBUS7n6wJRBp8c
 XgjDPFoEhAROdKwom4ombmRwOPgHeABTE91ba/DCiuzFKSaGQZJG0mCKCOXP5hZapoQT
 aldmCzyifFXbB3xzBwnY2H28Px/QscPzsuUDWBO+dpoZTRVNAHWtHAydWkBHl7wC8+HH
 sb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HqyueAZanP82uR8ZbxI19U2lugwiObwSRZof5+d18Gk=;
 b=X7XJUTfiAEIhkyBnVtKIeLgs0S/y9enQbSqCIgqYWf+/NvZryhsQV9qJP5sYXcelIa
 +Uqj9BXC1KjYOMhYKUz/fhY9tSHE0S+f9dyQcpl3cSABtrLQU9jzSO3EUVwNjr7DXr/5
 M/KNnuEH3yXep05rbfpOmT2z+LOzEve63AjA7wJG8E6cig9WTx1Y7jmfYnK/IC8PUbuk
 1OOMi2MPqrKUKdiWTgr+7pEEHiD1MtRrGypUY/Anoj6remmeaDgrMh0fx89AVCl8YHYB
 Eyj8B/ftFRhVtlP62yIX3U8yCbUfJT4n7FoUGoP+4Y8jiaicv6nhYq9dzADihID2c9zT
 puMw==
X-Gm-Message-State: AOAM533+01QxuGaTWBmpSKJ43NCJyzybHxJ68q/eg6xySzY9K80LbTId
 pZIlEdOuYyZKj+U9X82nKX2pOZ44m6jK1VG+fcabaw==
X-Google-Smtp-Source: ABdhPJyR7pohToKv3iruQaeRZZLw9p+JtN7Dn609ODnHbBFPcOzTqz/TePjY+zD0O3NolP0nUX64FfCXdqN72ua/u+g=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr3881167ejb.4.1597947314399; 
 Thu, 20 Aug 2020 11:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200820165543.215372-1-berrange@redhat.com>
In-Reply-To: <20200820165543.215372-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 19:15:03 +0100
Message-ID: <CAFEAcA8Rk5yB-Cudx8abpxSEcR=87cWhg0Ywm9w6bvqa5nneGA@mail.gmail.com>
Subject: Re: [PATCH] configure: add support for psuedo-"in source tree" builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 17:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Meson requires the build dir to be separate from the source tree. Many
> people are used to just running "./configure && make" though and the
> meson conversion breaks that.
>
> This introduces some backcompat support to make it appear as if an
> "in source tree" build is being done, but with the the results in the
> "build/" directory. This allows "./configure && make" to work as it
> did historically, albeit with the output binaries staying under build/.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Oh, one more minor thing: 'make distclean' should remove
the created GNUMakefile (and also build/ if configure
created it? dunno).

thanks
-- PMM


Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D21420639
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pegGiYYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21420639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaN5Z-0008EN-EB
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN3f-0006Bn-G2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:58:55 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN3d-0003tD-Vg
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:58:55 -0500
Received: by mail-ej1-x642.google.com with SMTP id dk16so30413676ejb.12
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tiMc1SzEb9/AlSm+lWxWCGF+8aQOAj16s2TaXghW7V4=;
 b=pegGiYYnGCYQtZMM+ZRIsr0ezlbbyMQDuvsUPE1h08A7zhWAT0W5C1RzX0wDTGSx/1
 bSkNzWInS1evWUmDjytnJNUOJnzhrDw5WSgOO51l2QXnmSAR1Zp/NwQ96DJpkUhcAsmS
 KuzUCatyIG8ANIKeWtedwViTwp+ZYZskkMBsoDkMCHHXTiZohyPrTAz7YPyw5Sm2pjdW
 j29q470gQlvMa6LWDUuKZJ7MQyYYfR5rSx1pLdAMKj5NMoPBYmKd740ir+nNXUuEgJNP
 HM7T0gA0MXkzrkhGyliX/jUUykEBlDUJx2Ectf9VgFx6jGvAxmEdmK7BSPSwAeiXgwhI
 etjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tiMc1SzEb9/AlSm+lWxWCGF+8aQOAj16s2TaXghW7V4=;
 b=WY3ZXfbTT9yZ5Un7WH5A4stQCqOrMgGzw9o+8x26PzEJyFjRaq1YvSWrcEVu+ZGJ0p
 4HP8Wd0zuc3phr3sHYG/qeMkPlryeEaIJGd3/+qNQYW0pNiaNeG8KYhqxDL50I6kK+9d
 3mlnO1nqPZ4F7zStmt5PKwCzQ0qcSyf+GVj1FZXpU68xfyjxPdjbybwyNjYTiaK4NuOd
 lU/ll968G1MJrdfOtqb27jSF1qoYDDNXRUmPiwely3EDHFEtqTzSATRAf3W4bVlXOzBP
 hVlPIZ50OkkZco7Egom1FJ8GoU4khAynFyJZdmryamOmqCQG/kWIwkhz9JtOY5E46VAW
 O/SQ==
X-Gm-Message-State: AOAM532FIoNUphaGmjneBn+XnH4IjVyG5xXi+/u5QzAJzXgrEpDTWG2s
 wyzaB+TprZhPiHmAZuoCvefE1sXe/hqsNKx7N2qQWw==
X-Google-Smtp-Source: ABdhPJytUjPJuz14l55SKD3uW1VPsHXkiSs+rTUgRuh5SAgtCdVQaCNjCnJ8PfE1SX00T/nWJ0eCnkD4/iauqwT6Ieo=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr26048032ejd.250.1604512732596; 
 Wed, 04 Nov 2020 09:58:52 -0800 (PST)
MIME-Version: 1.0
References: <5FA280F5.8060902@huawei.com>
 <CAKmqyKOS4bALKNTA9wMK=HANz4Dc=fffq2pZafCxGFqsJ_LMkg@mail.gmail.com>
In-Reply-To: <CAKmqyKOS4bALKNTA9wMK=HANz4Dc=fffq2pZafCxGFqsJ_LMkg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 17:58:41 +0000
Message-ID: <CAFEAcA9bq8Fs62wD6dsrRcYvSogrdzK9cDrzoVmMFcpui8=_uQ@mail.gmail.com>
Subject: Re: [PATCH] ssi: Fix bad printf format specifiers
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, QEMU <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, AlexChen <alex.chen@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 16:33, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 2:23 AM AlexChen <alex.chen@huawei.com> wrote:
> >
> > We should use printf format specifier "%u" instead of "%d" for
> > argument of type "unsigned int".
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Alex Chen <alex.chen@huawei.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>



Applied to target-arm.next, thanks.

-- PMM


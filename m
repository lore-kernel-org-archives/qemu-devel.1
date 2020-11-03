Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB502C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292B920757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESRvoTKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3o8-0007VK-8R
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3ly-0005uI-4u
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:23:22 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3lv-0006Me-CF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:23:21 -0500
Received: by mail-ej1-x644.google.com with SMTP id k3so26443527ejj.10
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ka8Xf5tuG9vgtHyQpuwVYXHEQ5Lz4ACYUCnB4dnXRtM=;
 b=ESRvoTKO1RCFbfPpxdFV7pE791TOOMizwzEAmYDZxsC730XWTWJlsYBboWu/Tp0pb2
 0IkJf1mlQV/TbI+uJH0FvChiVwLpySyFz5OqVvbLKsz+RT39aIZDrxy51NKIFwcT4j7J
 q64oGJh5n3iGPzzlylDk7UHk0e7An1spdqHiNKsdqFylns9/AscYsrxOsVVeGpu6gY2P
 5Y7gfWFK+976sS3zq23N2UgTzZgbbohayK/Y4fMQTT3Vbbt7xszqmbA9gg+LcGB7ZgmD
 acDespIoxm07u8JVpEvfcHky+BxWaUtsZv+3vfNL8nOk97phTEZUy7J/BJCKgv5g4p10
 KDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ka8Xf5tuG9vgtHyQpuwVYXHEQ5Lz4ACYUCnB4dnXRtM=;
 b=lrHHZw4C7tg+tOQZmHiVCQr9JHZSKTRWrw5CHcju0ukUPiiwEUdWrbf/6KcSSf/DuX
 vVC3b6VoZk3DQsMXQ5Sc/OTMevmDBrUkEAEsi8RyKMjbbZiyGvAzjofdQBQG8u6vrwQQ
 zH5qShFwvDoinU/Qti6wsHSejs74gT0x620cxoPDMD/+P0hdWvzHgtXVrMhhwZ5XjCBO
 ZW755s8aIKyEde2fhn56giIhb/3jLT00SA+dYjddNItShvGB35kvqK4WC8nsUJ7EewLe
 1qpLhIh5AcMMmJJiIPlqQGvihX1NXpWFW5zNU3no3f3MAZsyiy1nNsTIscEqYU7Vib4x
 KVfA==
X-Gm-Message-State: AOAM5324M1vr/qhXe6zG7DLpLXijWBoO0prJukb+92+5gL1x6Yz4pfwe
 h5aWQ9/H70m/7WvQnMPYigFWhsGcMBmpWbZCk+VIqg==
X-Google-Smtp-Source: ABdhPJyxL91w+dzNGRrJTkpJRz4BWLHyyFFO4GraY6XcAq3tMqf2LBSwH8UXMQ6+CII7W+V6A11zzWHwCbXr8rD4GJU=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr21235315ejb.85.1604438597225; 
 Tue, 03 Nov 2020 13:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20201103114918.11807-1-peter.maydell@linaro.org>
 <6eefc3e5-2b95-1f0b-7b02-ef321cbce0f5@amsat.org>
In-Reply-To: <6eefc3e5-2b95-1f0b-7b02-ef321cbce0f5@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 21:23:06 +0000
Message-ID: <CAFEAcA9W+NW1VpNyR+M3YpV_iWTrgovYV=guNN61d+4WcPP+8A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/nseries: Check return value from
 load_image_targphys()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 21:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 11/3/20 12:49 PM, Peter Maydell wrote:
> > The nseries machines have a codepath that allows them to load a
> > secondary bootloader.  This code wasn't checking that the
> > load_image_targphys() succeeded.  Check the return value and report
> > the error to the user.
> >
> > While we're in the vicinity, fix the comment style of the
> > comment documenting what this image load is doing.
> >
> > Fixes: Coverity CID 1192904
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> What about the other cases?
>
> $ git grep -E ^\\s+load_image_targphys
> hw/alpha/dp264.c:163:            load_image_targphys(initrd_filename,
> initrd_base,
> hw/hppa/machine.c:301:            load_image_targphys(initrd_filename,
> initrd_base, initrd_size);
> hw/m68k/q800.c:388:            load_image_targphys(initrd_filename,
> initrd_base,

They could be fixed too, certainly; I only care about the ones
Coverity is currently complaining about, though :-)

-- PMM


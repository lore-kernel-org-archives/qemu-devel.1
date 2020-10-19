Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A1EC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E4B22268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es41IcoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E4B22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSpZ-0003Tx-Rn
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUSfy-0001GI-25
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:46:02 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:39254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUSft-0001A5-3X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:46:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id lw21so13214882ejb.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+73bcJjy4acKs0QQOk2O6PyYmDWLhs2NPqndP0910bQ=;
 b=Es41IcoX1rrBWxfBzXgJPTbTbrDQHMC+OqYY1V4s+MuEDQqhdc/UXtjgCD569Dg2Fs
 0Bzy1MYkLazJ8Pcuudf68lbg2TZeET9nGYdmErQbM7rAK9Z7vXzFWCEKkXzG3zlw33MZ
 g38BZzaI0V6WhOrpEC8MT92BBP/N4rkPKN3XdPqIrfHUa2ovr1VdnVs2i7dFQRGJfHpp
 sX9QrSM4xjZ6JaPhk4IkIziz+eJpu2Pv8IqGU7PljoQd6WgJgurZOsaMAujd1JIXClrN
 xpeU4cgwGXcnDzLy5jBU/aCYbmnkHX+8nfdiS5pYfUNKs7KRjKeMrV9NzSiCOyjjT6/x
 9/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+73bcJjy4acKs0QQOk2O6PyYmDWLhs2NPqndP0910bQ=;
 b=Ow8kyTOYaN4Cij76rIRlG/Fu8muz/za8CIU7qbTHo7xkjlSqYdLsUFCSWhshMRlDlF
 8V6xP6N/AG7Rbl97qTfo9qzAlPR8RK55ATZ6JQTaOAFgXMTRCF4SGww9BCrUMN0nU+w0
 bPaHXc4CUK7GmSb+0uxiZht+f1XLVIGA63grU/hlu5PcqL7hicP0qlbHuqn9o3V92Y4x
 1DpoHmJgm22rgyjeRKDJpt/48RE57CkqnsxOD6yBE1lCylh+A8O1KGm64tA/VTBI1Hf5
 Tx1VFUgXqCRvlDZcV7gqC/k9QxNKufzCOy2aA5+0UUY2ct6BZqMLbTXc365mFGMStVNR
 W9Yw==
X-Gm-Message-State: AOAM533AmZyXbHJRIv8s2XMNuSvnMxF57OzHD6fRZXBAaMl4jzZHXCcC
 PU/1HjjXp0a3Vdmt1qjvnFwB9sQ2IrrIhD4QdXZWcg==
X-Google-Smtp-Source: ABdhPJyFV1jeriePU6Z9wgohRzIp5T11CFJ6aJYaPbOcgoLIpKzKWSlaBIcQlbW+EgU6JNYFO4f25+FHKf0p9RgjYDE=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr15903600ejk.382.1603104355170; 
 Mon, 19 Oct 2020 03:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201017140243.1078718-1-f4bug@amsat.org>
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 11:45:43 +0100
Message-ID: <CAFEAcA9JpBn3ux_R678reRZaFyMbtRA0i6R1YuXb8bCUipX7Hg@mail.gmail.com>
Subject: Re: [PULL 00/44] mips-next patches for 2020-10-17
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Oct 2020 at 15:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 7daf8f8d011cdd5d3e86930ed2bde969425c79=
0c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging=3D
>  (2020-10-16 17:39:01 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-next-20201017
>
> for you to fetch changes up to 68fa519a6cb455005317bd61f95214b58b2f1e69:
>
>   target/mips: Increase number of TLB entries on the 34Kf core (16 -> 64)=
 (20=3D
> 20-10-17 13:59:40 +0200)
>
> ----------------------------------------------------------------
> MIPS patches queue
>
> . Fix some comment spelling errors
> . Demacro some TCG helpers
> . Add loongson-ext lswc2/lsdc2 group of instructions
> . Log unimplemented cache opcode
> . Increase number of TLB entries on the 34Kf core
> . Allow the CPU to use dynamic frequencies
> . Calculate the CP0 timer period using the CPU frequency
> . Set CPU frequency for each machine
> . Fix Malta FPGA I/O region size
> . Allow running qtests when ROM is missing
> . Add record/replay acceptance tests
> . Update MIPS CPU documentation
> . MAINTAINERS updates
>
> CI jobs results:
>   https://gitlab.com/philmd/qemu/-/pipelines/203931842
>   https://travis-ci.org/github/philmd/qemu/builds/736491461
>   https://cirrus-ci.com/build/6272264062631936
>   https://app.shippable.com/github/philmd/qemu/runs/886/summary/console
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


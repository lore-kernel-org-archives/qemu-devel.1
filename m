Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E63C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88DA20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWd+H3GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88DA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqd4C-0002Up-34
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqd3T-0001zJ-ED
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:45:39 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqd3R-0003y2-TC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:45:39 -0400
Received: by mail-lf1-x143.google.com with SMTP id y18so13615667lfh.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=if9uY0p3qfRQUqC4wu+FkB1BnF9XMBm0XdamLIpBPnE=;
 b=PWd+H3GGAaRYP0On5kaMEwToQMvy7qdSTFIzGEzTUFa2lfiPxeyPAgbRZ6Ejh1UGT4
 a4v+1rkd3xP7tXSeOpn8bYlPzihngA/qYWXWgduxxN4gJyAVBVI0PNbKvB+ufvCs2OtS
 OvnFmyPwZseSILGRKIOArRwcIY/lMpm8MZqSnFWvSwpe9L9XwRtBMMQJYwFdAa1QX720
 ORPF6lTg762kY3paZ6NGq+u49yZKs0yb6dB5b2zXnrX2hlrbvzB9NcCRUvvBUhkS+Qn9
 HssHrqcVmDRQ8ntGYshMF9AZbbmVpUH3P+mq5wFO7VVKVlQeimlWGRskplEU7nU4sZxT
 GK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=if9uY0p3qfRQUqC4wu+FkB1BnF9XMBm0XdamLIpBPnE=;
 b=nOVq6bkNGWSvE29VR0V16ItlHxgWWwZlNrSxXndWU2p+jvFL1hXJPaVI/MNvSol53q
 CDs2DugGANedQnOch5XJ1eRGTpa6WWzs7FX4GiDTmokR+7WfC57t2P5n4f1Xm0huZOXb
 qMREbxIu3ejNPMt352MnUHqqVf9LYTxLvgj6IjYJ8P3aoau3dU/yd+Us8NFwQyGlwg5Q
 OHTDJ4yUta2JHh4Qvs0dLz/HkV6pT45tZGg1l5LrYiyGq+yReqfLgFq5T47lMwzBITcy
 4UwsZsgduQLOOLvAU9TvfAk4Hs3WRz4KRWmiBfJ6kuLvw+djVw8EOSfSuM57S1dlFn6K
 rdCA==
X-Gm-Message-State: AOAM531qh4G43+eIutUMjXJlJyT/zmsv8RReR/U7hGNytF6bE1Hy09mB
 UBX/5SjcY59Phy3xXVAUCOhZVbdJvdLCzP2yW14=
X-Google-Smtp-Source: ABdhPJxnhtW//cSbjRglPzHwYgzLTo16ef3YBB95j12wsAayWHgwWdLGQqnRd/6Ysk6LoCD8REX4dkPM9TDT34t0dZU=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr15415733lfh.89.1593611133414; 
 Wed, 01 Jul 2020 06:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
In-Reply-To: <878sg5svu5.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 1 Jul 2020 15:44:57 +0200
Message-ID: <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Assuming your test case is constant execution (i.e. runs the same each
> time) you could run in through a plugins build to extract the number of
> guest instructions, e.g.:
>
>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d pl=
ugin ./tests/tcg/aarch64-linux-user/sha1
>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
>   insns: 158603512
>
> --
> Alex Benn=C3=A9e

Hi Mr. Alex,
I've created a plugins build as you've said using "--enable-plugins" option=
.
I've searched for "libinsn.so" plugin that you've mentioned in your
command but it isn't in that path.

Are there any other options that I should configure my build with?
Thanks in advance.

Regards,
Ahmed Karaman


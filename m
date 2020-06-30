Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7612073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKrMPWyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7612073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqOEX-00083T-B3
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 17:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqODh-0007LX-00; Tue, 30 Jun 2020 17:55:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqODf-0006eO-9k; Tue, 30 Jun 2020 17:55:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so19198425wrp.10;
 Tue, 30 Jun 2020 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I6CDGJL8XjgO7LAGyyB4NDAKVqim4HeLk2kRAk4UpVU=;
 b=sKrMPWydGAVKsAjkdnoq9PYl5XZr6XNNjzvLkPJmxrop6ZBhbVhlM77MowB/6dcdYW
 sLuncYfUKjf3q+86MDn7G1AkNASrYnwWCDcSpXQO2eaU8M65vBB9d4OXL3ILpfvPHbQD
 +rN6jrJwK+nZIBQrybJ6lfXJyEozjzxLtbAX1wEcPoC4jm5kZWgbo2WtuLcjw6+nESEd
 Xj9SqNQIzvdxUieCd56H82j8K4SoOlq0vywYZvXZ0UXCAxsiDidnWcQMec79az/5gbKt
 nIzcX++A9cpiFeJr/yohGsOxZ9zrVI/C+Wgx7j3F0QQmqzJVSQzQhCJ4EqSuKKVJq72q
 tTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I6CDGJL8XjgO7LAGyyB4NDAKVqim4HeLk2kRAk4UpVU=;
 b=sk9bz7y/3wmFvuFXDa9ExaR9LMbPJeXf4uDgHZKWRyo5NYVA4RtlQQfszHg1TCoZId
 F0Ufymk1N8eu/qxVQ5rM5npJ7+SJNr9n45wX2GjGtx/cNaWOz06DfH1OY3ldAnhhC7hT
 YjQa9YoDJmqzcJE0IgB++kbfUrk2Wnk+cpxygqqDk5LSbbUvK1unfnlx493r9UWf+QeJ
 o7xqd4VCfCgV3HMCVyXyRHhhAQMxHkWGhndPuhrmRqgnkmjwKsS4EvYBqaOAXSKOymXs
 8UVsIU8ij2vHY5OzUnCoG6RukK8AD3QKtiGPeMr/zyezDDvCinr8B9GA6A4AqNRMPAOZ
 pf3g==
X-Gm-Message-State: AOAM530/TLX2McaquLkLm13cf5J5RccdJdz0UhfTV0QJQe3rHWeg+PoP
 0eNX65RyTdHruyVt8XK2MMfMKD3auLLNfyw/Vm0=
X-Google-Smtp-Source: ABdhPJy2fH3go2ND/pH3qegkPKvP5V0oaBJ9DkPS9xkODsBTc6WnD67P10bvNvvMQR+YtzTckkrEPsnzEu7Xv7VR268=
X-Received: by 2002:a5d:6907:: with SMTP id t7mr23475654wru.329.1593554107954; 
 Tue, 30 Jun 2020 14:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200630195723.1359-1-f4bug@amsat.org>
In-Reply-To: <20200630195723.1359-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 23:54:55 +0200
Message-ID: <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As, in a very clear way, evidenced from the previous versions of this
series, this series real goal was not not to create some new
"malta-strict" machine, but to prepare path to creation of some
imagined "malta-unleashed" machine which will, to the contrary of
proclaimed goal, create a machine that could never exist in reality.
That is why I can't accept this series.

Regards,
Aleksandar


=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 21:58 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi,
>
> This series add a new 'malta-strict' machine, that aims to properly
> model the real hardware (which is not what the current 'malta'
> machine models).
>
> Since v2:
> - Initialize missing malta_machine_types::class_size
> - Remove RFC patch that confuses Aleksandar
> - Added examples of 'malta-strict' use
>
> $ git backport-diff -u v2
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>
> 001/5:[----] [--] 'hw/mips/malta: Trivial code movement'
> 002/5:[----] [--] 'hw/mips/malta: Register the machine as a TypeInfo'
> 003/5:[0001] [FC] 'hw/mips/malta: Introduce MaltaMachineClass::max_ramsiz=
e'
> 004/5:[----] [--] 'hw/mips/malta: Introduce the 'malta-strict' machine'
> 005/5:[----] [--] 'hw/mips/malta: Verify malta-strict machine uses correc=
t DIMM sizes'
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/mips/malta: Trivial code movement
>   hw/mips/malta: Register the machine as a TypeInfo
>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>   hw/mips/malta: Introduce the 'malta-strict' machine
>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>
>  hw/mips/malta.c | 105 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 91 insertions(+), 14 deletions(-)
>
> --
> 2.21.3
>
>


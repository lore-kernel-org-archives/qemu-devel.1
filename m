Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6255C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7289B2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyHpaA7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7289B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvu8x-0005x9-Bj
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 23:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvu82-0005Ny-LQ; Wed, 15 Jul 2020 23:00:10 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvu80-000453-R8; Wed, 15 Jul 2020 23:00:10 -0400
Received: by mail-il1-x144.google.com with SMTP id k6so3825672ili.6;
 Wed, 15 Jul 2020 20:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kcv9F9yInqThuGi9ooZUXwSu/hdJyhJpWeASQpL33I0=;
 b=UyHpaA7brQcecUCqgqsffOSnPA4yCLOgdj9IgLU+k7BHdOm0pXFYFP6KxDHBzRi6t6
 cO2np075Txv8ddUGHeC1/2s2B9MBlAzAxH+aL7EW+vskKL12EbzkHwAQSkuweXpCqNle
 DC2QCHh8YNVgKTEi2b6ErnxfxOIKouZBuKEwjDGKRGvtEbqRP9BaenR7Z4GrF5SM4XOm
 OCdhaE1SrZZ+EnQfygro3RtUMP8YlKrOsIFq1v5YmevuV3tyJNziSk0gdDAsGWdSC7ry
 deupzxjpIVKGEKSw/O97MykGZnCvCftb6WkLD7+Tn9tpJiAhfgjkHsRrS850mrysyKXm
 keWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kcv9F9yInqThuGi9ooZUXwSu/hdJyhJpWeASQpL33I0=;
 b=aeZrBoCFNssa0Uj6o7XVC0cym/dcld4YPTdOJ/5hpcXe5InNgSTl1w3adK6u9zTvqo
 olK3+WLqbtxs+KHZSZ/EVpHiyOCD6M5TvltYQOh9BgEB5zoRapAaSM9YdQDH7NaszrcX
 Sus0xTtQ7R1PAI7Lb7bLVLBtygsq+1QMVoliPQ6P4LQ0/RabxiEsb6eScfFAs4wmIDIF
 zXI1/Vu2xLg4T2OAwaDbq/WDeRNljmjLg4j0nQ63Gone7+oG9e+8ZQBM2qG52vgcYmq6
 UAtBIQrZVcKylMHV+voqLUtEFs/Qi9swNClrUH8wRXVmvzrR+dXz5ma+Krda4QnDaz7m
 MUVQ==
X-Gm-Message-State: AOAM531+Hk1TYw6pSyD0c5x7SWH4LZYro77CN2F+6YrJNIZ6ShZ2VXUJ
 Cce5sAGQZIzpdTM142Kah28eg9+EPoP/NB0g1Uc=
X-Google-Smtp-Source: ABdhPJz0V5PqocNQiuleGnwGAToyqfsNlT+seElo0VM4mBKehy3uk6gy9qSzk9YG7Xkq8n84BUIKta37JHZrEMNzuZE=
X-Received: by 2002:a92:c0c4:: with SMTP id t4mr2491585ilf.211.1594868406315; 
 Wed, 15 Jul 2020 20:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
 <ef1d7fe4-0558-cc7b-16d7-906c4aa9915b@amsat.org>
 <87wo34u9fv.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo34u9fv.fsf@dusky.pond.sub.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 16 Jul 2020 08:29:55 +0530
Message-ID: <CALHRZurw_HsyFmNWYuG_Cagx8cTTBCGzafWmx6JHJ+NS7aVKOw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=sundeep.lkml@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, nieklinnenbank@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 8:12 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
> > On 7/15/20 4:04 PM, Markus Armbruster wrote:
> >> Watch this:
> >>
> >>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
> >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}=
, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
> >>     {"execute": "qmp_capabilities"}
> >>     {"return": {}}
> >>     {"execute": "device-list-properties", "arguments": {"typename": "m=
sf2-soc"}}
> >>     Unsupported NIC model: ftgmac100
> >>     armbru@dusky:~/work/images$ echo $?
> >>     1
> >>
> >> This is what breaks "make check SPEED=3Dslow".
> >>
> >> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
> >> qemu_check_nic_model().  That's wrong.
> >>
> >> We fixed the exact same bug for device "allwinner-a10" in commit
> >> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
> >> function".  Fix this instance the same way: move the offending code to
> >> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.
> >
> > That addresses this other thread, right?
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg720658.html
>
> Correct!  I wasn't aware of it, thanks for making the connection.
>

Thanks Markus for the fix.
Sundeep


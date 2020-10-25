Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44161C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA3E208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="En6BgOvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWjSK-0007Oz-Kb
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 13:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWjR2-0006mC-Le
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 13:04:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:45899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWjR0-0006Cv-4E
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 13:03:59 -0400
Received: by mail-ed1-x52b.google.com with SMTP id dg9so6954069edb.12
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wqquwDSqVyG/bvFmgSKscajVVQD8GYLcOXhE5nkMEDg=;
 b=En6BgOvKfNT2YKtZjpknNZVJTpbJiu0NKWYJ7sz91ONhqSNfcU3woj6HJ+Lov1kR98
 lYWZdERRaDxCjDVkrHW3fHPmjbyXy4+lFPCIH306GUlpMmqr0Qt6k3MkmUUjF5/l3O5h
 CrsQ38hR4mcYDTwNgfdh7L2naQmn9+c3Rs7ecoL/VXLpF1szAICh/GqOuLUguQsteMqx
 pqWsRIXFrzA/BLt/zrgkVCGXA03KRq6QmycafUFrmXoEIxzaEgHe9hNabkBMJfEil30a
 dmvde2y+05aiOJ11mag9aJj8NZ2/wuJIYf278jftkOJ1aoFp1avkm3+M1C+IPT/ND+RA
 m/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wqquwDSqVyG/bvFmgSKscajVVQD8GYLcOXhE5nkMEDg=;
 b=jtpPGwp/EHDOtjEa4PlCoPzwzLTHwgaNkO1T9nz4hK3vmjKKGBR38NlChZ95sdsGGc
 QjjZhxrzsXNOxT0ybRC3VSNTcsMOlPa6o6pilNhSwref/eH2yhy3hNpz1X+ngMSLIlXS
 EQTw12EWLaHA8BuC14YS1wzZLYG8/l/4VKW5/ZmZGhJO+5XZTdttswwOsu1bYiqO/TaZ
 JHJQNdFUk1FvJ8L/be07tlH5ipnvFpl4Pp+JJrT5rX7IqzP/pghUcPOvwoYHxK+TD2q5
 15ag5kgqwAO34OTDuLvBXMz2WfsIfiMo/122PZDFvqaIY1MvO5M5U4/a1FkPxhpOHGgN
 sHTw==
X-Gm-Message-State: AOAM532juF4HKKPWXC8WWuUMh3bioXoq/7xhY6xTLC8ob6bJYPdQddIa
 LpFd1Bs2iODP1VOc1+qGxhg88GchD1kdw3z9UieiWg==
X-Google-Smtp-Source: ABdhPJzuCSxCaVkctclTJeyp1LXaXVs1clxaRIVGhep9x3m9rmcRL5WzCcw+5dEm5rwpsSYZ5nOAVJhktoYtnvMWKYk=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr12510991edb.100.1603645435012; 
 Sun, 25 Oct 2020 10:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
 <20201023174351.31838a86@redhat.com>
 <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
 <20201023210445.2fa72562@redhat.com>
In-Reply-To: <20201023210445.2fa72562@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Oct 2020 17:03:43 +0000
Message-ID: <CAFEAcA_wP1t1+o_PnCOotHvs54qSxJQSyuhtbSCSg4oewD43ng@mail.gmail.com>
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 20:04, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 23 Oct 2020 19:39:16 +0200
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> > Are you saying arm_boot_info should hold a pointer to MachineState*
> > instead of duplicating?
>
> yep, some parts of it (fdt related) already use MachineState* so it's
> complete rewrite. The same probably applies to the fields you've just
> quoted.

Hmm, maybe, maybe not. The original design idea here was that
the boot loader code took a structure defining only the things
that the bootloader needed to know. It doesn't really need to
know about all the stuff that's in MachineState, which is
the state structure for the machine.

thanks
-- PMM


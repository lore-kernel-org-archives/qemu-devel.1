Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5D5221F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ivssjTlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D5221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jljVQ-0005P8-6c
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 21:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jljSp-0004nl-Rf; Wed, 17 Jun 2020 21:35:37 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jljSn-0004cD-95; Wed, 17 Jun 2020 21:35:35 -0400
Received: by mail-ej1-x642.google.com with SMTP id k11so4630010ejr.9;
 Wed, 17 Jun 2020 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MzY4OVA4rpGN1Q5egJ+3o1xLeeZmfNYcTBKwzKW4Uxo=;
 b=ivssjTlJ1lzLvG+1vCTd68ElceexoWLSz0XBMXd0BrbgQ7sejtfeg4yvBx5qxSJP5H
 rjnup88xHqX2xJDU+ifdjIKhSJoS8OFjOmeVRq0oCnP0zA4rPLgY3VGpnVqh2easrSAo
 HfYgP36Jgy7MC+7HRCrhQ2ZRHeSA0KOQ4TsEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MzY4OVA4rpGN1Q5egJ+3o1xLeeZmfNYcTBKwzKW4Uxo=;
 b=AKXzer96DACPSae2ory9w0W4GTA+lnI2F5GEGcNsQBnfY25w9WN9ln2/f2vYf7soCs
 3PsYsTqSoeSyv2qO6mIty+UcOA+hwSYchZu+k6c0wgNu86fSkG8jSwazg9fzkVWWRG4a
 G1j/f8FjEcGGuabiPZSpZvKy5U9E86vgUvr3Zy3DnC/G/Hp0/pl78P58toxkyWVvGys4
 h2bPiChQkd+OXXYGjR0bYaQREZUpC594n1EuIIKHGcRJrsEFBLibhBnvfFI0AACsW5JN
 7qoiw2AQJVczrupaPr2/Wm1qcToElVKbLKhOqiGYlHPNmD/V/OP6hTaUxvH7V2pSEbAQ
 7wbQ==
X-Gm-Message-State: AOAM532kIds7+PTfjZr3cwYuEG+1gIsn/cEIHmhoJS33G1uYOxRW0rGx
 8ep0HEXdHY+XdzmLmEUrhljeb1gbe3g6EKMHNWo=
X-Google-Smtp-Source: ABdhPJxWQ1zPHApn1EAHZM6du4CXISdlG86JIlLKRl2iKHPy9fg9rFmsJ50ODe4P+w37S247bmjxRt3MCdoYOyQ/QbQ=
X-Received: by 2002:a17:906:f53:: with SMTP id
 h19mr1721877ejj.491.1592444130786; 
 Wed, 17 Jun 2020 18:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <20200611223016.259837-12-hskinnemoen@google.com>
 <69a4b9c8-0ae0-96e2-8b46-cc89c9acbc9a@kaod.org>
In-Reply-To: <69a4b9c8-0ae0-96e2-8b46-cc89c9acbc9a@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 18 Jun 2020 01:35:18 +0000
Message-ID: <CACPK8XfzgLURHct7=cOW8ABuZ72sCFb6tgVAWX=n58oP6qdUCA@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, PDS_OTHER_BAD_TLD=1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 16:42, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 6/12/20 12:30 AM, Havard Skinnemoen wrote:
> > This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> > one built with OpenBMC. For example like this:
> >
> > IMAGE=3D${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
>
> could you put the image on some site when ready ?

They are built as part of OpenBMC CI:

https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,label=3Dbuilder,tar=
get=3Dgsj/lastSuccessfulBuild/artifact/deploy/images/gsj/

Cheers,

Joel

>
> > qemu-system-arm -machine quanta-gsj -nographic \
> >       -bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
> >       -drive file=3D${IMAGE},if=3Dmtd,bus=3D0,unit=3D0,format=3Draw,sna=
pshot=3Don
> >
> > Change-Id: I158a4d9952c0e90f2b1b7280443a7305b6ae57cf
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


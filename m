Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6010A2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kS58IrIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6010A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKkd-0004wB-LM
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiKPz-00070x-C9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:14:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiKPy-00022A-1L
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:14:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id d67so15807656oig.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/+4QjpT+tPPNmlVcx3DdQ4kyskVFCMtysHbcHTNYe74=;
 b=kS58IrIM5lez6Lj5rtZnhJPFBV+K9srHQMqeFSm7Z+xDcxy5VB1+sG7mD7OgAU3Xlc
 pqtBn6vqhsdiy+5UWO9tA5v94lie87F6qtEtU8Oox/I3ezGt7DNwpHBQTSE1GTX+xmXw
 k3pbE1MrKcyt2zqAeLEsEhQOPlnINXANgWN9+eUAWrJHhjMAubtk/mMoq4Yz4NnaAb+E
 qok7pIPLclNsBFO2iEIhsEcGPn4rTChUJWZlcplpcZ+BJti3DUIyDl7hvfGaH3LbrDMV
 sQ7C65a11jICToH03NJRuGZhykKF9IAflFSwaOXhWoK0BC8Ws5uLBhYv++PjUzYGuCna
 Iofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/+4QjpT+tPPNmlVcx3DdQ4kyskVFCMtysHbcHTNYe74=;
 b=RTjKlMcRbMZjX7uwgsU//gqkZoaYTaf6nMjcgek8Owk4Gauh3CsvgZQ+2QJBsGZ/v0
 sTgOVYdCQBbwnZ55CIJxQ9mIjytiqEKppO6stkowTdsU8O2zGuuMAL4A4BEu7KAVshy3
 J7okjkBbkmG0GirYqZsjUflVUalQt9WHU4ydSAgUuKpBSmDW4nBAPTheVm9rbDeRuXo8
 AGQSqDnj0W6pb4Z6lYvwI6imJKYHQ50U+GJ+pqb/+gXlmyboxcytAC0pSNhqcTUjGbCJ
 cwOHSZUTh40TJcwVoRO1Yl9V8nBvbkA/hAzSl7oya7ayEUNclmaiG8sRx+8RU4tTLvKt
 yO2Q==
X-Gm-Message-State: AOAM5308JMKx1CDjjD6XF+XqaRYXiG594P8NMYLlymPzyvdBfbNcj155
 F1bmQdzVE9Pb42r+ndy58azCKWFoyyG3x99U15XlVA==
X-Google-Smtp-Source: ABdhPJxY837bRoD3+f6ZcPgGbh8vCM84Cl4LR/XbymbYhKCUqj4k8XH49NE9YAo4JBnuJUGXAVD6K2cFlG42HGdNVeI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr107477oib.48.1591632872829; 
 Mon, 08 Jun 2020 09:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608160044.15531-1-philmd@redhat.com>
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 17:14:21 +0100
Message-ID: <CAFEAcA_Ni8=mvyfG=9Aa=ym-ae9HpP8J8B0ekm8=SN2WgZ6_vA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] hw/qdev: Warn when using pre-qdev/QOM devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 17:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Based on today's IRC chat, this is a trivial RFC series
> to anotate pre-qdev/QOM devices so developers using them
> without knowing they are not QOM'ified yet can realize
> it and convert them if they have time.

What mechanism did you use for identifying non-QOM devices?

thanks
-- PMM


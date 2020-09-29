Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B131C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFAD2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggxhdLxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFAD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLzT-0006nU-Nh
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNLyX-0005Zu-GF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:11:49 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNLyT-0002XR-QN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:11:49 -0400
Received: by mail-ej1-x641.google.com with SMTP id h26so6908159ejq.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=73MxEsPtUT/TTCdrgP6iPP4/Lq4sm/5f1xzmLyh6hxA=;
 b=ggxhdLxCcavZ37JWVQnppWDOQKG1qFmxrrJTXv2OCkUF5/4r6+TJGKFxoXwaqduF9D
 6qWtqG6zl2kmkzE7lPX96g5ScHb4lB7arVx+fYXAPR0RVB3q7RJXKRLX6gTuA649f27t
 jUgxK/HMOVu48tiF7jgMaAK/mr/dI71tC9Ijb0H+pxCjuuaSuScQ43hLgmiJJyv547rw
 QIvi5b+16P9Up6iGBm/QoVJBf2GQNZXhGk2RzT5RacStnF51hlJ3n3LDYcub6+CIfoGa
 MjHJe+SYfRlmsZrFI91Lh1ENWcZrKnrEl+MVtDQcOMSt1oAYbykPKBh9maC/8DatLmTw
 nQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=73MxEsPtUT/TTCdrgP6iPP4/Lq4sm/5f1xzmLyh6hxA=;
 b=RlQzw+F9QmW1XUh2E0iwcPzWzvfhfSReFye2DpzVi27uL1MH2B0Idl7DtRWtfvgMiz
 PEr6Oa+YOfC2OVNsnmyjT76xIhC5u2RT2PkqqIZ93dPHSSap/lxPBdo5fDAOrGVeS90p
 /9yESAODHU63lQIEd6nAdpDTsw2YOQ+qVvi3AyIanLnAWStF+u2DMqMffMa1thkocSD8
 S5cZclWtkTh08f4UX5xHnLlw3YPfKEALIENU90o/IHfzbnYjVA8lv0rp7MeDeGduquuD
 B/+c+VE5A7D7Rl6EZy7TggpVgywHwVyRT5vnuDsMcfri67YitlN3c6/nZf4AWYCmjcTE
 qfiA==
X-Gm-Message-State: AOAM532t1vz4eqYnM7+uoX9eeStfW+c7FP9ua1Ny7Li7cHht+FIPltor
 ijDdNIfsoqPKvZZOiZGWOcGGgkyYuj4RtWUo9+DJXNRLUPf78w==
X-Google-Smtp-Source: ABdhPJyg+ZLsFEMn4YKZQIGAM4gNsSD24gIeZvsuq9F+1zA0aKU9tg0AxMmILZyBdUSEqXkHWTobmd3jnYwL0+Xng5I=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr5876763ejv.56.1601410304552; 
 Tue, 29 Sep 2020 13:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-18-philmd@redhat.com>
 <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Rt__Du0TqqVFov4mNoBvC9hTt7t7e-3G45Eck4z94tQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 21:11:33 +0100
Message-ID: <CAFEAcA-u53dVdv8EJdeeOWxw+SfPJueTq7M6g0vBF5XM2Go4zw@mail.gmail.com>
Subject: Re: [PATCH v3 17/19] hw/arm: Automatically select the 'virt' machine
 on KVM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 21:06, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 16 Mar 2020 at 16:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> >
> > When building a KVM-only QEMU, the 'virt' machine is a good
> > default :)
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  hw/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index d0903d8544..8e801cd15f 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -1,5 +1,6 @@
> >  config ARM_VIRT
> >      bool
> > +    default y if KVM
> >      imply PCI_DEVICES
> >      imply TEST_DEVICES
> >      imply VFIO_AMD_XGBE
>
> What does this actually do ? Why should the choice of
> accelerator affect what boards we pull in by default?

Put another way, our current default is "build everything",
so "default y if ..." on a board is a no-op...

-- PMM


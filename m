Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF24246DD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHVhe9cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF24246DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlLv-0005Hk-Kq
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXlHe-0003Ra-BN
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:14:34 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXlHc-0006Ua-3u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:14:33 -0400
Received: by mail-ej1-x643.google.com with SMTP id t25so7090317ejd.13
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rBLszawus5f/ziAV13XoV3WL/ejC+3NYjCmP97iLa60=;
 b=PHVhe9cdXpgy5XSfMo/zNfj6CgT2w/hiHvQQ5EvzU0V5ZUl5H+m+IVyh3Dzx0FPcpD
 YWjSbM85SFePOAW/RFkhf28tZ8CVwQljWwWeB8wf/TOPmPbYzCrNxbhCcEGMaSa13AS4
 cNL/MiEKtvWmEwwm0uFDmpQrse1512A0vD/jTrZ3WEcAqjckejBLj/avmwOIFhmfxVub
 m049MWVe5YxGmTSpXSPmZ+R3fS74lPs3DA/90cWDl45pr8JyIIZLaT4AuZBYGwAOl6g/
 T1yB5pRxroQnXNadcmp5gNAvvb3KNLTegj3XmKhSoJkkpA1t8b3e90uejn/u/6O8r1Fm
 kefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rBLszawus5f/ziAV13XoV3WL/ejC+3NYjCmP97iLa60=;
 b=hLQA1zeojTtLb1yj+UUBpO7XcOgWQzd03ikVutP1J8XVKQ4UlaavrjwwQ8Hqw04gG2
 05fYldsD7+iaXqpA2LJGFYMgHQYAijYFG1NBTvwmqr5BuDSxS4335X5WV+ALS64DXzuE
 FAWdnDqZBGcWkUmVF0ORR3aFkoa0ycWbZjgH4xMyC9e+9EAJeMHqEJydR4Agh1nBG5xB
 ZNGm5ErAXvRIccZE1Ke9n4/raDoFHHINF7mjln+KI3aNgeuqxU0os6BZqiVRRxye7sec
 b7SLX4Z5+OEzposJLHjDfD8Trb94b7VScUTD6UHbHNz3BoOOji639MnJmFXx/sJqSHh7
 MsAw==
X-Gm-Message-State: AOAM532Ekn/dn6WApnZEqe3EIjU2yFxPILA8wHwAEmaaptsxJyyNeOlb
 Dtymwv72dOhrygxmm/XC4pZPCxpxe7SztclnZ8BRuQ==
X-Google-Smtp-Source: ABdhPJzUlSXhuGCKy+DifSB1xcFv0jPVAwR5vOreFYpBsfGC6Ayt6dIAaOd7hFNvea6Z7tbBzFENpJEAtyUL7jYJnTU=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr7910298ejf.56.1603890869901; 
 Wed, 28 Oct 2020 06:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA_UuL=ymba+v1O75EOZqXBopLq_HOEtgZ8vZSyJ3AcF3Q@mail.gmail.com>
 <BY5PR02MB67726DABBD88E12722E48F95CA190@BY5PR02MB6772.namprd02.prod.outlook.com>
 <BY5PR02MB677213F5F6D3EE8D980B4B0ECA170@BY5PR02MB6772.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB677213F5F6D3EE8D980B4B0ECA170@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 13:14:18 +0000
Message-ID: <CAFEAcA_HX6gYE8yt6Qi2x1NKCWZ+GySgUW65r-cLobzN=z4rCQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
To: Sai Pavan Boddu <saipava@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 12:58, Sai Pavan Boddu <saipava@xilinx.com> wrote:
>
> Hi Peter,
>
> > -----Original Message-----
> > From: Sai Pavan Boddu
> > Sent: Monday, October 26, 2020 10:59 PM
> > To: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Markus Armbruster <armbru@redhat.com>; Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>;
> > Francisco Eduardo Iglesias <figlesia@xilinx.com>; QEMU Developers <qemu=
-
> > devel@nongnu.org>; Alistair Francis <alistair.francis@wdc.com>; Eduardo
> > Habkost <ehabkost@redhat.com>; Ying Fang <fangying1@huawei.com>;
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; Vikram Garhwal
> > <fnuv@xilinx.com>; Paul Zimmerman <pauldzim@gmail.com>
> > Subject: RE: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
> >
> > Hi Peter,
> >
> > > -----Original Message-----
> > > From: Peter Maydell <peter.maydell@linaro.org>
> > > Sent: Monday, October 26, 2020 9:33 PM
> > > To: Sai Pavan Boddu <saipava@xilinx.com>
> > > Cc: Markus Armbruster <armbru@redhat.com>; Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > > Gerd Hoffmann <kraxel@redhat.com>; Edgar Iglesias <edgari@xilinx.com>=
;
> > > Francisco Eduardo Iglesias <figlesia@xilinx.com>; QEMU Developers
> > > <qemu- devel@nongnu.org>; Alistair Francis <alistair.francis@wdc.com>=
;
> > > Eduardo Habkost <ehabkost@redhat.com>; Ying Fang
> > > <fangying1@huawei.com>; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>;
> > > Vikram Garhwal <fnuv@xilinx.com>; Paul Zimmerman
> > <pauldzim@gmail.com>;
> > > Sai Pavan Boddu <saipava@xilinx.com>
> > > Subject: Re: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
> > >
> > > On Thu, 22 Oct 2020 at 13:11, Sai Pavan Boddu
> > > <sai.pavan.boddu@xilinx.com>
> > > wrote:
> > > >
> > > > This module emulates control registers of versal usb2 controller,
> > > > this is added just to make guest happy. In general this module woul=
d
> > > > control the phy-reset signal from usb controller, data coherency of
> > > > the transactions, signals the host system errors received from cont=
roller.
> > > >
> > > > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > > > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> > > > ---
> > > >  hw/misc/meson.build                          |   1 +
> > > >  hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 229
> > > +++++++++++++++++++++++++++
> > > >  include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++++++
> > >
> > > This seems a bit odd. If it's a USB device (or part of a USB
> > > device) then it should be under hw/usb, shouldn't it?
> > [Sai Pavan Boddu] This is a top level wrapper over hcd-dwc3 device, whi=
ch is
> > specific to versal soc. It's mostly dummy which controls the phy-reset =
and does
> > frame length adjustments. It was added just to make guest happy, that i=
s the
> > reason it has been added to misc devices.
> > >
> > > > +static void ir_status_postw(RegisterInfo *reg, uint64_t val64) {
> > > > +    VersalUsb2CtrlRegs *s =3D XILINX_VERSAL_USB2_CTRL_REGS(reg-
> > >opaque);
> > > > +    /*
> > > > +     * TODO: This should also clear USBSTS.HSE field in USB XHCI r=
egister.
> > > > +     * May be combine both the modules.
> > > > +     */
> > >
> > > What does the hardware for this look like? You've modelled it as two
> > > completely separate devices (this one and the
> > > TYPE_USB_DWC3) but would it be closer to the hardware structure to
> > > have a top-level device which has-a DWC3 ?
> > [Sai Pavan Boddu] Yes, we can look at it such way. But as its specific =
to versal
> > SOC, we have crafted it out and stitched them in SOC file.
> >
> > Regards,
> > Sai Pavan
> [Sai Pavan Boddu] I would be sending V13 without doing any changes with t=
his patch and addressing other comments, Please review over V13.

You have my review comments above. I think the way you've structured
this isn't really the best way to do it.

thanks
-- PMM


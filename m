Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E51C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54142076D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrlpjgDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54142076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNim-0005J8-FJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNiC-0004sP-9D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:38:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNi9-0000ez-8b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:38:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id m12so5569253otr.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qlEyDwWh2OkDyedjLyzGGkOuB0nkdYYHRPa9WVBJNcw=;
 b=RrlpjgDyPSU+tHbRmCKgDLaDVtrpOjf3Fry1DG4XLH6vpH4F8QKwejvoThsRNo774z
 Ru+mk2ioWcXr2QL9GDOzrPX5MfrDA2ZWGr7fI/wwHd/hqW2paM1MIowxfVY72EfzLeIj
 FQicdmCXYcRqTh7zXZlQM1lknfThEw8cDIEt1FdM3vZNwazWn+dCpi+xu8OyBp7R9vDS
 Ito/WAj3V+3WCzpPVee/oWCWqwNp2mxpJpcWevjE3ibnhpfCY6M6YCrxsW+H0DaMxZTN
 R9Xf85dgPG1Ya/diS22UmMnUxgJPJBc3JyvFGPu0XhkH37PRhuXM7JZR/tAxiBBgPNl8
 HgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qlEyDwWh2OkDyedjLyzGGkOuB0nkdYYHRPa9WVBJNcw=;
 b=B2JB3Q0RNWbFTUeGq6ofMwYZVOeSJHapQ20vubS8yd/KfliKeX0nBsPi6IGzT1QQOj
 up9ZSSYlXAOX8UbLG/YhyEN/7zh5VZsfpGerP2pFan0uDDw9Pqk8Bawec4OlH5BB/6NF
 xUhoWAT8cRzADDpBA1huiWsVm+XFf/elUiN5Pd1W6+IUmNQwjMKn9PsVr79rsnWSzG5o
 PQVY/vejWaR6qlHemb6mnLSkS7KYKsITOXjnaMTZXL+RS5yRPnPvuXAo9EyTMX1GQB8G
 QWpy/KQErkntDWOaXG2++2wjTTUfy/J4ir1tm6I6d3g5EWw7KxM+nbFMoFznX8CKNFi3
 b0zQ==
X-Gm-Message-State: AOAM530pqWQrlmbx84eo2Ay7su15TkxEnnYOs4nd6aM1UrumgqPsLRgx
 OLtGi9Ha/iqbhUOE2tZ7hGP4g5bSThbuecRhWNo=
X-Google-Smtp-Source: ABdhPJwsZWGLk4zyhucB7XvoyzPtUwRWxMuoCpZpHltvQIghsmKsl/Yk4kzBXG60VIdFb3aHExXzHbEro1VlIkJ81N0=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr3969564ote.181.1599748684027; 
 Thu, 10 Sep 2020 07:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
 <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
 <20200909044856.lvk77pcfvt567ub6@sirius.home.kraxel.org>
 <CAKXe6S+s-hV2dcK=xVd4jrfNEYH0DvwkAkj5ooyrutA-vGJsdw@mail.gmail.com>
 <20200909142816.qd3cunwmpwxzf3dd@mozz.bu.edu>
In-Reply-To: <20200909142816.qd3cunwmpwxzf3dd@mozz.bu.edu>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Sep 2020 22:37:28 +0800
Message-ID: <CAKXe6SKfm8otRMHW5p+u_evr_XoctyM_HO42ouXhM11DbWbaCA@mail.gmail.com>
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <alxndr@bu.edu> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 200909 1258, Li Qiang wrote:
> > Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8812:49=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Sep 09, 2020 at 10:15:47AM +0800, Jason Wang wrote:
> > > >
> > > > On 2020/9/9 =E4=B8=8A=E5=8D=8812:41, Li Qiang wrote:
> > > > > Currently the MR is not explicitly connecting with its device ins=
tead of
> > > > > a opaque. In most situation this opaque is the deivce but it is n=
ot an
> > > > > enforcement. This patch adds a DeviceState member of to MemoryReg=
ion
> > > > > we will use it in later patch.
> > > >
> > > >
> > > > I don't have a deep investigation. But I wonder whether we could ma=
ke sure
> > > > of owner instead of adding a new field here.
> > >
> > > Should be possible.  There is object_dynamic_cast() which can be used=
 to
> > > figure whenever a given owner object is a device.
> > >
> >
> > I found most caller of 'memory_region_init_io' will set the owner to
> > the device object.
> > But some of them will just set it to NULL. Do will have a clear rule
> > that the device's MR
> > 'owner' should be the device object? If yes, we can use this field.
> >
>
> Those seem to be devices that havent't been QOM-imfied yet?  Maybe those
> devices are unlikely to be affected by these issues, though...
>

No it seems not related QOM-ified.

> For i386, it seems like parallel, port80, portF0, pckbd, and xen_pvdevice=
 .. ?
> I'm guessing none of these do DMA.
>

In fact xen_pvdevice is MMIO but the handlers does nothing.

There are some other example than i386 such as the riscv in
hw/riscv/sifive_uart.c

If we have a rule to force the 'MR's owner to the device then we can
fix these NULL owner MR.

Thanks,
Li Qiang

> +CC Stefan, since he replied to the other thread.
>
> > Thanks,
> > Li Qiang
> >
> > > take care,
> > >   Gerd
> > >


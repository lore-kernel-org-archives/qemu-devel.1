Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED01C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 16:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55517206B6
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j8XBZINy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55517206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4RuV-0007PA-Ig
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k4Rtl-0006v9-Iv
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 12:40:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k4Rth-0005Cu-5p
 for qemu-devel@nongnu.org; Sat, 08 Aug 2020 12:40:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12so4376610wru.13
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2020 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hFV+KoX+cMJn4Ee5sqSNIgUySdYsdL+k8zZfryoHc/I=;
 b=j8XBZINy8dgseRQ5+whPd0upaAGcJO7ayWBLgj4DFxZLBFWRkHPM464HvgJEr9Vqnx
 hAMEHX3icPHeHte1iR06Eq3+qn9i22Hb2Px8m/dHKzoKwIydMvdcKovrwYLiykZjt7se
 E99bQ/CVCDhgc1OC368u/m2wvQ0ZMtLP+9V7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hFV+KoX+cMJn4Ee5sqSNIgUySdYsdL+k8zZfryoHc/I=;
 b=VWaWk5x6MvrjzzOKWTijFDoCQzKlROHHlmEquMUY/i8olwpGjilpvo9jSsStC1b2Yn
 0NmI6h8QzzMzVRWzKfMX23IiCt6yrzGBAXrXjnubOmJ/PJnzaJvxoGPRbC1mB2IBk/9w
 pXgqjvrfAo1JLERbkaLi6Yc8b4DOd5o2GlD1ctO/tb5QYyavGfpL9/myG+KNKLJXhxV/
 ML8PnloOsFLMNscgENROoTJ8PYUuMFXK2NaJXHdP2OZ4sRK7YG+1s9JtXdWcl34yxcH0
 S0PyPqDKSKXpS9cUqeBXH4zc7UX4JsCzcoxWCB8R3L6UYG82Qy9oKstHlI49R2mOYdH4
 AtLQ==
X-Gm-Message-State: AOAM530JxO8307kTRsC6u5LC0/+8ZYPyW5dwe873DCVfG/CSYuA4AbX9
 k8KxTp7d30VinFyJ9esqDYGenN/I5uo361ZnB0NCDXkWFwY=
X-Google-Smtp-Source: ABdhPJw4S+ii3mA4hzLpvTZYdlQS4ivldkGUGD9IMk1gU1qxOFS9uZfHGCM0/HJNogqc29A5LRh1Yds10lJ+DacbSY4=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr18310912wrm.301.1596904837761; 
 Sat, 08 Aug 2020 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOf5uwkxAVNs_=TtVwUiEKyp+UZO_bT26sdCneR679Q5hZ_J2A@mail.gmail.com>
 <CAOf5uw=_tT1h612vnsHjCSRWhQg3_rFWeh9cic86sgKX8ZGubg@mail.gmail.com>
 <CAOf5uw=uiL2vVJQYaGcKU_SvVFDd-_h6QuaSZ9abZZQuZKEaUw@mail.gmail.com>
In-Reply-To: <CAOf5uw=uiL2vVJQYaGcKU_SvVFDd-_h6QuaSZ9abZZQuZKEaUw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 8 Aug 2020 18:40:26 +0200
Message-ID: <CAOf5uwnhOHs3o5sE59Neo0R13VROY6xQsbbUsboHOOJRDxjBQQ@mail.gmail.com>
Subject: Re: usb-wacom-tablet failing to register
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=michael@amarulasolutions.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sat, Aug 8, 2020 at 6:06 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Markus
>
> I have seen that you are a committer there so what I have seen that
>
> This request is not implement
>  switch (request) {
>     case InterfaceRequest | USB_REQ_GET_DESCRIPTOR:
>
> When linux probe it fail here
>
> ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
> >                         HID_DT_REPORT, rdesc, rsize);
>
> I think that I miss something in documentation
>
> Running 5.8.0-rc3 and qemu 4.2.0

If I implement
    case InterfaceRequest | USB_REQ_GET_DESCRIPTOR:
        switch (value >> 8) {
        case 0x22:
            p->actual_length = 0;
        default:
            break;
        }
    break;

Them modprobe wacom.ko works. Seems that the WACOM should be blacklist in kernel

Michael
>
> Michael
>
> On Sat, Aug 8, 2020 at 4:59 PM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > What I have seen is that the parse fail to execute
> > hid ll_driver parse fai for
> >
> >  ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
> >                         HID_DT_REPORT, rdesc, rsize);
> >
> > Now this is not implemented in hw/dev-wacom.c . What am I missing?
> >
> > #!/bin/sh
> > IMAGE_DIR="${0%/*}/"
> >
> > if [ "${1}" = "serial-only" ]; then
> >     EXTRA_ARGS='-nographic'
> > else
> >     EXTRA_ARGS='-serial stdio'
> > fi
> >
> > export PATH="/home/michael/work/amarula/buildroot/output/host/bin:${PATH}"
> > exec   qemu-system-i386 -M pc -kernel ${IMAGE_DIR}/bzImage -usb
> > -device usb-wacom-tablet -drive
> > file=${IMAGE_DIR}/rootfs.ext2,if=virtio,format=raw -append "rootwait
> > root=/dev/vda console=tty1 console=ttyS0"  -net nic,model=virtio -net
> > use
> > r  ${EXTRA_ARGS}
> >
> > This is how I run it
> >
> > Michael
> >
> > On Sat, Jul 11, 2020 at 4:38 PM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi all
> > >
> > > On my 4.17.0-rc1 linux kernel i386 running on qemu, I can't register
> > > the wacom driver emulation
> > > QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6.3)
> > > Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
> > >
> > > [    0.395368] ata2.00: configured for MWDMA2
> > > [    0.397049] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
> > >   2.5+ PQ: 0 ANSI: 5
> > > [    0.584135] usb 2-1: new full-speed USB device number 2 using xhci_hcd
> > > [    0.734449] usb 2-1: New USB device found, idVendor=056a,
> > > idProduct=0000, bcdDevice=42.10
> > > [    0.734461] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > > [    0.734466] usb 2-1: Product: Wacom PenPartner
> > > [    0.734470] usb 2-1: Manufacturer: QEMU
> > > [    0.734474] usb 2-1: SerialNumber: 1-0000:00:04.0-1
> > > [    0.737347] usbhid 2-1:1.0: can't add hid device: -32
> > > [    0.737366] usbhid: probe of 2-1:1.0 failed with error -32
> > >
> > > I get back an error. Any suggestions?
> > >
> > > Michael
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Amarula Solutions BV
> > COO Co-Founder
> > Cruquiuskade 47 Amsterdam 1018 AM NL
> > T. +31(0)851119172
> > M. +39(0)3479132170
> > [`as] https://www.amarulasolutions.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Amarula Solutions BV
> COO Co-Founder
> Cruquiuskade 47 Amsterdam 1018 AM NL
> T. +31(0)851119172
> M. +39(0)3479132170
> [`as] https://www.amarulasolutions.com



-- 
Michael Nazzareno Trimarchi
Amarula Solutions BV
COO Co-Founder
Cruquiuskade 47 Amsterdam 1018 AM NL
T. +31(0)851119172
M. +39(0)3479132170
[`as] https://www.amarulasolutions.com


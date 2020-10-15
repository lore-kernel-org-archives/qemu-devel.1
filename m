Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AABC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE7722249
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGmOrxNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE7722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSxp9-0006nB-93
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kSxoD-0006Fh-PV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:36:21 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kSxoC-0002rv-4T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:36:21 -0400
Received: by mail-il1-x143.google.com with SMTP id w17so3001121ilg.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+w6s4W717yKwCHvE8Y9vPa8xmSCMLJc3NtWKFiLx5I4=;
 b=VGmOrxNQscFSN/Nx0736KLhUaTDD0qP0Ay/xrSXwN6rgh5KYGyPcN75/sq07bvLg32
 fQEiZ2fOfT7S6yomes08YjxnFzvnc1y7A9AIlfBbqXa2cxDQp8wmVHwRppqoT8GYzJez
 GIwM2cUDuLLN1ZKd18fvPHv/rMmoVscEQBIWzFrtWBdHcNczE/UBspckRdy0Kvco8PPd
 f7EQaaKQlGcaWvmt/Kwm5ClRIT4lbUdKCFamQsXMmjSj2niC/UpHlv+g13mI1asS5TAK
 tFYI379Lh1Jn6wRNNRDpNzBCM8o7Bnv1qpZbmpyM+11U+SS5SCRhOGRRJZXOrfBHd8oU
 BsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+w6s4W717yKwCHvE8Y9vPa8xmSCMLJc3NtWKFiLx5I4=;
 b=Lo/1+5vmYLMUxB4dJGtSk4h8UTFk4G/JslDq8IMDNTHs4GR/zr0g1quHZMFmEzs6Xl
 SQZZ3grtcZdcBbaMKPIdxjr1Lns8/sztWsbh9ls2x1NnchPm/Ik3X2sQ1Il0uxRTlji8
 OyVUslNYErWD0xQj6/Vid33p81OveKPtuVjgmJ9Sn5UuY+qEcZPixdeXBZpgj5Iznpue
 7vSB40X2F2lAlpdOJzj+w5OmOk0jwDZhO2MDUAhr4NjQUf2mqzkLsmakX70/Jsfj4KbK
 k+ZRoK0ousOsjGa+0m6anjK2iOmcH6tbA1imjn99EAfWZyqWfIPBXtR/k8/KeCO0bFeV
 OTBA==
X-Gm-Message-State: AOAM533a44Xu/FqK5ZZpULFPqMR1G/J4x+EwMKAAOqATP8IXOLQ3e5W5
 C2Kl0bov3RGBWct5PdmwecHsBenYWw0pCR6eOhI=
X-Google-Smtp-Source: ABdhPJyP8WEpTow7BM9ny8j5KSAm+kHkRVq83mB694rBhncDUdrnd381+QbjAfVfuSovU3+FTsbU+rdjoXg1bCyHi04=
X-Received: by 2002:a92:907:: with SMTP id y7mr2135940ilg.276.1602747378148;
 Thu, 15 Oct 2020 00:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012150356.79670-1-mcascell@redhat.com>
 <CADBGO7-w7txnd6MHAY0ge3k3LRcn0FfGDU9znQU7qxQddJQT0A@mail.gmail.com>
 <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
 <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
 <20201013084123.6eihr74ckoburszw@sirius.home.kraxel.org>
 <CAA8xKjX_o5QmXbvjbYkBP8gmO4EOMbESSzWpeAwz9-e1eKmYEg@mail.gmail.com>
In-Reply-To: <CAA8xKjX_o5QmXbvjbYkBP8gmO4EOMbESSzWpeAwz9-e1eKmYEg@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Thu, 15 Oct 2020 00:35:51 -0700
Message-ID: <CADBGO782sqBuszLDcA2PWDR4HujVA76BKDXfWWX_GYXHy2YwqA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
To: Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x143.google.com
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
Cc: gaoning.pgn@antgroup.com, linyi.lxw@antfin.com,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 12:55 PM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> On Tue, Oct 13, 2020 at 10:41 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > > > Also: What would be the effect of simply returning here? Would dwc2
> > > > emulation simply stop processing queues? Should we maybe raise an
> > > > error IRQ?
> > >
> > > Not entirely sure, I imagine the emulation will just stop working. I can
> > > test it tomorrow. Also, can you give me a hint what an error IRQ is?
> > > Is that a Qemu thing, or do you mean we should emulate what the
> > > real core does in this case?
> >
> > Same real hardware does.  ehci for example has the USBSTS_ERRINT bit in
> > the IRQ status register to signal errors.

So I tested this patch (modified as I suggested) in two ways. First, I
hacked up the dwc_otg driver in the Raspbian kernel to always set the
'mps' field to zero. Then I booted the 2019-09-26-raspbian-buster
Raspbian image with 4 usb devices, keyboard, tablet, storage, and
network.

In this test, the first USB device failed to enumerate, giving the kernel
error message "usb 1-1: device descriptor read/64, error -110". The
kernel retried the enumeration several times, finally giving the
message "usb usb1-port1: unable to enumerate usb device".
After that, there was no more USB activity shown in the kernel log.
Otherwise the kernel seemed to keep running normally and the
raspi emulation continued to run.

In the second test, I changed the hack to only zero the 'mps' field for
bulk transfers. In that case, the non-bulk devices (keyboard, tablet)
continued to operate normally. The bulk devices (storage, network)
enumerated fine, but after that they failed to work, with various
error messages in the kernel log. Again the kernel seemed to keep
running normally and the raspi emulation continued to run.

So I think the patch works fine, and I don't think we need to do
anything fancier.

- Paul

> >
> > take care,
> >   Gerd
> >
>
> I'll send a new version of the patch with the check moved earlier in
> the function, as suggested by Paul. If raising an error turns out to
> be the right thing to do, I think other checks may need to be updated
> in addition to this one. Hence we can possibly address that in a later
> patch. Thanks a lot for your comments.
>
> --
> Mauro Matteo Cascella, Red Hat Product Security
> 6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0
>


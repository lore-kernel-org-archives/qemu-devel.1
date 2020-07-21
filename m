Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE913C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A32064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI6wKfXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxscb-0007X9-OC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxsba-0006RY-Qb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:46:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxsbZ-0006LI-0X
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:46:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id e90so15107417ote.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lNRzKBDMfW3j3djz42vcJOq2OF3CutK+m56CkzVdtOA=;
 b=EI6wKfXn164J6bph+XbGa/fOMtamLA7z8XzIrz2/fDHOkzXhD//afUQAPFlDDcCVSb
 O9ap6Q+AA4BjVSJNQujuYySgbVm7jwUF8q504EDoUGLgAugSnipA5v4PaU+gvXoyovo+
 ZIK3D/BTSIZ2aBtVPCYPcmktEYtFUcvymRHuJl6jFWqnyF2FcPFDYsYDhUCEJm1AtUkh
 NbXIPv08uyrBnpiOXmfSvLrGXwz/PdKD9cB4lMpoyyEDNx1Qmaes31X5wvsb0772NnRS
 iwYdB9PKOZQZ5AcrU48trOSe24KdYKeXxC+5UZPKzbKwEC7ym9gaxWGpO1jtTORRVyXi
 3YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lNRzKBDMfW3j3djz42vcJOq2OF3CutK+m56CkzVdtOA=;
 b=Jms7jpXSckL8cI4ySQiYGuNmPHe+VMIwR5GEJTIE8K2BCoXvASHWjuPU18NZSoyReR
 V2F6aoMlptoxsddtV0r/dRoTCBHXf4CzcMBM/09B6nWO2YOF/GBf3z5ApuXMI0PIxusb
 78NgIQ/JN66EihsVoVCfynmtaK9CSId0WxW2Y1SWrtfqNHCiUTiPGgPpnC4RHMK43UYp
 K6relh9vOykXoRVe3sMcsP7v93mWdgI0JLPk6jNH4EvXrp7dbyF4rxrC7P9ROhxQqPl0
 YAK223o7ORFw3BWNAxX1mIsKdIGNnktEw0q0lKgxlcUxArFWBJZz7dNm7X0OuqqCAv44
 NtUw==
X-Gm-Message-State: AOAM530zZhffSEPBBJWHE5ChP88zFsOdUIcWHsHfBM4zvIEzvNOMRJRG
 76Cfx4pkdL+O5yaIXUlJZFDFZSeBnZM1wyqjN+0=
X-Google-Smtp-Source: ABdhPJxS2njTjoznYMrgLQ6ksCLxyxYJtTyPvAtSjRRvmWWsDAIxi38S438qo1OGV/lXRKipz6Zh/fp1/FnUNyVyZzU=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr22597335otr.353.1595339207712; 
 Tue, 21 Jul 2020 06:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
 <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
 <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
In-Reply-To: <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 21 Jul 2020 21:46:11 +0800
Message-ID: <CAKXe6SJvrTx=X2kQk6cKOwHczzTM0nocCj22m1eQaNtw-9yOuQ@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Jason Wang <jasowang@redhat.com>
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
 Bug 1886362 <1886362@bugs.launchpad.net>,
 Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:21=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 2020/7/21 =E4=B8=8B=E5=8D=888:31, Peter Maydell wrote:
> > On Wed, 15 Jul 2020 at 09:36, Jason Wang <jasowang@redhat.com> wrote:
> >> I think the point is to make DMA to MMIO work as real hardware.
> > I wouldn't care to give a 100% guarantee that asking a real
> > h/w device to DMA to itself didn't cause it to misbehave :-)
> > It's more likely to happen-to-work because the DMA engine bit
> > of a real h/w device is going to be decoupled somewhat from
> > the respond-to-memory-transactions-for-registers logic, but
> > it probably wasn't something the designers were actively
> > thinking about either...
>
>
> I think some device want such peer to peer transactions:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/driver-api/pci/p2pdma.rst
>
>
> >
> >> For
> >> e1000e and other networking devices we need make sure such DMA doesn't
> >> break anything.
> > Yeah, this is the interesting part for QEMU. How should we
> > structure devices that do DMA so that we can be sure that
> > the device emulation at least doesn't crash? We could have
> > a rule that all devices that do DMA must always postpone
> > all of that DMA to a bottom-half, but that's a lot of
> > refactoring of a lot of device code...
>
>
> It looks to me the issue happens only for device with loopback

IMO I think this is not related-loopback.

It happens when the guest write the MMIO address to the device's
DMA-related registers.
The one we see UAF occurs in loopback device because the same
structure uses in re-entry.
But we can't say there are no issue for non-loopback device.

>
> Simply git grep loopback in hw/net tells me we probably need only to
> audit dp8393x and rtl8139.
>
> Qiang, want to help to audit those devices?

No problem. Once I finish the e1000e patch I will try to audit those and
also try to audit some no-loopback device re-entry issue.

Thanks,
Li Qiang

>
> Thanks
>
>
> >
> > thanks
> > -- PMM
> >
>


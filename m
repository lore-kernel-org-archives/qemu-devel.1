Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E4C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29CB20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GChcP3QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29CB20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNGJ-00056g-Vl
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGNFH-0003jg-3c
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGNFF-0005lS-IY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:35:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGNFF-0005l2-6l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:35:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id w13so14747741oih.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sNAI7vhTY3M+NWHKMyKFOtI873Qmx3nYqb5BxKHWn5Q=;
 b=GChcP3QV+waUxzhQP6epAUEUItuTa41b0U5hFiQ3dhX5WKx8Ju0c+cBm7e2KC4xCzh
 DBby/EccIFamxcHL/UNfg1lu221UuFkqidzldyBCJByOMyVhqTKmmj+StaC5r1iApiPG
 qgDcO5QCbTuaMnln9KFbDAgu9K8nyC8yMTDaI6IVrqipSVnFgi3v+n5bavbeuMg45gbQ
 0I1qNvoopCj8cbPa2UYHSCFN1jqg5/6nRBqYTMftzX/Mu5MPjcuiJuLPXcukkHA+T6dr
 vASS6mMmzo4FSGBOfWJA/3l6Pxg0q1OWNDxIizKwxRkAxut0MosN8kQf6dRHXwk8fYrf
 f3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sNAI7vhTY3M+NWHKMyKFOtI873Qmx3nYqb5BxKHWn5Q=;
 b=R8lviyi963/55pJD6gc0idOowgOnU4l7fC9HtmjSTZ/DYkxJScFusscl8UAxeI4Y2p
 WX3o98PIG9P+wNfCxmD36UXBncXnjLRSylMsL3BeEhizexnTf3a937kbKSriSx0Ekm0m
 CB8bRD6r3EVlA5J07fUQ/Xxoc0Xg5NiGdPVDZaLCDgryy1jZCS0gXDJK5SW4Yr8m55VA
 RiiGWI8vSVRFodFW7nrnj0jDexxB3VwvYM9Eo/5c613QdLxaIn9S608d7NxeQodNpDok
 U/8CJvIzZLxcDtF4t9wsGZ/fNa+0laTPha8dPviQU8n8T3kIYWt5BpT8GXPHtnaH0dbk
 LwtQ==
X-Gm-Message-State: ANhLgQ0wTqy7pP2MTxWR2oIWPFhc/6TmEcdd32flermLYQidTiMR5yVU
 94SBBFKXKiksU34yQWgwOI0MSBu/DXokMTwiAqMbLw==
X-Google-Smtp-Source: ADFU+vvU3fvpL+OHECtSngFahNXvNfI+GWRBK2UNxneNesBEHZiaCaqPsrwBdcP7RlnJ/wLtOuDmwnK2FjX2BdGOEvc=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr6266094oih.146.1584970556043; 
 Mon, 23 Mar 2020 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 13:35:44 +0000
Message-ID: <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
Subject: Re: Coverity CID 1421984
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 13:12, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 23 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> > Cc'ing qemu-ppc since this is restricted to the aCube Sam460ex board.
> > On 3/23/20 12:46 PM, Max Reitz wrote:
> >> Hi,
> >>
> >> I was triaging new Coverity block layer reports today, and one that
> >> seemed like a real bug was CID 1421984:
> >>
> >> It complains about a memleak in sii3112_pci_realize() in
> >> hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s a=
llocated
> >> by qemu_allocate_irqs(), but never put anywhere or freed).
> >>
> >> I=E2=80=99m not really well-versed in anything under hw/ide, so I was =
wondering
> >> whether you agree it=E2=80=99s a bug and whether you know the correct =
way to fix
> >> it.  (I assume it=E2=80=99s just a g_free(irqs), but maybe there=E2=80=
=99s a more
> >> specific way that=E2=80=99s applicable here.)
> >
> > What does other devices is hold a reference in the DeviceState
> > (SiI3112PCIState) to make static analyzers happy.
>
> Other IDE devices such as ahci and cmd646 seem to free it at the end of
> the init function after calling ide_init2 with it. However it's not clear
> to me how all this is supposed to work.

Anything that uses qemu_allocate_irqs() is old pre-qom/qdev code.
The qdev way of doing this kind of thing (ie "I am a device with
some inbound lines and this is the handler function to call when
the line is set") is to use qdev_init_gpio_in().

Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
most of them I've for the moment just set as "insignificant, fix
required" because they're in called-once functions like board init.
If this device can't be hot-unplugged and so we will only ever call
realize once, it would fall in that category too. Otherwise I'd
suggest conversion to qdev_init_gpio_in(). (This allocates arrays
of IRQs under the hood too, but the device_finalize() function will
automatically free them for you, so it's easier to use non-leakily.)

I think in the long term we should be thinking about getting rid
of all uses of qemu_allocate_irqs(): they seem to generally be
leaky.

The right way to free something allocated with qemu_allocate_irqs()
is to call qemu_free_irqs() on it, but that will free both the
array and all the IRQs within it, so you can't do that until the
device is destroyed. If the device can never be destroyed, we
usually don't write the unrealize function for it, so it would just
be a matter of storing the returned pointer from qemu_allocate_irqs()
in the device struct for a theoretical unrealize to be able to use.
If you just g_free() the pointer you got back then this leaves all
the IRQs themselves allocated, so you still have a nominal leak,
you've just swept it under the rug enough to stop Coverity seeing it :-)

thanks
-- PMM


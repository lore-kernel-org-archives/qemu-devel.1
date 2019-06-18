Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE67C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98AB2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9uVoH/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98AB2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHIH-00022g-LH
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdGk2-0002dl-GM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdGjz-0001my-G7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:13:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdGjv-0001fc-Ax
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:13:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id 107so15612569otj.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aWtydLlbh+4SVoON9ri1UIJDkqJw3P7a2zT1eN10LN0=;
 b=Z9uVoH/NxRtDCm4qQOHnT7D+tc8WBknhDWSjXokhT6auK5baIQvJvTISOmy9Kk0yjb
 p6z2NHy/Uc9Vx0huKuvs26/FKQmJlLsLgnbRxrA3ga1bv3BkDZCMnwp+rxELTufFY+cC
 +Thm4Sw9pRg2bwFCwHsX5pF5xEc2GRM09QboRukBhR8TQzTIwNIHr/g9MAcbdbEBnyTX
 mAfzmnR3rTL6P8s3G821Vu4drCiAREQYO0gVBIYaIISD34qdG0ySO0j505o8xiymc90+
 dePnneij+tkbeYpzyKMooHJK/aVX33JBO4x8e6CQfAdlYcSfJHHdptqBwTJu1HXGUIyf
 13YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aWtydLlbh+4SVoON9ri1UIJDkqJw3P7a2zT1eN10LN0=;
 b=eoTtO9/5gS3hWKIZqt3CwGB07gUDPci3Lh6KRdCDVHzz7CdRtGqPpOB/REiSjnbdb7
 XJBJja+7c2HdmMu1oWBYFcPuDgBaYX6IjNOIBaUfMdoiKfGsYz9LCg8a4rOn+Z1kGR/1
 QzKgDjbxtCl5RW6mvTcjtkP0uUqvxEBtLDFgpewEowiMWCcbBwZPaM0dyorPDyD2IqI8
 Ri6uaSg0l/7gIGQCsRwrUcuq4uhrfLeOSAWD5A8YrbzLp0TieRaa9xTVX/BO30JVH2vN
 cLJy2aghRZmvLqWGwpk6h0DC5RPj+/qMJQbBV0F3Zte93MfCEMoGjYg7S8ewt+Trk0bO
 DlQQ==
X-Gm-Message-State: APjAAAU+jDsHUZcBc6Fp6TBLQQPt61YHcfuJBJN2RZhoA/MO7CUE0mMP
 tUU2yBNLrbacCP1al12nKqA8cCBEGmo9AnFWyesbAg==
X-Google-Smtp-Source: APXvYqw6pVP0FzgshWhlMB0F+L0QnHmC/KD9Xt2Odnms1n+NyRACEqjPDyjwzAvCWDlg2Y/UkqIu217n42jjsDfMMJY=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr64154680oti.221.1560874420705; 
 Tue, 18 Jun 2019 09:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 17:13:29 +0100
Message-ID: <CAFEAcA-BJehtxkMLkfrmDvMWMY137=L3i_7vGHNS5ozSPNSgGA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] Multi-phase reset
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, marc.burton@greensocs.com,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 17:25, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi all,
>
> Here's the second version of the multi-phase reset proposal patches.

Sorry for leaving this one hanging again. Some initial general
comments...

> # DESCRIPTION
>
> Basically the reset procedure is split in 3 parts:
> INIT PHASE: Reset the object internal state, put a resetting flag and do the
>     same for the reset subtree. No side effect on other devices to guarantee
>     that, in a reset domain, everything get initialized first. This corresponds
>     mostly to what is currently done in the device/bus reset method.
>
> HOLD PHASE: This phase allows to control a reset with a IO. When a IO control
>     reset procedure based on the IO level (not edge), we may need to assert
>     the reset, wait some time, and finally de-assert the reset. The consequence
>     is that such a device can stay in a "resetting state" and may need to show
>     this state to other devices through its outputs. For example, a clock
>     controller will typically shutdown its clocks when it is in resetting state.
>
> EXIT PHASE: This phase sets outputs to state after reset. For a clock controller
>      it starts the clocks. It also clears the "resetting" flag. A device should
>      not react to inputs until this flag has been cleared. During this phase,
>      outputs are propagated.
>
> The Resettable interface is detailed in the added doc in patch 7.
>
> # CHANGE SINCE V1
>
> The series now focus only on the Resettable interface (no more ResetDomain).
> Proposed changed have been applied:
>  - reset_count getter/modifier methods
>  - a foreach_child method
>
> This last method allows some flexibility on what is the hierarchy of reset.
> There is some discussion ongoing about this point. Althought the series does
> not aim to modify the qdev/qbus-centric reset behavior, it is not fixed. An
> object specialization can override it.

I've looked through the patches, and I think my current concerns
(stated briefly) are:
 * I don't think we have the "don't call device implementations of
   reset phase functions multiple times" semantics that I wanted;
   OTOH I think the logic I suggested for those in comments on the
   v1 of this series wouldn't work either.
 * handling of "call the parent class's reset" is not very clean
   (but this is a general QOM design issue)
 * migration (see below)

> # RESET DEPRECATION
>
> There is 3 changes in the current way of handling reset (for users or
> developers of Devices)
>
> 1. qdev/qbus_reset_all
>
> Theses functions are deprecated by this series and should be replaced by
> direct call to device_reset or bus_reset. There is only a few existing calls
> so I can probably replace them all and delete the original functions.

Sounds good.

> 2. old's device_reset
>
> There is a few call to this function, I renamed it *device_legacy_reset* to
> handle the transition. This function allowed to reset only a given device
> (and not its eventual qbus subtree). This behavior is not possible with
> the Resettable interface. At first glance it seemed that it is used only on
> device having no sub-buses so we could just use the new device_reset.
> But I need to look at them more closely to be sure. If this behavior is really
> needed (but why would we not reset children ?), it's possible to do a specific
> function for Device to to 3-phases reset without the children.

Users of this function:
 hw/audio/intel-hda.c
  -- used by the HDA device to reset the HDACodecDevice, which has
     no child buses
 hw/hyperv/hyperv.c
  -- resets the SynICState, which I think has no child buses
 hw/i386/pc.c
  -- resets the APIC, which has no child buses. (This reset is only
     done as a workaround for lack of reset phases: the whole machine
     is reset and then the APIC is re-reset last to undo any changes
     that other devices might have made to it. Probably making the APIC
     support phased reset would allow us to drop this hack.)
 hw/ide/microdrive.c
  -- called here to reset the MicroDriveState object. This does have
     a child bus, but md_reset() explicitly calls ide_bus_reset(),
     so it should be possible to clean this up.
 hw/intc/spapr_xive.c
  -- resets the SpaprXive device, which I think has no child buses
 hw/ppc/pnv_psi.c
  -- resets a XiveSource, which I think has no child buses
 hw/ppc/spapr_pci.c
  -- resets every QOM child of the SpaprPhbState. This one will
     require closer checking, but my guess is that if there's a child
     with a child bus then failure to reset the bus would be a bug.
 hw/ppc/spapr_vio.c
  -- resets an SpaprTceTable. This needs attention from an Spapr
     expert but is probably ok.
 hw/s390x/s390-pci-inst.c
  -- resets the S390PCIBusDevice. Needs S390 expertise, but probably
     either no child buses or failure to reset them is a bug.
 hw/scsi/vmw_pvscsi.c
  -- resets an individual SCSIDevice. I don't think those have child buses.
 hw/sd/omap_mmc.c
  -- resetting an SDState, which has no child bus
 hw/sd/pl181.c
  -- ditto.

So there are one or two not-totally-trivial cases but we should
be able to deal with these.

> 3. DeviceClass's reset and BusClass's methods
>
> This is the major change. The method is deprecated because reset methods are
> now located in the interface class. In the series, I make the init phase
> redirect to the original reset method of DeviceClass (or BusClass). There a
> lot of use of the method and transitioning to 3-phases only reset will need
> some work.

I think it should be possible to do the conversion mechanically
(eg with coccinelle). We can look at doing that later.

> # MIGRATION
>
> Bus reset state migration is right now not handled.
>
> Regarding "migration-during-reset should Just Work, without necessarily
> needing any specific changes for a device". The included patch define a vmsd
> subsection which must to be added to every device main vmsd structure for
> migration-during-reset of theses devices to work. I tried to find a way to
> avoid that but really don't see how to achieve that.
>
> So in the current state of this series, migration can only be supported for
> leaf device (in term of qdev/qbus) where we add the subsection.
>
> I'm not sure the migration is the problem here. I doubt a device will
> support staying in reset state (which is a new feature) without manual
> intervention. So migration of this unsupported state without any specific
> change may not be a real asset.

The approach I thought would be good turns out not to actually work,
so I need to think a bit more about this.

I think what I would like to achieve is "default to doing the right
thing" -- ideally devices that add support for being held in reset
should not need to manually do something to make the bus/device reset
state be migrated properly. Otherwise we have an easy mistake to
make (forgetting to do the necessary handling of migration) when
adding a new device or making a device support being held in reset.

Regarding "devices not supporting staying in reset state without
manual intervention" do you mean that they might not correctly
deal with incoming signals or guest register write attempts
in the held-in-reset state? That's true, but I don't think it's
too terrible. (In particular it's a bug that can be fixed without
breaking migration compatibility; and it seems unlikely that guest
software would be trying to read or write a device that it's put
into reset.)

thanks
-- PMM


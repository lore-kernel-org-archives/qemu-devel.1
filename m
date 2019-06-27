Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C12C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C4A2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="6bMTHFN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C4A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQU5-0000b3-Vv
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 05:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgQTY-0007pz-67
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgQTW-0002Vh-Ls
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:13:52 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgQTS-0002OK-NG; Thu, 27 Jun 2019 05:13:47 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id C833396F50;
 Thu, 27 Jun 2019 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561626821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBfNMPCQv3qkWkmYgiEUs4XBc2W+7xxOBcjc1GEMeE=;
 b=6bMTHFN8i0QJGhuRDTyQeotjuRcdj8g6Y6Xug5LKIgWfr/KRm/GMUhv+QqU/KfcVGjWMnb
 HzCnX7b+x7eetBLTnT19K9Hrbh6M2pqIIXQ8sWsj9nDDJ/e8IFMy3OauZVI6D/W+vyGZeb
 Jvy0vC8x0rWkBp8wz0+YxhEd731+gu0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
 <CAFEAcA-BJehtxkMLkfrmDvMWMY137=L3i_7vGHNS5ozSPNSgGA@mail.gmail.com>
Message-ID: <05918526-8112-2489-815b-06dde729a159@greensocs.com>
Date: Thu, 27 Jun 2019 11:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BJehtxkMLkfrmDvMWMY137=L3i_7vGHNS5ozSPNSgGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561626822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBfNMPCQv3qkWkmYgiEUs4XBc2W+7xxOBcjc1GEMeE=;
 b=OEB4MLgCFojbiFSHBZ/5cUS+O5eAwiUKiPDdfo6Ry4jwoPtGJ9pS8bfYgvHzaZoYmzPN2y
 hVMX+EpxDQwva9JB7qHmsBVosgXr+67h0NieSpxpEqBqNgCgF1RbBIrJuNQiJEfMVo7JtT
 a1V4zFU1ZY8Avf5krUY90xSbmft2pRo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561626822; a=rsa-sha256; cv=none;
 b=WOZkRz271LYCNn3e+0TJoPoG4SoHDkBwBdsLDtHMMXPAkxBzwjKvz71S5b8ReuBlTObF/W
 PAqjmtbU11uOSpgHXl4DPAoI/FUCQe9tH1lcCDb3j+I7XbGTpACdcMxAc0zBy1Y5Mx6O4P
 MOU8X3DpGTx/DofU/4GcHgp6aS1f5ms=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair@alistair23.me>, mark.burton@greensocs.com,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On 6/18/19 6:13 PM, Peter Maydell wrote:
> On Tue, 4 Jun 2019 at 17:25, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Hi all,
>>
>> Here's the second version of the multi-phase reset proposal patches.
> 
> I've looked through the patches, and I think my current concerns
> (stated briefly) are:
>  * I don't think we have the "don't call device implementations of
>    reset phase functions multiple times" semantics that I wanted;
>    OTOH I think the logic I suggested for those in comments on the
>    v1 of this series wouldn't work either.

I see now what you meant. I think it is possible but the cold/warm make
it more complicated. It will need a "get_reset_kind" method which
returns whether it's cold or warm.

>  * handling of "call the parent class's reset" is not very clean
>    (but this is a general QOM design issue)

Is it the current good way of doing this ? (some kind of
override_this_parent_method function)

>  * migration (see below)
> 
>> # RESET DEPRECATION
>>
>> There is 3 changes in the current way of handling reset (for users or
>> developers of Devices)
>>
>> 1. qdev/qbus_reset_all
>>
>> Theses functions are deprecated by this series and should be replaced by
>> direct call to device_reset or bus_reset. There is only a few existing calls
>> so I can probably replace them all and delete the original functions.
> 
> Sounds good.
> 
>> 2. old's device_reset
>>
>> There is a few call to this function, I renamed it *device_legacy_reset* to
>> handle the transition. This function allowed to reset only a given device
>> (and not its eventual qbus subtree). This behavior is not possible with
>> the Resettable interface. At first glance it seemed that it is used only on
>> device having no sub-buses so we could just use the new device_reset.
>> But I need to look at them more closely to be sure. If this behavior is really
>> needed (but why would we not reset children ?), it's possible to do a specific
>> function for Device to to 3-phases reset without the children.
> 
> Users of this function:
>  hw/audio/intel-hda.c
>   -- used by the HDA device to reset the HDACodecDevice, which has
>      no child buses
>  hw/hyperv/hyperv.c
>   -- resets the SynICState, which I think has no child buses
>  hw/i386/pc.c
>   -- resets the APIC, which has no child buses. (This reset is only
>      done as a workaround for lack of reset phases: the whole machine
>      is reset and then the APIC is re-reset last to undo any changes
>      that other devices might have made to it. Probably making the APIC
>      support phased reset would allow us to drop this hack.)
>  hw/ide/microdrive.c
>   -- called here to reset the MicroDriveState object. This does have
>      a child bus, but md_reset() explicitly calls ide_bus_reset(),
>      so it should be possible to clean this up.
>  hw/intc/spapr_xive.c
>   -- resets the SpaprXive device, which I think has no child buses
>  hw/ppc/pnv_psi.c
>   -- resets a XiveSource, which I think has no child buses
>  hw/ppc/spapr_pci.c
>   -- resets every QOM child of the SpaprPhbState. This one will
>      require closer checking, but my guess is that if there's a child
>      with a child bus then failure to reset the bus would be a bug.
>  hw/ppc/spapr_vio.c
>   -- resets an SpaprTceTable. This needs attention from an Spapr
>      expert but is probably ok.
>  hw/s390x/s390-pci-inst.c
>   -- resets the S390PCIBusDevice. Needs S390 expertise, but probably
>      either no child buses or failure to reset them is a bug.
>  hw/scsi/vmw_pvscsi.c
>   -- resets an individual SCSIDevice. I don't think those have child buses.
>  hw/sd/omap_mmc.c
>   -- resetting an SDState, which has no child bus
>  hw/sd/pl181.c
>   -- ditto.
> 
> So there are one or two not-totally-trivial cases but we should
> be able to deal with these.

Thanks for listing theses. Do you think I should includes all the
switches in the series or just the trivial ones ?

> 
>> 3. DeviceClass's reset and BusClass's methods
>>
>> This is the major change. The method is deprecated because reset methods are
>> now located in the interface class. In the series, I make the init phase
>> redirect to the original reset method of DeviceClass (or BusClass). There a
>> lot of use of the method and transitioning to 3-phases only reset will need
>> some work.
> 
> I think it should be possible to do the conversion mechanically
> (eg with coccinelle). We can look at doing that later.
> 
>> # MIGRATION
>>
>> Bus reset state migration is right now not handled.
>>
>> Regarding "migration-during-reset should Just Work, without necessarily
>> needing any specific changes for a device". The included patch define a vmsd
>> subsection which must to be added to every device main vmsd structure for
>> migration-during-reset of theses devices to work. I tried to find a way to
>> avoid that but really don't see how to achieve that.
>>
>> So in the current state of this series, migration can only be supported for
>> leaf device (in term of qdev/qbus) where we add the subsection.
>>
>> I'm not sure the migration is the problem here. I doubt a device will
>> support staying in reset state (which is a new feature) without manual
>> intervention. So migration of this unsupported state without any specific
>> change may not be a real asset.
> 
> The approach I thought would be good turns out not to actually work,
> so I need to think a bit more about this.
> 
> I think what I would like to achieve is "default to doing the right
> thing" -- ideally devices that add support for being held in reset
> should not need to manually do something to make the bus/device reset
> state be migrated properly. Otherwise we have an easy mistake to
> make (forgetting to do the necessary handling of migration) when
> adding a new device or making a device support being held in reset.

To have a default behavior, we need to somehow handle that in the
DeviceClass.
Ideally speaking, this subsection could be handled during the device
realization, when the vmsd is registered. But since we cannot
dynamically add a new subsection to the device vmsd structure, we have
to forge an extended new one (the same with additional subsection). It
seems technically possible but this feels like a bad hacky idea.

> 
> Regarding "devices not supporting staying in reset state without
> manual intervention" do you mean that they might not correctly
> deal with incoming signals or guest register write attempts
> in the held-in-reset state? That's true, but I don't think it's
> too terrible. (In particular it's a bug that can be fixed without
> breaking migration compatibility; and it seems unlikely that guest
> software would be trying to read or write a device that it's put
> into reset.)

Yes it is what I meant.

> 
> thanks
> -- PMM
> 


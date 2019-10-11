Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE87EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C856021D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C856021D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIuYq-0004cs-WE
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIuWr-0003Sr-Fp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIuWp-0007yG-6E
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIuWo-0007xi-U3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:00:19 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B7AD51F16
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 13:00:17 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id k53so9337301qtk.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z/aR1vLs+4n9Xu1c+z2vc+oIGUT9Z+Zv5pj3DkZNfNA=;
 b=OUU1rq7oThRUeO/owLj5srRCUsFUt8NUhWKy9xCAhfCmH31kkXKh1+bIkRSNQCYx/w
 URX0vCnsx+QRhvkv8cEQqzyosXSAE17ti7j/Sw7Vl70VoP6kyPhT5C75t+s7NYoaFOPx
 /w+ac5yUZoUbzPdipzHWzToaMEbpaGT279LGOvalYoBckTVtiVPY6C9VvTdlW63Elfd4
 WT3szvlma1SfiDzLmeR2c7ydkQd4O9mPnvWpm0seXZTS+LAR5ZauSmld0JKzgcDOmt0E
 cAko/cW8f6XZEdOr8eAHC+TzHA4w1LJRKZC/pZcUJ+YNGNNXLHBzN1s6D3o60d6eoCHa
 QGHw==
X-Gm-Message-State: APjAAAWBfI7B4gLwlwuMXRVQ3NzdHIqiiUn6l5r/SZGSWlUcFQo0GwO4
 DkdtPH2xY1nNPpvuLvEXpGNgOC2a3jbYTE8ZsdMqcv8rY1Z+4xzw2KIP70m7JHjFn9sMtSuivRv
 ezrqQ4RX/05ozSjw=
X-Received: by 2002:a37:9a0d:: with SMTP id c13mr15731002qke.93.1570798816654; 
 Fri, 11 Oct 2019 06:00:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfs5gQIgjM7GiT+ZRk5rFLGA7fbs5w5rZpbJPRURSox2wXuU/vRECCqjr/tUxr8NlBRsyKZg==
X-Received: by 2002:a37:9a0d:: with SMTP id c13mr15730955qke.93.1570798816290; 
 Fri, 11 Oct 2019 06:00:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c14sm4532533qta.80.2019.10.11.06.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:00:15 -0700 (PDT)
Date: Fri, 11 Oct 2019 09:00:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191011085852-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
 <20191010175754.7c62cf8f@Igors-MacBook-Pro>
 <20191010192039.GE4084@habkost.net>
 <e17adca7-f5f4-3a28-a4a2-6b921c1c2e2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17adca7-f5f4-3a28-a4a2-6b921c1c2e2f@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 10:01:42AM +0200, Laszlo Ersek wrote:
> On 10/10/19 21:20, Eduardo Habkost wrote:
> > On Thu, Oct 10, 2019 at 05:57:54PM +0200, Igor Mammedov wrote:
> >> On Thu, 10 Oct 2019 09:59:42 -0400
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>
> >>> On Thu, Oct 10, 2019 at 03:39:12PM +0200, Igor Mammedov wrote:
> >>>> On Thu, 10 Oct 2019 05:56:55 -0400
> >>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>>
> >>>>> On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
> >>>>>> As an alternative to passing to firmware topology info via new fwcfg files
> >>>>>> so it could recreate APIC IDs based on it and order CPUs are enumerated,
> >>>>>>
> >>>>>> extend CPU hotplug interface to return APIC ID as response to the new command
> >>>>>> CPHP_GET_CPU_ID_CMD.  
> >>>>>
> >>>>> One big piece missing here is motivation:
> >>>> I thought the only willing reader was Laszlo (who is aware of context)
> >>>> so I skipped on details and confused others :/
> >>>>
> >>>>> Who's going to use this interface?
> >>>> In current state it's for firmware, since ACPI tables can cheat
> >>>> by having APIC IDs statically built in.
> >>>>
> >>>> If we were creating CPU objects in ACPI dynamically
> >>>> we would be using this command as well.
> >>>
> >>> I'm not sure how it's even possible to create devices dynamically. Well
> >>> I guess it's possible with LoadTable. Is this what you had in
> >>> mind?
> >>
> >> Yep. I even played this shiny toy and I can say it's very tempting one.
> >> On the  other side, even problem of legacy OSes not working with it aside,
> >> it's hard to debug and reproduce compared to static tables.
> >> So from maintaining pov I dislike it enough to be against it.
> >>
> >>
> >>>> It would save
> >>>> us quite a bit space in ACPI blob but it would be a pain
> >>>> to debug and diagnose problems in ACPI tables, so I'd rather
> >>>> stay with static CPU descriptions in ACPI tables for the sake
> >>>> of maintenance.
> >>>>> So far CPU hotplug was used by the ACPI, so we didn't
> >>>>> really commit to a fixed interface too strongly.
> >>>>>
> >>>>> Is this a replacement to Laszlo's fw cfg interface?
> >>>>> If yes is the idea that OVMF going to depend on CPU hotplug directly then?
> >>>>> It does not depend on it now, does it?
> >>>> It doesn't, but then it doesn't support cpu hotplug,
> >>>> OVMF(SMM) needs to cooperate with QEMU "and" ACPI tables to perform
> >>>> the task and using the same interface/code path between all involved
> >>>> parties makes the task easier with the least amount of duplicated
> >>>> interfaces and more robust.
> >>>>
> >>>> Re-implementing alternative interface for firmware (fwcfg or what not)
> >>>> would work as well, but it's only question of time when ACPI and
> >>>> this new interface disagree on how world works and process falls
> >>>> apart.
> >>>
> >>> Then we should consider switching acpi to use fw cfg.
> >>> Or build another interface that can scale.
> >>
> >> Could be an option, it would be a pain to write a driver in AML for fwcfg access though
> >> (I've looked at possibility to access fwcfg from AML about a year ago and gave up.
> >> I'm definitely not volunteering for the second attempt and can't even give an estimate
> >> it it's viable approach).
> >>
> >> But what scaling issue you are talking about, exactly?
> >> With current CPU hotplug interface we can handle upto UNIT32_MAX cpus, and extend
> >> interface without need to increase IO window we are using now.
> >>
> >> Granted IO access it not fastest compared to fwcfg in DMA mode, but we already
> >> doing stop machine when switching to SMM which is orders of magnitude slower.
> >> Consensus was to compromise on speed of CPU hotplug versus more complex and more
> >> problematic unicast SMM mode in OVMF (can't find a particular email but we have discussed
> >> it with Laszlo already, when I considered ways to optimize hotplug speed)
> > 
> > If we were designing the interface from the ground up, I would
> > agree with Michael.  But I don't see why we would reimplement
> > everything from scratch now, if just providing the
> > cpu_selector => cpu_hardware_id mapping to firmware is enough to
> > make the existing interface work.
> > 
> > If somebody is really unhappy with the current interface and
> > wants to implement a new purely fw_cfg-based one (and write the
> > corresponding ACPI code), they would be welcome.
> 
> Let me re-iterate the difficulties quickly:
> 
> - DMA-based fw_cfg is troublesome in SEV guests (do you want to mess
> with page table entries in AML methods? or pre-allocate an always
> decrypted opregion? how large?)
> 
> - IO port based fw_cfg does not support writes (and I reckon that, when
> the *OS* handles a hotplug event, it does have to talk back to QEMU)
> 
> - the CPU hotplug AML would have to arbitrate with Linux's own fw_cfg
> driver (which exposes fw_cfg files to userspace, yay! /s)
> 
> In the phys world, CPU hotplug takes dedicated RAS hardware. Shoehorning
> CPU hotplug into *firmware* config, when in two use cases [*], the
> firmware shouldn't even know about CPU hotplug, feels messy.
> 
> [*] being (a) SeaBIOS, and (b) OVMF built without SMM

I agree. So ACPI should use a dedicated interface.

> > I just don't see why we should spend our time doing that now.
> 
> I have to agree, we're already spread thin.
> 
> ... I must admit: I didn't expect this, but now I've grown to *prefer*
> the CPU hotplug register block!
> 
> Laszlo

OK, send an ack then.

-- 
MST


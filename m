Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C6C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86572073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFTZsFZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86572073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIaA-0000zm-Ut
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWIZY-0000Rt-8U
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:50:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWIZX-0007Fv-Ac
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588765842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bifi6yeK19cuHiLsQuyg60oMZR/70MpbLi1jZ+gxDcA=;
 b=DFTZsFZBGKvSxyzkhK2ud+j3Fm89NKxlMQrjAL58RVC0j6xDVa/fpKKnaqFuiDGkt8/kSK
 i7zV18r2WEIhX5QcCsDp6qWiOER3HzgUuyhkCuwHoSkVfooXFwLy36GMCludrFkHc64kr+
 UI3sgUMAVNFunwLuUlwaMDS6vZKi0j4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-fzHrhiXmOhS4EOcJbqnBsg-1; Wed, 06 May 2020 07:50:38 -0400
X-MC-Unique: fzHrhiXmOhS4EOcJbqnBsg-1
Received: by mail-wm1-f72.google.com with SMTP id g142so251180wme.6
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 04:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wLoOvk5UJ/3sAEMFGuPtx1Zers9oxiSdGGAYaHPTRJ0=;
 b=AbFeqVOuZfqUnsujwpoxP/AMR3oBqjYpblFQngQjeW5wuAvAm4R179RIHCdINJGmIC
 NeIYPF5JttKa2p+ABBYSWBSX461zY3EKqKoK6q6xBSKY7JpKqC2isFUEbUOouOPKUee5
 It1MJb+b5plJLc8DFakE3iLJMXnJgIuZ2ftlLGMQPwHztsD8K7C3wntQipflxHFZA73j
 EfSdFLmVvSNHsIlaMezO7AKPQtXR2V+LxzyUDFdBDXb39/5mbD/lsHhZA5sv5J7M8SQA
 mrObj5CG6/Jy5eAz5qaMlY8+2UpOkg3eHhRbVxWjp1KLvmKoPHLp4gnizG8DMBwfTe2X
 P1jQ==
X-Gm-Message-State: AGi0PuZBQPuFZz9UGxFsVwV3NKJzqkXstIzI4eIObyeRqXVKToraVChv
 WQzP0nD9Ow6zNP/GSogNJkh7S9b2rOUG4DpPaMbzrwYpji7ix7eM36VpmlRiJnnS0ITcSqPl4jV
 3HQGrTseA11Z0Uzg=
X-Received: by 2002:a7b:c399:: with SMTP id s25mr3845463wmj.169.1588765837262; 
 Wed, 06 May 2020 04:50:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypLxSnxJZLfUdeNLQ+jxAWtQmVqIxMu++ICSJsAwB1SnIrOElZc9MgKVryRszzU8fxkvWAB2Hw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr3845441wmj.169.1588765837010; 
 Wed, 06 May 2020 04:50:37 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n7sm2602185wmd.11.2020.05.06.04.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 04:50:36 -0700 (PDT)
Date: Wed, 6 May 2020 07:50:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 00/13] microvm: add acpi support
Message-ID: <20200506074939-mutt-send-email-mst@kernel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505100010-mutt-send-email-mst@kernel.org>
 <20200506114635.b5msujuhhbim2kdv@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200506114635.b5msujuhhbim2kdv@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 01:46:35PM +0200, Gerd Hoffmann wrote:
> On Tue, May 05, 2020 at 10:04:02AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2020 at 03:42:52PM +0200, Gerd Hoffmann wrote:
> > > I know that not supporting ACPI in microvm is intentional.  If you st=
ill
> > > don't want ACPI this is perfectly fine, you can use the usual -no-acp=
i
> > > switch to toggle ACPI support.
> > >=20
> > > These are the advantages you are going to loose then:
> > >=20
> > >   (1) virtio-mmio device discovery without command line hacks (tweaki=
ng
> > >       the command line is a problem when not using direct kernel boot=
).
> > >   (2) Better IO-APIC support, we can use IRQ lines 16-23.
> > >   (3) ACPI power button (aka powerdown request) works.
> > >   (4) machine poweroff (aka S5 state) works.
> >=20
> > Questions
> >=20
> > - what's the tradeoff in startup time?
>=20
> In the noise.  0.28-0.29 seconds on my hardware to the "i8042: PNP: No
> PS/2 controller found" message, no matter whenever acpi is on or off.
> With "quiet" (acpi prints more and logging to the serial console is
> slow).
>=20
> At that point -no-acpi takes one second to figure the ps2 controller
> really isn't there (as discussed before).
>=20
> Another interesting difference is interrupt handling.
>=20
> The -no-acpi version:
>=20
>            CPU0      =20
>   2:          0    XT-PIC      cascade
>   4:        284   IO-APIC   4-edge      ttyS0
>   8:          0   IO-APIC   8-edge      rtc0
>  14:       5399   IO-APIC  14-edge      virtio1
>  15:         58   IO-APIC  15-edge      virtio0
> NMI:          0   Non-maskable interrupts
> [ ... ]
>=20
> The acpi version:
>=20
>            CPU0      =20
>   1:          0   IO-APIC   9-edge      ACPI:Ged
>   2:        231   IO-APIC  23-fasteoi   virtio0
>   3:       6291   IO-APIC  22-fasteoi   virtio1
>   4:       1758   IO-APIC   4-edge      ttyS0
>   5:          0   IO-APIC   8-edge      rtc0
> NMI:          0   Non-maskable interrupts
> [ ... ]
>=20
> > - what should be the default?
>=20
> IMO it makes sense to enable it by default.  You get working
> power management.  You can boot stock cloud images (patched
> seabios parses the dsdt to find virtio-mmio devices to boot
> from virtio-mmio disks).
>=20
> It's easier to leave behind legacy stuff:  The kernel trusts the
> firmware and doesn't go into "trying harder to find ps2 kbd" mode.
> Also what is this "cascade" thing in /proc/interrupts above? [1]
>=20
> I expect dropping the rtc is easier with acpi too, the kernel probably
> wouldn't try to find it then.  Right now seabios needs rtc cmos for
> ram size probing, so I didn't test that yet.
>=20
> On the other hand I don't really see any disadvantages.  The tables are
> small ...
>=20
> # find /sys/firmware/acpi/tables/ -type f | xargs ls -l
> -r--------. 1 root root  70 May  6 06:48 /sys/firmware/acpi/tables/APIC
> -r--------. 1 root root 472 May  6 06:48 /sys/firmware/acpi/tables/DSDT
> -r--------. 1 root root 268 May  6 06:48 /sys/firmware/acpi/tables/FACP
>=20
> ... and simple (no methods) so you can hardly call that "bloat".
>=20
> > Based on above I'd be inclined to say default should stay no acpi and
> > users should enable acpi with an option.
>=20
> I disagree, but I can live with off by default too.  We already have
> acpi=3DOnOffAuto for X86MachineState, so it is just a matter of handling
> microvm.acpi=3Dauto accordingly in x86_machine_is_acpi_enabled().
>=20
> take care,
>   Gerd
>=20
> [1] Rhetorical question, I know what it is. [2]
> [2] I don't want remember though.

Let's leave flipping the default as a separate patch, to be
decided on merits after a bunch of people test with/without.

--=20
MST



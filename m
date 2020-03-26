Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E4D206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8JvAi2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E4D206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHN2W-0006rM-Vx
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHN1h-0006RT-MG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHN1f-0004GQ-PT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:34:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHN1f-0004GA-KL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585208042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7lcNv4qAugsMI0oqguVg/bsHyRxaSLqf+InQOjjvZJQ=;
 b=H8JvAi2K0fKWR5rbo6JqylXKOMmQpoSbwnLbZwhow8V/G5WXLHMljc4H2Ys2LKOTBDerjO
 oeDmbCvo1FrRYr82v/fZ13phZ/6ZOQePk6zv5zFOzDfuAWUgndhKJH+uvsfeB96Vmcd4zB
 RIcadCMkRP7r0GidVFHF2DCDVfm0VgA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-xTKb635tPr6h4C305819cQ-1; Thu, 26 Mar 2020 03:33:40 -0400
X-MC-Unique: xTKb635tPr6h4C305819cQ-1
Received: by mail-wm1-f69.google.com with SMTP id w12so1807194wmc.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OzyRSAXoysheh6uulNWTWJJ4aDnGXfSaCUvgeLbdIZ0=;
 b=C9rhrB3BY65Us5giVWXBd6+6fdeOk9rdHtBY1QBylnmmggMKJX/iw9uSj+r4DouusX
 XfcrjfyJ1QgpQOEK9E8RRh6DSTbwnnrxAvZNLFYxry2TTgVHn2zJDfIOCD586AANOtRe
 S5yaimXhkI7u/ESUxByroEvQ4geYv5LqJb94fQM9Jarat2iP/qQUmsyCfNfMVuwsT45n
 mcWIaVUIlr6WXoBrLD8aQ4ynPAyw7gxWoeWsGUTm918rJHiOKJGkQsGevdieAWMcc24S
 Zm/9bxCdB8jk4V7TOGewd8KhUIbHzWTUk1UJD5YZNvSSNPOc3O6BcY8JsQRPc6UsRNOG
 SRaQ==
X-Gm-Message-State: ANhLgQ2dn3+8QMHzoUnrEsLxHj5dIDCzF9iGw426IaNKyNA7wkqWF2Fa
 4jXpI4hvHn1ESX513lTUaWrmvQCU2c9/6pMaSQaX5xur3hvC7hm01ri5d2RWrI7U4iZlJPZ7G+E
 b8oznmlbW7kl7JvE=
X-Received: by 2002:a5d:6847:: with SMTP id o7mr7569991wrw.274.1585208019247; 
 Thu, 26 Mar 2020 00:33:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsc912D51b8lV8FdWk0/evNHok8ut2kWl5reYNz5f0/KjwTY6h8ii1Ky7kTGGA7LoIWSBmFXQ==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr7569952wrw.274.1585208018906; 
 Thu, 26 Mar 2020 00:33:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
 by smtp.gmail.com with ESMTPSA id a2sm2404143wrp.13.2020.03.26.00.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 00:33:37 -0700 (PDT)
Date: Thu, 26 Mar 2020 03:33:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200326032841-mutt-send-email-mst@kernel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200325133212.6fd0fefb@redhat.com>
 <20200325150339.7kqibe5cfkzxhtzr@sirius.home.kraxel.org>
 <20200325194434.58b50148@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200325194434.58b50148@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 07:44:34PM +0100, Igor Mammedov wrote:
> On Wed, 25 Mar 2020 16:03:39 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > On Wed, Mar 25, 2020 at 01:32:12PM +0100, Igor Mammedov wrote:
> > > On Thu, 19 Mar 2020 09:01:04 +0100
> > > Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >  =20
> > > > I know that not supporting ACPI in microvm is intentional.  If you =
still
> > > > don't want ACPI this is perfectly fine, you can use the usual -no-a=
cpi
> > > > switch to toggle ACPI support.
> > > >=20
> > > > These are the advantages you are going to loose then:
> > > >=20
> > > >   (1) virtio-mmio device discovery without command line hacks (twea=
king
> > > >       the command line is a problem when not using direct kernel bo=
ot).
> > > >   (2) Better IO-APIC support, we can use IRQ lines 16-23.
> > > >   (3) ACPI power button (aka powerdown request) works.
> > > >   (4) machine poweroff (aka S5 state) works.
> > > >=20
> > > > Together with seabios patches for virtio-mmio support this allows t=
o
> > > > boot standard fedora images (cloud, coreos, workstation live) with =
the
> > > > microvm machine type. =20
> > >=20
> > > what CLI do you use to test it? =20
> >=20
> > Test script below.  "qemu-default" is a wrapper script which starts
> > qemu-system-x86_64 from my build directory.  "qemu-firmware" is the
> > same plus isa-debugcon configured for a firmware log on stdout.
> >=20
> > Latest bits (with some of the review comments addressed) just pushed
> > to git://git,kraxel.org/qemu sirius/microvm
>=20
> thanks, below are test results I got on my system,
> spoiler hw-reduced reduces boot time on ~0.02s compared to full blown acp=
i
> ----
> using timestamp at "Run /init as init process" as measuring point
>=20
> no acpi
> 1.967316
> 1.975272
> 1.981267
> 1.974316
> 1.962452
> 1.960988
>=20
> hw reduced acpi
> 0.893838
> 0.892573
> 0.890585
> 0.900306
> 0.897902
>=20
> normal acpi:
> 0.921647
> 0.916298
> 0.923518
> 0.916298
> 0.913234
>=20
> PS:
> I just quickly hacked hw-reduced acpi (using arm/virt as model)
> without implementing power button but I doubt that would affect results n=
oticeably=20
> on qemu side it probably also will save some time since there are less
> things to setup for qemu.

And no ACPI is faster because of PS/2 probing, right?

> >=20
> > HTH,
> >   Gerd
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > #!/bin/sh
> >=20
> > mode=3D"${1}"
> > shift
> >=20
> > back=3D()
> > devs=3D()
> > args=3D()
> > qemu=3D"qemu-firmware -monitor none -boot menu=3Don"
> > disk=3D""
> > liso=3D""
> > krnl=3D""
> > karg=3D"console=3DttyS0,115200"
> >=20
> > case "$mode" in
> > kernel)
> > =09qemu=3D"qemu-default -nographic"
> > =09disk=3D"/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qco=
w2"
> > =09krnl=3D"$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
> > =09karg=3D"$karg root=3D/dev/sda4"
> > =09karg=3D"$karg quiet"
> > =09;;
> > seabios)
> > =09disk=3D"/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qco=
w2"
> > =09krnl=3D"$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
> > =09karg=3D"$karg root=3D/dev/sda4"
> > =09args+=3D("-bios" "/home/kraxel/projects/seabios/out-bios-microvm/bio=
s.bin")
> > =09;;
> > cloud)
> > =09disk=3D"/vmdisk/iso/Fedora-Cloud-Base-31-1.9.x86_64.raw"
> > =09;;
> > coreos)
> > =09disk=3D"/vmdisk/iso/fedora-coreos-31.20200210.3.0-metal.x86_64.raw"
> > =09;;
> > live)
> > =09liso=3D"/vmdisk/iso/Fedora-Workstation-Live-x86_64-30-1.2.iso"
> > =09devs+=3D("-device" "virtio-gpu-device")
> > =09devs+=3D("-device" "virtio-keyboard-device")
> > =09devs+=3D("-device" "virtio-tablet-device")
> > =09;;
> > *)
> > =09echo "unknown mode: $mode"
> > =09echo "known modes: kernel seabios cloud coreos live"
> > =09exit 1
> > =09;;
> > esac
> >=20
> > if test "$disk" !=3D ""; then
> > =09format=3D"${disk##*.}"
> > =09back+=3D("-drive" "if=3Dnone,id=3Ddisk,format=3D${format},file=3D${d=
isk}")
> > =09devs+=3D("-device" "scsi-hd,drive=3Ddisk,bootindex=3D1")
> > fi
> > if test "$liso" !=3D ""; then
> > =09back+=3D("-drive" "if=3Dnone,id=3Dcdrom,media=3Dcdrom,readonly,forma=
t=3Draw,file=3D${liso}")
> > =09devs+=3D("-device" "scsi-cd,drive=3Dcdrom,bootindex=3D2")
> > fi
> > if test "$krnl" !=3D ""; then
> > =09args+=3D("-kernel" "$krnl")
> > =09args+=3D("-append" "$karg")
> > fi
> >=20
> > set -ex
> > $qemu \
> > =09-enable-kvm \
> > =09-cpu host \
> > =09-M microvm,graphics=3Doff,pit=3Doff,pic=3Don,rtc=3Don \
> > =09\
> > =09-m 4G \
> > =09\
> > =09-netdev user,id=3Dnet \
> > =09"${back[@]}" \
> > =09\
> > =09-global virtio-mmio.force-legacy=3Dfalse \
> > =09-device virtio-net-device,netdev=3Dnet \
> > =09-device virtio-scsi-device \
> > =09"${devs[@]}" \
> > =09\
> > =09"${args[@]}" \
> > =09"$@"



Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3354EC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DE920409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AF3YuHqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DE920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7aa-0004ZH-3s
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH7Zr-00049B-G5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH7Zn-0007iM-Hq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:04:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH7Zn-0007hU-Am
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585148654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Hsw5+VOnnwWmlTRuL3FPzwn75hyQinilw84F16CmZo=;
 b=AF3YuHqN8vcG0WoEb+TEiypR10oZxPEfKdnUCw6XRQH39LGIBVDgnDnsQbuOSt8Lq2lpOP
 UzzsUZAAakVc9YQbMZmaSAZXOvFaFbskQY1+V+DzjwXnok2vKJukwTIP/iDTpN7h3Pj7fr
 cEnFFwEfe2Mj353JyZDCQg33RNP4RMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ddASeHyqOhyWRnjoUxpewg-1; Wed, 25 Mar 2020 11:03:50 -0400
X-MC-Unique: ddASeHyqOhyWRnjoUxpewg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBB69107ACCA;
 Wed, 25 Mar 2020 15:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF8F810002A9;
 Wed, 25 Mar 2020 15:03:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D751E17535; Wed, 25 Mar 2020 16:03:39 +0100 (CET)
Date: Wed, 25 Mar 2020 16:03:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200325150339.7kqibe5cfkzxhtzr@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200325133212.6fd0fefb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200325133212.6fd0fefb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 01:32:12PM +0100, Igor Mammedov wrote:
> On Thu, 19 Mar 2020 09:01:04 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > I know that not supporting ACPI in microvm is intentional.  If you stil=
l
> > don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> > switch to toggle ACPI support.
> >=20
> > These are the advantages you are going to loose then:
> >=20
> >   (1) virtio-mmio device discovery without command line hacks (tweaking
> >       the command line is a problem when not using direct kernel boot).
> >   (2) Better IO-APIC support, we can use IRQ lines 16-23.
> >   (3) ACPI power button (aka powerdown request) works.
> >   (4) machine poweroff (aka S5 state) works.
> >=20
> > Together with seabios patches for virtio-mmio support this allows to
> > boot standard fedora images (cloud, coreos, workstation live) with the
> > microvm machine type.
>=20
> what CLI do you use to test it?

Test script below.  "qemu-default" is a wrapper script which starts
qemu-system-x86_64 from my build directory.  "qemu-firmware" is the
same plus isa-debugcon configured for a firmware log on stdout.

Latest bits (with some of the review comments addressed) just pushed
to git://git,kraxel.org/qemu sirius/microvm

HTH,
  Gerd

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D cut here =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/sh

mode=3D"${1}"
shift

back=3D()
devs=3D()
args=3D()
qemu=3D"qemu-firmware -monitor none -boot menu=3Don"
disk=3D""
liso=3D""
krnl=3D""
karg=3D"console=3DttyS0,115200"

case "$mode" in
kernel)
=09qemu=3D"qemu-default -nographic"
=09disk=3D"/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qcow2"
=09krnl=3D"$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
=09karg=3D"$karg root=3D/dev/sda4"
=09karg=3D"$karg quiet"
=09;;
seabios)
=09disk=3D"/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qcow2"
=09krnl=3D"$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
=09karg=3D"$karg root=3D/dev/sda4"
=09args+=3D("-bios" "/home/kraxel/projects/seabios/out-bios-microvm/bios.bi=
n")
=09;;
cloud)
=09disk=3D"/vmdisk/iso/Fedora-Cloud-Base-31-1.9.x86_64.raw"
=09;;
coreos)
=09disk=3D"/vmdisk/iso/fedora-coreos-31.20200210.3.0-metal.x86_64.raw"
=09;;
live)
=09liso=3D"/vmdisk/iso/Fedora-Workstation-Live-x86_64-30-1.2.iso"
=09devs+=3D("-device" "virtio-gpu-device")
=09devs+=3D("-device" "virtio-keyboard-device")
=09devs+=3D("-device" "virtio-tablet-device")
=09;;
*)
=09echo "unknown mode: $mode"
=09echo "known modes: kernel seabios cloud coreos live"
=09exit 1
=09;;
esac

if test "$disk" !=3D ""; then
=09format=3D"${disk##*.}"
=09back+=3D("-drive" "if=3Dnone,id=3Ddisk,format=3D${format},file=3D${disk}=
")
=09devs+=3D("-device" "scsi-hd,drive=3Ddisk,bootindex=3D1")
fi
if test "$liso" !=3D ""; then
=09back+=3D("-drive" "if=3Dnone,id=3Dcdrom,media=3Dcdrom,readonly,format=3D=
raw,file=3D${liso}")
=09devs+=3D("-device" "scsi-cd,drive=3Dcdrom,bootindex=3D2")
fi
if test "$krnl" !=3D ""; then
=09args+=3D("-kernel" "$krnl")
=09args+=3D("-append" "$karg")
fi

set -ex
$qemu \
=09-enable-kvm \
=09-cpu host \
=09-M microvm,graphics=3Doff,pit=3Doff,pic=3Don,rtc=3Don \
=09\
=09-m 4G \
=09\
=09-netdev user,id=3Dnet \
=09"${back[@]}" \
=09\
=09-global virtio-mmio.force-legacy=3Dfalse \
=09-device virtio-net-device,netdev=3Dnet \
=09-device virtio-scsi-device \
=09"${devs[@]}" \
=09\
=09"${args[@]}" \
=09"$@"



Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC251C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8696C20409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H57zEztt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8696C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQFv-0002uT-LK
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHQFB-0002PM-UB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHQFA-0002yi-8M
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:00:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHQFA-0002wv-3j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585220410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvAwwmvIULHFCVyQMd8BSWITSS6wRL8cxAMpstK/4gs=;
 b=H57zEzttD28qOlD92U2nLSZpY9OzD9Gkma8Q1+QMj1905lf93kxnTLsAPcFc0KGwnsEIws
 cWD+UsmCDE53tnczVLrh6t80C36Cbuu/kSsNb/OSJgiJ5H3SWih47a5a5mKrwK0rLwBwsq
 AhJ5BUxWi+scTt2DbqukZoV1/gXo6bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-RAl-fOq3NdGgAVvGss_-KQ-1; Thu, 26 Mar 2020 06:59:58 -0400
X-MC-Unique: RAl-fOq3NdGgAVvGss_-KQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C83DA107ACC4;
 Thu, 26 Mar 2020 10:59:56 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC7419925;
 Thu, 26 Mar 2020 10:59:45 +0000 (UTC)
Date: Thu, 26 Mar 2020 11:59:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200326115943.5e19119b@redhat.com>
In-Reply-To: <20200326032841-mutt-send-email-mst@kernel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200325133212.6fd0fefb@redhat.com>
 <20200325150339.7kqibe5cfkzxhtzr@sirius.home.kraxel.org>
 <20200325194434.58b50148@redhat.com>
 <20200326032841-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Thu, 26 Mar 2020 03:33:35 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 25, 2020 at 07:44:34PM +0100, Igor Mammedov wrote:
> > On Wed, 25 Mar 2020 16:03:39 +0100
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > On Wed, Mar 25, 2020 at 01:32:12PM +0100, Igor Mammedov wrote:  
> > > > On Thu, 19 Mar 2020 09:01:04 +0100
> > > > Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >     
> > > > > I know that not supporting ACPI in microvm is intentional.  If you still
> > > > > don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> > > > > switch to toggle ACPI support.
> > > > > 
> > > > > These are the advantages you are going to loose then:
> > > > > 
> > > > >   (1) virtio-mmio device discovery without command line hacks (tweaking
> > > > >       the command line is a problem when not using direct kernel boot).
> > > > >   (2) Better IO-APIC support, we can use IRQ lines 16-23.
> > > > >   (3) ACPI power button (aka powerdown request) works.
> > > > >   (4) machine poweroff (aka S5 state) works.
> > > > > 
> > > > > Together with seabios patches for virtio-mmio support this allows to
> > > > > boot standard fedora images (cloud, coreos, workstation live) with the
> > > > > microvm machine type.    
> > > > 
> > > > what CLI do you use to test it?    
> > > 
> > > Test script below.  "qemu-default" is a wrapper script which starts
> > > qemu-system-x86_64 from my build directory.  "qemu-firmware" is the
> > > same plus isa-debugcon configured for a firmware log on stdout.
> > > 
> > > Latest bits (with some of the review comments addressed) just pushed
> > > to git://git,kraxel.org/qemu sirius/microvm  
> > 
> > thanks, below are test results I got on my system,
> > spoiler hw-reduced reduces boot time on ~0.02s compared to full blown acpi
> > ----
> > using timestamp at "Run /init as init process" as measuring point
> > 
> > no acpi
> > 1.967316
> > 1.975272
> > 1.981267
> > 1.974316
> > 1.962452
> > 1.960988
> > 
> > hw reduced acpi
> > 0.893838
> > 0.892573
> > 0.890585
> > 0.900306
> > 0.897902
> > 
> > normal acpi:
> > 0.921647
> > 0.916298
> > 0.923518
> > 0.916298
> > 0.913234
> > 
> > PS:
> > I just quickly hacked hw-reduced acpi (using arm/virt as model)
> > without implementing power button but I doubt that would affect results noticeably 
> > on qemu side it probably also will save some time since there are less
> > things to setup for qemu.  
> 
> And no ACPI is faster because of PS/2 probing, right?
I suppose you've meant -slower- because of ...

if I compare at 'i8042: PNP: No PS/2 controller found.' to rule out
probing, then no-api and hw-reduced are about in the same ballpark
(3-4ms difference in favor of no-acpi).

no-acpi
0.765785
0.783540
0.785269
0.777751
0.774474
0.770611
0.789309

hw-reduced
0.788733
0.775982
0.793132
0.769077
0.774771
0.775191
0.771170

 

> 
> > > 
> > > HTH,
> > >   Gerd
> > > 
> > > ============================ cut here ============================
> > > #!/bin/sh
> > > 
> > > mode="${1}"
> > > shift
> > > 
> > > back=()
> > > devs=()
> > > args=()
> > > qemu="qemu-firmware -monitor none -boot menu=on"
> > > disk=""
> > > liso=""
> > > krnl=""
> > > karg="console=ttyS0,115200"
> > > 
> > > case "$mode" in
> > > kernel)
> > > 	qemu="qemu-default -nographic"
> > > 	disk="/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qcow2"
> > > 	krnl="$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
> > > 	karg="$karg root=/dev/sda4"
> > > 	karg="$karg quiet"
> > > 	;;
> > > seabios)
> > > 	disk="/vmdisk/imagefish/rhel-8.1.0-ks-x86_64-testboot-sys-disk.qcow2"
> > > 	krnl="$HOME/build/linux-sirius-x86_64-qemu/arch/x86/boot/bzImage"
> > > 	karg="$karg root=/dev/sda4"
> > > 	args+=("-bios" "/home/kraxel/projects/seabios/out-bios-microvm/bios.bin")
> > > 	;;
> > > cloud)
> > > 	disk="/vmdisk/iso/Fedora-Cloud-Base-31-1.9.x86_64.raw"
> > > 	;;
> > > coreos)
> > > 	disk="/vmdisk/iso/fedora-coreos-31.20200210.3.0-metal.x86_64.raw"
> > > 	;;
> > > live)
> > > 	liso="/vmdisk/iso/Fedora-Workstation-Live-x86_64-30-1.2.iso"
> > > 	devs+=("-device" "virtio-gpu-device")
> > > 	devs+=("-device" "virtio-keyboard-device")
> > > 	devs+=("-device" "virtio-tablet-device")
> > > 	;;
> > > *)
> > > 	echo "unknown mode: $mode"
> > > 	echo "known modes: kernel seabios cloud coreos live"
> > > 	exit 1
> > > 	;;
> > > esac
> > > 
> > > if test "$disk" != ""; then
> > > 	format="${disk##*.}"
> > > 	back+=("-drive" "if=none,id=disk,format=${format},file=${disk}")
> > > 	devs+=("-device" "scsi-hd,drive=disk,bootindex=1")
> > > fi
> > > if test "$liso" != ""; then
> > > 	back+=("-drive" "if=none,id=cdrom,media=cdrom,readonly,format=raw,file=${liso}")
> > > 	devs+=("-device" "scsi-cd,drive=cdrom,bootindex=2")
> > > fi
> > > if test "$krnl" != ""; then
> > > 	args+=("-kernel" "$krnl")
> > > 	args+=("-append" "$karg")
> > > fi
> > > 
> > > set -ex
> > > $qemu \
> > > 	-enable-kvm \
> > > 	-cpu host \
> > > 	-M microvm,graphics=off,pit=off,pic=on,rtc=on \
> > > 	\
> > > 	-m 4G \
> > > 	\
> > > 	-netdev user,id=net \
> > > 	"${back[@]}" \
> > > 	\
> > > 	-global virtio-mmio.force-legacy=false \
> > > 	-device virtio-net-device,netdev=net \
> > > 	-device virtio-scsi-device \
> > > 	"${devs[@]}" \
> > > 	\
> > > 	"${args[@]}" \
> > > 	"$@"  
> 
> 



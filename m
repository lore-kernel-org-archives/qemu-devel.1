Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F8AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82371207D4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7qcq9mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82371207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr087-0001RY-Ok
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr07B-0008N8-3T
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:23:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr077-0001Ao-Vf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593699776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=cO3nvy7cJVjqzt8ZddFK4lrlOyucErVq0KVGUNnzVlg=;
 b=Z7qcq9mZec1AD1S1fGfgSpZ4tVBOnanoviFQgUqeyzHjaPI6WNWB25vqESkkLDKj2lm6yj
 gRJ1lYnGmI9P2iWAFfzwxI8gk7IfgPJjHthfAYB3i5ugU5An9XIXTKLnJSZBfO3eqx93fx
 MRAlLE2SNt70KRM82HWc+PTjH2pUNg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-CPsd5o1uMZm28XbF0F5EWA-1; Thu, 02 Jul 2020 10:22:55 -0400
X-MC-Unique: CPsd5o1uMZm28XbF0F5EWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7548680058A
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 14:22:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73F3010013D4;
 Thu,  2 Jul 2020 14:22:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8DB3F31E87; Thu,  2 Jul 2020 16:22:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] seabios: update submodule to pre-1.14 master snapshot
Date: Thu,  2 Jul 2020 16:22:48 +0200
Message-Id: <20200702142250.21793-2-kraxel@redhat.com>
In-Reply-To: <20200702142250.21793-1-kraxel@redhat.com>
References: <20200702142250.21793-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

seabios 1.14 release is planned for end of july,
early enough to make it into qemu 5.1-rc2 if
everything goes as planned.

Update seabios to a master snapshot now, so it'll get
test coverage during the freeze and the update to the
final version is much smaller (and should have bugfixes
only).

seabios git shortlog
--------------------

Alexey Kirillov (2):
      boot: Detect strict boot order (HALT record) in function
      virtio: Do not init non-bootable devices

Christian Ehrhardt (1):
      build: use -fcf-protection=none when available

Gerd Hoffmann (25):
      boot: cache HALT priority
      virtio-scsi: skip initializing non-bootable devices
      nvme: skip initializing non-bootable devices
      timer: add tsctimer_setfreq()
      kvm: detect unconditionally
      kvm: add support for reading tsc frequency via cpuid.
      kvm: add support for reading tsc frequency from kvmclock
      sercon: vbe modeset is int 10h function 4f02 not 4f00
      pci: factor out ioconfig_cmd()
      pci: add mmconfig support
      qemu: factor out qemu_cfg_detect()
      qemu: rework e820 detection
      qemu: check rtc presence before reading cpu count from cmos
      virtio-mmio: device probing and initialization.
      virtio-mmio: add support to vp_*() functions
      virtio-mmio: add support for scsi devices.
      virtio-mmio: add support for block devices.
      virtio-mmio: print device type
      acpi: add xsdt support
      acpi: add dsdt parser
      acpi: skip kbd init if not present
      acpi: find and register virtio-mmio devices
      rewrap Makefile lines.
      pci: fix mmconfig support
      vga: fix cirrus bios

Jason Andryuk (1):
      serialio: Preserve Xen DebugOutputPort

Kevin O'Connor (3):
      usb-hid: Improve max packet size checking
      Revert "ps2port: adjust init routine to fix PS/2 keyboard issues"
      boot: Fixup check for only one item in boot list

Matt DeVillier (4):
      hw/usb-hid: Don't abort if setting key repeat rate fails
      Skip boot menu and timeout with only one boot device
      ps2port: adjust init routine to fix PS/2 keyboard issues
      boot: Fix logic for boot menu display

Paul Menzel (4):
      std/tcg: Replace zero-length array with flexible-array member
      boot: Extend `etc/show-boot-menu` to configure skipping boot menu with only one device
      boot: Log, if boot menu is skipped
      cdrom: Demote `scsi_is_ready` return print to debug level

Roman Bolshakov (1):
      timer: Handle decrements of PIT counter

Stefan Berger (3):
      tcgbios: Only write logs for PCRs that are in active PCR banks
      tcgbios: Fix the vendorInfoSize to be of type u8
      tcgbios: Add support for SHA3 type of algorithms

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/seabios | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios b/roms/seabios
index f21b5a4aeb02..88ab0c15525c 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
+Subproject commit 88ab0c15525ced2eefe39220742efe4769089ad8
-- 
2.18.4



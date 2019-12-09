Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E49C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE3620692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="LqcXhaZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE3620692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieQFJ-0008Mv-HE
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 16:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin@koconnor.net>) id 1ieQEc-0007vp-6L
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1ieQEa-0007oV-NR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:06:25 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1ieQEa-0007n8-FX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:06:24 -0500
Received: by mail-qk1-x742.google.com with SMTP id m188so14472225qkc.4
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding:user-agent;
 bh=kB8/lHcdu6D0WpY2Fk8gtBWr4qptuj9p44dCcRYl7AM=;
 b=LqcXhaZ5UXw7kXv6gi1lrhd+PIZZmfUd0lhX2U7Cny8Qah3lYpY7hsgyQQQVsjFx02
 3eXThrERZAWxRZiWeqalt32bR1EJ5/xlAEW3LF+5aJL2FR70lKg5o4v2moU/atHluGXD
 idOd5LHXb/7iOSMKcl9Rhfufhp4fWlB08M4LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding:user-agent;
 bh=kB8/lHcdu6D0WpY2Fk8gtBWr4qptuj9p44dCcRYl7AM=;
 b=SqVa3Z5lrnvQOBBOZ41hrJPIneyMYvqmwgB45Ho6WbGjPdee2F1lRv+8k5ECHyPVb9
 RgUybH8MgRVE9WKHubVFwElC4wXPD2Pq+6WWuqpy1kuc3bfQ0MRSjKYPsqAEnukzZkXG
 eKCAikK3DOroj8ptKP/+fQDR62eBe/ql2elqnU77uhyqkf+YfwwI+VZVP3fNW4D/SUi4
 hCn7y5v4uLSEIIOqsQkDMGydRk9Kq9flHIcOfxanYxnSJB07SgOt5up5QQIDdFp7Vy06
 wI1cRTiiGYsGfMK7nhwB3f1JCiIWCRykekVq/stAInece3UqqvzX9nbLbMzH/mCxmciO
 TtqA==
X-Gm-Message-State: APjAAAVDcOJybbj6PdTiYWnV6VpkQ/W6rcTPrlqRxwOMbXZs8GR7dolQ
 +nxgp7l4gaI4nJhLIfgOIUg7Hg==
X-Google-Smtp-Source: APXvYqwdwZ/+EwEVdSHN74vbE9RW9WN0dqXKo8VPcBU1PimgqvJ6Rsh8+6/gYUCF6tq3IF3JUu2VZg==
X-Received: by 2002:a37:85c4:: with SMTP id
 h187mr29493437qkd.223.1575925583161; 
 Mon, 09 Dec 2019 13:06:23 -0800 (PST)
Received: from localhost ([64.9.249.143])
 by smtp.gmail.com with ESMTPSA id e123sm215605qkf.80.2019.12.09.13.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 13:06:22 -0800 (PST)
Date: Mon, 9 Dec 2019 16:06:21 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: seabios@seabios.org, qemu-devel@nongnu.org, coreboot@coreboot.org
Subject: [ANNOUNCE] SeaBIOS 1.13.0
Message-ID: <20191209210621.GA29750@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 1.13.0 version of SeaBIOS has now been released.  For more
information on the release, please see:

http://seabios.org/Releases


New in this release:

* Support for reading logical CHS drive information from QEMU
* Workaround added for misbehaving optionroms that grab "int19"
* The TPM 2 "PCR bank" option can now be set from the TPM menu
* SeaVGABIOS support for QEMU "atiext" display
* Several bug fixes and code cleanups


For information on obtaining SeaBIOS, please see:

http://seabios.org/Download


===== git shortlog -n rel-1.12.0..rel-1.13.0 =====

Gerd Hoffmann (25):
      vga: move modelist from bochsvga.c to new svgamodes.c
      vga: make memcpy_high() public
      vga: add atiext driver
      vga: add ati bios tables
      vbe: add edid support.
      ati: add edid support.
      bochsvga: add edid support.
      bochsdisplay: add edid support.
      bochsdisplay: parse resolution from edid.
      add get_keystroke_full() helper
      bootmenu: add support for more than 9 entries
      optionrom: disallow int19 redirect for pnp roms.
      ati-vga: make less verbose
      ati-vga: fix ati_read()
      ati-vga: make i2c register and bits configurable
      ati-vga: try vga ddc first
      ati-vga: add rage128 edid support
      bochsdisplay: add copyright and license to bochsdisplay.c
      ramfb: add copyright and license to ramfb.c
      cp437: add license to cp437.c
      ahci: zero-initialize port struct
      Revert "geometry: Apply LCHS values for boot devices"
      Revert "config: Add toggle for bootdevice information"
      Revert "geometry: Add boot_lchs_find_*() utility functions"
      Revert "geometry: Read LCHS from fw_cfg"

Kevin O'Connor (11):
      output: Avoid thunking to 16bit mode in printf() if no vgabios
      docs: Update mailing list archive links
      docs: Fix cut-and-paste error in Mailinglist.md archive link
      usb-ehci: Clear pipe token on pipe reallocate
      pciinit: Use %pP shorthand for printing device ids in intel_igd_setup()
      virtio-pci: Use %pP format in dprintf() calls
      Makefile: Build with -Wno-address-of-packed-member
      svgamodes: Add copyright notice to vgasrc/svgamodes.c
      docs: Add developer-certificate-of-origin
      docs: Note release date for v1.12.1
      docs: Note v1.13.0 release

Sam Eiderman (10):
      smbios: Add missing zero byte to Type 0
      geometry: Read LCHS from fw_cfg
      boot: Reorder functions in boot.c
      geometry: Add boot_lchs_find_*() utility functions
      config: Add toggle for bootdevice information
      geometry: Apply LCHS values for boot devices
      geometry: Read LCHS from fw_cfg
      boot: Build ata and scsi paths in function
      geometry: Add boot_lchs_find_*() utility functions
      geometry: Apply LCHS values for boot devices

Stefan Berger (4):
      tcgbios: Use table to convert hash to buffer size
      tcgbios: Implement TPM 2.0 menu item to activate and deactivate PCR banks
      tpm: Require a response to have minimum size of a valid response header
      tcgbios: Check for enough bytes returned from TPM2_GetCapability

Uwe Kleine-König (3):
      cbvga: reuse svga modes definitions from svgamodes.c
      Add additional resolutions for 16:9 displays: 1600x900 and 2560x1440
      Remove dos line endings introduced in the last two commits

David Woodhouse (2):
      csm: Sanitise alignment constraint in Legacy16GetTableAddress
      csm: Fix boot priority translation

Denis Plotnikov (1):
      virtio: extend virtio queue size to 256

Joseph Pacheco-Corwin (1):
      bootsplash: Added support for 16/24/32bpp in one function

Liran Alon (1):
      pvscsi: ring_desc do not have to be page aligned

Stefano Garzarella (1):
      qemu: avoid debug prints if debugcon is not enabled

Stephen Douthit (1):
      tpm: Check for TPM related ACPI tables before attempting hw probe


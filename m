Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCEFC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CC720732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZwVF8Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CC720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWsK-000850-8v
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFWqL-0004fx-J5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:11:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFWqJ-0003H7-EW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599545458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWag+r3eKGvAohddnJn+bFfOxTaQIWsNlAzENuZWfTk=;
 b=ZZwVF8Ps27Mg+00HMDqnkCotmbsfq/iJxn0o/YicAjLB2ss8hUEVlDaAP0IfLmESVFYu1n
 0+xIjLk+j9OFYQtRs/i8+P15/OvsDYL6fgqq47GMMmMnXeCFfKMCbFlmDrqZxXbyzC0BkR
 RWg04+t++y8a/nGsSw11ZguD7T0cG5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ml6wlI52NsiykMvzXkwuuQ-1; Tue, 08 Sep 2020 02:10:52 -0400
X-MC-Unique: ml6wlI52NsiykMvzXkwuuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C156E801AE2
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 06:10:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6F327E43C;
 Tue,  8 Sep 2020 06:10:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9E6EC9C87; Tue,  8 Sep 2020 08:10:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] ipxe: update submodule
Date: Tue,  8 Sep 2020 08:10:44 +0200
Message-Id: <20200908061046.10871-2-kraxel@redhat.com>
In-Reply-To: <20200908061046.10871-1-kraxel@redhat.com>
References: <20200908061046.10871-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

master snapshot, most recent commit from Aug 23th

shortlog
========

Andrew Grasso (1):
      [intel] Add INTEL_NO_PHY_RST for I218LM

Ben Bleything (1):
      [intel] Set INTEL_NO_PHY_RST on i218v

Bobby Lockwood (1):
      [libgcc] Change __divmoddi4 from int64 [unknown] to int64_t

Bruce Rogers (1):
      [build] Be explicit about -fcommon compiler directive

Christian Nilsson (1):
      [intel] Add PCI ID for I219-V and -LM 6 to 9

Daniel Johnson (1):
      [deflate] Fix typo in comment describing length codes

David Decotigny (2):
      [pcbios] Fix "out of memory" detection when expanding bottom area
      [pcbios] Take alignment into account when checking for available space

Dentcho Ludmilov Bankov (1):
      [comboot] Fix stack pointer retrieval after COM32 binary returns

Ignat Korchagin (3):
      [snp] Try promiscuous multicast receive filter if the regular one fails
      [snp] Set EFI_SIMPLE_NETWORK_RECEIVE_MULTICAST bit as per UEFI spec
      [efi] Check the status code from AllocatePool()

Joe Groocock (1):
      [cmdline] Add "--timeout" parameter to "ifconf" command

Joseph Wong (1):
      [bnxt] Add driver support for Broadcom NetXtreme-E Adapters

LaDerrick H (1):
      [sfc] Add PCI ID for Solarflare SFC9120 and Solarflare SFC9140

Michael Brown (105):
      [init] Show startup and shutdown function names in debug messages
      [efi] Blacklist the Dell Ip4ConfigDxe driver
      [tls] Support stateful session resumption
      [tls] Fix incorrectly duplicated error number
      [tls] Support stateless session resumption
      [crypto] Use x509_name() in validator debug messages
      [tls] Display cross-certificate and OCSP status messages
      [tls] Display validator messages only while validation is in progress
      [tcp] Display "connecting" status until connection is established
      [ocsp] Accept response certID with missing hashAlgorithm parameters
      [pci] Add support for PCI MSI-X interrupts
      [vlan] Provide vlan_netdev_rx() and vlan_netdev_rx_err()
      [intelxl] Use VLAN tag in receive descriptor if present
      [intelxl] Allow for virtual function admin queue register maps
      [intelxl] Use one admin queue buffer per admin queue descriptor
      [intelxl] Allow admin queues to be reinitialised
      [intelxl] Allow admin cookie to hold extended opcode and return code
      [intelxl] Provide a mechanism for handling "send to VF" events
      [intelxl] Use 32-byte receive descriptors
      [intelxl] Allow for arbitrary placement of ring tail registers
      [intelxl] Split out ring creation from context programming
      [intelxl] Allow for arbitrary placement of interrupt control register
      [intelxl] Expose functions required by virtual function driver
      [intelxl] Choose to operate in non-PXE mode
      [intelxl] Add driver for Intel 40 Gigabit Ethernet NIC virtual functions
      [build] Fix use of inline assembly on GCC 8 ARM64 builds
      [arm] Provide dummy implementations for {in,out}[s]{b,w,l}
      [efi] Return only registered EFI devices from efidev_parent()
      [fdt] Add ability to parse a MAC address from a flattened device tree
      [efi] Register a device tree if provided by the platform firmware
      [smsc95xx] Fetch MAC from device tree for Raspberry Pi
      [build] Add named configuration for Raspberry Pi
      [smscusb] Fetch MAC from device tree for Raspberry Pi Model B+
      [build] Do not apply WORKAROUND_CFLAGS for host compiler
      [build] Move predefined all-drivers build shortcut to Makefile
      [build] Add predefined shortcut for Raspberry Pi builds
      [process] Add PROC_INIT() for initialising static processes
      [peerdist] Start block download timers from within opener methods
      [peerdist] Limit number of concurrent raw block downloads
      [tls] Add missing call to tls_tx_resume() when restarting negotiation
      [crypto] Drag in configured digestInfo prefixes for any use of RSA
      [crypto] Profile the various stages of modular multiplication
      [coverity] Override assumptions about wcrtomb() and hmac_init()
      [ethernet] Avoid false positive Coverity warning
      [golan] Fix address-of-pointer bug for multicast attach/detach
      [efi] Report failed control transfers as expected by the USB core
      [efi] Do not attempt EFI_USB_IO_PROTOCOL transfers during shutdown
      [lan78xx] Always enable automatic speed and duplex detection
      [peerdist] Allow PeerDist to be globally enabled or disabled
      [peerdist] Allow for the use of a hosted cache server
      [build] Construct full version number automatically from git revision
      [travis] Ensure that most recent tag is always available
      [tftp] Eliminate unnecessary variable-length stack allocation
      [infiniband] Eliminate variable-length stack allocation
      [slam] Eliminate variable-length stack allocation
      [slam] Allow for the possibility of IPv6 multicast addresses
      [settings] Eliminate variable-length stack allocation
      [iscsi] Eliminate variable-length stack allocations in CHAP handlers
      [iscsi] Eliminate variable-length stack allocation in URI parsing
      [bios] Define macros for constructing partition table entries
      [int13con] Create log partition only when CONSOLE_INT13 is enabled
      [efi] Disambiguate errors returned by ConnectController
      [png] Fix potential integer overflow
      [efi] Work around UEFI specification bug in LoadImage
      [efi] Work around UEFI specification bug in LoadImage for SAN boot
      [uri] Avoid appearing to access final byte of a potentially empty string
      [efi] Attempt to connect our driver directly if ConnectController fails
      [tls] Allow a minimum TLS protocol version to be specified
      [tls] Default to supporting only TLSv1.1 or above
      [crypto] Allow algorithms to be included without being OID-identifiable
      [crypto] Ensure that test code drags in required ASN.1 object identifiers
      [crypto] Disable MD5 as an OID-identifiable algorithm by default
      [snp] Retry initialisation if link is reported as down
      [util] Treat empty integer strings as invalid
      [parseopt] Treat empty integer strings in user input as invalid
      [efi] Enable stack protection where possible
      [ocsp] Accept SHA1 certID responses even if SHA1 is not enabled
      [intel] Avoid spurious compiler warning on GCC 10
      [golan] Add explicit type casts for nodnic_queue_pair_type
      [build] Disable position-independent code for ARM64 EFI builds
      [efi] Detect and disable seriously broken EFI_RNG_PROTOCOL implementations
      [efi] Raise TPL during driver entry point
      [axge] Handle non-gigabit link speeds
      [usb] Clear device endpoint halt before resetting host endpoint
      [usb] Add missing usb_recycle() for completed hub interrupt transfers
      [usb] Do not attempt to disable USB3 hub ports
      [xhci] Set link state to RxDetect after disabling USB3 root hub port
      [usb] Avoid unnecessary calls to usb_hub_set_drvdata()
      [xhci] Increase link state settling delay to 100ms
      [axge] Reapply USB device configuration when opening network device
      [usb] Leave port enabled after a failed device registration
      [crypto] Avoid temporarily setting direction flag in bigint_is_geq()
      [libc] Provide an unoptimised generic_memcpy_reverse()
      [efi] Avoid setting direction flag on EFI platforms
      [libc] Add bit-rotation functions for unsigned long values
      [efi] Distribute available entropy within stack cookie
      [efi] Ensure NUL byte is at lowest address within stack cookie
      [efi] Claim SNP devices early in efi_download_start()
      [xfer] Remove address family from definition of a socket opener
      [dns] Use all configured DNS servers
      [wpa] Fix erroneous debug message in wpa_derive_ptk
      [efi] Match EDK2 numbering for USB ports
      [efi] Use device path to locate filesystem from which we were loaded
      [efi] Attempt NII initialisation both with and without cable detection
      [build] Fix building on older versions of gcc

Michael J. Bazzinotti (1):
      [libc] Fix memcmp() to return proper values

Mohammed (1):
      [golan] Add various new PCI device IDs

Rob Taglang (1):
      [intelx] Added PCI_ROM entry for Intel x553/x557-AT and x553 (SFP+) NICs

Tobias Kortkamp (1):
      [build] Fix a GNUism that FreeBSD's sed(1) cannot deal with

Valentine Barshak (2):
      [build] Fix "'%s' directive argument is null" error
      [build] Workaround compilation error with gcc 9.1

bit (1):
      [build] Fix default target in sdsk image

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/ipxe | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/ipxe b/roms/ipxe
index de4565cbe76e..4bd064de239d 160000
--- a/roms/ipxe
+++ b/roms/ipxe
@@ -1 +1 @@
-Subproject commit de4565cbe76ea9f7913a01f331be3ee901bb6e17
+Subproject commit 4bd064de239dab2426b31c9789a1f4d78087dc63
-- 
2.27.0



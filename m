Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0164C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD67206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD67206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsdZ0-00030G-L7
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsdXT-0000jN-A6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:56732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsdXM-0001vr-Io
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:40:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jsdXK-0002ia-Ee
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 02:40:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6882D2E805B
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 02:40:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2020 02:30:35 -0000
From: Alex Austin <1886602@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: circuitsoft
X-Launchpad-Bug-Reporter: Alex Austin (circuitsoft)
X-Launchpad-Bug-Modifier: Alex Austin (circuitsoft)
References: <159408874500.32011.1427435858163411654.malonedeb@gac.canonical.com>
Message-Id: <159408903603.3096.9193568620111206044.malone@chaenomeles.canonical.com>
Subject: [Bug 1886602] Re: Windows 10 very slow with OVMF
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ffd32ad7291fe66b5578d7c1407aaae58d1e0170";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b8e8bde4fd248d9ea1cfdcaf9f8b6f1535ed7147
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 22:40:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1886602 <1886602@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

# dmidecode 3.2
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.
Table at 0x9A694000.

...

Handle 0x000A, DMI type 4, 48 bytes
Processor Information
        Socket Designation: U3E1
        Type: Central Processor
        Family: Core i7
...
        Core Count: 2
        Core Enabled: 2
        Thread Count: 4
        Characteristics:
                64-bit capable
                Multi-Core
                Hardware Thread
                Execute Protection
                Enhanced Virtualization
                Power/Performance Control


Handle 0x000B, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: N1QET88W (1.63 )
        Release Date: 04/22/2020
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 16 MB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                3.5"/720 kB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 1.63
        Firmware Revision: 1.35

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886602

Title:
  Windows 10 very slow with OVMF

Status in QEMU:
  New

Bug description:
  Debian Buster

  Kernel 4.19.0-9-amd64
  qemu-kvm 1:3.1+dfsg-8+deb10u5
  ovmf 0~20181115.85588389-3+deb10u1

  Machine: Thinkpad T470, i7-7500u, 20GB RAM
  VM: 4 CPUs, 8GB RAM, Broadwell-noTSX CPU Model

  Windows 10, under this VM, seems to be exceedingly slow with all
  operations. This is a clean install with very few services running.
  Task Manager can take 30% CPU looking at an idle system.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886602/+subscriptions


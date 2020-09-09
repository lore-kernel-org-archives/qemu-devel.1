Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E85C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED2E206A5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW613FRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwgK-0005XW-1W
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFwex-00042G-Dn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:44:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFwet-0007Li-7s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599644694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpKvVCS+MEZJo8TmVDj2NayOkphxgn0PgyHjr2UGt4Y=;
 b=iW613FRI4QRYrJrZFvK64FoX61gL6qJ9i0uXrSifYBFF+TqzfNRHC65zLVoOyDWCRS+FFI
 iJgUvO43fKDCMCTLzfPUwTLcLPJDoXloxKpzRs1DnHP3dY3zuYjc/6Oeef7lF1nwv/7yZ5
 GciM0eh1si4QuIY6uK3Sawbbz4PiGRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-TodjrrszNvm_rMLqjcsP7Q-1; Wed, 09 Sep 2020 05:44:48 -0400
X-MC-Unique: TodjrrszNvm_rMLqjcsP7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0B118B9F28;
 Wed,  9 Sep 2020 09:44:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-82.ams2.redhat.com
 [10.36.114.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EF411002D5C;
 Wed,  9 Sep 2020 09:44:41 +0000 (UTC)
Subject: Re: [PATCH 0/5] Add support for loading SMBIOS OEM strings from a file
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200908165438.1008942-1-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d3c345b6-c2db-ef61-2ac0-afc0f9f737c2@redhat.com>
Date: Wed, 9 Sep 2020 11:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200908165438.1008942-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 18:54, Daniel P. Berrangé wrote:
> I previously added support for SMBIOS OEM strings tables but only
> allowed for data to be passed inline. Potential users indicated they
> wanted to pass some quite large data blobs which is inconvenient todo
> inline. Thus I'm adding support for passing the data from a file.
>
> In testing this I discovered the hard way that on x86 we're limited to
> using the SMBIOS 2.1 entry point currently. This has a maximum size of
> 0xffff, and if you exceed this all sorts of wierd behaviour happens.
>
> QEMU forces SMBIOS 2.1 on x86 because the default SeaBIOS firmware
> does not support SMBIOS 3.0. The EDK2 firmware supports SMBIOS 3.0 and
> QEMU defaults to this on the ARM virt machine type.
>
> This series adds support for checking the SMBIOS 2.1 limits to protect
> users from impossible to diagnose problems.
>
> There is also a fix needed to SeaBIOS which fails to check for
> integer overflow when it appends the type 0 table.
>
>   https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/3EMIOY6YS6MG5UQN3JJJS2A3DJZOVFR6/
>
> IIUC, SMBIOS 3.0 should onlky be limited by what you can fit into RAM,
> but in testing, EDK2 appears to hang shortly after the SMBIOS 3.0 data
> size exceeds 128 KB. I've not spotted an obvious flaw in EDK2 or QEMU,
> nor do I attempt to enforce a limit in QEMU for SMBIOS 3.0.

Under UEFI, the SMBIOS-2 and SMBIOS-3 entry points ("anchors") are
represented as "UEFI configuration tables", with GUIDs that are defined
by the UEFI spec. This is not complex; I guess the simplest explanation
I can give is the BiosTablesTestMain() function in

  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c

That UEFI application is independent of this use case -- it is a
guest-side helper utility for

  tests/qtest/bios-tables-test.c

only it comes real handy now, for explaining how the SMBIOS anchors are
located on UEFI.

On a UEFI system, the SMBIOS-2 and SMBIOS-3 entry points (and their
associated table sets) may *both* exist, at the same time. The
ArmVirtQemu firmware is configured to produce only SMBIOS-3. OVMF is
configured to produce both SMBIOS-2 and SMBIOS-3. It's actually more
precise to call these tables "32-bit" and "64-bit".

Notably, the version fields in the 32-bit entry point, such as "SMBIOS
Major Version", "SMBIOS Minor Version", and "SMBIOS BCD Revision", may
refer to versions 3.x+ of the SMBIOS specification.

What OVMF does is, it fetches the SMBIOS payload from QEMU over fw_cfg.
The SMBIOS entry point(s) and tables that the OS will see are not under
the direct control of OVMF. Those artifacts are managed by the
platform-independent driver

  MdeModulePkg/Universal/SmbiosDxe/

which publishes its services through EFI_SMBIOS_PROTOCOL. The protocol
doesn't allow callers to manage the entry points directly, only to add
tables, update strings, iterate over existent tables, and remove tables.
The entry point(s) are installed internally to the driver.

What the platform (OVMF) can do however is use the following "side
channels" to communicate with the driver:

- PcdSmbiosEntryPointProvideMethod
- PcdSmbiosVersion
- PcdSmbiosDocRev

(1) "PcdSmbiosEntryPointProvideMethod" is a bitmask; bit#0 decides
whether the 32-bit entry point will be installed, bit#1 decides whether
the 64-bit entry point will be installed. In ArmVirtQemu, we have value
0x2 for this (statically), in OVMF, we have value 0x3 (statically).

(2) "PcdSmbiosVersion" encodes the SMBIOS specification that the
installed entry points will claim compliance with. It determines the
following fields (all of them):
- 32-bit entry point (if any), SMBIOS Major Version
- 32-bit entry point (if any), SMBIOS Minor Version
- 32-bit entry point (if any), SMBIOS BCD Revision
- 64-bit entry point (if any), SMBIOS Major Version
- 64-bit entry point (if any), SMBIOS Minor Version

OVMF (and ArmVirtQemu too) set PcdSmbiosVersion dynamically, in
"OvmfPkg/Library/SmbiosVersionLib/DetectSmbiosVersionLib.c", as follows:

(2a) if QEMU offers a 32-bit entry point (anchor) via fw_cfg, then parse
the SMBIOS Major Version / SMBIOS Minor Version fields from that, and
encode them in PcdSmbiosVersion.

(2b) if QEMU offers a 64-bit entry point (anchor) via fw_cfg, then parse
the the SMBIOS Major Version / SMBIOS Minor Version fields from that,
and encode them in PcdSmbiosVersion.

(3) "PcdSmbiosDocRev" is only relevant for when the 64-bit entry point
is enabled via "PcdSmbiosEntryPointProvideMethod". OVMF sets this PCD
dynamically, in case QEMU offers a 64-bit entry point (anchor), namely
from the SMBIOS Docrev field.


When a table is added or a string is updated via EFI_SMBIOS_PROTOCOL,
the "MdeModulePkg/Universal/SmbiosDxe" driver evaluates the validity of
the request against *each enabled* entry point (that is, 32-bit AND/OR
64-bit). The request is then satisfied for *all* entry points that are
technically eligible. (If none of the entry points are capable of
satisfying the request, then the request is rejected.)


OVMF and ArmVirtQemu dissect the fw_cfg payload from QEMU (see
InstallAllStructures() in
"OvmfPkg/SmbiosPlatformDxe/SmbiosPlatformDxe.c", in edk2), and add the
extracted tables one by one, using EFI_SMBIOS_PROTOCOL.Add(). Finally,
if a Type 0 table has not been provided, then OVMF installs a built-in
(default) Type 0 table.


Accordingly, using the following QEMU options:

  -smbios type=11,path=/tmp/testfile \
  -machine smbios-ep=3_0 \

where /tmp/testfile (195,464 bytes) was generated like this:

  head -c $((128*1024)) /dev/zero \
  | base64 \
  | cat -n \
  | expand \
  > /tmp/testfile

we get the following log, from "MdeModulePkg/Universal/SmbiosDxe":

> SmbiosAdd: Smbios type 1 with size 0x4B is added to 32-bit table
> SmbiosAdd: Smbios type 1 with size 0x4B is added to 64-bit table
> SmbiosCreateTable: Initialize 32-bit entry point structure
> SmbiosCreateTable() re-allocate SMBIOS 32-bit table
> SmbiosCreateTable: Initialize 64-bit entry point structure
> SmbiosCreate64BitTable() re-allocate SMBIOS 64-bit table
> SmbiosAdd: Smbios type 3 with size 0x27 is added to 32-bit table
> SmbiosAdd: Smbios type 3 with size 0x27 is added to 64-bit table
> SmbiosAdd: Smbios type 4 with size 0x41 is added to 32-bit table
> SmbiosAdd: Smbios type 4 with size 0x41 is added to 64-bit table
> SmbiosAdd: Total length exceeds max 32-bit table length with type = 11 size = 0x300F6
> SmbiosAdd: Smbios type 11 with size 0x300F6 is added to 64-bit table
> SmbiosCreate64BitTable() re-allocate SMBIOS 64-bit table
> SmbiosAdd: Smbios type 16 with size 0x19 is added to 32-bit table
> SmbiosAdd: Smbios type 16 with size 0x19 is added to 64-bit table
> SmbiosAdd: Smbios type 17 with size 0x35 is added to 32-bit table
> SmbiosAdd: Smbios type 17 with size 0x35 is added to 64-bit table
> SmbiosAdd: Smbios type 19 with size 0x21 is added to 32-bit table
> SmbiosAdd: Smbios type 19 with size 0x21 is added to 64-bit table
> SmbiosAdd: Smbios type 19 with size 0x21 is added to 32-bit table
> SmbiosAdd: Smbios type 19 with size 0x21 is added to 64-bit table
> SmbiosAdd: Smbios type 32 with size 0xD is added to 32-bit table
> SmbiosAdd: Smbios type 32 with size 0xD is added to 64-bit table
> SmbiosAdd: Smbios type 0 with size 0x4A is added to 32-bit table
> SmbiosAdd: Smbios type 0 with size 0x4A is added to 64-bit table

Note that the Type 11 table (OEM Strings) is only exposed under the
64-bit entry point.

The firmware is entirely OK with this; I see the boot progress through
shim -> grub -> kernel (the kernel's UEFI stub confirms that UEFI Secure
Boot is enabled, for example).

However, the guest kernel does crash. Using the following (relevant)
kernel params:

  ignore_loglevel earlyprintk=ttyS0,115200n8 console=ttyS0,115200n8 \
  efi=debug

I get the panic below:

> [    0.000000] Linux version 5.3.6-200.fc30.x86_64 (mockbuild@bkernel04.phx2.fedoraproject.org) (gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)) #1 SMP Mon Oct 14 13:11:01 UTC 2019
> [    0.000000] Command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.3.6-200.fc30.x86_64 root=/dev/mapper/fedora_192-root ro resume=/dev/mapper/fedora_192-swap rd.lvm.lv=fedora_192/root rd.lvm.lv=fedora_192/swap ignore_loglevel earlyprintk=ttyS0,115200n8 console=tty0 console=ttyS0,115200n8 no_console_suspend efi=debug video=800x480 earlyprintk=ttyS0,115200n8
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000002ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000030000-0x000000000004ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000050000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000000806fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000807000-0x0000000000807fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000000808000-0x000000000080ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000810000-0x000000000170ffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000001710000-0x000000007e728fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007e729000-0x000000007eb6dfff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000007eb6e000-0x000000007eb7dfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000007eb7e000-0x000000007ebfdfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007ebfe000-0x000000007ef3ffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007ef40000-0x000000007effffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000007fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001bfffffff] usable
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] printk: bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x7c273018-0x7c27ca57] usable ==> usable
> [    0.000000] e820: update [mem 0x7c273018-0x7c27ca57] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000002ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000030000-0x000000000004ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000050000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009ffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000000806fff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000807000-0x0000000000807fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000000808000-0x000000000080ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000810000-0x000000000170ffff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000001710000-0x000000007c273017] usable
> [    0.000000] reserve setup_data: [mem 0x000000007c273018-0x000000007c27ca57] usable
> [    0.000000] reserve setup_data: [mem 0x000000007c27ca58-0x000000007e728fff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007e729000-0x000000007eb6dfff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000007eb6e000-0x000000007eb7dfff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000007eb7e000-0x000000007ebfdfff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000007ebfe000-0x000000007ef3ffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000007ef40000-0x000000007effffff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x000000007f000000-0x000000007fffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000001bfffffff] usable
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  SMBIOS=0x7e954000  SMBIOS 3.0=0x7e952000  ACPI=0x7eb7d000  ACPI 2.0=0x7eb7d014  MEMATTR=0x7cd8b018

(Note: both 32-bit and 64-bit SMBIOS entry points are present)

> [    0.000000] efi: mem00: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000000fff] (0MB)
> [    0.000000] efi: mem01: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000001000-0x0000000000001fff] (0MB)
> [    0.000000] efi: mem02: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000002000-0x000000000002ffff] (0MB)
> [    0.000000] efi: mem03: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000050000-0x0000000000086fff] (0MB)
> [    0.000000] efi: mem04: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000087000-0x0000000000087fff] (0MB)
> [    0.000000] efi: mem05: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000088000-0x000000000009dfff] (0MB)
> [    0.000000] efi: mem06: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009e000-0x000000000009ffff] (0MB)
> [    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x0000000000806fff] (7MB)
> [    0.000000] efi: mem08: [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000807000-0x0000000000807fff] (0MB)
> [    0.000000] efi: mem09: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000808000-0x000000000080ffff] (0MB)
> [    0.000000] efi: mem10: [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000810000-0x000000000170ffff] (15MB)
> [    0.000000] efi: mem11: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000001710000-0x0000000001ffffff] (8MB)
> [    0.000000] efi: mem12: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000002000000-0x0000000004b4afff] (43MB)
> [    0.000000] efi: mem13: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000004b4b000-0x0000000057f19fff] (1331MB)
> [    0.000000] efi: mem14: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000057f1a000-0x000000005c372fff] (68MB)
> [    0.000000] efi: mem15: [Loader Code        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000005c373000-0x000000007aefdfff] (491MB)
> [    0.000000] efi: mem16: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007aefe000-0x000000007af1dfff] (0MB)
> [    0.000000] efi: mem17: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007af1e000-0x000000007bcf2fff] (13MB)
> [    0.000000] efi: mem18: [Loader Code        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007bcf3000-0x000000007be9bfff] (1MB)
> [    0.000000] efi: mem19: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007be9c000-0x000000007c044fff] (1MB)
> [    0.000000] efi: mem20: [Loader Code        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c045000-0x000000007c155fff] (1MB)
> [    0.000000] efi: mem21: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c156000-0x000000007c159fff] (0MB)
> [    0.000000] efi: mem22: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c15a000-0x000000007c169fff] (0MB)
> [    0.000000] efi: mem23: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c16a000-0x000000007c16afff] (0MB)
> [    0.000000] efi: mem24: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c16b000-0x000000007c272fff] (1MB)
> [    0.000000] efi: mem25: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c273000-0x000000007c27dfff] (0MB)
> [    0.000000] efi: mem26: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c27e000-0x000000007c281fff] (0MB)
> [    0.000000] efi: mem27: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c282000-0x000000007c284fff] (0MB)
> [    0.000000] efi: mem28: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c285000-0x000000007c288fff] (0MB)
> [    0.000000] efi: mem29: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c289000-0x000000007c28dfff] (0MB)
> [    0.000000] efi: mem30: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c28e000-0x000000007c28efff] (0MB)
> [    0.000000] efi: mem31: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c28f000-0x000000007c294fff] (0MB)
> [    0.000000] efi: mem32: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007c295000-0x000000007cd83fff] (10MB)
> [    0.000000] efi: mem33: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd84000-0x000000007cd84fff] (0MB)
> [    0.000000] efi: mem34: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd85000-0x000000007cd86fff] (0MB)
> [    0.000000] efi: mem35: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd87000-0x000000007cd87fff] (0MB)
> [    0.000000] efi: mem36: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd88000-0x000000007cd88fff] (0MB)
> [    0.000000] efi: mem37: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd89000-0x000000007cd8afff] (0MB)
> [    0.000000] efi: mem38: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd8b000-0x000000007cd8cfff] (0MB)
> [    0.000000] efi: mem39: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd8d000-0x000000007cd8dfff] (0MB)
> [    0.000000] efi: mem40: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd8e000-0x000000007cd98fff] (0MB)
> [    0.000000] efi: mem41: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cd99000-0x000000007ceb3fff] (1MB)
> [    0.000000] efi: mem42: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ceb4000-0x000000007cf02fff] (0MB)
> [    0.000000] efi: mem43: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf03000-0x000000007cf4afff] (0MB)
> [    0.000000] efi: mem44: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf4b000-0x000000007cf4dfff] (0MB)
> [    0.000000] efi: mem45: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf4e000-0x000000007cf64fff] (0MB)
> [    0.000000] efi: mem46: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf65000-0x000000007cf6bfff] (0MB)
> [    0.000000] efi: mem47: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf6c000-0x000000007cf98fff] (0MB)
> [    0.000000] efi: mem48: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf99000-0x000000007cf9bfff] (0MB)
> [    0.000000] efi: mem49: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007cf9c000-0x000000007d00cfff] (0MB)
> [    0.000000] efi: mem50: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d00d000-0x000000007d015fff] (0MB)
> [    0.000000] efi: mem51: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d016000-0x000000007d058fff] (0MB)
> [    0.000000] efi: mem52: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d059000-0x000000007d05afff] (0MB)
> [    0.000000] efi: mem53: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d05b000-0x000000007d099fff] (0MB)
> [    0.000000] efi: mem54: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d09a000-0x000000007d09cfff] (0MB)
> [    0.000000] efi: mem55: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d09d000-0x000000007d0cefff] (0MB)
> [    0.000000] efi: mem56: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d0cf000-0x000000007d0d3fff] (0MB)
> [    0.000000] efi: mem57: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d0d4000-0x000000007d102fff] (0MB)
> [    0.000000] efi: mem58: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d103000-0x000000007d104fff] (0MB)
> [    0.000000] efi: mem59: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d105000-0x000000007d127fff] (0MB)
> [    0.000000] efi: mem60: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d128000-0x000000007d139fff] (0MB)
> [    0.000000] efi: mem61: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d13a000-0x000000007d153fff] (0MB)
> [    0.000000] efi: mem62: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d154000-0x000000007d154fff] (0MB)
> [    0.000000] efi: mem63: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d155000-0x000000007d172fff] (0MB)
> [    0.000000] efi: mem64: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d173000-0x000000007d178fff] (0MB)
> [    0.000000] efi: mem65: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d179000-0x000000007d19cfff] (0MB)
> [    0.000000] efi: mem66: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d19d000-0x000000007d1a8fff] (0MB)
> [    0.000000] efi: mem67: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d1a9000-0x000000007d1ccfff] (0MB)
> [    0.000000] efi: mem68: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d1cd000-0x000000007d1d3fff] (0MB)
> [    0.000000] efi: mem69: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d1d4000-0x000000007d1f1fff] (0MB)
> [    0.000000] efi: mem70: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d1f2000-0x000000007d1fcfff] (0MB)
> [    0.000000] efi: mem71: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d1fd000-0x000000007d255fff] (0MB)
> [    0.000000] efi: mem72: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d256000-0x000000007d25cfff] (0MB)
> [    0.000000] efi: mem73: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d25d000-0x000000007d387fff] (1MB)
> [    0.000000] efi: mem74: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d388000-0x000000007d38cfff] (0MB)
> [    0.000000] efi: mem75: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d38d000-0x000000007d396fff] (0MB)
> [    0.000000] efi: mem76: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d397000-0x000000007d3a0fff] (0MB)
> [    0.000000] efi: mem77: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d3a1000-0x000000007d3d2fff] (0MB)
> [    0.000000] efi: mem78: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d3d3000-0x000000007d3d5fff] (0MB)
> [    0.000000] efi: mem79: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d3d6000-0x000000007d3defff] (0MB)
> [    0.000000] efi: mem80: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d3df000-0x000000007d553fff] (1MB)
> [    0.000000] efi: mem81: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d554000-0x000000007d572fff] (0MB)
> [    0.000000] efi: mem82: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d573000-0x000000007d591fff] (0MB)
> [    0.000000] efi: mem83: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d592000-0x000000007d5a3fff] (0MB)
> [    0.000000] efi: mem84: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d5a4000-0x000000007d5aefff] (0MB)
> [    0.000000] efi: mem85: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d5af000-0x000000007d5c0fff] (0MB)
> [    0.000000] efi: mem86: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d5c1000-0x000000007d5cbfff] (0MB)
> [    0.000000] efi: mem87: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d5cc000-0x000000007d5fffff] (0MB)
> [    0.000000] efi: mem88: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d600000-0x000000007d804fff] (2MB)
> [    0.000000] efi: mem89: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d805000-0x000000007d82afff] (0MB)
> [    0.000000] efi: mem90: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d82b000-0x000000007d82bfff] (0MB)
> [    0.000000] efi: mem91: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d82c000-0x000000007d830fff] (0MB)
> [    0.000000] efi: mem92: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d831000-0x000000007d835fff] (0MB)
> [    0.000000] efi: mem93: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d836000-0x000000007d846fff] (0MB)
> [    0.000000] efi: mem94: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d847000-0x000000007d850fff] (0MB)
> [    0.000000] efi: mem95: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d851000-0x000000007d87efff] (0MB)
> [    0.000000] efi: mem96: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007d87f000-0x000000007dc7efff] (4MB)
> [    0.000000] efi: mem97: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dc7f000-0x000000007dd7bfff] (0MB)
> [    0.000000] efi: mem98: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dd7c000-0x000000007dd7efff] (0MB)
> [    0.000000] efi: mem99: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dd7f000-0x000000007dda1fff] (0MB)
> [    0.000000] efi: mem100: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dda2000-0x000000007dda6fff] (0MB)
> [    0.000000] efi: mem101: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dda7000-0x000000007ddc6fff] (0MB)
> [    0.000000] efi: mem102: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ddc7000-0x000000007ddcafff] (0MB)
> [    0.000000] efi: mem103: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ddcb000-0x000000007ddcffff] (0MB)
> [    0.000000] efi: mem104: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ddd0000-0x000000007dde6fff] (0MB)
> [    0.000000] efi: mem105: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007dde7000-0x000000007de1bfff] (0MB)
> [    0.000000] efi: mem106: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007de1c000-0x000000007de1cfff] (0MB)
> [    0.000000] efi: mem107: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007de1d000-0x000000007de21fff] (0MB)
> [    0.000000] efi: mem108: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007de22000-0x000000007de23fff] (0MB)
> [    0.000000] efi: mem109: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007de24000-0x000000007de24fff] (0MB)
> [    0.000000] efi: mem110: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007de25000-0x000000007e728fff] (9MB)
> [    0.000000] efi: mem111: [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007e729000-0x000000007e96afff] (2MB)
> [    0.000000] efi: mem112: [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007e96b000-0x000000007eaedfff] (1MB)
> [    0.000000] efi: mem113: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007eaee000-0x000000007eb6dfff] (0MB)
> [    0.000000] efi: mem114: [ACPI Reclaim Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007eb6e000-0x000000007eb7dfff] (0MB)
> [    0.000000] efi: mem115: [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007eb7e000-0x000000007ebfdfff] (0MB)
> [    0.000000] efi: mem116: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ebfe000-0x000000007edfffff] (2MB)
> [    0.000000] efi: mem117: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ee00000-0x000000007ee29fff] (0MB)
> [    0.000000] efi: mem118: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ee2a000-0x000000007ee49fff] (0MB)
> [    0.000000] efi: mem119: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ee4a000-0x000000007eeaefff] (0MB)
> [    0.000000] efi: mem120: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007eeaf000-0x000000007eeeffff] (0MB)
> [    0.000000] efi: mem121: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007eef0000-0x000000007ef3ffff] (0MB)
> [    0.000000] efi: mem122: [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007ef40000-0x000000007effffff] (0MB)
> [    0.000000] efi: mem123: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x00000001bfffffff] (3072MB)
> [    0.000000] efi: mem124: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000030000-0x000000000004ffff] (0MB)
> [    0.000000] efi: mem125: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007f000000-0x000000007fffffff] (16MB)
> [    0.000000] efi: mem126: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000b0000000-0x00000000bfffffff] (256MB)
> [    0.000000] secureboot: Secure boot enabled
> [    0.000000] Kernel is locked down from EFI secure boot; see man kernel_lockdown.7
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/x86/kernel/setup.c:264!

BUG hit here

> PANIC: early exception 0x06 IP 10:ffffffff8799951f error 0 cr2 0xffff88818c40eff8
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.6-200.fc30.x86_64 #1
> [    0.000000] RIP: 0010:extend_brk+0x3b/0x4f
> [    0.000000] Code: 8d 46 ff 75 02 0f 0b 48 85 c6 74 02 0f 0b 48 03 05 76 9e a8 ff 48 f7 de 49 89 c0 49 21 f0 49 8d 04 38 48 3d 00 c0 02 88 76 02 <0f> 0b 48 89 05 58 9e a8 ff 4c 89 c7 31 c0 f3 aa 4c 89 c0 c3 e8 88
> [    0.000000] RSP: 0000:ffffffff87403da8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
> [    0.000000] RAX: ffffffff8803018d RBX: ffffffff880005dc RCX: 000000000002fb89
> [    0.000000] RDX: 0000000000000031 RSI: fffffffffffffffc RDI: 000000000002fb89
> [    0.000000] RBP: ffffffffff24061f R08: ffffffff88000604 R09: ffffffff87514b40
> [    0.000000] R10: ffffffffffffffff R11: ffffffff88000065 R12: 0000000000000002
> [    0.000000] R13: ffffffff87514b40 R14: 0000000000000002 R15: ffffffffff2400b3
> [    0.000000] FS:  0000000000000000(0000) GS:ffffffff87961000(0000) knlGS:0000000000000000
> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.000000] CR2: ffff88818c40eff8 CR3: 000000018ca10000 CR4: 00000000000406a0
> [    0.000000] Call Trace:
> [    0.000000]  ? dmi_string+0x37/0x52
> [    0.000000]  ? dmi_decode+0x349/0x49c
> [    0.000000]  ? dmi_format_ids.constprop.0+0x128/0x128
> [    0.000000]  ? dmi_decode_table+0xb8/0xd0
> [    0.000000]  ? dmi_format_ids.constprop.0+0x128/0x128
> [    0.000000]  ? dmi_walk_early+0x3d/0x5e
> [    0.000000]  ? dmi_smbios3_present+0x9a/0xe1
> [    0.000000]  ? dmi_setup+0x83/0x264
> [    0.000000]  ? printk+0x58/0x6f
> [    0.000000]  ? setup_arch+0x433/0xcb2
> [    0.000000]  ? start_kernel+0x5e/0x56c
> [    0.000000]  ? secondary_startup_64+0xa4/0xb0

This is from "drivers/firmware/dmi_scan.c". dmi_string() calls
dmi_alloc(), which is an inline function that calls extend_brk() (see
"arch/x86/include/asm/dmi.h").

Then extend_brk() in "arch/x86/kernel/setup.c" hits a BUG (note the line
numbers are from upstream v5.3.6, not from Fedora's "5.3.6-200.fc30") :

    254 void * __init extend_brk(size_t size, size_t align)
    255 {
    256         size_t mask = align - 1;
    257         void *ret;
    258
    259         BUG_ON(_brk_start == 0);
    260         BUG_ON(align & mask);
    261
    262         _brk_end = (_brk_end + mask) & ~mask;
    263         BUG_ON((char *)(_brk_end + size) > __brk_limit);
    264
    265         ret = (void *)_brk_end;
    266         _brk_end += size;
    267
    268         memset(ret, 0, size);
    269
    270         return ret;
    271 }

So we're exceeding "__brk_limit".

... I'm quite getting out of my league here, but "__brk_limit" seems to
be controlled by "brk_reservation" in "arch/x86/kernel/vmlinux.lds.S"...
and ultimately through the RESERVE_BRK() macro:

[arch/x86/include/asm/setup.h]

> /*
>  * Reserve space in the brk section.  The name must be unique within
>  * the file, and somewhat descriptive.  The size is in bytes.  Must be
>  * used at file scope.
>  *
>  * (This uses a temp function to wrap the asm so we can pass it the
>  * size parameter; otherwise we wouldn't be able to.  We can't use a
>  * "section" attribute on a normal variable because it always ends up
>  * being @progbits, which ends up allocating space in the vmlinux
>  * executable.)
>  */
> #define RESERVE_BRK(name,sz)                                            \

OK, so let's see RESERVE_BRK() invocations... The relevant match is
likely the one below:

> arch/x86/kernel/setup.c:RESERVE_BRK(dmi_alloc, 65536);

... Then see kernel commits:

- 6de6cb442e76 ("x86: use brk allocation for DMI", 2009-03-14)

- 796216a57fe4 ("x86: allow extend_brk users to reserve brk space",
2009-03-14)

- e808bae2407a ("x86: Do not reserve brk for DMI if it's not going to be
used", 2010-02-25)

Commit 796216a57fe4 is helpful:

>     Add RESERVE_BRK(name, size) macro to reserve space in the brk
>     area.  This should be a conservative (ie, larger) estimate of
>     how much space might possibly be required from the brk area.
>     Any unused space will be freed, so there's no real downside
>     on making the reservation too large (within limits).

So it seems like the 64K limit could be increased, but still
- it requires guest kernels to be rebuilt,
- it doesn't seem suitable for passing MBs of data (on x86 anyway).

Thanks
Laszlo



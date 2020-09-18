Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2505C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57799208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="V52/wwul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57799208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC54-00014m-CK
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJByS-00030c-7E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJByM-0007xJ-G0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id g29so3079678pgl.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PZ0t5l0h/1dEpMOLrSPH28d48Nu+Fe9SZlr/r+Ye7Vw=;
 b=V52/wwul9s8DedAR5ouvf561AUTmNU26zuIzCZygkxDsTHNsYFyqYnWxqzQjblA4QF
 vYJb9T2zdd5KV93kPPhhR4+3O67aorRQ587Xrsz7WuIYJKvR6/V9QuwiZYIbYmPRc72N
 gg8IZUYSmoJQlvZzVyGYs8ZD95GFHsE9KZJQ6IrqrZJwZyhoKZ2NlXdcx5cdG4vIL85W
 4y1qIwiETNjWR5cQ5cUsvbZpuCWNU+YmUzRsz6eiwbWyszFifNIm9rpOghTqALCIIHpV
 PhIb3JAP6BinCaiZqTyQGHFJr0R7mxqtuvpayN4aze90LyN4U80J5k9gafKgbdo+vzB5
 7bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PZ0t5l0h/1dEpMOLrSPH28d48Nu+Fe9SZlr/r+Ye7Vw=;
 b=PtcpgBOLyhYwQrAvHKXJLDE5qa8qjX6Y4d6NxaLuyEbi1/BBUg/8Kkv1VMpus/l4LX
 jqk70WohJ24Ue1FeTWD86jq5ua9b094rEQIRE9xMlk/oSPFfueQ1c4ngAlbqgPSCk1i2
 FfCPrOeW+XY3i0Tbw9RKRQIq29aUB8a1evTvFwXIEZjrqsrY/g+lntqZ4LQGardvGmO/
 8CXJpufcUXjnO6WhxyYHZfr0uLgLn4K76Ea5b0ePQHGLxDuNHnxy+c+K+9QOgDD0tS93
 fmMUCm617Q/nENkusm9cAKbQiBnlnCQLpotnil4oCTVmyOreH3EXN3cSKhQORbOcUvzM
 jFZw==
X-Gm-Message-State: AOAM531Z84iwj5cowYt52/aEABoPO5C+NMTov+/Mie3RfHNRAJ9yJ2si
 cTCTOO/tYLHlgy74bVldud1Feg==
X-Google-Smtp-Source: ABdhPJybscssd5cy/TUiUtK4KTDQWxE0pC92Oer/JqYDebgAxByIHDLNhE5ol/3wdbqhx/8xjNfrGw==
X-Received: by 2002:aa7:9182:0:b029:142:2501:3977 with SMTP id
 x2-20020aa791820000b029014225013977mr14816879pfa.60.1600418545120; 
 Fri, 18 Sep 2020 01:42:25 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:42:24 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob to
 test global i440fx hotplug
Date: Fri, 18 Sep 2020 14:11:11 +0530
Message-Id: <20200918084111.15339-14-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::543;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a new DSDT golden master table blob to test disabling
hotplug on both pci root bus and pci bridges. Also reverts the change
in file bios-tables-test-allowed-diff.h to make sure its now empty so that
future modifications to acpi tables can be caught.

The following is the disassembled diff between DSDT.hpbridge and DSDT.hpbrroot:

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20180105 (64-bit version)
  * Copyright (c) 2000 - 2018 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Wed Sep 16 09:45:56 2020
+ * Disassembly of /tmp/aml-ECV9Q0, Wed Sep 16 09:45:56 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000131F (4895)
+ *     Length           0x00000B89 (2953)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xF9
+ *     Checksum         0xA2
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

@@ -234,64 +234,32 @@
         {
             Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 IO (Decode16,
                     0x0070,             // Range Minimum
                     0x0070,             // Range Maximum
                     0x01,               // Alignment
                     0x08,               // Length
                     )
                 IRQNoFlags ()
                     {8}
             })
         }
     }

-    Scope (_SB.PCI0)
-    {
-        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
-        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
-        {
-            PCIU,   32,
-            PCID,   32
-        }
-
-        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
-        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
-        {
-            B0EJ,   32
-        }
-
-        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
-        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
-        {
-            BNUM,   32
-        }
-
-        Mutex (BLCK, 0x00)
-        Method (PCEJ, 2, NotSerialized)
-        {
-            Acquire (BLCK, 0xFFFF)
-            BNUM = Arg0
-            B0EJ = (One << Arg1)
-            Release (BLCK)
-            Return (Zero)
-        }
-    }
-
     Scope (_SB)
     {
         Scope (PCI0)
         {
             Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
             {
                 Local0 = Package (0x80){}
                 Local1 = Zero
                 While ((Local1 < 0x80))
                 {
                     Local2 = (Local1 >> 0x02)
                     Local3 = ((Local1 + Local2) & 0x03)
                     If ((Local3 == Zero))
                     {
                         Local4 = Package (0x04)
                             {
@@ -690,38 +658,32 @@
                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (Zero, Arg0, Arg1, Arg2)
                 }
             }
         }
     }

     Method (\_GPE._E02, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
     {
         \_SB.CPUS.CSCN ()
     }

     Scope (_GPE)
     {
         Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
-        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
-        {
-            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
-            \_SB.PCI0.PCNT ()
-            Release (\_SB.PCI0.BLCK)
-        }
     }

     Scope (\_SB.PCI0)
     {
         Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
         {
             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                 0x0000,             // Granularity
                 0x0000,             // Range Minimum
                 0x00FF,             // Range Maximum
                 0x0000,             // Translation Offset
                 0x0100,             // Length
                 ,, )
             IO (Decode16,
                 0x0CF8,             // Range Minimum
                 0x0CF8,             // Range Maximum
@@ -766,48 +728,32 @@
         })
         Device (GPE0)
         {
             Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
             Name (_UID, "GPE0 resources")  // _UID: Unique ID
             Name (_STA, 0x0B)  // _STA: Status
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 IO (Decode16,
                     0xAFE0,             // Range Minimum
                     0xAFE0,             // Range Maximum
                     0x01,               // Alignment
                     0x04,               // Length
                     )
             })
         }
-
-        Device (PHPR)
-        {
-            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
-            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
-            Name (_STA, 0x0B)  // _STA: Status
-            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
-            {
-                IO (Decode16,
-                    0xAE00,             // Range Minimum
-                    0xAE00,             // Range Maximum
-                    0x01,               // Alignment
-                    0x14,               // Length
-                    )
-            })
-        }
     }

     Scope (\)
     {
         Name (_S3, Package (0x04)  // _S3_: S3 System State
         {
             One,
             One,
             Zero,
             Zero
         })
         Name (_S4, Package (0x04)  // _S4_: S4 System State
         {
             0x02,
             0x02,
             Zero,
@@ -831,479 +777,48 @@
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 IO (Decode16,
                     0x0510,             // Range Minimum
                     0x0510,             // Range Maximum
                     0x01,               // Alignment
                     0x0C,               // Length
                     )
             })
         }
     }

     Scope (\_SB)
     {
         Scope (PCI0)
         {
-            Name (BSEL, Zero)
             Device (S00)
             {
                 Name (_ADR, Zero)  // _ADR: Address
             }

             Device (S10)
             {
                 Name (_ADR, 0x00020000)  // _ADR: Address
                 Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                 {
                     Return (Zero)
                 }
             }

             Device (S18)
             {
                 Name (_ADR, 0x00030000)  // _ADR: Address
             }
-
-            Device (S20)
-            {
-                Name (_SUN, 0x04)  // _SUN: Slot User Number
-                Name (_ADR, 0x00040000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S28)
-            {
-                Name (_SUN, 0x05)  // _SUN: Slot User Number
-                Name (_ADR, 0x00050000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S30)
-            {
-                Name (_SUN, 0x06)  // _SUN: Slot User Number
-                Name (_ADR, 0x00060000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S38)
-            {
-                Name (_SUN, 0x07)  // _SUN: Slot User Number
-                Name (_ADR, 0x00070000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S40)
-            {
-                Name (_SUN, 0x08)  // _SUN: Slot User Number
-                Name (_ADR, 0x00080000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S48)
-            {
-                Name (_SUN, 0x09)  // _SUN: Slot User Number
-                Name (_ADR, 0x00090000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S50)
-            {
-                Name (_SUN, 0x0A)  // _SUN: Slot User Number
-                Name (_ADR, 0x000A0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S58)
-            {
-                Name (_SUN, 0x0B)  // _SUN: Slot User Number
-                Name (_ADR, 0x000B0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S60)
-            {
-                Name (_SUN, 0x0C)  // _SUN: Slot User Number
-                Name (_ADR, 0x000C0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S68)
-            {
-                Name (_SUN, 0x0D)  // _SUN: Slot User Number
-                Name (_ADR, 0x000D0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S70)
-            {
-                Name (_SUN, 0x0E)  // _SUN: Slot User Number
-                Name (_ADR, 0x000E0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S78)
-            {
-                Name (_SUN, 0x0F)  // _SUN: Slot User Number
-                Name (_ADR, 0x000F0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S80)
-            {
-                Name (_SUN, 0x10)  // _SUN: Slot User Number
-                Name (_ADR, 0x00100000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S88)
-            {
-                Name (_SUN, 0x11)  // _SUN: Slot User Number
-                Name (_ADR, 0x00110000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S90)
-            {
-                Name (_SUN, 0x12)  // _SUN: Slot User Number
-                Name (_ADR, 0x00120000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (S98)
-            {
-                Name (_SUN, 0x13)  // _SUN: Slot User Number
-                Name (_ADR, 0x00130000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SA0)
-            {
-                Name (_SUN, 0x14)  // _SUN: Slot User Number
-                Name (_ADR, 0x00140000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SA8)
-            {
-                Name (_SUN, 0x15)  // _SUN: Slot User Number
-                Name (_ADR, 0x00150000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SB0)
-            {
-                Name (_SUN, 0x16)  // _SUN: Slot User Number
-                Name (_ADR, 0x00160000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SB8)
-            {
-                Name (_SUN, 0x17)  // _SUN: Slot User Number
-                Name (_ADR, 0x00170000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SC0)
-            {
-                Name (_SUN, 0x18)  // _SUN: Slot User Number
-                Name (_ADR, 0x00180000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SC8)
-            {
-                Name (_SUN, 0x19)  // _SUN: Slot User Number
-                Name (_ADR, 0x00190000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SD0)
-            {
-                Name (_SUN, 0x1A)  // _SUN: Slot User Number
-                Name (_ADR, 0x001A0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SD8)
-            {
-                Name (_SUN, 0x1B)  // _SUN: Slot User Number
-                Name (_ADR, 0x001B0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SE0)
-            {
-                Name (_SUN, 0x1C)  // _SUN: Slot User Number
-                Name (_ADR, 0x001C0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SE8)
-            {
-                Name (_SUN, 0x1D)  // _SUN: Slot User Number
-                Name (_ADR, 0x001D0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SF0)
-            {
-                Name (_SUN, 0x1E)  // _SUN: Slot User Number
-                Name (_ADR, 0x001E0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Device (SF8)
-            {
-                Name (_SUN, 0x1F)  // _SUN: Slot User Number
-                Name (_ADR, 0x001F0000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
-
-            Method (DVNT, 2, NotSerialized)
-            {
-                If ((Arg0 & 0x10))
-                {
-                    Notify (S20, Arg1)
-                }
-
-                If ((Arg0 & 0x20))
-                {
-                    Notify (S28, Arg1)
-                }
-
-                If ((Arg0 & 0x40))
-                {
-                    Notify (S30, Arg1)
-                }
-
-                If ((Arg0 & 0x80))
-                {
-                    Notify (S38, Arg1)
-                }
-
-                If ((Arg0 & 0x0100))
-                {
-                    Notify (S40, Arg1)
-                }
-
-                If ((Arg0 & 0x0200))
-                {
-                    Notify (S48, Arg1)
-                }
-
-                If ((Arg0 & 0x0400))
-                {
-                    Notify (S50, Arg1)
-                }
-
-                If ((Arg0 & 0x0800))
-                {
-                    Notify (S58, Arg1)
-                }
-
-                If ((Arg0 & 0x1000))
-                {
-                    Notify (S60, Arg1)
-                }
-
-                If ((Arg0 & 0x2000))
-                {
-                    Notify (S68, Arg1)
-                }
-
-                If ((Arg0 & 0x4000))
-                {
-                    Notify (S70, Arg1)
-                }
-
-                If ((Arg0 & 0x8000))
-                {
-                    Notify (S78, Arg1)
-                }
-
-                If ((Arg0 & 0x00010000))
-                {
-                    Notify (S80, Arg1)
-                }
-
-                If ((Arg0 & 0x00020000))
-                {
-                    Notify (S88, Arg1)
-                }
-
-                If ((Arg0 & 0x00040000))
-                {
-                    Notify (S90, Arg1)
-                }
-
-                If ((Arg0 & 0x00080000))
-                {
-                    Notify (S98, Arg1)
-                }
-
-                If ((Arg0 & 0x00100000))
-                {
-                    Notify (SA0, Arg1)
-                }
-
-                If ((Arg0 & 0x00200000))
-                {
-                    Notify (SA8, Arg1)
-                }
-
-                If ((Arg0 & 0x00400000))
-                {
-                    Notify (SB0, Arg1)
-                }
-
-                If ((Arg0 & 0x00800000))
-                {
-                    Notify (SB8, Arg1)
-                }
-
-                If ((Arg0 & 0x01000000))
-                {
-                    Notify (SC0, Arg1)
-                }
-
-                If ((Arg0 & 0x02000000))
-                {
-                    Notify (SC8, Arg1)
-                }
-
-                If ((Arg0 & 0x04000000))
-                {
-                    Notify (SD0, Arg1)
-                }
-
-                If ((Arg0 & 0x08000000))
-                {
-                    Notify (SD8, Arg1)
-                }
-
-                If ((Arg0 & 0x10000000))
-                {
-                    Notify (SE0, Arg1)
-                }
-
-                If ((Arg0 & 0x20000000))
-                {
-                    Notify (SE8, Arg1)
-                }
-
-                If ((Arg0 & 0x40000000))
-                {
-                    Notify (SF0, Arg1)
-                }
-
-                If ((Arg0 & 0x80000000))
-                {
-                    Notify (SF8, Arg1)
-                }
-            }
-
-            Method (PCNT, 0, NotSerialized)
-            {
-                BNUM = Zero
-                DVNT (PCIU, One)
-                DVNT (PCID, 0x03)
-            }
         }
     }
 }

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/pc/DSDT.hpbrroot            | Bin 0 -> 2953 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot

diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/pc/DSDT.hpbrroot
new file mode 100644
index 0000000000000000000000000000000000000000..14518bb843059a0db1d216543f632d5a00c1a695
GIT binary patch
literal 2953
zcmb7GUvJY^6hAk1igTSbPV23RzC;B!4JL3BhLH9`Vy8*gBz5DIZE__$ZO{Tj!U8Js
zM`&q~pzww=rakN-RC(`5*ggUufqez0L7&LZv71oRR02zJ?mhS1^ZT7Y_xc!?QGY4}
zu$|npUbK?ApG@6A83O<s)4x&@*T8NYxq`#wkjU&U*&pL8C#l~Wxzz&uqvihYx_6$q
ztl`1>j`Cu?;XT@R*MXEa*FDZ@pe#66&apf5re4w{r&uzg*;ibUoUBm;$yqHKpj4zl
zCodJve0`|IP>Gi9cG0X?APVs6y$qtgrO<r#O1^3&&6?pP)r*c*&w@u1*CSEmzRMN2
z7k%D!q3g<nK_7b4&$|uytr3NP{tNe^&*PG#*Q`W>Pd|>J$7mcxfP0{Pb&l8&UAuFl
zWMv(nE5b9RVqVbn5O=w#ROikMLq*cEI~SI61}X<G3dkN=4PlP+FAB^B7Z@wBCN%MX
zA%tjl=Tv2Rb+ju!`_V3mhZjI0t*o?Y=%e@@!^jc&d49aW-Ux355DV;`@J;}>a2d{s
zzTwnj*~|{(yl9kWk_zxJU*;O)yFA2C<8Ow~^8vrX-|{$@BxljcC+4_H6>#tg;l%Ew
z%Vs?_bWaR&$3CK~@K}M}748a>w9xiBr1j;>XipfmF`*Oo><N1UNDGR;=X9;Ej{+j^
zd+M9^zyl^N0K+U*G3hx+S>lu^)!>d<tAjTaYP%jZc5;yy4c_+dH+Trvy$81%>%axr
z=qcR|REl7t%he?Vn!Quq4c1F^8(bWTEoi=sjb>R?N_01PXe7z)ON5a`ho<-N-a1zR
zOAWT00N#TJ;%zq>c+G9M0h^7!Yj2%8FA!U*7OEp=)>bqLUnzQ}>6MYx+0u$tXT8V+
z-fm%;M*3V<FP2vHS_BnpT4I{ZPp2T_=ja|hBN-3lyVR3kw9w}kjr%0FJLO~OCe}bu
zl2I&qI#3eE%1V66XP-_(L<nPYIsWiQ!0@Ya|19;11kqCyj#0AUA&q(4m&B>`05$ZQ
zKc91~n#G>A0v34wY9*5IqvyuZG5ep4o;rY@^3hYs?;v_gos6EcI~DR>A4BJ%&wx)K
zfKU7I=`r~95%B4Kcw-zMFNII`K63y*<HKjh;4??SXY9_hh~8V{@L~WzEFrr0Fy)aT
z<ydD^ezH|Lh%r$`5oK2?`^U}h=zQ(NwP)7yBM3g_7gtO-SChq?cf1>$za(#6y?t}@
z*2dM_U^Cq;FYTY@80Q5ByRgfmc(q|sVZF<+%cJ(zNt$FKshjyK(@Ry0>9xugrssdq
z7>K%FF(i9yhLi-|%9oR<X=Lk3HR_bACCLL4qVs3h{5u@E1pH!I-7INZN+Slr7bvVI
z^!nn@p&swH;IXc0+BLN}r6YR8KDl;Y9A53@BXJ)Lyw<oF!8~w#C%WSc#NOj^*Z%s@
zN_na8s+BN#^m#yR+!R`vXkRT(>y}=Xj&g&!J6XBwGNkUoxKWI7uOJ?B$j=0ZYg`?J
z&%8s-P}^hf%O$Z_JZ#F(=VVh{IBW~m(bi-~D-nI!sz;A<bYi{^kwuTaYZLtPcxYTo
zs@KPb7=nrH>_?ZVs_=;6g9VC}CH1Mkum&sHdP3$BNYqr|>a>G?$m9&Pu3cB>v3v_=
z-pOleOpxDYP$^SZ6_r-}bG={G+C@+b@u1*?9*a7I%bfqY9fJ_IE%*%Rg^kBvbT7&z
zl(VQnqIbBw7ah%G`1Jz#_sJYUuuflw!GOLD^n}1)8FmNKVDQ)bVCC<(&(40>6Uazy
zFc|zgR1c)krhn>abP*j1I+~bSHMJ}{5?mo9KX7*hEruL)JpSGBdiV7%6R`>SW(~Jk
z8E0lnWQc>~3(kxrVq=3X3(mfy6#`Vg{}3R%b8hiReKCmPO1`p+SxS>Oc54Swl&}(}
z8%imL*Zf}NayV!TWlPh7rV!mYW2N>d7|Rf-XeVVr-yfuhgA5JqPTWde3O1sy0RICI
C_`Dwg

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dea61d94f1..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT.hpbrroot",
-- 
2.17.1



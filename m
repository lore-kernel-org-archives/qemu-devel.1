Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622FBC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7A12075E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="DPWm/LIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7A12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNErL-0000mQ-Hs
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNEmE-0005Ck-Sp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:38 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNEmB-0007mT-1y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:30:38 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b17so2562602pji.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y1yEoYjrtjiUHxSnshYe3IcGImchCLVXVbGhASu8LxY=;
 b=DPWm/LIiQvCuU3KALmNp9DEYC92Rys+/lULPmnpP8o+YIFZDcqPkT97sOHso1djgpv
 V3wvjXPQ8WjtBrBFzlN/cCL8BpWYm6DsMEb3d5wDLJNNwPqiNFTnmV1Nsu/bYi2UtAai
 Ppt/Nmy4lRzo44wyuffMDbviSZeUduj7dClXSaxRnBv/eZGNjrGuQgiDNZrjFM2WHYNj
 v48ZZFDm5mYDyUWr1RMN2IBy2qkGstx3AzVhVdEgl1ZCkyUZZbKdQefvXSbZ7Eg6mAPG
 iaAXFIpzJ3meTBqviysnvfgcuxjIsfKVR7SfS1sdv//b5AVf3muMhMm29e0TAORLmjot
 xAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y1yEoYjrtjiUHxSnshYe3IcGImchCLVXVbGhASu8LxY=;
 b=O1N56ANRe4o2EFL+ESf1vrI1DL3d6Qjw9GIiJO2ya2RXfcxeTSxgPAGm9E+Un322zb
 Yi2UV+mMbsORX50uMWHqpEhn5Ge4QPiQpDhkM2twih1TCGoTghaDNgsp8aH02tncS7pB
 dZdtGObDuszJgh9IHEvbC8sdm8qSJWRpd8WSSDUU8Nkr+dlTyihv0N4T3CzdirK16WdE
 yOVJQxY9HoFnxHQS+/SapYJZIrYSpCRVInwYgzbwEKnKh2KSNJDv0rQAGzm/6F5KgBLL
 cttETzgsig6D6x67gp1cP2nzxJapD1U53bNkmGLdV3SfQGt6y+wQkOdUqQE7aRt7zGmb
 ddww==
X-Gm-Message-State: AOAM531O8NDs92cv0O0Me43886oBmdNvsl4ECxn02MvGiwpBc1VV/mMw
 TG22jY5ZMMH9zOKyk4G+6zWfFA==
X-Google-Smtp-Source: ABdhPJzoV+BsTm25s1AO46Y8l8g8XKDOlZA/3/RhOfDPgKg0sSx7U8P7+FQZS0ZcDqz8/vhv93XsGw==
X-Received: by 2002:a17:90a:e64f:: with SMTP id
 ep15mr3872178pjb.194.1601382630376; 
 Tue, 29 Sep 2020 05:30:30 -0700 (PDT)
Received: from localhost.localdomain ([115.96.125.11])
 by smtp.googlemail.com with ESMTPSA id 16sm4359035pjl.27.2020.09.29.05.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 05:30:29 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/acpi: add DSDT.hpbrroot DSDT table blob to test
 global i440fx hotplug
Date: Tue, 29 Sep 2020 18:00:11 +0530
Message-Id: <20200929123011.31836-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929123011.31836-1-ani@anisinha.ca>
References: <20200929123011.31836-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 jusual@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a new DSDT golden master table blob to test disabling
hotplug on both pci root bus and pci bridges. Also reverts the change
in file bios-tables-test-allowed-diff.h to make sure its now empty so that
future modifications to acpi tables can be caught.

The following is the disassembled diff between DSDT.hpbridge and DSDT.hpbrroot:

@@ -5,13 +5,13 @@
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29 17:51:04 2020
+ * Disassembly of tests/data/acpi/pc/DSDT.hpbrroot, Tue Sep 29 17:50:00 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000139D (5021)
+ *     Length           0x00000C07 (3079)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x05
+ *     Checksum         0xAD
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -247,38 +247,6 @@
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
@@ -737,12 +705,6 @@
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
@@ -813,22 +775,6 @@
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
@@ -878,7 +824,6 @@
     {
         Scope (PCI0)
         {
-            Name (BSEL, Zero)
             Device (S00)
             {
                 Name (_ADR, Zero)  // _ADR: Address
@@ -907,436 +852,6 @@
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
 tests/data/acpi/pc/DSDT.hpbrroot            | Bin 0 -> 3079 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot

changelog:
changes since v10:
updated binary blob for DSDT.hpbrroot and also updated the diff in
the commit log to match.

diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/pc/DSDT.hpbrroot
new file mode 100644
index 0000000000000000000000000000000000000000..36b0a8f2fbf93df47b66107125cd3ce01e017b92
GIT binary patch
literal 3079
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
X(DMe#!5~Egt372VF8CW!SAhQk!%yZP

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



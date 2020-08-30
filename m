Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EBBC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F7820714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="zNHHOkqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F7820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCKAl-0008VX-64
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7o-0005PY-Np
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:49 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7m-00043S-8E
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:48 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mw10so1519041pjb.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kfpCpGp/mL+H/UxufHlUBynuOAjh9squgpXLIIoOGdU=;
 b=zNHHOkqU0MIbIHqY1KXsgtznkXidRIqwBkOkWYZyWW2twaMmPBzXq9uNKbmtJaz3Bs
 tFJ9z812WBBbtgfintRh7q1aerd65ATtDSqV9ZiLmPElmugUuqO7AIJfKEnadJM0KGA3
 jjBrTag4VWrHNmtouMRn3xTG9s2aXbsWatznUvtZxc8n7AB/lpK8l9wHou2bwz2w1a0A
 Cp7eR6VWFT6rblWaMxbKqk9SiTtwAAxtYuxOxzbii1uECa7MlKjf7aEwU9cTFPFQ1lg0
 w5SVx3EeAWgAy+VJwlU3XihLS9Cck9QWKAQ8okiNYtL9u49fxQsaHs7oHGQTzOoDfEr/
 xijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kfpCpGp/mL+H/UxufHlUBynuOAjh9squgpXLIIoOGdU=;
 b=E7qBamkl+cipR6YKONNpwtEb7RHuZvxmca3oAm9SZ3qnwd4xjqRsXsNp2Gy83yE2yH
 ZdLueQShXygJo27UpjSNvmF8juNHViwU12m8qk75eiGQAV/7lMR/gR5l9Zig3yxEVHi5
 qu17B3UDVhJM9GB+Yqg5ob2tjwtHRYl26OLenm2jThjeLiGF9VFl7M3HFXPzhDghrOCw
 fI6AMsVxUEa2v1IwChoGRA6IEaFFpJYd1gEWjuqWGzArlnpH41XZbZvYfjkBTmHZM4s3
 IVAtvndgWuVSIS1yqHNkECOg9dThIAgz5dLGSujB0iGyTlaKai0bL4wlYUYTeXHFk6LZ
 HsYA==
X-Gm-Message-State: AOAM5313ywfboi3Tce9XrudGVWF1CxaiHMhNkrO5vdWESPK0EogiWdWs
 NmKPEkqsW+yISyJ7LV77syqhU/r94xKtIg==
X-Google-Smtp-Source: ABdhPJzERvwGHG/EDXtrd3MYDmBhu5ULK8LCZhDA7ZV46s0Pc+zVEVBfUIB+nsjal1CvxouUKzo+Gw==
X-Received: by 2002:a17:90b:1093:: with SMTP id
 gj19mr6164785pjb.149.1598781584405; 
 Sun, 30 Aug 2020 02:59:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.143.103])
 by smtp.googlemail.com with ESMTPSA id c143sm4773722pfb.84.2020.08.30.02.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 02:59:43 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/acpi: add a new ACPI table in order to test root
 pci hotplug on/off
Date: Sun, 30 Aug 2020 15:29:14 +0530
Message-Id: <20200830095915.14402-4-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830095915.14402-1-ani@anisinha.ca>
References: <20200830095915.14402-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary ACPI table tests/data/acpi/pc/DSDT.roothp is added in order
to unit test hotplug on/off capability on the root pci bus for i440fx.
The diff between the table DSDT and DSDT.roothp is listed below:

--- /tmp/asl-7VRVP0.dsl	2020-08-30 12:01:53.992010411 +0530
+++ /tmp/asl-96QVP0.dsl	2020-08-30 12:01:53.988010392 +0530
@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20180105 (64-bit version)
  * Copyright (c) 2000 - 2018 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT, Sun Aug 30 12:01:53 2020
+ * Disassembly of /tmp/aml-W5QVP0, Sun Aug 30 12:01:53 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001346 (4934)
+ *     Length           0x00000C8F (3215)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xBF
+ *     Checksum         0x3D
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

@@ -831,489 +831,47 @@
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

-            Device (S18)
-            {
-                Name (_SUN, 0x03)  // _SUN: Slot User Number
-                Name (_ADR, 0x00030000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
-            }
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
-                If ((Arg0 & 0x08))
-                {
-                    Notify (S18, Arg1)
-                }
-
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
             Method (PCNT, 0, NotSerialized)
             {
-                BNUM = Zero
-                DVNT (PCIU, One)
-                DVNT (PCID, 0x03)
             }
         }
     }
 }

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/data/acpi/pc/DSDT.roothp              | Bin 0 -> 3215 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
new file mode 100644
index 0000000000000000000000000000000000000000..ddabd997794b698e64efa43c58f40af35a7aebbd
GIT binary patch
literal 3215
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
XTq2;OoRkTjV3O`lrh>^3B?9~pFwX-n

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ac864fc982..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1



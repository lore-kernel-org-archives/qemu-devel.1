Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11456C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9323220684
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="12L1Y0Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9323220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQuU-0000pQ-LR
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQi9-0002XT-8v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:33 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQi6-0005nw-7g
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:32 -0400
Received: by mail-pj1-x1043.google.com with SMTP id u3so994271pjr.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ARrqKiw0ZI71X/nMn8SUrP42xKqFqGltw1z766gv2gQ=;
 b=12L1Y0Tl3SLjKNYPGT3G9NLqIuCsvYdGfr5MT2wnVjgHQ+s1REQ89sT+EKrb/3Sjzc
 P4LtZ3GtXjI/t7VA4VsN/YSpc136mScDY6/egTM2SVRzKCQ15L2M1TlZeq8PSaTXLUse
 ZsZzREbic+0rcnWEh4uiAGHoqsSX+peaKiitlrItnnMa5qRvY8H5YFFnP8j2aGBfdhkD
 0X73wWYft9uSKwqWSdDaImz1NP0gDlKCy4XCouHFnwfIYUzUjGgWzjSbWjHzeVopc66+
 soGlG6LIcudX8E/gyABHOTmmJ4VR+QQWZ1S4919BrxntSkbjWGBnnWsCo/lHB8xxrZOo
 o1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ARrqKiw0ZI71X/nMn8SUrP42xKqFqGltw1z766gv2gQ=;
 b=dZ6MRp+LsucXF2JyVaGpiWFQdlPebiHLHzQ4VhrMU0oRzKugXfutTJs9a/DWgu61lA
 GhoRuiE4FhTj3+dhUjU0tYS29eQR/tErbF24f2bjYmzXR/fm4qIcmE4+oU/YPEfjdhBL
 lonkr0dIkW56qkBd24LeCIPaM0euMd9Y5fpgXg3dwoCylkzAbuYAwLJZmavL7E2sSJfb
 C5u40g20vlNM6Nu9mALtDpfd2c2H3C44pHGxfmRchymVkonbM//lDigNbqCDLo1WsNyo
 TqBMemaZEwteG1zxF3sttvfR2EGN3tjyB11iRDCi2Qecdg9QfANP8RZojFLaJesNi4y/
 mcRw==
X-Gm-Message-State: AOAM533sAatZ4gn+Qa4J7+nahkrIdUow3lwO5ugEAwp9083yfEj4Jdr1
 /mzH4DwTLMMHgXXVhlBL1IGwlNQsCVZoAP/s
X-Google-Smtp-Source: ABdhPJz4wt2LpDp6RB5a53NboArCY2Y6yyJe90a38U0ejT0hP5HlqUmehyojLz8BHWwnzBoWfiXEYg==
X-Received: by 2002:a17:90a:bd8b:: with SMTP id
 z11mr2700085pjr.2.1600236868285; 
 Tue, 15 Sep 2020 23:14:28 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:27 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/11] tests/acpi: add newly added acpi DSDT table blob for
 pci bridge hotplug flag
Date: Wed, 16 Sep 2020 11:43:32 +0530
Message-Id: <20200916061335.14045-9-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a binary blob corresponding to the DSDT acpi table. It is used
to unit test the flag 'acpi-pci-hotplug-with-bridge-support' used with pci
bridges.

This change also clears the file tests/qtest/bios-tables-test-allowed-diff.h
so that future changes which affect the table can be caught.

The following is the diff between files tests/data/acpi/pc/DSDT.bridge and
tests/data/acpi/pc/DSDT.hpbridge after disassembly :

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20180105 (64-bit version)
  * Copyright (c) 2000 - 2018 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep 11 23:21:34 2020
+ * Disassembly of /tmp/aml-7UURQ0, Fri Sep 11 23:21:34 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A89 (6793)
+ *     Length           0x0000131F (4895)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x09
+ *     Checksum         0xF9
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

@@ -859,522 +859,32 @@
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
-                Name (BSEL, One)
-                Device (S00)
-                {
-                    Name (_SUN, Zero)  // _SUN: Slot User Number
-                    Name (_ADR, Zero)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S08)
-                {
-                    Name (_SUN, One)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00010000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S10)
-                {
-                    Name (_SUN, 0x02)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00020000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S18)
-                {
-                    Name (_SUN, 0x03)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00030000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S20)
-                {
-                    Name (_SUN, 0x04)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00040000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S28)
-                {
-                    Name (_SUN, 0x05)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00050000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S30)
-                {
-                    Name (_SUN, 0x06)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00060000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S38)
-                {
-                    Name (_SUN, 0x07)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00070000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S40)
-                {
-                    Name (_SUN, 0x08)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00080000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S48)
-                {
-                    Name (_SUN, 0x09)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00090000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S50)
-                {
-                    Name (_SUN, 0x0A)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000A0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S58)
-                {
-                    Name (_SUN, 0x0B)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000B0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S60)
-                {
-                    Name (_SUN, 0x0C)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000C0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S68)
-                {
-                    Name (_SUN, 0x0D)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000D0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S70)
-                {
-                    Name (_SUN, 0x0E)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000E0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S78)
-                {
-                    Name (_SUN, 0x0F)  // _SUN: Slot User Number
-                    Name (_ADR, 0x000F0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S80)
-                {
-                    Name (_SUN, 0x10)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00100000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S88)
-                {
-                    Name (_SUN, 0x11)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00110000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S90)
-                {
-                    Name (_SUN, 0x12)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00120000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (S98)
-                {
-                    Name (_SUN, 0x13)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00130000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SA0)
-                {
-                    Name (_SUN, 0x14)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00140000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SA8)
-                {
-                    Name (_SUN, 0x15)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00150000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SB0)
-                {
-                    Name (_SUN, 0x16)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00160000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SB8)
-                {
-                    Name (_SUN, 0x17)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00170000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SC0)
-                {
-                    Name (_SUN, 0x18)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00180000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SC8)
-                {
-                    Name (_SUN, 0x19)  // _SUN: Slot User Number
-                    Name (_ADR, 0x00190000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SD0)
-                {
-                    Name (_SUN, 0x1A)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001A0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SD8)
-                {
-                    Name (_SUN, 0x1B)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001B0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SE0)
-                {
-                    Name (_SUN, 0x1C)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001C0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SE8)
-                {
-                    Name (_SUN, 0x1D)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001D0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SF0)
-                {
-                    Name (_SUN, 0x1E)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001E0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Device (SF8)
-                {
-                    Name (_SUN, 0x1F)  // _SUN: Slot User Number
-                    Name (_ADR, 0x001F0000)  // _ADR: Address
-                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                    {
-                        PCEJ (BSEL, _SUN)
-                    }
-                }
-
-                Method (DVNT, 2, NotSerialized)
-                {
-                    If ((Arg0 & One))
-                    {
-                        Notify (S00, Arg1)
-                    }
-
-                    If ((Arg0 & 0x02))
-                    {
-                        Notify (S08, Arg1)
-                    }
-
-                    If ((Arg0 & 0x04))
-                    {
-                        Notify (S10, Arg1)
-                    }
-
-                    If ((Arg0 & 0x08))
-                    {
-                        Notify (S18, Arg1)
-                    }
-
-                    If ((Arg0 & 0x10))
-                    {
-                        Notify (S20, Arg1)
-                    }
-
-                    If ((Arg0 & 0x20))
-                    {
-                        Notify (S28, Arg1)
-                    }
-
-                    If ((Arg0 & 0x40))
-                    {
-                        Notify (S30, Arg1)
-                    }
-
-                    If ((Arg0 & 0x80))
-                    {
-                        Notify (S38, Arg1)
-                    }
-
-                    If ((Arg0 & 0x0100))
-                    {
-                        Notify (S40, Arg1)
-                    }
-
-                    If ((Arg0 & 0x0200))
-                    {
-                        Notify (S48, Arg1)
-                    }
-
-                    If ((Arg0 & 0x0400))
-                    {
-                        Notify (S50, Arg1)
-                    }
-
-                    If ((Arg0 & 0x0800))
-                    {
-                        Notify (S58, Arg1)
-                    }
-
-                    If ((Arg0 & 0x1000))
-                    {
-                        Notify (S60, Arg1)
-                    }
-
-                    If ((Arg0 & 0x2000))
-                    {
-                        Notify (S68, Arg1)
-                    }
-
-                    If ((Arg0 & 0x4000))
-                    {
-                        Notify (S70, Arg1)
-                    }
-
-                    If ((Arg0 & 0x8000))
-                    {
-                        Notify (S78, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00010000))
-                    {
-                        Notify (S80, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00020000))
-                    {
-                        Notify (S88, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00040000))
-                    {
-                        Notify (S90, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00080000))
-                    {
-                        Notify (S98, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00100000))
-                    {
-                        Notify (SA0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00200000))
-                    {
-                        Notify (SA8, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00400000))
-                    {
-                        Notify (SB0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x00800000))
-                    {
-                        Notify (SB8, Arg1)
-                    }
-
-                    If ((Arg0 & 0x01000000))
-                    {
-                        Notify (SC0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x02000000))
-                    {
-                        Notify (SC8, Arg1)
-                    }
-
-                    If ((Arg0 & 0x04000000))
-                    {
-                        Notify (SD0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x08000000))
-                    {
-                        Notify (SD8, Arg1)
-                    }
-
-                    If ((Arg0 & 0x10000000))
-                    {
-                        Notify (SE0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x20000000))
-                    {
-                        Notify (SE8, Arg1)
-                    }
-
-                    If ((Arg0 & 0x40000000))
-                    {
-                        Notify (SF0, Arg1)
-                    }
-
-                    If ((Arg0 & 0x80000000))
-                    {
-                        Notify (SF8, Arg1)
-                    }
-                }
-
-                Method (PCNT, 0, NotSerialized)
-                {
-                    BNUM = One
-                    DVNT (PCIU, One)
-                    DVNT (PCID, 0x03)
-                }
             }

             Device (S20)
             {
                 Name (_SUN, 0x04)  // _SUN: Slot User Number
                 Name (_ADR, 0x00040000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }

             Device (S28)
             {
                 Name (_SUN, 0x05)  // _SUN: Slot User Number
                 Name (_ADR, 0x00050000)  // _ADR: Address
@@ -1779,22 +1289,21 @@
                 If ((Arg0 & 0x40000000))
                 {
                     Notify (SF0, Arg1)
                 }

                 If ((Arg0 & 0x80000000))
                 {
                     Notify (SF8, Arg1)
                 }
             }

             Method (PCNT, 0, NotSerialized)
             {
                 BNUM = Zero
                 DVNT (PCIU, One)
                 DVNT (PCID, 0x03)
-                ^S18.PCNT ()
             }
         }
     }
 }

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/data/acpi/pc/DSDT.hpbridge            | Bin 0 -> 4895 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge

diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
new file mode 100644
index 0000000000000000000000000000000000000000..b0751398541bdf88ce405be9742aeba0b375dbc3
GIT binary patch
literal 4895
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
S66ohVtr{L;J8bx3aOwYF+mJl~

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 96a9237355..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT.hpbridge",
-- 
2.17.1



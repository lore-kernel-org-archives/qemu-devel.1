Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1241C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDA920757
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="17gqgFsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDA920757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEVYY-0005YN-NK
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 06:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVXo-0004ze-L6
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:36344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVXm-00040T-1j
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id m8so6007724pfh.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=z7BX5XuG5iEZqoDahY/O/X9PCHt6zYvr3byrSIWrzSk=;
 b=17gqgFsFP3xG7LbveD9aux1HDud1gAvlETuvHeYA2hkezWbRIP2Vd1mBHzbmhGBjNo
 JB5vtIQMekXGZNPlNQfgS0e/w3xn+a4yMylaa6t4Gy/ldlKkX/evKxHXO0PSZRVl9I63
 K+vqdiolweTx7FTK7h3MXl74oqeqh3obnxvjU6M69NosSwkTrFH18y5hUlqQYdcIDp9L
 Ds/whu79QiZnupKfH8mkWNSoRG5qyRxa5B3HwgelaIU6Gov9cXOoVyRhuo5TPaQjlRLB
 Vm/C8oi9iFjJnbJVUkXfL1ZSdKt2KAWzkB9aswJSmlCge28NcEuotNcxUUYjB81TG34y
 Zt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=z7BX5XuG5iEZqoDahY/O/X9PCHt6zYvr3byrSIWrzSk=;
 b=PzAriM4aN6OyCQirQXq312D1unv4Ti0Dr1/t9t2qYOVtS6t4IavWM1TZ9lGc83nFSg
 DuMhsrZqWJ+5pvFHDLLz4nNvZaSS01XtH4TaT9+VZqW9UdWo0l+ZK7Twag1gAa61K618
 MM9zlhilyr9fEs2eZGk4Q16KlKYChgwUFZsXPt2aHFcanBXK/0ZYCo6EG7FGKNqs72+R
 ljrW5SvJfmIbNBezzPV/GNsZgNLKV9YF8Dn5v6sEr8XZrgWeDhTogSsdOx79xPy+n+jJ
 OEs560CLkr3TU9xC9EjPUReokW+ygsRQpThc64WqhPnF+5zGfaRISJr5CYpXZ4P8NgWE
 uaBA==
X-Gm-Message-State: AOAM531HUQBXxzkCYn2Mt5y9i13ypSB/YuCzw0+hrId/X+diMS11bNxx
 /+UhQOrUYjoAB6hLSbCoq0W16b8Evj0J3w==
X-Google-Smtp-Source: ABdhPJzSkCeHUgFRmi11yjJiQJMc3RTfslSwiGf7hwZDP5udMHcbCw023wA7YG0K0lPSf0iwI+HGSg==
X-Received: by 2002:a63:cd4f:: with SMTP id a15mr8334028pgj.416.1599302135137; 
 Sat, 05 Sep 2020 03:35:35 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.214])
 by smtp.googlemail.com with ESMTPSA id k24sm9200643pfg.148.2020.09.05.03.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 03:35:33 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/3] unit tests for change 'do not add hotplug related amls
 for cold plugged bridges'
Date: Sat,  5 Sep 2020 16:05:17 +0530
Message-Id: <20200905103520.12626-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x432.google.com
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 jusual@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following patchset adds the unit test for the change:
f80ba9e599 ("tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag")

Please compare the diff of the DSDT table attached with the commit log with the following diff which
was generated before appplying the above change. The major difference between the diffs are the absence
of the following lines in the diff corresponding to this change:

+                Name (_SUN, 0x03)  // _SUN: Slot User Number
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
+                    PCEJ (BSEL, _SUN)

+                If ((Arg0 & 0x08))
+                {
+                    Notify (S18, Arg1)
+                }
+

These are hotplug related amls which were present for slot 3 in the root pci bus before this change was applied.
With the change, these amls have been removed. Hence, slot 3 where the bridge is attached is no longer hotplug
capable.

--Ani

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20180105 (64-bit version)
  * Copyright (c) 2000 - 2018 Intel Corporation
  * 
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep  4 11:08:58 2020
+ * Disassembly of /tmp/aml-IEQEQ0, Fri Sep  4 11:08:58 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A89 (6793)
+ *     Length           0x00001346 (4934)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x08
+ *     Checksum         0xBF
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
 
@@ -859,521 +859,36 @@
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
+                Name (_SUN, 0x03)  // _SUN: Slot User Number
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
-                    BNUM = One
-                    DVNT (PCIU, One)
-                    DVNT (PCID, 0x03)
+                    PCEJ (BSEL, _SUN)
                 }
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
@@ -1633,32 +1148,37 @@
                     PCEJ (BSEL, _SUN)
                 }
             }
 
             Device (SF8)
             {
                 Name (_SUN, 0x1F)  // _SUN: Slot User Number
                 Name (_ADR, 0x001F0000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }
 
             Method (DVNT, 2, NotSerialized)
             {
+                If ((Arg0 & 0x08))
+                {
+                    Notify (S18, Arg1)
+                }
+
                 If ((Arg0 & 0x10))
                 {
                     Notify (S20, Arg1)
                 }
 
                 If ((Arg0 & 0x20))
                 {
                     Notify (S28, Arg1)
                 }
 
                 If ((Arg0 & 0x40))
                 {
                     Notify (S30, Arg1)
                 }
 
                 If ((Arg0 & 0x80))
@@ -1779,22 +1299,21 @@
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
 

***

Ani Sinha (3):
  tests/acpi: list added acpi table binary file for pci bridge hotplug
    test
  tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
    bridge flag
  tests/acpi: add newly added acpi DSDT table blob for pci bridge
    hotplug flag

 tests/data/acpi/pc/DSDT.hpbridge | Bin 0 -> 4895 bytes
 tests/qtest/bios-tables-test.c   |  15 +++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge

-- 
2.17.1



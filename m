Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A07C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EED42075E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flL6/AED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EED42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAOB-0005nn-JR
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yK-0004Ur-TX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yF-0001nt-SN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+sv9RBb+rSSUYGpqVIUdbSPEVOUodQITcJ1XA2UhV4=;
 b=flL6/AEDeU7hW6UApW5k9N+g4JMJUsxqvgQ7EOulOMhZ3FWTKeTQTwHouULK3KTRSZycX6
 lxU6O3rNFjPDwyRh8JGNgxq6osggNTZ05p/1Zh2zUjXW4TK7TbE0wwKqH0nyZnK0yoqiLo
 nhgJtm7MfufKXhpNGZ2N8Bwg6AMmtJQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-UeVM2Z5SNOWWS3fRhDXsXw-1; Tue, 29 Sep 2020 03:22:35 -0400
X-MC-Unique: UeVM2Z5SNOWWS3fRhDXsXw-1
Received: by mail-wr1-f72.google.com with SMTP id g6so1376457wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8+sv9RBb+rSSUYGpqVIUdbSPEVOUodQITcJ1XA2UhV4=;
 b=h4ojubstIJtYHzvBezJ+3/mAbGh4L7F5fXGT87REOWEpoSesHNI5NAffhkdpa8P+Gt
 9vZu3Fr5ESWO9VmM62mj7pSZNNKZnOZD8EvrmkDqClirRYaUf+Ty9YhAOsCdm04uA5tJ
 8bXyhFHvgaLsAbFUrmbRolifk5UcVpqSifT9Z7UYgFa9+rRL6NW9yVhJGvEh8R88M9WH
 mVNPhswrItTQyRt+l+mGeCODFKSsZrG3jruGuu2f3blesBQaiP53Q0d3zYltyIwM/nCI
 oF5GEYMCglDzLd1JOrfEm2h3n/kZPfmoxFAJu9QTOUI0POaM+TumQXXWFvyrqL4PG/IU
 rvKw==
X-Gm-Message-State: AOAM532fIkBAOWPIADuDVSm8EHtEMVEWS5knPhqEErbjNud9G9yy3Ct0
 v81ahp9gdGAG3jF9bsZyIJ02StAMriMtc6nQU3VcbNSIYvncSasofgEr0HD6fQ5hpSMp0EUAheZ
 ZgP8NKf2WhqGqNJQ=
X-Received: by 2002:adf:a418:: with SMTP id d24mr2582795wra.80.1601364153669; 
 Tue, 29 Sep 2020 00:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl4Pl4L4apMkzsW/X61VXBKfO8xmu6JN2+Tyqyk+HzoAZrMiC/oyLZGEnJsLwOjLNn4Fqqow==
X-Received: by 2002:adf:a418:: with SMTP id d24mr2582767wra.80.1601364153401; 
 Tue, 29 Sep 2020 00:22:33 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id l4sm4870895wrc.14.2020.09.29.00.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:32 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 37/48] tests/acpi: add a new ACPI table in order to test
 root pci hotplug on/off
Message-ID: <20200929071948.281157-38-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

A new binary ACPI table tests/data/acpi/pc/DSDT.roothp is added in order
to unit test hotplug on/off capability on the root pci bus for i440fx.
The diff between the table DSDT.bridge and DSDT.roothp is listed below:

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20180105 (64-bit version)
  * Copyright (c) 2000 - 2018 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep 11 22:51:04 2020
+ * Disassembly of /tmp/aml-UGIHQ0, Fri Sep 11 22:51:04 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A89 (6793)
+ *     Length           0x0000140A (5130)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x09
+ *     Checksum         0xE6
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

@@ -831,61 +831,60 @@
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
-                Name (BSEL, One)
+                Name (BSEL, Zero)
                 Device (S00)
                 {
                     Name (_SUN, Zero)  // _SUN: Slot User Number
                     Name (_ADR, Zero)  // _ADR: Address
                     Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                     {
                         PCEJ (BSEL, _SUN)
                     }
                 }

                 Device (S08)
                 {
                     Name (_SUN, One)  // _SUN: Slot User Number
                     Name (_ADR, 0x00010000)  // _ADR: Address
                     Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                     {
@@ -1345,456 +1344,30 @@
                         Notify (SE8, Arg1)
                     }

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
-                    BNUM = One
+                    BNUM = Zero
                     DVNT (PCIU, One)
                     DVNT (PCID, 0x03)
                 }
             }

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
             Method (PCNT, 0, NotSerialized)
             {
-                BNUM = Zero
-                DVNT (PCIU, One)
-                DVNT (PCID, 0x03)
                 ^S18.PCNT ()
             }
         }
     }
 }

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-4-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/pc/DSDT.roothp              | Bin 0 -> 5130 bytes
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ac864fc982..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT.roothp",
diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
new file mode 100644
index 0000000000000000000000000000000000000000..886a5e6952f6f034bdd80d44d43de5975a1a4b0f
GIT binary patch
literal 5130
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

literal 0
HcmV?d00001

-- 
MST



Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC17FC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBE42074B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 10:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="pTQ/WrQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBE42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEVZ3-0006At-W3
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 06:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVY7-0005I3-M0
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:51291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEVY5-00042O-7R
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 06:35:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id a9so1150255pjg.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ck/Dy0OKKQF86VLFyV9ynWpe5Tbi5sUuH2yyDtGrKyU=;
 b=pTQ/WrQNHlzF9+53x1DpnrB3IGAEMNYuxr5VOk3afbmMsxEm6I4PtwlpiDaNIfOHwS
 aA2UGtgwDZfYp2BOZvJpnYPEtRDGie+xUL8QgMGS8+7Lcj9wagiGaTLewcbVrczN+vaN
 JUcilHDFnvF6XG3yNFU28w7VQ/acDXLGLN+i6RUiOhKc3LcZZI7v6hGxpT1EPkuQSaEU
 r7v9gNWJ3DEYFmDw/EIVvhYYLUbPMYpr1++cRMMV1chrh18S7KWsfW3Tq0hXKNPViERI
 N2/nvcWqtywkQ67EE7wKd3+NbgJ+WxmFt+mmqcM+s3tRU8bh6MSLjNr7Tl6yS4BDwsCf
 wvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ck/Dy0OKKQF86VLFyV9ynWpe5Tbi5sUuH2yyDtGrKyU=;
 b=af7VqoGNLcMHYseWnCbYjvtZyn7WH0RI5zSyPiTca4xnxg0cSN21EaN2g2Log6Bvpi
 Od5YEjvpYyIrTO/fzW+34VWTGxTVVC4xUrP4zX8vvfABPoAbUFVVbZ3qPNxQ3onjABbK
 PXTVjjerpWER0fPBbShVe/zTFRcYtwfoX0nwoMQkQkEnoOgR3Yh4cUIR2BAQwD5DRqmR
 BGvd2vmCb+LrujpM7rnMkWlGSAZkGknaO/qOgRpfEn9Wv/26ixrhr/FTtXeerpGua3sI
 HuiZ/Uuh8N0xAfiL3fEUSzJPz487R2nl1q8zUFYCKNXkF1gaDcJegewnLg0eBjGPXH4L
 7PHg==
X-Gm-Message-State: AOAM532HTulXj6sjKL/SrteVms2tC6Q4/k/uCgvIERFzFMbfHeyVtDIm
 +FbRDZvi1xKAEsnzSwDb9NZMglJhrsILDQ==
X-Google-Smtp-Source: ABdhPJzw+4/2EECqc53qCIMS+8YtEkTHvjlX64f7r4eVHHLYIwETPgdmTt18dI/PMT23Vjy+FIT8GQ==
X-Received: by 2002:a17:90b:4b89:: with SMTP id
 lr9mr12610123pjb.190.1599302155204; 
 Sat, 05 Sep 2020 03:35:55 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.214])
 by smtp.googlemail.com with ESMTPSA id k24sm9200643pfg.148.2020.09.05.03.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 03:35:54 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/3] tests/acpi: add newly added acpi DSDT table blob for
 pci bridge hotplug flag
Date: Sat,  5 Sep 2020 16:05:20 +0530
Message-Id: <20200905103520.12626-4-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200905103520.12626-1-ani@anisinha.ca>
References: <20200905103520.12626-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1030.google.com
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
- * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep  4 17:13:04 2020
+ * Disassembly of /tmp/aml-CISFQ0, Fri Sep  4 17:13:04 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A89 (6793)
+ *     Length           0x0000131F (4895)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x08
+ *     Checksum         0xF8
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
index 0000000000000000000000000000000000000000..ec130fcc9e33daf41336d965807161ed4d7c6a03
GIT binary patch
literal 4895
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
Q&v{xkJjAxx@WtfPuU}M<Jpcdz

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



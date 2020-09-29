Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A3C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2538D2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="JNWYwrMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2538D2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAaJ-0000Ue-7x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kN9z8-0005K3-9P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kN9z5-0001wQ-0P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:23:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so3519070wmi.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A2Ik0Iy0Y21xIQj8jc0rREK963ikpABuu2rxFfhtfM8=;
 b=JNWYwrMj4t0C250UshLtRVGu55qSPKuJvs1g7LHiX7abNt1IRvLPdkfhRZ/GPZFbxW
 HliVy301B8sgk4dCS7bQwx8fLy0x4WQCPF7qV34amJU4hZqebGJdRw2xAjCAJ1U6y3Bt
 Nl7uwU9jO2gv+wow1z1a9Rq51w1u7DPyMReC2PTfpRw30SuW1JFgRgWQuyhsVAjFpmKQ
 e/+0+7xJjCd3A9m2yzk8hDJNAgwrhfgyt96MDWxxCMiPSbEuSXtLOgeZacW9Nbb5WvHd
 CEibYXqyjqQugtOtQPBFYZLkMGRSLvYIyhqhbWlv69b+QOqsPjCre2uDQFScOoipyNBj
 f7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A2Ik0Iy0Y21xIQj8jc0rREK963ikpABuu2rxFfhtfM8=;
 b=Qq+G8zDmbD++zgF2JMKeI2jn98MY74B3t5f8rj0v1HWXqFrA47WC+0oLEXQAR71r5A
 3QwvzF/ZuJxeK1YY+m7bPg8zplSff6whDKdrVsHCMYgtbJRIolt//vY7WnUFAswF13Wo
 No5WkqpkXy2lPBW0z5wuTNZJicd6B0dInJUIqnUTQkNJaKdG6jdfKFTtEqGKQQiE9Wpy
 GDQTwfablU9TQfoLjGiHRmAjr8iQf1sbs7PYQFC+A8SZ/D5O4IwUgSwHTHaMXglc6rYP
 CRYVaAaOk11Q6N3/dz/WMsMXUt5SnRvW2nwAUoBpRfGF2myywz/4EC6/P/KJESz/PVjQ
 DvPg==
X-Gm-Message-State: AOAM532AcwDl5bhuw12a+JFCo2+9cHCEJqnJAX1+f2G2N8M4VKL4s6zZ
 85+2EmxXsMIFi3cM0W6MymYBBgc7IUJa5X+uYFzdPjjT5sw27w==
X-Google-Smtp-Source: ABdhPJw92I9uUuhBsevaPoWyr4rmmzsuiYtty+sZALcDl5H+CjnO9sGodKG6c+fRkMUGYoencbV3g/F2dzr1PGaICY8=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr3164422wmg.137.1601364209224; 
 Tue, 29 Sep 2020 00:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200918084111.15339-1-ani@anisinha.ca>
 <20200918084111.15339-14-ani@anisinha.ca>
 <20200929031032-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929031032-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 29 Sep 2020 12:53:17 +0530
Message-ID: <CAARzgwzdVCwzXE2hUgPQdQpnp8eTf0JyEt3vctKWnZgwZZAfuA@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 12:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Sep 18, 2020 at 02:11:11PM +0530, Ani Sinha wrote:
> > This change adds a new DSDT golden master table blob to test disabling
> > hotplug on both pci root bus and pci bridges. Also reverts the change
> > in file bios-tables-test-allowed-diff.h to make sure its now empty so that
> > future modifications to acpi tables can be caught.
> >
> > The following is the disassembled diff between DSDT.hpbridge and DSDT.hpbrroot:
> >
> > @@ -1,30 +1,30 @@
> >  /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20180105 (64-bit version)
> >   * Copyright (c) 2000 - 2018 Intel Corporation
> >   *
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Wed Sep 16 09:45:56 2020
> > + * Disassembly of /tmp/aml-ECV9Q0, Wed Sep 16 09:45:56 2020
> >   *
> >   * Original Table Header:
> >   *     Signature        "DSDT"
> > - *     Length           0x0000131F (4895)
> > + *     Length           0x00000B89 (2953)
> >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > - *     Checksum         0xF9
> > + *     Checksum         0xA2
> >   *     OEM ID           "BOCHS "
> >   *     OEM Table ID     "BXPCDSDT"
> >   *     OEM Revision     0x00000001 (1)
> >   *     Compiler ID      "BXPC"
> >   *     Compiler Version 0x00000001 (1)
> >   */
> >  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
> >  {
> >      Scope (\)
> >      {
> >          OperationRegion (DBG, SystemIO, 0x0402, One)
> >          Field (DBG, ByteAcc, NoLock, Preserve)
> >          {
> >              DBGB,   8
> >          }
> >
> > @@ -234,64 +234,32 @@
> >          {
> >              Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
> >              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >              {
> >                  IO (Decode16,
> >                      0x0070,             // Range Minimum
> >                      0x0070,             // Range Maximum
> >                      0x01,               // Alignment
> >                      0x08,               // Length
> >                      )
> >                  IRQNoFlags ()
> >                      {8}
> >              })
> >          }
> >      }
> >
> > -    Scope (_SB.PCI0)
> > -    {
> > -        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
> > -        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
> > -        {
> > -            PCIU,   32,
> > -            PCID,   32
> > -        }
> > -
> > -        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
> > -        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
> > -        {
> > -            B0EJ,   32
> > -        }
> > -
> > -        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
> > -        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
> > -        {
> > -            BNUM,   32
> > -        }
> > -
> > -        Mutex (BLCK, 0x00)
> > -        Method (PCEJ, 2, NotSerialized)
> > -        {
> > -            Acquire (BLCK, 0xFFFF)
> > -            BNUM = Arg0
> > -            B0EJ = (One << Arg1)
> > -            Release (BLCK)
> > -            Return (Zero)
> > -        }
> > -    }
> > -
> >      Scope (_SB)
> >      {
> >          Scope (PCI0)
> >          {
> >              Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
> >              {
> >                  Local0 = Package (0x80){}
> >                  Local1 = Zero
> >                  While ((Local1 < 0x80))
> >                  {
> >                      Local2 = (Local1 >> 0x02)
> >                      Local3 = ((Local1 + Local2) & 0x03)
> >                      If ((Local3 == Zero))
> >                      {
> >                          Local4 = Package (0x04)
> >                              {
> > @@ -690,38 +658,32 @@
> >                  Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
> >                  {
> >                      COST (Zero, Arg0, Arg1, Arg2)
> >                  }
> >              }
> >          }
> >      }
> >
> >      Method (\_GPE._E02, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> >      {
> >          \_SB.CPUS.CSCN ()
> >      }
> >
> >      Scope (_GPE)
> >      {
> >          Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
> > -        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> > -        {
> > -            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
> > -            \_SB.PCI0.PCNT ()
> > -            Release (\_SB.PCI0.BLCK)
> > -        }
> >      }
> >
> >      Scope (\_SB.PCI0)
> >      {
> >          Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >          {
> >              WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> >                  0x0000,             // Granularity
> >                  0x0000,             // Range Minimum
> >                  0x00FF,             // Range Maximum
> >                  0x0000,             // Translation Offset
> >                  0x0100,             // Length
> >                  ,, )
> >              IO (Decode16,
> >                  0x0CF8,             // Range Minimum
> >                  0x0CF8,             // Range Maximum
> > @@ -766,48 +728,32 @@
> >          })
> >          Device (GPE0)
> >          {
> >              Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
> >              Name (_UID, "GPE0 resources")  // _UID: Unique ID
> >              Name (_STA, 0x0B)  // _STA: Status
> >              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >              {
> >                  IO (Decode16,
> >                      0xAFE0,             // Range Minimum
> >                      0xAFE0,             // Range Maximum
> >                      0x01,               // Alignment
> >                      0x04,               // Length
> >                      )
> >              })
> >          }
> > -
> > -        Device (PHPR)
> > -        {
> > -            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
> > -            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
> > -            Name (_STA, 0x0B)  // _STA: Status
> > -            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> > -            {
> > -                IO (Decode16,
> > -                    0xAE00,             // Range Minimum
> > -                    0xAE00,             // Range Maximum
> > -                    0x01,               // Alignment
> > -                    0x14,               // Length
> > -                    )
> > -            })
> > -        }
> >      }
> >
> >      Scope (\)
> >      {
> >          Name (_S3, Package (0x04)  // _S3_: S3 System State
> >          {
> >              One,
> >              One,
> >              Zero,
> >              Zero
> >          })
> >          Name (_S4, Package (0x04)  // _S4_: S4 System State
> >          {
> >              0x02,
> >              0x02,
> >              Zero,
> > @@ -831,479 +777,48 @@
> >              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >              {
> >                  IO (Decode16,
> >                      0x0510,             // Range Minimum
> >                      0x0510,             // Range Maximum
> >                      0x01,               // Alignment
> >                      0x0C,               // Length
> >                      )
> >              })
> >          }
> >      }
> >
> >      Scope (\_SB)
> >      {
> >          Scope (PCI0)
> >          {
> > -            Name (BSEL, Zero)
> >              Device (S00)
> >              {
> >                  Name (_ADR, Zero)  // _ADR: Address
> >              }
> >
> >              Device (S10)
> >              {
> >                  Name (_ADR, 0x00020000)  // _ADR: Address
> >                  Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
> >                  {
> >                      Return (Zero)
> >                  }
> >
> >                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
> >                  {
> >                      Return (Zero)
> >                  }
> >
> >                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
> >                  {
> >                      Return (Zero)
> >                  }
> >              }
> >
> >              Device (S18)
> >              {
> >                  Name (_ADR, 0x00030000)  // _ADR: Address
> >              }
> > -
> > -            Device (S20)
> > -            {
> > -                Name (_SUN, 0x04)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00040000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S28)
> > -            {
> > -                Name (_SUN, 0x05)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00050000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S30)
> > -            {
> > -                Name (_SUN, 0x06)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00060000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S38)
> > -            {
> > -                Name (_SUN, 0x07)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00070000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S40)
> > -            {
> > -                Name (_SUN, 0x08)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00080000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S48)
> > -            {
> > -                Name (_SUN, 0x09)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00090000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S50)
> > -            {
> > -                Name (_SUN, 0x0A)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000A0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S58)
> > -            {
> > -                Name (_SUN, 0x0B)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000B0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S60)
> > -            {
> > -                Name (_SUN, 0x0C)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000C0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S68)
> > -            {
> > -                Name (_SUN, 0x0D)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000D0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S70)
> > -            {
> > -                Name (_SUN, 0x0E)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000E0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S78)
> > -            {
> > -                Name (_SUN, 0x0F)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x000F0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S80)
> > -            {
> > -                Name (_SUN, 0x10)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00100000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S88)
> > -            {
> > -                Name (_SUN, 0x11)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00110000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S90)
> > -            {
> > -                Name (_SUN, 0x12)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00120000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (S98)
> > -            {
> > -                Name (_SUN, 0x13)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00130000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SA0)
> > -            {
> > -                Name (_SUN, 0x14)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00140000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SA8)
> > -            {
> > -                Name (_SUN, 0x15)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00150000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SB0)
> > -            {
> > -                Name (_SUN, 0x16)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00160000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SB8)
> > -            {
> > -                Name (_SUN, 0x17)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00170000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SC0)
> > -            {
> > -                Name (_SUN, 0x18)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00180000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SC8)
> > -            {
> > -                Name (_SUN, 0x19)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x00190000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SD0)
> > -            {
> > -                Name (_SUN, 0x1A)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001A0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SD8)
> > -            {
> > -                Name (_SUN, 0x1B)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001B0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SE0)
> > -            {
> > -                Name (_SUN, 0x1C)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001C0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SE8)
> > -            {
> > -                Name (_SUN, 0x1D)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001D0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SF0)
> > -            {
> > -                Name (_SUN, 0x1E)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001E0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Device (SF8)
> > -            {
> > -                Name (_SUN, 0x1F)  // _SUN: Slot User Number
> > -                Name (_ADR, 0x001F0000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> > -            }
> > -
> > -            Method (DVNT, 2, NotSerialized)
> > -            {
> > -                If ((Arg0 & 0x10))
> > -                {
> > -                    Notify (S20, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x20))
> > -                {
> > -                    Notify (S28, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x40))
> > -                {
> > -                    Notify (S30, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x80))
> > -                {
> > -                    Notify (S38, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x0100))
> > -                {
> > -                    Notify (S40, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x0200))
> > -                {
> > -                    Notify (S48, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x0400))
> > -                {
> > -                    Notify (S50, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x0800))
> > -                {
> > -                    Notify (S58, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x1000))
> > -                {
> > -                    Notify (S60, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x2000))
> > -                {
> > -                    Notify (S68, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x4000))
> > -                {
> > -                    Notify (S70, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x8000))
> > -                {
> > -                    Notify (S78, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00010000))
> > -                {
> > -                    Notify (S80, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00020000))
> > -                {
> > -                    Notify (S88, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00040000))
> > -                {
> > -                    Notify (S90, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00080000))
> > -                {
> > -                    Notify (S98, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00100000))
> > -                {
> > -                    Notify (SA0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00200000))
> > -                {
> > -                    Notify (SA8, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00400000))
> > -                {
> > -                    Notify (SB0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x00800000))
> > -                {
> > -                    Notify (SB8, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x01000000))
> > -                {
> > -                    Notify (SC0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x02000000))
> > -                {
> > -                    Notify (SC8, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x04000000))
> > -                {
> > -                    Notify (SD0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x08000000))
> > -                {
> > -                    Notify (SD8, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x10000000))
> > -                {
> > -                    Notify (SE0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x20000000))
> > -                {
> > -                    Notify (SE8, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x40000000))
> > -                {
> > -                    Notify (SF0, Arg1)
> > -                }
> > -
> > -                If ((Arg0 & 0x80000000))
> > -                {
> > -                    Notify (SF8, Arg1)
> > -                }
> > -            }
> > -
> > -            Method (PCNT, 0, NotSerialized)
> > -            {
> > -                BNUM = Zero
> > -                DVNT (PCIU, One)
> > -                DVNT (PCID, 0x03)
> > -            }
> >          }
> >      }
> >  }
>
> This is not the only diff I see if I apply this patchset on
> top of master.
> Dropped this and the previous patch.
> Please check what is going on and repost as appropriate.

Which two ACPI DSDT files are you diffing? What diff are you getting?

>
>
>
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > ---
>


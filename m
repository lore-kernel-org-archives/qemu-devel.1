Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540EAC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AA820757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Hp9Jp+2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AA820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNC76-0003vb-Lv
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNC5P-00039f-2D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:38:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNC5I-00064R-4v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:38:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id k10so4585198wru.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=689KA+N2xHqAsUSLYENWwM6g+nYjSbt/VMUMogHC9ic=;
 b=Hp9Jp+2YQAGqKNrLk2RFAbYPYXYg3X2CVHtDF8yIM4y5+J9denaH5by2rDc73vBlzD
 N/8HcbEkD0yxhh7gAM7NFmIXLc0VPzTiY1hA5WChWP9QQDu99HCL0hGMZpv2AM0IRaha
 HcLERh/iebHb78Oylq1+HRHUu5htJ2F2DlTmMM3gzGH7pWaTw3PNWDPCIjvn4Ple+afc
 xVXGhN2OGOTuRJMwALOBZykkd9U2QyxUL/6/wdjpcI6O5zJuNx6g6/Qkigo+AT3Bxmoo
 mMiBfCKiey3ieTaMmhKi6NO8qvAWGFqrlR4TG3xCYb8B9CxVVNuB1q70yLHp+PZOUFFw
 FYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=689KA+N2xHqAsUSLYENWwM6g+nYjSbt/VMUMogHC9ic=;
 b=Cf5vO2QYAaG2wzQaBdFcrHw0ivCLjhra7DpPoKT5b+JC6LuktKTkJC7OC6TIWMw6LE
 j3uNlmSzIE1UN8JR39jSvYC5divUlzuD6g4Pa/Of/U6pdujdpzaWIncZm1iDDwhgN1s3
 8DIwTdVALUGy3imH4e5zxJbQTm0P6YwnEuunZkr0Yqrs/vjIrApa/oQaKXK0vWVeYDTX
 V72j+tfnPp5zCqLOK3Zplxu2wY9V1vCkxoULQE6YQQTjrMxcqc9BC+wl+GFAo7+AVh2i
 9DowwngwasOUdyhMk2aaDG+XbHn8/ivOkE1LGuNa3Cha8q2mmhHKK9JoGGilMmuxjKx0
 B7yA==
X-Gm-Message-State: AOAM530zdsnCSCa4KW2VS/bjCy7IxynSYZRmSA4qAeT3InP2vXeQ0tBc
 HXMczhLh0NedbTnjDQ1xXfGKHm8tBgXAmW/u9TMqog==
X-Google-Smtp-Source: ABdhPJyP/EJRyndWxHouckZAUbD4hMzCrGuEISEOpovEZKvLMXun4LVEpvRXCMv0yyL+eMG2u8gkhv+Hfa+sAfm3nGI=
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr3059160wru.427.1601372285984; 
 Tue, 29 Sep 2020 02:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200918084111.15339-1-ani@anisinha.ca>
 <20200918084111.15339-14-ani@anisinha.ca>
 <20200929031032-mutt-send-email-mst@kernel.org>
 <CAARzgwzdVCwzXE2hUgPQdQpnp8eTf0JyEt3vctKWnZgwZZAfuA@mail.gmail.com>
 <20200929032619-mutt-send-email-mst@kernel.org>
 <CAARzgwz7x6uinPQ+oC+yAuFCbQEWhQuDmGU73E5NZ2WCH_C_kA@mail.gmail.com>
 <CAARzgwwxjjCAVsFB6_987pa1Z_in2G50rViYiRGVae-c_wn6xQ@mail.gmail.com>
In-Reply-To: <CAARzgwwxjjCAVsFB6_987pa1Z_in2G50rViYiRGVae-c_wn6xQ@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 29 Sep 2020 15:07:53 +0530
Message-ID: <CAARzgwxvQdDpi20=MmZ3rTZBFsMiHHhYXrYiSP2qHF0_GvJTGg@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042790505b0708a75"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000042790505b0708a75
Content-Type: text/plain; charset="UTF-8"

Maybe you can give me access to your workspace  aane I can take a look.

On Tue, Sep 29, 2020 at 2:21 PM Ani Sinha <ani@anisinha.ca> wrote:

> On Tue, Sep 29, 2020 at 1:53 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> >
>
> > On Tue, Sep 29, 2020 at 12:56 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > >
>
> > > On Tue, Sep 29, 2020 at 12:53:17PM +0530, Ani Sinha wrote:
>
> > > > On Tue, Sep 29, 2020 at 12:42 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > > > >
>
> > > > > On Fri, Sep 18, 2020 at 02:11:11PM +0530, Ani Sinha wrote:
>
> > > > > > This change adds a new DSDT golden master table blob to test
> disabling
>
> > > > > > hotplug on both pci root bus and pci bridges. Also reverts the
> change
>
> > > > > > in file bios-tables-test-allowed-diff.h to make sure its now
> empty so that
>
> > > > > > future modifications to acpi tables can be caught.
>
> > > > > >
>
> > > > > > The following is the disassembled diff between DSDT.hpbridge and
> DSDT.hpbrroot:
>
> > > > > >
>
> > > > > > @@ -1,30 +1,30 @@
>
> > > > > >  /*
>
> > > > > >   * Intel ACPI Component Architecture
>
> > > > > >   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>
> > > > > >   * Copyright (c) 2000 - 2018 Intel Corporation
>
> > > > > >   *
>
> > > > > >   * Disassembling to symbolic ASL+ operators
>
> > > > > >   *
>
> > > > > > - * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Wed Sep 16
> 09:45:56 2020
>
> > > > > > + * Disassembly of /tmp/aml-ECV9Q0, Wed Sep 16 09:45:56 2020
>
> > > > > >   *
>
> > > > > >   * Original Table Header:
>
> > > > > >   *     Signature        "DSDT"
>
> > > > > > - *     Length           0x0000131F (4895)
>
> > > > > > + *     Length           0x00000B89 (2953)
>
> > > > > >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit
> math support
>
> > > > > > - *     Checksum         0xF9
>
> > > > > > + *     Checksum         0xA2
>
> > > > > >   *     OEM ID           "BOCHS "
>
> > > > > >   *     OEM Table ID     "BXPCDSDT"
>
> > > > > >   *     OEM Revision     0x00000001 (1)
>
> > > > > >   *     Compiler ID      "BXPC"
>
> > > > > >   *     Compiler Version 0x00000001 (1)
>
> > > > > >   */
>
> > > > > >  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT",
> 0x00000001)
>
> > > > > >  {
>
> > > > > >      Scope (\)
>
> > > > > >      {
>
> > > > > >          OperationRegion (DBG, SystemIO, 0x0402, One)
>
> > > > > >          Field (DBG, ByteAcc, NoLock, Preserve)
>
> > > > > >          {
>
> > > > > >              DBGB,   8
>
> > > > > >          }
>
> > > > > >
>
> > > > > > @@ -234,64 +234,32 @@
>
> > > > > >          {
>
> > > > > >              Name (_HID, EisaId ("PNP0B00") /* AT Real-Time
> Clock */)  // _HID: Hardware ID
>
> > > > > >              Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > > > >              {
>
> > > > > >                  IO (Decode16,
>
> > > > > >                      0x0070,             // Range Minimum
>
> > > > > >                      0x0070,             // Range Maximum
>
> > > > > >                      0x01,               // Alignment
>
> > > > > >                      0x08,               // Length
>
> > > > > >                      )
>
> > > > > >                  IRQNoFlags ()
>
> > > > > >                      {8}
>
> > > > > >              })
>
> > > > > >          }
>
> > > > > >      }
>
> > > > > >
>
> > > > > > -    Scope (_SB.PCI0)
>
> > > > > > -    {
>
> > > > > > -        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
>
> > > > > > -        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
>
> > > > > > -        {
>
> > > > > > -            PCIU,   32,
>
> > > > > > -            PCID,   32
>
> > > > > > -        }
>
> > > > > > -
>
> > > > > > -        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
>
> > > > > > -        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
>
> > > > > > -        {
>
> > > > > > -            B0EJ,   32
>
> > > > > > -        }
>
> > > > > > -
>
> > > > > > -        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
>
> > > > > > -        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
>
> > > > > > -        {
>
> > > > > > -            BNUM,   32
>
> > > > > > -        }
>
> > > > > > -
>
> > > > > > -        Mutex (BLCK, 0x00)
>
> > > > > > -        Method (PCEJ, 2, NotSerialized)
>
> > > > > > -        {
>
> > > > > > -            Acquire (BLCK, 0xFFFF)
>
> > > > > > -            BNUM = Arg0
>
> > > > > > -            B0EJ = (One << Arg1)
>
> > > > > > -            Release (BLCK)
>
> > > > > > -            Return (Zero)
>
> > > > > > -        }
>
> > > > > > -    }
>
> > > > > > -
>
> > > > > >      Scope (_SB)
>
> > > > > >      {
>
> > > > > >          Scope (PCI0)
>
> > > > > >          {
>
> > > > > >              Method (_PRT, 0, NotSerialized)  // _PRT: PCI
> Routing Table
>
> > > > > >              {
>
> > > > > >                  Local0 = Package (0x80){}
>
> > > > > >                  Local1 = Zero
>
> > > > > >                  While ((Local1 < 0x80))
>
> > > > > >                  {
>
> > > > > >                      Local2 = (Local1 >> 0x02)
>
> > > > > >                      Local3 = ((Local1 + Local2) & 0x03)
>
> > > > > >                      If ((Local3 == Zero))
>
> > > > > >                      {
>
> > > > > >                          Local4 = Package (0x04)
>
> > > > > >                              {
>
> > > > > > @@ -690,38 +658,32 @@
>
> > > > > >                  Method (_OST, 3, Serialized)  // _OST: OSPM
> Status Indication
>
> > > > > >                  {
>
> > > > > >                      COST (Zero, Arg0, Arg1, Arg2)
>
> > > > > >                  }
>
> > > > > >              }
>
> > > > > >          }
>
> > > > > >      }
>
> > > > > >
>
> > > > > >      Method (\_GPE._E02, 0, NotSerialized)  // _Exx:
> Edge-Triggered GPE
>
> > > > > >      {
>
> > > > > >          \_SB.CPUS.CSCN ()
>
> > > > > >      }
>
> > > > > >
>
> > > > > >      Scope (_GPE)
>
> > > > > >      {
>
> > > > > >          Name (_HID, "ACPI0006" /* GPE Block Device */)  //
> _HID: Hardware ID
>
> > > > > > -        Method (_E01, 0, NotSerialized)  // _Exx:
> Edge-Triggered GPE
>
> > > > > > -        {
>
> > > > > > -            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
>
> > > > > > -            \_SB.PCI0.PCNT ()
>
> > > > > > -            Release (\_SB.PCI0.BLCK)
>
> > > > > > -        }
>
> > > > > >      }
>
> > > > > >
>
> > > > > >      Scope (\_SB.PCI0)
>
> > > > > >      {
>
> > > > > >          Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > > > >          {
>
> > > > > >              WordBusNumber (ResourceProducer, MinFixed,
> MaxFixed, PosDecode,
>
> > > > > >                  0x0000,             // Granularity
>
> > > > > >                  0x0000,             // Range Minimum
>
> > > > > >                  0x00FF,             // Range Maximum
>
> > > > > >                  0x0000,             // Translation Offset
>
> > > > > >                  0x0100,             // Length
>
> > > > > >                  ,, )
>
> > > > > >              IO (Decode16,
>
> > > > > >                  0x0CF8,             // Range Minimum
>
> > > > > >                  0x0CF8,             // Range Maximum
>
> > > > > > @@ -766,48 +728,32 @@
>
> > > > > >          })
>
> > > > > >          Device (GPE0)
>
> > > > > >          {
>
> > > > > >              Name (_HID, "PNP0A06" /* Generic Container Device
> */)  // _HID: Hardware ID
>
> > > > > >              Name (_UID, "GPE0 resources")  // _UID: Unique ID
>
> > > > > >              Name (_STA, 0x0B)  // _STA: Status
>
> > > > > >              Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > > > >              {
>
> > > > > >                  IO (Decode16,
>
> > > > > >                      0xAFE0,             // Range Minimum
>
> > > > > >                      0xAFE0,             // Range Maximum
>
> > > > > >                      0x01,               // Alignment
>
> > > > > >                      0x04,               // Length
>
> > > > > >                      )
>
> > > > > >              })
>
> > > > > >          }
>
> > > > > > -
>
> > > > > > -        Device (PHPR)
>
> > > > > > -        {
>
> > > > > > -            Name (_HID, "PNP0A06" /* Generic Container Device
> */)  // _HID: Hardware ID
>
> > > > > > -            Name (_UID, "PCI Hotplug resources")  // _UID:
> Unique ID
>
> > > > > > -            Name (_STA, 0x0B)  // _STA: Status
>
> > > > > > -            Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > > > > -            {
>
> > > > > > -                IO (Decode16,
>
> > > > > > -                    0xAE00,             // Range Minimum
>
> > > > > > -                    0xAE00,             // Range Maximum
>
> > > > > > -                    0x01,               // Alignment
>
> > > > > > -                    0x14,               // Length
>
> > > > > > -                    )
>
> > > > > > -            })
>
> > > > > > -        }
>
> > > > > >      }
>
> > > > > >
>
> > > > > >      Scope (\)
>
> > > > > >      {
>
> > > > > >          Name (_S3, Package (0x04)  // _S3_: S3 System State
>
> > > > > >          {
>
> > > > > >              One,
>
> > > > > >              One,
>
> > > > > >              Zero,
>
> > > > > >              Zero
>
> > > > > >          })
>
> > > > > >          Name (_S4, Package (0x04)  // _S4_: S4 System State
>
> > > > > >          {
>
> > > > > >              0x02,
>
> > > > > >              0x02,
>
> > > > > >              Zero,
>
> > > > > > @@ -831,479 +777,48 @@
>
> > > > > >              Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > > > >              {
>
> > > > > >                  IO (Decode16,
>
> > > > > >                      0x0510,             // Range Minimum
>
> > > > > >                      0x0510,             // Range Maximum
>
> > > > > >                      0x01,               // Alignment
>
> > > > > >                      0x0C,               // Length
>
> > > > > >                      )
>
> > > > > >              })
>
> > > > > >          }
>
> > > > > >      }
>
> > > > > >
>
> > > > > >      Scope (\_SB)
>
> > > > > >      {
>
> > > > > >          Scope (PCI0)
>
> > > > > >          {
>
> > > > > > -            Name (BSEL, Zero)
>
> > > > > >              Device (S00)
>
> > > > > >              {
>
> > > > > >                  Name (_ADR, Zero)  // _ADR: Address
>
> > > > > >              }
>
> > > > > >
>
> > > > > >              Device (S10)
>
> > > > > >              {
>
> > > > > >                  Name (_ADR, 0x00020000)  // _ADR: Address
>
> > > > > >                  Method (_S1D, 0, NotSerialized)  // _S1D: S1
> Device State
>
> > > > > >                  {
>
> > > > > >                      Return (Zero)
>
> > > > > >                  }
>
> > > > > >
>
> > > > > >                  Method (_S2D, 0, NotSerialized)  // _S2D: S2
> Device State
>
> > > > > >                  {
>
> > > > > >                      Return (Zero)
>
> > > > > >                  }
>
> > > > > >
>
> > > > > >                  Method (_S3D, 0, NotSerialized)  // _S3D: S3
> Device State
>
> > > > > >                  {
>
> > > > > >                      Return (Zero)
>
> > > > > >                  }
>
> > > > > >              }
>
> > > > > >
>
> > > > > >              Device (S18)
>
> > > > > >              {
>
> > > > > >                  Name (_ADR, 0x00030000)  // _ADR: Address
>
> > > > > >              }
>
> > > > > > -
>
> > > > > > -            Device (S20)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x04)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00040000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S28)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x05)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00050000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S30)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x06)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00060000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S38)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x07)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00070000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S40)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x08)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00080000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S48)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x09)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00090000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S50)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0A)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000A0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S58)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0B)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000B0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S60)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0C)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000C0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S68)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0D)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000D0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S70)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0E)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000E0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S78)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x0F)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x000F0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S80)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x10)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00100000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S88)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x11)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00110000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S90)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x12)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00120000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (S98)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x13)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00130000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SA0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x14)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00140000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SA8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x15)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00150000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SB0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x16)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00160000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SB8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x17)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00170000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SC0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x18)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00180000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SC8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x19)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x00190000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SD0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1A)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001A0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SD8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1B)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001B0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SE0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1C)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001C0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SE8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1D)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001D0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SF0)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1E)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001E0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Device (SF8)
>
> > > > > > -            {
>
> > > > > > -                Name (_SUN, 0x1F)  // _SUN: Slot User Number
>
> > > > > > -                Name (_ADR, 0x001F0000)  // _ADR: Address
>
> > > > > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device
>
> > > > > > -                {
>
> > > > > > -                    PCEJ (BSEL, _SUN)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Method (DVNT, 2, NotSerialized)
>
> > > > > > -            {
>
> > > > > > -                If ((Arg0 & 0x10))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S20, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x20))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S28, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x40))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S30, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x80))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S38, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x0100))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S40, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x0200))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S48, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x0400))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S50, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x0800))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S58, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x1000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S60, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x2000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S68, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x4000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S70, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x8000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S78, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00010000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S80, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00020000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S88, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00040000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S90, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00080000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (S98, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00100000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SA0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00200000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SA8, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00400000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SB0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x00800000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SB8, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x01000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SC0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x02000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SC8, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x04000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SD0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x08000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SD8, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x10000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SE0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x20000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SE8, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x40000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SF0, Arg1)
>
> > > > > > -                }
>
> > > > > > -
>
> > > > > > -                If ((Arg0 & 0x80000000))
>
> > > > > > -                {
>
> > > > > > -                    Notify (SF8, Arg1)
>
> > > > > > -                }
>
> > > > > > -            }
>
> > > > > > -
>
> > > > > > -            Method (PCNT, 0, NotSerialized)
>
> > > > > > -            {
>
> > > > > > -                BNUM = Zero
>
> > > > > > -                DVNT (PCIU, One)
>
> > > > > > -                DVNT (PCID, 0x03)
>
> > > > > > -            }
>
> > > > > >          }
>
> > > > > >      }
>
> > > > > >  }
>
> > > > >
>
> > > > > This is not the only diff I see if I apply this patchset on
>
> > > > > top of master.
>
> > > > > Dropped this and the previous patch.
>
> > > > > Please check what is going on and repost as appropriate.
>
> > > >
>
> > > > Which two ACPI DSDT files are you diffing? What diff are you getting?
>
> > >
>
> > >
>
> > > diff -rup ./tests/data/acpi/pc/DSDT.hpbridge.dsl
> ./tests/data/acpi/pc/DSDT.hpbrroot.dsl
>
> >
>
> > I re-based my patchset on top of the latest qemu master and did a make
>
> >  && make check-qtest-x86_64 V=1.
>
> > They pass. I am seeing this diff:
>
> > https://pastebin.ubuntu.com/p/BXy9GFfB2R/
>
> >
>
> > and it looks good to me.
>
> >
>
> > Not sure why your diff looks different. Maybe you can regenerate the
> blob?
>
>
>
> I did a full make check and it passed. I compared the diff again and
>
> it's the same. I checked my tree and it looks clean. These are the
>
> patches I have:
>
>
>
> $ git log --oneline
>
> 20d1323e10 (HEAD -> master) qom: code hardening - have bound checking
>
> while looping with integer value
>
> 0f69dae0e2 Add a comment in bios-tables-test.c to clarify the reason
>
> behind approach
>
> dd9a8c3cd3 tests/acpi: add DSDT.hpbrroot DSDT table blob to test
>
> global i440fx hotplug
>
> 5b93474fe9 tests/acpi: unit test exercising global pci hotplug off for
> i440fx
>
> 54c33e334a tests/acpi: update golden master DSDT binary table blobs for q35
>
> 2279f61f30 piix4: don't reserve hw resources when hotplug is off globally
>
> 1f61c524a0 Add ACPI DSDT tables for q35 that are being updated by the next
> patch
>
> bdd823611b tests/acpi: add newly added acpi DSDT table blob for pci
>
> bridge hotplug flag
>
> 8c80f8fba9 tests/acpi: unit test for
>
> 'acpi-pci-hotplug-with-bridge-support' bridge flag
>
> e0a3142df9 tests/acpi: list added acpi table binary file for pci
>
> bridge hotplug test
>
> 0ba08317a8 i440fx/acpi: do not add hotplug related amls for cold plugged
> bridges
>
> 73b191ade6 Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
>
> non-hotpluggable bus
>
> ef0e526cc2 tests/acpi: add a new ACPI table in order to test root pci
>
> hotplug on/off
>
> c6d13264f8 tests/acpi: add new unit test to test hotplug off/on
>
> feature on the root pci bus
>
> 6901bada65 tests/acpi: mark addition of table DSDT.roothp for unit
>
> testing root pci hotplug
>
> 74504514b1 (origin/master, origin/HEAD) Merge remote-tracking branch
>
> 'remotes/alistair/tags/pull-register-20200927' into staging
>
>
>
>
>
> >
>
> > >
>
> > >
>
> > >
>
> > > --- ./tests/data/acpi/pc/DSDT.hpbridge.dsl      2020-09-29
> 02:44:43.874622404 -0400
>
> > > +++ ./tests/data/acpi/pc/DSDT.hpbrroot.dsl      2020-09-29
> 02:44:43.876622403 -0400
>
> > > @@ -5,13 +5,13 @@
>
> > >   *
>
> > >   * Disassembling to symbolic ASL+ operators
>
> > >   *
>
> > > - * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue Sep 29
> 02:44:43 2020
>
> > > + * Disassembly of tests/data/acpi/pc/DSDT.hpbrroot, Tue Sep 29
> 02:44:43 2020
>
> > >   *
>
> > >   * Original Table Header:
>
> > >   *     Signature        "DSDT"
>
> > > - *     Length           0x0000139D (5021)
>
> > > + *     Length           0x00000B89 (2953)
>
> > >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math
> support
>
> > > - *     Checksum         0x05
>
> > > + *     Checksum         0xA2
>
> > >   *     OEM ID           "BOCHS "
>
> > >   *     OEM Table ID     "BXPCDSDT"
>
> > >   *     OEM Revision     0x00000001 (1)
>
> > > @@ -247,38 +247,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >          }
>
> > >      }
>
> > >
>
> > > -    Scope (_SB.PCI0)
>
> > > -    {
>
> > > -        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
>
> > > -        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
>
> > > -        {
>
> > > -            PCIU,   32,
>
> > > -            PCID,   32
>
> > > -        }
>
> > > -
>
> > > -        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
>
> > > -        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
>
> > > -        {
>
> > > -            B0EJ,   32
>
> > > -        }
>
> > > -
>
> > > -        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
>
> > > -        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
>
> > > -        {
>
> > > -            BNUM,   32
>
> > > -        }
>
> > > -
>
> > > -        Mutex (BLCK, 0x00)
>
> > > -        Method (PCEJ, 2, NotSerialized)
>
> > > -        {
>
> > > -            Acquire (BLCK, 0xFFFF)
>
> > > -            BNUM = Arg0
>
> > > -            B0EJ = (One << Arg1)
>
> > > -            Release (BLCK)
>
> > > -            Return (Zero)
>
> > > -        }
>
> > > -    }
>
> > > -
>
> > >      Scope (_SB)
>
> > >      {
>
> > >          Scope (PCI0)
>
> > > @@ -643,56 +611,22 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >              Method (CSCN, 0, Serialized)
>
> > >              {
>
> > >                  Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
>
> > > -                Name (CNEW, Package (0xFF){})
>
> > > -                Local3 = Zero
>
> > > -                Local4 = One
>
> > > -                While ((Local4 == One))
>
> > > +                Local0 = One
>
> > > +                While ((Local0 == One))
>
> > >                  {
>
> > > -                    Local4 = Zero
>
> > > -                    Local0 = One
>
> > > -                    Local1 = Zero
>
> > > -                    While (((Local0 == One) && (Local3 < One)))
>
> > > +                    Local0 = Zero
>
> > > +                    \_SB.PCI0.PRES.CCMD = Zero
>
> > > +                    If ((\_SB.PCI0.PRES.CINS == One))
>
> > >                      {
>
> > > -                        Local0 = Zero
>
> > > -                        \_SB.PCI0.PRES.CSEL = Local3
>
> > > -                        \_SB.PCI0.PRES.CCMD = Zero
>
> > > -                        If ((\_SB.PCI0.PRES.CDAT < Local3))
>
> > > -                        {
>
> > > -                            Break
>
> > > -                        }
>
> > > -
>
> > > -                        If ((Local1 == 0xFF))
>
> > > -                        {
>
> > > -                            Local4 = One
>
> > > -                            Break
>
> > > -                        }
>
> > > -
>
> > > -                        Local3 = \_SB.PCI0.PRES.CDAT
>
> > > -                        If ((\_SB.PCI0.PRES.CINS == One))
>
> > > -                        {
>
> > > -                            CNEW [Local1] = Local3
>
> > > -                            Local1++
>
> > > -                            Local0 = One
>
> > > -                        }
>
> > > -                        ElseIf ((\_SB.PCI0.PRES.CRMV == One))
>
> > > -                        {
>
> > > -                            CTFY (Local3, 0x03)
>
> > > -                            \_SB.PCI0.PRES.CRMV = One
>
> > > -                            Local0 = One
>
> > > -                        }
>
> > > -
>
> > > -                        Local3++
>
> > > +                        CTFY (\_SB.PCI0.PRES.CDAT, One)
>
> > > +                        \_SB.PCI0.PRES.CINS = One
>
> > > +                        Local0 = One
>
> > >                      }
>
> > > -
>
> > > -                    Local2 = Zero
>
> > > -                    While ((Local2 < Local1))
>
> > > +                    ElseIf ((\_SB.PCI0.PRES.CRMV == One))
>
> > >                      {
>
> > > -                        Local3 = DerefOf (CNEW [Local2])
>
> > > -                        CTFY (Local3, One)
>
> > > -                        Debug = Local3
>
> > > -                        \_SB.PCI0.PRES.CSEL = Local3
>
> > > -                        \_SB.PCI0.PRES.CINS = One
>
> > > -                        Local2++
>
> > > +                        CTFY (\_SB.PCI0.PRES.CDAT, 0x03)
>
> > > +                        \_SB.PCI0.PRES.CRMV = One
>
> > > +                        Local0 = One
>
> > >                      }
>
> > >                  }
>
> > >
>
> > > @@ -737,12 +671,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >      Scope (_GPE)
>
> > >      {
>
> > >          Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID:
> Hardware ID
>
> > > -        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE,
> xx=0x00-0xFF
>
> > > -        {
>
> > > -            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
>
> > > -            \_SB.PCI0.PCNT ()
>
> > > -            Release (\_SB.PCI0.BLCK)
>
> > > -        }
>
> > >      }
>
> > >
>
> > >      Scope (\_SB.PCI0)
>
> > > @@ -813,22 +741,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >                      )
>
> > >              })
>
> > >          }
>
> > > -
>
> > > -        Device (PHPR)
>
> > > -        {
>
> > > -            Name (_HID, "PNP0A06" /* Generic Container Device */)  //
> _HID: Hardware ID
>
> > > -            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
>
> > > -            Name (_STA, 0x0B)  // _STA: Status
>
> > > -            Name (_CRS, ResourceTemplate ()  // _CRS: Current
> Resource Settings
>
> > > -            {
>
> > > -                IO (Decode16,
>
> > > -                    0xAE00,             // Range Minimum
>
> > > -                    0xAE00,             // Range Maximum
>
> > > -                    0x01,               // Alignment
>
> > > -                    0x14,               // Length
>
> > > -                    )
>
> > > -            })
>
> > > -        }
>
> > >      }
>
> > >
>
> > >      Scope (\)
>
> > > @@ -878,7 +790,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >      {
>
> > >          Scope (PCI0)
>
> > >          {
>
> > > -            Name (BSEL, Zero)
>
> > >              Device (S00)
>
> > >              {
>
> > >                  Name (_ADR, Zero)  // _ADR: Address
>
> > > @@ -907,436 +818,6 @@ DefinitionBlock ("", "DSDT", 1, "BOCHS "
>
> > >              {
>
> > >                  Name (_ADR, 0x00030000)  // _ADR: Address
>
> > >              }
>
> > > -
>
> > > -            Device (S20)
>
> > > -            {
>
> > > -                Name (_SUN, 0x04)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00040000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S28)
>
> > > -            {
>
> > > -                Name (_SUN, 0x05)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00050000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S30)
>
> > > -            {
>
> > > -                Name (_SUN, 0x06)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00060000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S38)
>
> > > -            {
>
> > > -                Name (_SUN, 0x07)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00070000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S40)
>
> > > -            {
>
> > > -                Name (_SUN, 0x08)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00080000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S48)
>
> > > -            {
>
> > > -                Name (_SUN, 0x09)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00090000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S50)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0A)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000A0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S58)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0B)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000B0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S60)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0C)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000C0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S68)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0D)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000D0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S70)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0E)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000E0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S78)
>
> > > -            {
>
> > > -                Name (_SUN, 0x0F)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x000F0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S80)
>
> > > -            {
>
> > > -                Name (_SUN, 0x10)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00100000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S88)
>
> > > -            {
>
> > > -                Name (_SUN, 0x11)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00110000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S90)
>
> > > -            {
>
> > > -                Name (_SUN, 0x12)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00120000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (S98)
>
> > > -            {
>
> > > -                Name (_SUN, 0x13)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00130000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SA0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x14)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00140000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SA8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x15)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00150000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SB0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x16)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00160000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SB8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x17)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00170000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SC0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x18)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00180000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SC8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x19)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x00190000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SD0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1A)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001A0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SD8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1B)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001B0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SE0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1C)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001C0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SE8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1D)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001D0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SF0)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1E)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001E0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Device (SF8)
>
> > > -            {
>
> > > -                Name (_SUN, 0x1F)  // _SUN: Slot User Number
>
> > > -                Name (_ADR, 0x001F0000)  // _ADR: Address
>
> > > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject
> Device, x=0-9
>
> > > -                {
>
> > > -                    PCEJ (BSEL, _SUN)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Method (DVNT, 2, NotSerialized)
>
> > > -            {
>
> > > -                If ((Arg0 & 0x10))
>
> > > -                {
>
> > > -                    Notify (S20, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x20))
>
> > > -                {
>
> > > -                    Notify (S28, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x40))
>
> > > -                {
>
> > > -                    Notify (S30, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x80))
>
> > > -                {
>
> > > -                    Notify (S38, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x0100))
>
> > > -                {
>
> > > -                    Notify (S40, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x0200))
>
> > > -                {
>
> > > -                    Notify (S48, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x0400))
>
> > > -                {
>
> > > -                    Notify (S50, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x0800))
>
> > > -                {
>
> > > -                    Notify (S58, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x1000))
>
> > > -                {
>
> > > -                    Notify (S60, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x2000))
>
> > > -                {
>
> > > -                    Notify (S68, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x4000))
>
> > > -                {
>
> > > -                    Notify (S70, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x8000))
>
> > > -                {
>
> > > -                    Notify (S78, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00010000))
>
> > > -                {
>
> > > -                    Notify (S80, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00020000))
>
> > > -                {
>
> > > -                    Notify (S88, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00040000))
>
> > > -                {
>
> > > -                    Notify (S90, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00080000))
>
> > > -                {
>
> > > -                    Notify (S98, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00100000))
>
> > > -                {
>
> > > -                    Notify (SA0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00200000))
>
> > > -                {
>
> > > -                    Notify (SA8, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00400000))
>
> > > -                {
>
> > > -                    Notify (SB0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x00800000))
>
> > > -                {
>
> > > -                    Notify (SB8, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x01000000))
>
> > > -                {
>
> > > -                    Notify (SC0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x02000000))
>
> > > -                {
>
> > > -                    Notify (SC8, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x04000000))
>
> > > -                {
>
> > > -                    Notify (SD0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x08000000))
>
> > > -                {
>
> > > -                    Notify (SD8, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x10000000))
>
> > > -                {
>
> > > -                    Notify (SE0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x20000000))
>
> > > -                {
>
> > > -                    Notify (SE8, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x40000000))
>
> > > -                {
>
> > > -                    Notify (SF0, Arg1)
>
> > > -                }
>
> > > -
>
> > > -                If ((Arg0 & 0x80000000))
>
> > > -                {
>
> > > -                    Notify (SF8, Arg1)
>
> > > -                }
>
> > > -            }
>
> > > -
>
> > > -            Method (PCNT, 0, NotSerialized)
>
> > > -            {
>
> > > -                BNUM = Zero
>
> > > -                DVNT (PCIU, One)
>
> > > -                DVNT (PCID, 0x03)
>
> > > -            }
>
> > >          }
>
> > >      }
>
> > >  }
>
> > >
>
>

--00000000000042790505b0708a75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPk1heWJlIHlvdSBjYW4gZ2l2ZSBtZSBhY2Nlc3MgdG8geW91ciB3b3Jr
c3BhY2UgwqBhYW5lIEkgY2FuIHRha2UgYSBsb29rLjwvZGl2PjxkaXY+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCBT
ZXAgMjksIDIwMjAgYXQgMjoyMSBQTSBBbmkgU2luaGEgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlA
YW5pc2luaGEuY2EiPmFuaUBhbmlzaW5oYS5jYTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmct
bGVmdDoxZXg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KSI+T24gVHVlLCBTZXAg
MjksIDIwMjAgYXQgMTo1MyBQTSBBbmkgU2luaGEgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlAYW5p
c2luaGEuY2EiIHRhcmdldD0iX2JsYW5rIj5hbmlAYW5pc2luaGEuY2E8L2E+Jmd0OyB3cm90ZTo8
YnI+PGJyPiZndDs8YnI+PGJyPiZndDsgT24gVHVlLCBTZXAgMjksIDIwMjAgYXQgMTI6NTYgUE0g
TWljaGFlbCBTLiBUc2lya2luICZsdDs8YSBocmVmPSJtYWlsdG86bXN0QHJlZGhhdC5jb20iIHRh
cmdldD0iX2JsYW5rIj5tc3RAcmVkaGF0LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48YnI+Jmd0OyAm
Z3Q7PGJyPjxicj4mZ3Q7ICZndDsgT24gVHVlLCBTZXAgMjksIDIwMjAgYXQgMTI6NTM6MTdQTSAr
MDUzMCwgQW5pIFNpbmhhIHdyb3RlOjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgT24gVHVlLCBTZXAg
MjksIDIwMjAgYXQgMTI6NDIgUE0gTWljaGFlbCBTLiBUc2lya2luICZsdDs8YSBocmVmPSJtYWls
dG86bXN0QHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5tc3RAcmVkaGF0LmNvbTwvYT4mZ3Q7
IHdyb3RlOjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyBPbiBGcmksIFNlcCAxOCwgMjAyMCBhdCAwMjoxMToxMVBNICswNTMwLCBBbmkgU2luaGEg
d3JvdGU6PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgVGhpcyBjaGFuZ2UgYWRkcyBh
IG5ldyBEU0RUIGdvbGRlbiBtYXN0ZXIgdGFibGUgYmxvYiB0byB0ZXN0IGRpc2FibGluZzxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IGhvdHBsdWcgb24gYm90aCBwY2kgcm9vdCBidXMg
YW5kIHBjaSBicmlkZ2VzLiBBbHNvIHJldmVydHMgdGhlIGNoYW5nZTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IGluIGZpbGUgYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCB0
byBtYWtlIHN1cmUgaXRzIG5vdyBlbXB0eSBzbyB0aGF0PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgZnV0dXJlIG1vZGlmaWNhdGlvbnMgdG8gYWNwaSB0YWJsZXMgY2FuIGJlIGNhdWdo
dC48YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IFRoZSBmb2xsb3dpbmcgaXMgdGhlIGRpc2Fzc2VtYmxlZCBkaWZmIGJldHdlZW4g
RFNEVC5ocGJyaWRnZSBhbmQgRFNEVC5ocGJycm9vdDo8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEBAIC0xLDMwICsxLDMwIEBA
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCAvKjxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAqIEludGVsIEFDUEkgQ29tcG9uZW50IEFyY2hpdGVjdHVyZTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAqIEFNTC9BU0wrIERpc2Fzc2VtYmxlciB2
ZXJzaW9uIDIwMTgwMTA1ICg2NC1iaXQgdmVyc2lvbik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0O8KgIMKgKiBDb3B5cmlnaHQgKGMpIDIwMDAgLSAyMDE4IEludGVsIENvcnBvcmF0aW9u
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCo8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIMKgKiBEaXNhc3NlbWJsaW5nIHRvIHN5bWJvbGljIEFTTCsgb3BlcmF0
b3JzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCo8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtICogRGlzYXNzZW1ibHkgb2YgdGVzdHMvZGF0YS9hY3BpL3BjL0RT
RFQuaHBicmlkZ2UsIFdlZCBTZXAgMTYgMDk6NDU6NTYgMjAyMDxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICsgKiBEaXNhc3NlbWJseSBvZiAvdG1wL2FtbC1FQ1Y5UTAsIFdlZCBTZXAg
MTYgMDk6NDU6NTYgMjAyMDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAqPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCogT3JpZ2luYWwgVGFibGUgSGVhZGVy
Ojxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAqwqAgwqAgwqBTaWduYXR1cmXC
oCDCoCDCoCDCoCAmcXVvdDtEU0RUJnF1b3Q7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLSAqwqAgwqAgwqBMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoDB4MDAwMDEzMUYgKDQ4OTUpPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgKyAqwqAgwqAgwqBMZW5ndGjCoCDCoCDCoCDC
oCDCoCDCoDB4MDAwMDBCODkgKDI5NTMpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvC
oCDCoCrCoCDCoCDCoFJldmlzaW9uwqAgwqAgwqAgwqAgwqAweDAxICoqKiogMzItYml0IHRhYmxl
IChWMSksIG5vIDY0LWJpdCBtYXRoIHN1cHBvcnQ8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtICrCoCDCoCDCoENoZWNrc3VtwqAgwqAgwqAgwqAgwqAweEY5PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgKyAqwqAgwqAgwqBDaGVja3N1bcKgIMKgIMKgIMKgIMKgMHhBMjxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAqwqAgwqAgwqBPRU0gSUTCoCDCoCDC
oCDCoCDCoCDCoCZxdW90O0JPQ0hTICZxdW90Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAqwqAgwqAgwqBPRU0gVGFibGUgSUTCoCDCoCDCoCZxdW90O0JYUENEU0RUJnF1b3Q7
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCrCoCDCoCDCoE9FTSBSZXZpc2lv
bsKgIMKgIMKgMHgwMDAwMDAwMSAoMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IMKgKsKgIMKgIMKgQ29tcGlsZXIgSUTCoCDCoCDCoCAmcXVvdDtCWFBDJnF1b3Q7PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCrCoCDCoCDCoENvbXBpbGVyIFZlcnNpb24gMHgw
MDAwMDAwMSAoMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgKi88YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIERlZmluaXRpb25CbG9jayAoJnF1b3Q7JnF1b3Q7
LCAmcXVvdDtEU0RUJnF1b3Q7LCAxLCAmcXVvdDtCT0NIUyAmcXVvdDssICZxdW90O0JYUENEU0RU
JnF1b3Q7LCAweDAwMDAwMDAxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgezxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgU2NvcGUgKFwpPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBPcGVyYXRpb25SZWdpb24gKERCRywgU3lzdGVtSU8sIDB4
MDQwMiwgT25lKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
RmllbGQgKERCRywgQnl0ZUFjYywgTm9Mb2NrLCBQcmVzZXJ2ZSk8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIERCR0IswqAgwqA4PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBAQCAtMjM0LDY0ICsyMzQsMzIgQEA8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9ISUQsIEVp
c2FJZCAoJnF1b3Q7UE5QMEIwMCZxdW90OykgLyogQVQgUmVhbC1UaW1lIENsb2NrICovKcKgIC8v
IF9ISUQ6IEhhcmR3YXJlIElEPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCBOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpwqAgLy8gX0NSUzog
Q3VycmVudCBSZXNvdXJjZSBTZXR0aW5nczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSU8gKERlY29kZTE2LDxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDcwLMKgIMKg
IMKgIMKgIMKgIMKgIMKgLy8gUmFuZ2UgTWluaW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDcwLMKgIMKgIMKgIMKg
IMKgIMKgIMKgLy8gUmFuZ2UgTWF4aW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMSzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoC8vIEFsaWdubWVudDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwOCzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIExl
bmd0aDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSVJRTm9GbGFncyAoKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezh9PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCB9KTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIFNjb3BlIChfU0IuUENJMCk8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCBPcGVyYXRpb25SZWdpb24gKFBDU1QsIFN5c3RlbUlPLCAweEFFMDAs
IDB4MDgpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIEZpZWxk
IChQQ1NULCBEV29yZEFjYywgTm9Mb2NrLCBXcml0ZUFzWmVyb3MpPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgUENJVSzCoCDCoDMyLDxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBQQ0lELMKgIMKgMzI8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
T3BlcmF0aW9uUmVnaW9uIChTRUosIFN5c3RlbUlPLCAweEFFMDgsIDB4MDQpPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIEZpZWxkIChTRUosIERXb3JkQWNjLCBO
b0xvY2ssIFdyaXRlQXNaZXJvcyk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCBCMEVKLMKgIMKgMzI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgT3BlcmF0aW9uUmVnaW9uIChCTk1SLCBTeXN0
ZW1JTywgMHhBRTEwLCAweDA0KTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCBGaWVsZCAoQk5NUiwgRFdvcmRBY2MsIE5vTG9jaywgV3JpdGVBc1plcm9zKTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIEJOVU0swqAgwqAzMjxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCBNdXRleCAoQkxDSywgMHgwMCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgTWV0aG9kIChQQ0VKLCAyLCBOb3RTZXJpYWxpemVkKTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIEFjcXVpcmUgKEJMQ0ssIDB4RkZGRik8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgQk5VTSA9IEFyZzA8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgQjBFSiA9
IChPbmUgJmx0OyZsdDsgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgUmVsZWFzZSAoQkxDSyk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgUmV0dXJuIChaZXJvKTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCBTY29wZSAoX1NCKTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgU2NvcGUgKFBDSTApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCBNZXRob2QgKF9QUlQsIDAsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX1BSVDog
UENJIFJvdXRpbmcgVGFibGU8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIExvY2FsMCA9IFBhY2thZ2UgKDB4ODApe308YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsMSA9IFplcm88
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFdoaWxlICgoTG9jYWwxICZsdDsgMHg4MCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMb2NhbDIgPSAoTG9jYWwxICZn
dDsmZ3Q7IDB4MDIpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBMb2NhbDMgPSAoKExvY2FsMSArIExvY2FsMikgJmFtcDsgMHgw
Myk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIElmICgoTG9jYWwzID09IFplcm8pKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9j
YWw0ID0gUGFja2FnZSAoMHgwNCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyBAQCAtNjkwLDM4ICs2NTgsMzIgQEA8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX09TVCwgMywg
U2VyaWFsaXplZCnCoCAvLyBfT1NUOiBPU1BNIFN0YXR1cyBJbmRpY2F0aW9uPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBD
T1NUIChaZXJvLCBBcmcwLCBBcmcxLCBBcmcyKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAg
wqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDvCoCDCoCDCoCBNZXRob2QgKFxfR1BFLl9FMDIsIDAsIE5vdFNlcmlhbGl6ZWQp
wqAgLy8gX0V4eDogRWRnZS1UcmlnZ2VyZWQgR1BFPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCBcX1NCLkNQVVMuQ1NDTiAoKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCBTY29wZSAoX0dQRSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0O8KgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIE5hbWUgKF9ISUQsICZxdW90O0FDUEkwMDA2JnF1b3Q7IC8qIEdQRSBCbG9jayBE
ZXZpY2UgKi8pwqAgLy8gX0hJRDogSGFyZHdhcmUgSUQ8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgTWV0aG9kIChfRTAxLCAwLCBOb3RTZXJpYWxpemVkKcKgIC8v
IF9FeHg6IEVkZ2UtVHJpZ2dlcmVkIEdQRTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIEFjcXVpcmUgKFxfU0IuUENJMC5CTENLLCAweEZGRkYpPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIFxfU0IuUENJMC5QQ05UICgpPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIFJlbGVhc2Ug
KFxfU0IuUENJMC5CTENLKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCB9PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IMKgIMKgIFNjb3BlIChcX1NCLlBDSTApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvC
oCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBO
YW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpwqAgLy8gX0NSUzogQ3VycmVudCBSZXNvdXJj
ZSBTZXR0aW5nczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgV29y
ZEJ1c051bWJlciAoUmVzb3VyY2VQcm9kdWNlciwgTWluRml4ZWQsIE1heEZpeGVkLCBQb3NEZWNv
ZGUsPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAweDAwMDAswqAgwqAgwqAgwqAgwqAgwqAgwqAvLyBHcmFudWxhcml0eTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDAwLMKg
IMKgIMKgIMKgIMKgIMKgIMKgLy8gUmFuZ2UgTWluaW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMEZGLMKgIMKgIMKgIMKgIMKg
IMKgIMKgLy8gUmFuZ2UgTWF4aW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDAwLMKgIMKgIMKgIMKgIMKgIMKgIMKgLy8gVHJh
bnNsYXRpb24gT2Zmc2V0PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAweDAxMDAswqAgwqAgwqAgwqAgwqAgwqAgwqAvLyBMZW5ndGg8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICws
ICk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIElP
IChEZWNvZGUxNiw8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIDB4MENGOCzCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIFJhbmdlIE1pbmltdW08
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDB4MENGOCzCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIFJhbmdlIE1heGltdW08YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyBAQCAtNzY2LDQ4ICs3MjgsMzIgQEA8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIH0pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKEdQRTApPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfSElELCAmcXVvdDtQTlAwQTA2JnF1b3Q7IC8q
IEdlbmVyaWMgQ29udGFpbmVyIERldmljZSAqLynCoCAvLyBfSElEOiBIYXJkd2FyZSBJRDxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1VJ
RCwgJnF1b3Q7R1BFMCByZXNvdXJjZXMmcXVvdDspwqAgLy8gX1VJRDogVW5pcXVlIElEPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1RB
LCAweDBCKcKgIC8vIF9TVEE6IFN0YXR1czxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0NSUywgUmVzb3VyY2VUZW1wbGF0ZSAoKcKgIC8v
IF9DUlM6IEN1cnJlbnQgUmVzb3VyY2UgU2V0dGluZ3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElPIChEZWNvZGUxNiw8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4QUZF
MCzCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIFJhbmdlIE1pbmltdW08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4QUZFMCzCoCDC
oCDCoCDCoCDCoCDCoCDCoC8vIFJhbmdlIE1heGltdW08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDEswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAvLyBBbGlnbm1lbnQ8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDQswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAvLyBMZW5ndGg8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIH0pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCBEZXZpY2UgKFBIUFIpPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0hJRCwgJnF1b3Q7UE5QMEEwNiZx
dW90OyAvKiBHZW5lcmljIENvbnRhaW5lciBEZXZpY2UgKi8pwqAgLy8gX0hJRDogSGFyZHdhcmUg
SUQ8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgTmFt
ZSAoX1VJRCwgJnF1b3Q7UENJIEhvdHBsdWcgcmVzb3VyY2VzJnF1b3Q7KcKgIC8vIF9VSUQ6IFVu
aXF1ZSBJRDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCBOYW1lIChfU1RBLCAweDBCKcKgIC8vIF9TVEE6IFN0YXR1czxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBs
YXRlICgpwqAgLy8gX0NSUzogQ3VycmVudCBSZXNvdXJjZSBTZXR0aW5nczxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElPIChEZWNvZGUxNiw8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgMHhBRTAwLMKgIMKgIMKgIMKgIMKgIMKgIMKgLy8gUmFuZ2UgTWluaW11bTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweEFF
MDAswqAgwqAgwqAgwqAgwqAgwqAgwqAvLyBSYW5nZSBNYXhpbXVtPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDEswqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAvLyBBbGlnbm1lbnQ8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgxNCzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC8vIExlbmd0aDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIH0pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIH08YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgU2NvcGUgKFwpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDC
oCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBOYW1l
IChfUzMsIFBhY2thZ2UgKDB4MDQpwqAgLy8gX1MzXzogUzMgU3lzdGVtIFN0YXRlPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCBPbmUsPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCBPbmUsPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCBaZXJvLDxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgWmVybzxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgfSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIE5hbWUgKF9TNCwgUGFja2FnZSAoMHgwNCnCoCAvLyBfUzRf
OiBTNCBTeXN0ZW0gU3RhdGU8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIDB4MDIsPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCAweDAyLDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgWmVybyw8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBAQCAtODMxLDQ3OSAr
Nzc3LDQ4IEBAPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOYW1lIChfQ1JTLCBSZXNvdXJjZVRlbXBsYXRlICgpwqAgLy8gX0NSUzogQ3VycmVudCBS
ZXNvdXJjZSBTZXR0aW5nczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSU8gKERlY29kZTE2LDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwNTEwLMKgIMKgIMKgIMKgIMKg
IMKgIMKgLy8gUmFuZ2UgTWluaW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwNTEwLMKgIMKgIMKgIMKgIMKgIMKgIMKg
Ly8gUmFuZ2UgTWF4aW11bTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIEFs
aWdubWVudDxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgMHgwQyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIExlbmd0aDxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
fSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIH08YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgU2NvcGUg
KFxfU0IpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCB7PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBTY29wZSAoUENJMCk8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoQlNFTCwgWmVybyk8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAo
UzAwKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTmFtZSAoX0FEUiwgWmVybynCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIERldmljZSAoUzEwKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDAyMDAwMCnCoCAvLyBfQURSOiBBZGRy
ZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBNZXRob2QgKF9TMUQsIDAsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX1MxRDogUzEgRGV2aWNl
IFN0YXRlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBSZXR1cm4gKFplcm8pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE1ldGhvZCAoX1MyRCwgMCwgTm90U2VyaWFsaXplZCnCoCAvLyBfUzJEOiBTMiBE
ZXZpY2UgU3RhdGU8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJldHVybiAoWmVybyk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfUzNELCAwLCBOb3RTZXJpYWxpemVkKcKgIC8vIF9TM0Q6
IFMzIERldmljZSBTdGF0ZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUmV0dXJuIChaZXJvKTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCBEZXZpY2UgKFMxOCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAwMzAwMDApwqAgLy8gX0FEUjog
QWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTMjApPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgw
NCnCoCAvLyBfU1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAwNDAwMDApwqAg
Ly8gX0FEUjogQWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VK
eDogRWplY3QgRGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCBEZXZpY2UgKFMyOCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA1KcKgIC8vIF9TVU46IFNsb3QgVXNl
ciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDA1MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhv
ZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBQQ0VKIChCU0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoUzMw
KTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5h
bWUgKF9TVU4sIDB4MDYpwqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAw
eDAwMDYwMDAwKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxp
emVkKcKgIC8vIF9FSng6IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTMzgpPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgwNynCoCAvLyBf
U1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAwNzAwMDApwqAgLy8gX0FEUjog
QWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3Qg
RGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCBEZXZpY2UgKFM0MCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA4KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
TmFtZSAoX0FEUiwgMHgwMDA4MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwg
MSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VKIChC
U0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoUzQ4KTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9TVU4s
IDB4MDkpwqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAweDAwMDkwMDAw
KcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKgIC8v
IF9FSng6IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTNTApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgwQSnCoCAvLyBfU1VOOiBTbG90
IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAwQTAwMDApwqAgLy8gX0FEUjogQWRkcmVzczxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBN
ZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNlPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2Ug
KFM1OCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBOYW1lIChfU1VOLCAweDBCKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FE
UiwgMHgwMDBCMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2Vy
aWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VKIChCU0VMLCBfU1VO
KTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoUzYwKTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9TVU4sIDB4MEMpwqAg
Ly8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAweDAwMEMwMDAwKcKgIC8vIF9B
RFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKgIC8vIF9FSng6IEVq
ZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgRGV2aWNlIChTNjgpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgwRCnCoCAvLyBfU1VOOiBTbG90IFVzZXIgTnVt
YmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE5hbWUgKF9BRFIsIDB4MDAwRDAwMDApwqAgLy8gX0FEUjogQWRkcmVzczxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKF9F
SjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNlPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENF
SiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM3MCk8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChf
U1VOLCAweDBFKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDBF
MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnC
oCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VKIChCU0VMLCBfU1VOKTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoUzc4KTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9TVU4sIDB4MEYpwqAgLy8gX1NVTjog
U2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAweDAwMEYwMDAwKcKgIC8vIF9BRFI6IEFkZHJl
c3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKgIC8vIF9FSng6IEVqZWN0IERldmlj
ZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2
aWNlIChTODApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgTmFtZSAoX1NVTiwgMHgxMCnCoCAvLyBfU1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUg
KF9BRFIsIDB4MDAxMDAwMDApwqAgLy8gX0FEUjogQWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5v
dFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwg
X1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM4OCk8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDEx
KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDExMDAwMCnCoCAv
LyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4
OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VKIChCU0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIERldmljZSAoUzkwKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9TVU4sIDB4MTIpwqAgLy8gX1NVTjogU2xvdCBVc2Vy
IE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOYW1lIChfQURSLCAweDAwMTIwMDAwKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9k
IChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKgIC8vIF9FSng6IEVqZWN0IERldmljZTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTOTgp
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFt
ZSAoX1NVTiwgMHgxMynCoCAvLyBfU1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4
MDAxMzAwMDApwqAgLy8gX0FEUjogQWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6
ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNBMCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDE0KcKgIC8vIF9T
VU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDE0MDAwMCnCoCAvLyBfQURSOiBB
ZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBE
ZXZpY2U8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBQQ0VKIChCU0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IERldmljZSAoU0E4KTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE5hbWUgKF9TVU4sIDB4MTUpwqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
YW1lIChfQURSLCAweDAwMTUwMDAwKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAx
LCBOb3RTZXJpYWxpemVkKcKgIC8vIF9FSng6IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJT
RUwsIF9TVU4pPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTQjApPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwg
MHgxNinCoCAvLyBfU1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAxNjAwMDAp
wqAgLy8gX0FEUjogQWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8g
X0VKeDogRWplY3QgRGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNCOCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDE3KcKgIC8vIF9TVU46IFNsb3Qg
VXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDE3MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1l
dGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBQQ0VKIChCU0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAo
U0MwKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IE5hbWUgKF9TVU4sIDB4MTgpwqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURS
LCAweDAwMTgwMDAwKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJp
YWxpemVkKcKgIC8vIF9FSng6IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4p
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTQzgpPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgxOSnCoCAv
LyBfU1VOOiBTbG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAxOTAwMDApwqAgLy8gX0FE
UjogQWRkcmVzczxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWpl
Y3QgRGV2aWNlPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCBEZXZpY2UgKFNEMCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDFBKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1i
ZXI8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTmFtZSAoX0FEUiwgMHgwMDFBMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VK
MCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VK
IChCU0VMLCBfU1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoU0Q4KTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9T
VU4sIDB4MUIpwqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAweDAwMUIw
MDAwKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKg
IC8vIF9FSng6IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTRTApPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgxQynCoCAvLyBfU1VOOiBT
bG90IFVzZXIgTnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAxQzAwMDApwqAgLy8gX0FEUjogQWRkcmVz
czxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBNZXRob2QgKF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNl
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
LTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZp
Y2UgKFNFOCk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOYW1lIChfU1VOLCAweDFEKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAo
X0FEUiwgMHgwMDFEMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90
U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2U8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQQ0VKIChCU0VMLCBf
U1VOKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIERldmljZSAoU0YwKTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9TVU4sIDB4MUUp
wqAgLy8gX1NVTjogU2xvdCBVc2VyIE51bWJlcjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfQURSLCAweDAwMUUwMDAwKcKgIC8v
IF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTWV0aG9kIChfRUowLCAxLCBOb3RTZXJpYWxpemVkKcKgIC8vIF9FSng6
IEVqZWN0IERldmljZTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFBDRUogKEJTRUwsIF9TVU4pPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgRGV2aWNlIChTRjgpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX1NVTiwgMHgxRinCoCAvLyBfU1VOOiBTbG90IFVzZXIg
TnVtYmVyPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIE5hbWUgKF9BRFIsIDB4MDAxRjAwMDApwqAgLy8gX0FEUjogQWRkcmVzczxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZXRob2Qg
KF9FSjAsIDEsIE5vdFNlcmlhbGl6ZWQpwqAgLy8gX0VKeDogRWplY3QgRGV2aWNlPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
UENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKERWTlQs
IDIsIE5vdFNlcmlhbGl6ZWQpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MTApKTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzIw
LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFt
cDsgMHgyMCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTMjgsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDQwKSk8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFMz
MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZh
bXA7IDB4ODApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzM4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwMTAwKSk8YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkg
KFM0MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcw
ICZhbXA7IDB4MDIwMCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTNDgsIEFyZzEpPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDA0MDApKTxicj48YnI+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5v
dGlmeSAoUzUwLCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAo
KEFyZzAgJmFtcDsgMHgwODAwKSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFM1OCwgQXJnMSk8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MTAwMCkpPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTm90aWZ5IChTNjAsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IElmICgoQXJnMCAmYW1wOyAweDIwMDApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzY4LCBBcmcxKTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHg0MDAwKSk8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOb3RpZnkgKFM3MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgSWYgKChBcmcwICZhbXA7IDB4ODAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTNzgsIEFyZzEp
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDAw
MDEwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFM4MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDAwMjAwMDApKTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlm
eSAoUzg4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFy
ZzAgJmFtcDsgMHgwMDA0MDAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTOTAsIEFyZzEpPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJy
PiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDAwMDgwMDAwKSk8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOb3RpZnkgKFM5OCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDAxMDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0EwLCBB
cmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsg
MHgwMDIwMDAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTQTgsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDAwNDAwMDAwKSk8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
b3RpZnkgKFNCMCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYg
KChBcmcwICZhbXA7IDB4MDA4MDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0I4LCBBcmcxKTxicj48
YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJy
Pjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwMTAwMDAw
MCkpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTm90aWZ5IChTQzAsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDAyMDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFND
OCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZh
bXA7IDB4MDQwMDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0QwLCBBcmcxKTxicj48YnI+Jmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwODAwMDAwMCkpPGJyPjxi
cj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTm90aWZ5IChTRDgsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAt
PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IElmICgoQXJnMCAmYW1wOyAweDEwMDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFNFMCwgQXJnMSk8
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MjAw
MDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0U4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHg0MDAwMDAwMCkpPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5
IChTRjAsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJn
MCAmYW1wOyAweDgwMDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFNGOCwgQXJnMSk8YnI+PGJyPiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKFBDTlQsIDAsIE5vdFNlcmlhbGl6ZWQpPGJyPjxicj4m
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQk5VTSA9IFplcm88
YnI+PGJyPiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
RFZOVCAoUENJVSwgT25lKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBEVk5UIChQQ0lELCAweDAzKTxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDvCoCB9PGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRoaXMgaXMgbm90IHRoZSBv
bmx5IGRpZmYgSSBzZWUgaWYgSSBhcHBseSB0aGlzIHBhdGNoc2V0IG9uPGJyPjxicj4mZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IHRvcCBvZiBtYXN0ZXIuPGJyPjxicj4mZ3Q7ICZndDsgJmd0OyAmZ3Q7IERy
b3BwZWQgdGhpcyBhbmQgdGhlIHByZXZpb3VzIHBhdGNoLjxicj48YnI+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyBQbGVhc2UgY2hlY2sgd2hhdCBpcyBnb2luZyBvbiBhbmQgcmVwb3N0IGFzIGFwcHJvcHJp
YXRlLjxicj48YnI+Jmd0OyAmZ3Q7ICZndDs8YnI+PGJyPiZndDsgJmd0OyAmZ3Q7IFdoaWNoIHR3
byBBQ1BJIERTRFQgZmlsZXMgYXJlIHlvdSBkaWZmaW5nPyBXaGF0IGRpZmYgYXJlIHlvdSBnZXR0
aW5nPzxicj48YnI+Jmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDs8YnI+PGJyPiZndDsgJmd0OyBk
aWZmIC1ydXAgLi90ZXN0cy9kYXRhL2FjcGkvcGMvRFNEVC5ocGJyaWRnZS5kc2wgLi90ZXN0cy9k
YXRhL2FjcGkvcGMvRFNEVC5ocGJycm9vdC5kc2w8YnI+PGJyPiZndDs8YnI+PGJyPiZndDsgSSBy
ZS1iYXNlZCBteSBwYXRjaHNldCBvbiB0b3Agb2YgdGhlIGxhdGVzdCBxZW11IG1hc3RlciBhbmQg
ZGlkIGEgbWFrZTxicj48YnI+Jmd0O8KgICZhbXA7JmFtcDsgbWFrZSBjaGVjay1xdGVzdC14ODZf
NjQgVj0xLjxicj48YnI+Jmd0OyBUaGV5IHBhc3MuIEkgYW0gc2VlaW5nIHRoaXMgZGlmZjo8YnI+
PGJyPiZndDsgPGEgaHJlZj0iaHR0cHM6Ly9wYXN0ZWJpbi51YnVudHUuY29tL3AvQlh5OUdGZkIy
Ui8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcGFzdGViaW4udWJ1
bnR1LmNvbS9wL0JYeTlHRmZCMlIvPC9hPjxicj48YnI+Jmd0Ozxicj48YnI+Jmd0OyBhbmQgaXQg
bG9va3MgZ29vZCB0byBtZS48YnI+PGJyPiZndDs8YnI+PGJyPiZndDsgTm90IHN1cmUgd2h5IHlv
dXIgZGlmZiBsb29rcyBkaWZmZXJlbnQuIE1heWJlIHlvdSBjYW4gcmVnZW5lcmF0ZSB0aGUgYmxv
Yj88YnI+PGJyPjxicj48YnI+SSBkaWQgYSBmdWxsIG1ha2UgY2hlY2sgYW5kIGl0IHBhc3NlZC4g
SSBjb21wYXJlZCB0aGUgZGlmZiBhZ2FpbiBhbmQ8YnI+PGJyPml0JiMzOTtzIHRoZSBzYW1lLiBJ
IGNoZWNrZWQgbXkgdHJlZSBhbmQgaXQgbG9va3MgY2xlYW4uIFRoZXNlIGFyZSB0aGU8YnI+PGJy
PnBhdGNoZXMgSSBoYXZlOjxicj48YnI+PGJyPjxicj4kIGdpdCBsb2cgLS1vbmVsaW5lPGJyPjxi
cj4yMGQxMzIzZTEwIChIRUFEIC0mZ3Q7IG1hc3RlcikgcW9tOiBjb2RlIGhhcmRlbmluZyAtIGhh
dmUgYm91bmQgY2hlY2tpbmc8YnI+PGJyPndoaWxlIGxvb3Bpbmcgd2l0aCBpbnRlZ2VyIHZhbHVl
PGJyPjxicj4wZjY5ZGFlMGUyIEFkZCBhIGNvbW1lbnQgaW4gYmlvcy10YWJsZXMtdGVzdC5jIHRv
IGNsYXJpZnkgdGhlIHJlYXNvbjxicj48YnI+YmVoaW5kIGFwcHJvYWNoPGJyPjxicj5kZDlhOGMz
Y2QzIHRlc3RzL2FjcGk6IGFkZCBEU0RULmhwYnJyb290IERTRFQgdGFibGUgYmxvYiB0byB0ZXN0
PGJyPjxicj5nbG9iYWwgaTQ0MGZ4IGhvdHBsdWc8YnI+PGJyPjViOTM0NzRmZTkgdGVzdHMvYWNw
aTogdW5pdCB0ZXN0IGV4ZXJjaXNpbmcgZ2xvYmFsIHBjaSBob3RwbHVnIG9mZiBmb3IgaTQ0MGZ4
PGJyPjxicj41NGMzM2UzMzRhIHRlc3RzL2FjcGk6IHVwZGF0ZSBnb2xkZW4gbWFzdGVyIERTRFQg
YmluYXJ5IHRhYmxlIGJsb2JzIGZvciBxMzU8YnI+PGJyPjIyNzlmNjFmMzAgcGlpeDQ6IGRvbiYj
Mzk7dCByZXNlcnZlIGh3IHJlc291cmNlcyB3aGVuIGhvdHBsdWcgaXMgb2ZmIGdsb2JhbGx5PGJy
Pjxicj4xZjYxYzUyNGEwIEFkZCBBQ1BJIERTRFQgdGFibGVzIGZvciBxMzUgdGhhdCBhcmUgYmVp
bmcgdXBkYXRlZCBieSB0aGUgbmV4dCBwYXRjaDxicj48YnI+YmRkODIzNjExYiB0ZXN0cy9hY3Bp
OiBhZGQgbmV3bHkgYWRkZWQgYWNwaSBEU0RUIHRhYmxlIGJsb2IgZm9yIHBjaTxicj48YnI+YnJp
ZGdlIGhvdHBsdWcgZmxhZzxicj48YnI+OGM4MGY4ZmJhOSB0ZXN0cy9hY3BpOiB1bml0IHRlc3Qg
Zm9yPGJyPjxicj4mIzM5O2FjcGktcGNpLWhvdHBsdWctd2l0aC1icmlkZ2Utc3VwcG9ydCYjMzk7
IGJyaWRnZSBmbGFnPGJyPjxicj5lMGEzMTQyZGY5IHRlc3RzL2FjcGk6IGxpc3QgYWRkZWQgYWNw
aSB0YWJsZSBiaW5hcnkgZmlsZSBmb3IgcGNpPGJyPjxicj5icmlkZ2UgaG90cGx1ZyB0ZXN0PGJy
Pjxicj4wYmEwODMxN2E4IGk0NDBmeC9hY3BpOiBkbyBub3QgYWRkIGhvdHBsdWcgcmVsYXRlZCBh
bWxzIGZvciBjb2xkIHBsdWdnZWQgYnJpZGdlczxicj48YnI+NzNiMTkxYWRlNiBGaXggYSBnYXAg
d2hlcmUgYWNwaV9wY2locF9maW5kX2hvdHBsdWdfYnVzKCkgcmV0dXJucyBhPGJyPjxicj5ub24t
aG90cGx1Z2dhYmxlIGJ1czxicj48YnI+ZWYwZTUyNmNjMiB0ZXN0cy9hY3BpOiBhZGQgYSBuZXcg
QUNQSSB0YWJsZSBpbiBvcmRlciB0byB0ZXN0IHJvb3QgcGNpPGJyPjxicj5ob3RwbHVnIG9uL29m
Zjxicj48YnI+YzZkMTMyNjRmOCB0ZXN0cy9hY3BpOiBhZGQgbmV3IHVuaXQgdGVzdCB0byB0ZXN0
IGhvdHBsdWcgb2ZmL29uPGJyPjxicj5mZWF0dXJlIG9uIHRoZSByb290IHBjaSBidXM8YnI+PGJy
PjY5MDFiYWRhNjUgdGVzdHMvYWNwaTogbWFyayBhZGRpdGlvbiBvZiB0YWJsZSBEU0RULnJvb3Ro
cCBmb3IgdW5pdDxicj48YnI+dGVzdGluZyByb290IHBjaSBob3RwbHVnPGJyPjxicj43NDUwNDUx
NGIxIChvcmlnaW4vbWFzdGVyLCBvcmlnaW4vSEVBRCkgTWVyZ2UgcmVtb3RlLXRyYWNraW5nIGJy
YW5jaDxicj48YnI+JiMzOTtyZW1vdGVzL2FsaXN0YWlyL3RhZ3MvcHVsbC1yZWdpc3Rlci0yMDIw
MDkyNyYjMzk7IGludG8gc3RhZ2luZzxicj48YnI+PGJyPjxicj48YnI+PGJyPiZndDs8YnI+PGJy
PiZndDsgJmd0Ozxicj48YnI+Jmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDs8YnI+PGJyPiZndDsg
Jmd0OyAtLS0gLi90ZXN0cy9kYXRhL2FjcGkvcGMvRFNEVC5ocGJyaWRnZS5kc2zCoCDCoCDCoCAy
MDIwLTA5LTI5IDAyOjQ0OjQzLjg3NDYyMjQwNCAtMDQwMDxicj48YnI+Jmd0OyAmZ3Q7ICsrKyAu
L3Rlc3RzL2RhdGEvYWNwaS9wYy9EU0RULmhwYnJyb290LmRzbMKgIMKgIMKgIDIwMjAtMDktMjkg
MDI6NDQ6NDMuODc2NjIyNDAzIC0wNDAwPGJyPjxicj4mZ3Q7ICZndDsgQEAgLTUsMTMgKzUsMTMg
QEA8YnI+PGJyPiZndDsgJmd0O8KgIMKgKjxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAqIERpc2Fzc2Vt
YmxpbmcgdG8gc3ltYm9saWMgQVNMKyBvcGVyYXRvcnM8YnI+PGJyPiZndDsgJmd0O8KgIMKgKjxi
cj48YnI+Jmd0OyAmZ3Q7IC0gKiBEaXNhc3NlbWJseSBvZiB0ZXN0cy9kYXRhL2FjcGkvcGMvRFNE
VC5ocGJyaWRnZSwgVHVlIFNlcCAyOSAwMjo0NDo0MyAyMDIwPGJyPjxicj4mZ3Q7ICZndDsgKyAq
IERpc2Fzc2VtYmx5IG9mIHRlc3RzL2RhdGEvYWNwaS9wYy9EU0RULmhwYnJyb290LCBUdWUgU2Vw
IDI5IDAyOjQ0OjQzIDIwMjA8YnI+PGJyPiZndDsgJmd0O8KgIMKgKjxicj48YnI+Jmd0OyAmZ3Q7
wqAgwqAqIE9yaWdpbmFsIFRhYmxlIEhlYWRlcjo8YnI+PGJyPiZndDsgJmd0O8KgIMKgKsKgIMKg
IMKgU2lnbmF0dXJlwqAgwqAgwqAgwqAgJnF1b3Q7RFNEVCZxdW90Ozxicj48YnI+Jmd0OyAmZ3Q7
IC0gKsKgIMKgIMKgTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAweDAwMDAxMzlEICg1MDIxKTxicj48
YnI+Jmd0OyAmZ3Q7ICsgKsKgIMKgIMKgTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAweDAwMDAwQjg5
ICgyOTUzKTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAqwqAgwqAgwqBSZXZpc2lvbsKgIMKgIMKgIMKg
IMKgMHgwMSAqKioqIDMyLWJpdCB0YWJsZSAoVjEpLCBubyA2NC1iaXQgbWF0aCBzdXBwb3J0PGJy
Pjxicj4mZ3Q7ICZndDsgLSAqwqAgwqAgwqBDaGVja3N1bcKgIMKgIMKgIMKgIMKgMHgwNTxicj48
YnI+Jmd0OyAmZ3Q7ICsgKsKgIMKgIMKgQ2hlY2tzdW3CoCDCoCDCoCDCoCDCoDB4QTI8YnI+PGJy
PiZndDsgJmd0O8KgIMKgKsKgIMKgIMKgT0VNIElEwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtCT0NI
UyAmcXVvdDs8YnI+PGJyPiZndDsgJmd0O8KgIMKgKsKgIMKgIMKgT0VNIFRhYmxlIElEwqAgwqAg
wqAmcXVvdDtCWFBDRFNEVCZxdW90Ozxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAqwqAgwqAgwqBPRU0g
UmV2aXNpb27CoCDCoCDCoDB4MDAwMDAwMDEgKDEpPGJyPjxicj4mZ3Q7ICZndDsgQEAgLTI0Nywz
OCArMjQ3LDYgQEAgRGVmaW5pdGlvbkJsb2NrICgmcXVvdDsmcXVvdDssICZxdW90O0RTRFQmcXVv
dDssIDEsICZxdW90O0JPQ0hTICZxdW90Ozxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
fTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIFNjb3BlIChfU0IuUENJMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgezxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCBPcGVyYXRpb25SZWdpb24gKFBDU1QsIFN5c3Rl
bUlPLCAweEFFMDAsIDB4MDgpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIEZpZWxkIChQ
Q1NULCBEV29yZEFjYywgTm9Mb2NrLCBXcml0ZUFzWmVyb3MpPGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgUENJVSzCoCDC
oDMyLDxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBQQ0lELMKgIMKgMzI8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgT3BlcmF0aW9uUmVnaW9uIChTRUosIFN5c3RlbUlPLCAweEFF
MDgsIDB4MDQpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIEZpZWxkIChTRUosIERXb3Jk
QWNjLCBOb0xvY2ssIFdyaXRlQXNaZXJvcyk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBCMEVKLMKgIMKgMzI8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgT3BlcmF0aW9uUmVnaW9uIChCTk1SLCBTeXN0ZW1JTywgMHhBRTEw
LCAweDA0KTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCBGaWVsZCAoQk5NUiwgRFdvcmRB
Y2MsIE5vTG9jaywgV3JpdGVBc1plcm9zKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB7
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIEJOVU0swqAgwqAzMjxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCBNdXRleCAoQkxDSywgMHgwMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgTWV0aG9kIChQQ0VKLCAyLCBOb3RTZXJpYWxpemVkKTxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIEFjcXVp
cmUgKEJMQ0ssIDB4RkZGRik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgQk5V
TSA9IEFyZzA8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgQjBFSiA9IChPbmUg
Jmx0OyZsdDsgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgUmVsZWFz
ZSAoQkxDSyk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgUmV0dXJuIChaZXJv
KTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IH08YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCBTY29wZSAoX1NC
KTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgU2NvcGUgKFBDSTApPGJyPjxicj4mZ3Q7ICZndDsgQEAgLTY0Myw1NiArNjExLDIyIEBAIERl
ZmluaXRpb25CbG9jayAoJnF1b3Q7JnF1b3Q7LCAmcXVvdDtEU0RUJnF1b3Q7LCAxLCAmcXVvdDtC
T0NIUyAmcXVvdDs8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAo
Q1NDTiwgMCwgU2VyaWFsaXplZCk8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IHs8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFjcXVpcmUgKFxf
U0IuUENJMC5QUkVTLkNQTEssIDB4RkZGRik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTmFtZSAoQ05FVywgUGFja2FnZSAoMHhGRil7fSk8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9jYWwzID0gWmVybzxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMb2NhbDQgPSBPbmU8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgV2hpbGUgKChMb2NhbDQgPT0gT25lKSk8YnI+PGJyPiZn
dDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9jYWwwID0gT25lPGJyPjxicj4mZ3Q7
ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFdoaWxlICgoTG9jYWwwID09IE9uZSkpPGJy
Pjxicj4mZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsNCA9IFplcm88YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9jYWwwID0gT25lPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsMSA9IFplcm88
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgV2hpbGUgKCgo
TG9jYWwwID09IE9uZSkgJmFtcDsmYW1wOyAoTG9jYWwzICZsdDsgT25lKSkpPGJyPjxicj4mZ3Q7
ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsMCA9IFplcm88YnI+PGJy
PiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXF9TQi5QQ0kwLlBSRVMu
Q0NNRCA9IFplcm88YnI+PGJyPiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgSWYgKChcX1NCLlBDSTAuUFJFUy5DSU5TID09IE9uZSkpPGJyPjxicj4mZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsMCA9IFplcm88YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXF9TQi5QQ0kwLlBSRVMuQ1NF
TCA9IExvY2FsMzxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcX1NCLlBDSTAuUFJFUy5DQ01EID0gWmVybzxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKFxfU0IuUENJMC5QUkVTLkNEQVQg
Jmx0OyBMb2NhbDMpKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIEJyZWFrPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoTG9jYWwxID09IDB4RkYp
KTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIExvY2FsNCA9IE9uZTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBCcmVhazxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMb2NhbDMgPSBcX1NCLlBD
STAuUFJFUy5DREFUPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIElmICgoXF9TQi5QQ0kwLlBSRVMuQ0lOUyA9PSBPbmUpKTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIENORVcgW0xvY2Fs
MV0gPSBMb2NhbDM8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTG9jYWwxKys8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9jYWwwID0gT25lPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRWxzZUlmICgoXF9TQi5QQ0kwLlBS
RVMuQ1JNViA9PSBPbmUpKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIENURlkgKExvY2FsMywgMHgwMyk8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXF9TQi5QQ0kwLlBSRVMu
Q1JNViA9IE9uZTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBMb2NhbDAgPSBPbmU8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTG9jYWwzKys8YnI+PGJy
PiZndDsgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ1RGWSAoXF9T
Qi5QQ0kwLlBSRVMuQ0RBVCwgT25lKTxicj48YnI+Jmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcX1NCLlBDSTAuUFJFUy5DSU5TID0gT25lPGJyPjxicj4mZ3Q7
ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2FsMCA9IE9uZTxi
cj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTG9jYWwyID0gWmVybzxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBXaGlsZSAoKExvY2FsMiAmbHQ7IExvY2FsMSkpPGJyPjxicj4mZ3Q7ICZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVsc2VJZiAoKFxfU0IuUENJMC5QUkVTLkNSTVYg
PT0gT25lKSk8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
TG9jYWwzID0gRGVyZWZPZiAoQ05FVyBbTG9jYWwyXSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ1RGWSAoTG9jYWwzLCBPbmUpPGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERlYnVnID0gTG9j
YWwzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFxfU0IuUENJMC5QUkVTLkNTRUwgPSBMb2NhbDM8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXF9TQi5QQ0kwLlBSRVMuQ0lOUyA9IE9uZTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMb2NhbDIr
Kzxicj48YnI+Jmd0OyAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBD
VEZZIChcX1NCLlBDSTAuUFJFUy5DREFULCAweDAzKTxicj48YnI+Jmd0OyAmZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcX1NCLlBDSTAuUFJFUy5DUk1WID0gT25lPGJy
Pjxicj4mZ3Q7ICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIExvY2Fs
MCA9IE9uZTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0
OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDsgQEAgLTczNywxMiArNjcxLDYgQEAgRGVmaW5pdGlvbkJs
b2NrICgmcXVvdDsmcXVvdDssICZxdW90O0RTRFQmcXVvdDssIDEsICZxdW90O0JPQ0hTICZxdW90
Ozxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgU2NvcGUgKF9HUEUpPGJyPjxicj4mZ3Q7ICZndDvC
oCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCBOYW1lIChfSElELCAmcXVv
dDtBQ1BJMDAwNiZxdW90OyAvKiBHUEUgQmxvY2sgRGV2aWNlICovKcKgIC8vIF9ISUQ6IEhhcmR3
YXJlIElEPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIE1ldGhvZCAoX0UwMSwgMCwgTm90
U2VyaWFsaXplZCnCoCAvLyBfRXh4OiBFZGdlLVRyaWdnZXJlZCBHUEUsIHh4PTB4MDAtMHhGRjxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIEFjcXVpcmUgKFxfU0IuUENJMC5CTENLLCAweEZGRkYpPGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIFxfU0IuUENJMC5QQ05UICgpPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIFJlbGVhc2UgKFxfU0IuUENJMC5CTENLKTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7
ICZndDs8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIFNjb3BlIChcX1NCLlBDSTApPGJyPjxicj4m
Z3Q7ICZndDsgQEAgLTgxMywyMiArNzQxLDYgQEAgRGVmaW5pdGlvbkJsb2NrICgmcXVvdDsmcXVv
dDssICZxdW90O0RTRFQmcXVvdDssIDEsICZxdW90O0JPQ0hTICZxdW90Ozxicj48YnI+Jmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKTxicj48YnI+Jmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgfSk8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIH08YnI+
PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIERldmljZSAoUEhQ
Uik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCBOYW1lIChfSElELCAmcXVvdDtQTlAwQTA2JnF1b3Q7IC8qIEdlbmVyaWMg
Q29udGFpbmVyIERldmljZSAqLynCoCAvLyBfSElEOiBIYXJkd2FyZSBJRDxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfVUlELCAmcXVvdDtQQ0kgSG90cGx1ZyByZXNv
dXJjZXMmcXVvdDspwqAgLy8gX1VJRDogVW5pcXVlIElEPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIE5hbWUgKF9TVEEsIDB4MEIpwqAgLy8gX1NUQTogU3RhdHVzPGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIE5hbWUgKF9DUlMsIFJlc291cmNlVGVtcGxhdGUg
KCnCoCAvLyBfQ1JTOiBDdXJyZW50IFJlc291cmNlIFNldHRpbmdzPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgSU8gKERlY29kZTE2LDxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAweEFFMDAswqAgwqAgwqAgwqAgwqAgwqAgwqAvLyBSYW5nZSBNaW5pbXVtPGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4QUUwMCzCoCDC
oCDCoCDCoCDCoCDCoCDCoC8vIFJhbmdlIE1heGltdW08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIEFs
aWdubWVudDxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAw
eDE0LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLy8gTGVuZ3RoPGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgfSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7PGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCBT
Y29wZSAoXCk8YnI+PGJyPiZndDsgJmd0OyBAQCAtODc4LDcgKzc5MCw2IEBAIERlZmluaXRpb25C
bG9jayAoJnF1b3Q7JnF1b3Q7LCAmcXVvdDtEU0RUJnF1b3Q7LCAxLCAmcXVvdDtCT0NIUyAmcXVv
dDs8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIFNjb3BlIChQQ0kwKTxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgezxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChCU0VMLCBaZXJvKTxicj48YnI+Jmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlIChTMDApPGJyPjxicj4mZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOYW1lIChfQURSLCBaZXJvKcKgIC8vIF9BRFI6IEFkZHJlc3M8YnI+PGJyPiZndDsg
Jmd0OyBAQCAtOTA3LDQzNiArODE4LDYgQEAgRGVmaW5pdGlvbkJsb2NrICgmcXVvdDsmcXVvdDss
ICZxdW90O0RTRFQmcXVvdDssIDEsICZxdW90O0JPQ0hTICZxdW90Ozxicj48YnI+Jmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDAzMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxi
cj4mZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFMyMCk8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA0KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgw
MDA0MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBF
amVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENF
SiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsg
LTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFMyOCk8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA1KcKgIC8vIF9TVU46IFNsb3QgVXNlciBO
dW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FE
UiwgMHgwMDA1MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBf
RUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7
ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFMzMCk8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA2KcKgIC8vIF9TVU46IFNsb3Qg
VXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFt
ZSAoX0FEUiwgMHgwMDA2MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnC
oCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxi
cj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2Ug
KFMzOCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA3KcKgIC8vIF9TVU46
IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTmFtZSAoX0FEUiwgMHgwMDA3MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFs
aXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9
PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBE
ZXZpY2UgKFM0MCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA4KcKgIC8v
IF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDA4MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90
U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCBEZXZpY2UgKFM0OCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDA5
KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDA5MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNz
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwg
MSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCBEZXZpY2UgKFM1MCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VO
LCAweDBBKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDBBMDAwMCnCoCAvLyBfQURSOiBB
ZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAo
X0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM1OCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1l
IChfU1VOLCAweDBCKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDBCMDAwMCnCoCAvLyBf
QURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1l
dGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9
MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM2MCk8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBOYW1lIChfU1VOLCAweDBDKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDBDMDAwMCnC
oCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZp
Y2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwg
X1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM2OCk8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBOYW1lIChfU1VOLCAweDBEKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDBE
MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVj
dCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAo
QlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM3MCk8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDBFKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1i
ZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwg
MHgwMDBFMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4
OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
UENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZn
dDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM3OCk8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDBGKcKgIC8vIF9TVU46IFNsb3QgVXNl
ciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAo
X0FEUiwgMHgwMDBGMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAv
LyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4m
Z3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFM4
MCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDEwKcKgIC8vIF9TVU46IFNs
b3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
TmFtZSAoX0FEUiwgMHgwMDEwMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXpl
ZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJy
Pjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZp
Y2UgKFM4OCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDExKcKgIC8vIF9T
VU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgTmFtZSAoX0FEUiwgMHgwMDExMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2Vy
aWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCBEZXZpY2UgKFM5MCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDEyKcKg
IC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDEyMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwg
Tm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCBEZXZpY2UgKFM5OCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAw
eDEzKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDEzMDAwMCnCoCAvLyBfQURSOiBBZGRy
ZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VK
MCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNBMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChf
U1VOLCAweDE0KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDE0MDAwMCnCoCAvLyBfQURS
OiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhv
ZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNBOCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
YW1lIChfU1VOLCAweDE1KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDE1MDAwMCnCoCAv
LyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2Us
IHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NV
Tik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNCMCk8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOYW1lIChfU1VOLCAweDE2KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDE2MDAw
MCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBE
ZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNF
TCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNCOCk8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDE3KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgw
MDE3MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBF
amVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENF
SiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsg
LTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNDMCk8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDE4KcKgIC8vIF9TVU46IFNsb3QgVXNlciBO
dW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FE
UiwgMHgwMDE4MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBf
RUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7
ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNDOCk8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDE5KcKgIC8vIF9TVU46IFNsb3Qg
VXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFt
ZSAoX0FEUiwgMHgwMDE5MDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnC
oCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxi
cj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2Ug
KFNEMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDFBKcKgIC8vIF9TVU46
IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgTmFtZSAoX0FEUiwgMHgwMDFBMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFs
aXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9
PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBE
ZXZpY2UgKFNEOCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDFCKcKgIC8v
IF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDFCMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNzPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90
U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCBEZXZpY2UgKFNFMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgezxi
cj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VOLCAweDFD
KcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDFDMDAwMCnCoCAvLyBfQURSOiBBZGRyZXNz
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAoX0VKMCwg
MSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJyPiZndDsg
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCBEZXZpY2UgKFNFOCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1lIChfU1VO
LCAweDFEKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDFEMDAwMCnCoCAvLyBfQURSOiBB
ZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1ldGhvZCAo
X0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9MC05PGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8YnI+PGJy
PiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNGMCk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOYW1l
IChfU1VOLCAweDFFKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDFFMDAwMCnCoCAvLyBf
QURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1l
dGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZpY2UsIHg9
MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwgX1NVTik8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2UgKFNGOCk8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBOYW1lIChfU1VOLCAweDFGKcKgIC8vIF9TVU46IFNsb3QgVXNlciBOdW1iZXI8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTmFtZSAoX0FEUiwgMHgwMDFGMDAwMCnC
oCAvLyBfQURSOiBBZGRyZXNzPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE1ldGhvZCAoX0VKMCwgMSwgTm90U2VyaWFsaXplZCnCoCAvLyBfRUp4OiBFamVjdCBEZXZp
Y2UsIHg9MC05PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUENFSiAoQlNFTCwg
X1NVTik8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKERWTlQsIDIsIE5vdFNlcmlhbGl6
ZWQpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MTApKTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzIwLCBBcmcxKTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgy
MCkpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTMjgsIEFyZzEp
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsg
Jmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJn
MCAmYW1wOyAweDQwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkg
KFMzMCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgSWYgKChBcmcwICZhbXA7IDB4ODApKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE5vdGlmeSAoUzM4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwMTAwKSk8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFM0MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDIwMCkpPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTNDgsIEFyZzEpPGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAtPGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAw
eDA0MDApKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzUwLCBB
cmcxKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4m
Z3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAo
KEFyZzAgJmFtcDsgMHgwODAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
b3RpZnkgKFM1OCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MTAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgTm90aWZ5IChTNjAsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDIwMDApKTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzY4LCBBcmcxKTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHg0MDAw
KSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFM3MCwgQXJnMSk8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcw
ICZhbXA7IDB4ODAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5
IChTNzgsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08
YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIElmICgoQXJnMCAmYW1wOyAweDAwMDEwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBOb3RpZnkgKFM4MCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDAwMjAwMDApKTxicj48YnI+
Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoUzg4LCBBcmcxKTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgw
MDA0MDAwMCkpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+
PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTOTAs
IEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJy
PiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElm
ICgoQXJnMCAmYW1wOyAweDAwMDgwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBOb3RpZnkgKFM5OCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDAxMDAwMDApKTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0EwLCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwMDIwMDAw
MCkpPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZn
dDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTQTgsIEFyZzEp
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsg
Jmd0OyAtPGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJn
MCAmYW1wOyAweDAwNDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
b3RpZnkgKFNCMCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgSWYgKChBcmcwICZhbXA7IDB4MDA4MDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE5vdGlmeSAoU0I4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwMTAwMDAwMCkpPGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTQzAsIEFyZzEpPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAt
PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1w
OyAweDAyMDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ezxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkg
KFNDOCwgQXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj48YnI+Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgSWYgKChBcmcwICZhbXA7IDB4MDQwMDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE5vdGlmeSAoU0QwLCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHgwODAwMDAwMCkpPGJyPjxicj4m
Z3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTRDgsIEFyZzEpPGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxi
cj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDEw
MDAwMDAwKSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48
YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFNFMCwg
QXJnMSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+
Jmd0OyAmZ3Q7IC08YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSWYg
KChBcmcwICZhbXA7IDB4MjAwMDAwMDApKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7PGJyPjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIE5vdGlmeSAoU0U4LCBBcmcxKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBJZiAoKEFyZzAgJmFtcDsgMHg0MDAwMDAwMCkpPGJyPjxicj4mZ3Q7ICZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTm90aWZ5IChTRjAsIEFyZzEpPGJyPjxicj4mZ3Q7ICZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+PGJyPiZndDsgJmd0OyAtPGJyPjxicj4mZ3Q7
ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElmICgoQXJnMCAmYW1wOyAweDgwMDAwMDAw
KSk8YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgezxicj48YnI+Jmd0
OyAmZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOb3RpZnkgKFNGOCwgQXJnMSk8
YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDsgLTxicj48YnI+Jmd0OyAm
Z3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCBNZXRob2QgKFBDTlQsIDAsIE5vdFNlcmlhbGl6ZWQpPGJy
Pjxicj4mZ3Q7ICZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIHs8YnI+PGJyPiZndDsgJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgQk5VTSA9IFplcm88YnI+PGJyPiZndDsgJmd0OyAtwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgRFZOVCAoUENJVSwgT25lKTxicj48YnI+Jmd0OyAmZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBEVk5UIChQQ0lELCAweDAzKTxicj48YnI+Jmd0OyAmZ3Q7IC3C
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCB9PGJyPjxi
cj4mZ3Q7ICZndDvCoCDCoCDCoCB9PGJyPjxicj4mZ3Q7ICZndDvCoCB9PGJyPjxicj4mZ3Q7ICZn
dDs8YnI+PGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--00000000000042790505b0708a75--


Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E8C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E98020758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKws7Rwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E98020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDMM1-00087L-Ia
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kDMLB-0007Dg-Eb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:33:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kDML7-0006Gy-0o
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 02:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599028427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAibdyObQJogr5cfBDzGBCMmXS5ul574LuEPLAgO6nA=;
 b=dKws7RwfL8jLm1hT9vkJ9+XLZUf+dL+bmhwS3Tc7HarKSAEtwBioMcx0G0JLfchFP9zH2Q
 7ATIzRCDeO6R1dDFkoCpzMFGgisQqerq5niPDcsGTD/mMTQZkvppjMXT5eM5BpoacBbvwZ
 TNF/+6CzCACauA/UZj409i+GqTLckkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-hNKgmI2EPGuGyEfpHMFwrg-1; Wed, 02 Sep 2020 02:33:45 -0400
X-MC-Unique: hNKgmI2EPGuGyEfpHMFwrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43219801FCC;
 Wed,  2 Sep 2020 06:33:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D18B81002D6A;
 Wed,  2 Sep 2020 06:33:36 +0000 (UTC)
Date: Wed, 2 Sep 2020 08:33:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v2 3/3] tests/acpi: add a new ACPI table in order to
 test root pci hotplug on/off
Message-ID: <20200902083335.202b5419@redhat.com>
In-Reply-To: <CAARzgwzFpfn1_u-SZHPEhbGpnC-MyYfsEunrTSX+rhx5+gojFQ@mail.gmail.com>
References: <20200901150928.12428-1-ani@anisinha.ca>
 <20200901150928.12428-3-ani@anisinha.ca>
 <CAARzgwzFpfn1_u-SZHPEhbGpnC-MyYfsEunrTSX+rhx5+gojFQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Sep 2020 11:48:00 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> On Tue, Sep 1, 2020 at 8:39 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > A new binary ACPI table tests/data/acpi/pc/DSDT.roothp is added in order
> > to unit test hotplug on/off capability on the root pci bus for i440fx.
> > The diff between the table DSDT.bridge and DSDT.roothp is listed below:
> >
> > @@ -1,30 +1,30 @@
> >  /*
> >   * Intel ACPI Component Architecture
> >   * AML/ASL+ Disassembler version 20180105 (64-bit version)
> >   * Copyright (c) 2000 - 2018 Intel Corporation
> >   *
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of tests/data/acpi/pc/DSDT.bridge, Tue Sep  1 20:02:44 2020
> > + * Disassembly of /tmp/aml-4FIZP0, Tue Sep  1 20:02:44 2020
> >   *
> >   * Original Table Header:
> >   *     Signature        "DSDT"
> > - *     Length           0x00001A89 (6793)
> > + *     Length           0x0000140A (5130)
> >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > - *     Checksum         0x08
> > + *     Checksum         0xE5
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
> > @@ -831,61 +831,60 @@
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
> > -                Name (BSEL, One)
> > +                Name (BSEL, Zero)  
> The bsel numbering is now starting from 0 for the bridge. I believe
> this is because
> 
>        *bus_bsel = (*bsel_alloc)++;
> 
> The increment never happens for the root bus since the root bus is not
> hotpluggable.

considering it needs an optional CLI option, it shouldn't be an issue.

> 
> >                  Device (S00)
> >                  {
> >                      Name (_SUN, Zero)  // _SUN: Slot User Number
> >                      Name (_ADR, Zero)  // _ADR: Address
> >                      Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> >                      {
> >                          PCEJ (BSEL, _SUN)
> >                      }
> >                  }
> >
> >                  Device (S08)
> >                  {
> >                      Name (_SUN, One)  // _SUN: Slot User Number
> >                      Name (_ADR, 0x00010000)  // _ADR: Address
> >                      Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> >                      {
> > @@ -1345,456 +1344,30 @@
> >                          Notify (SE8, Arg1)
> >                      }
> >
> >                      If ((Arg0 & 0x40000000))
> >                      {
> >                          Notify (SF0, Arg1)
> >                      }
> >
> >                      If ((Arg0 & 0x80000000))
> >                      {
> >                          Notify (SF8, Arg1)
> >                      }
> >                  }
> >
> >                  Method (PCNT, 0, NotSerialized)
> >                  {
> > -                    BNUM = One
> > +                    BNUM = Zero
> >                      DVNT (PCIU, One)
> >                      DVNT (PCID, 0x03)
> >                  }
> >              }
> >
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
> >              Method (PCNT, 0, NotSerialized)
> >              {
> > -                BNUM = Zero
> > -                DVNT (PCIU, One)
> > -                DVNT (PCID, 0x03)
> >                  ^S18.PCNT ()
> >              }
> >          }
> >      }
> >  }
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  tests/data/acpi/pc/DSDT.roothp              | Bin 0 -> 5130 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
> >  2 files changed, 1 deletion(-)
> >  create mode 100644 tests/data/acpi/pc/DSDT.roothp
> >
> > diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..be3e3bfaff7e4e2cfc51e11ca88e4e113aa5e6c8
> > GIT binary patch
> > literal 5130
> > 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
> >
> > literal 0
> > HcmV?d00001
> >
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index ac864fc982..dfb8523c8b 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,2 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/pc/DSDT.roothp",
> > --
> > 2.17.1
> >  
> 



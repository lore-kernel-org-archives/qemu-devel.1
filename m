Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C935A20771
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzF4SGRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C935A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIRV7-0007lk-OC
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRSm-0006Qx-9R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIRSj-0003Lp-FF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600239757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiQUc9k3ht4bEQBR9nHRCn8b0STgiaqB1nW3IuOLae4=;
 b=AzF4SGRIZPApkxM0ngzlQL5kFdpKBDqlJLPQI0bLgk0+4PcVgU2c2XaWXDgYX8Mh5OWPiR
 w7Ec3kpVQ+nhq2NOfDA6afHRC4jA8OIjRN0gUsQV6M1ZcH1rh9aRZrsybYIXWLCs/CvnDe
 eG82k9CQSEKbo7viTkPD6BqklbAjiyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-W15BcbfOOuewD-lr47QosQ-1; Wed, 16 Sep 2020 03:02:35 -0400
X-MC-Unique: W15BcbfOOuewD-lr47QosQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32E50425D6;
 Wed, 16 Sep 2020 07:02:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D28F867CF5;
 Wed, 16 Sep 2020 07:02:24 +0000 (UTC)
Date: Wed, 16 Sep 2020 09:02:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v4 08/11] tests/acpi: add newly added acpi DSDT table
 blob for pci bridge hotplug flag
Message-ID: <20200916090224.6b09459a@redhat.com>
In-Reply-To: <20200916061335.14045-9-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916061335.14045-9-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Philippe =?UTF-8?B?TWF0aGll?= =?UTF-8?B?dS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 11:43:32 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> This patch adds a binary blob corresponding to the DSDT acpi table. It is used
> to unit test the flag 'acpi-pci-hotplug-with-bridge-support' used with pci
> bridges.
> 
> This change also clears the file tests/qtest/bios-tables-test-allowed-diff.h
> so that future changes which affect the table can be caught.
> 
> The following is the diff between files tests/data/acpi/pc/DSDT.bridge and
> tests/data/acpi/pc/DSDT.hpbridge after disassembly :

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>   * Copyright (c) 2000 - 2018 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep 11 23:21:34 2020
> + * Disassembly of /tmp/aml-7UURQ0, Fri Sep 11 23:21:34 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001A89 (6793)
> + *     Length           0x0000131F (4895)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x09
> + *     Checksum         0xF9
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
>  {
>      Scope (\)
>      {
>          OperationRegion (DBG, SystemIO, 0x0402, One)
>          Field (DBG, ByteAcc, NoLock, Preserve)
>          {
>              DBGB,   8
>          }
> 
> @@ -859,522 +859,32 @@
>                  }
> 
>                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
>                  {
>                      Return (Zero)
>                  }
>              }
> 
>              Device (S18)
>              {
>                  Name (_ADR, 0x00030000)  // _ADR: Address
> -                Name (BSEL, One)
> -                Device (S00)
> -                {
> -                    Name (_SUN, Zero)  // _SUN: Slot User Number
> -                    Name (_ADR, Zero)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S08)
> -                {
> -                    Name (_SUN, One)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00010000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S10)
> -                {
> -                    Name (_SUN, 0x02)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00020000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S18)
> -                {
> -                    Name (_SUN, 0x03)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00030000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S20)
> -                {
> -                    Name (_SUN, 0x04)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00040000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S28)
> -                {
> -                    Name (_SUN, 0x05)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00050000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S30)
> -                {
> -                    Name (_SUN, 0x06)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00060000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S38)
> -                {
> -                    Name (_SUN, 0x07)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00070000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S40)
> -                {
> -                    Name (_SUN, 0x08)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00080000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S48)
> -                {
> -                    Name (_SUN, 0x09)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00090000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S50)
> -                {
> -                    Name (_SUN, 0x0A)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000A0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S58)
> -                {
> -                    Name (_SUN, 0x0B)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000B0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S60)
> -                {
> -                    Name (_SUN, 0x0C)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000C0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S68)
> -                {
> -                    Name (_SUN, 0x0D)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000D0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S70)
> -                {
> -                    Name (_SUN, 0x0E)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000E0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S78)
> -                {
> -                    Name (_SUN, 0x0F)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x000F0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S80)
> -                {
> -                    Name (_SUN, 0x10)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00100000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S88)
> -                {
> -                    Name (_SUN, 0x11)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00110000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S90)
> -                {
> -                    Name (_SUN, 0x12)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00120000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (S98)
> -                {
> -                    Name (_SUN, 0x13)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00130000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SA0)
> -                {
> -                    Name (_SUN, 0x14)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00140000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SA8)
> -                {
> -                    Name (_SUN, 0x15)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00150000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SB0)
> -                {
> -                    Name (_SUN, 0x16)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00160000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SB8)
> -                {
> -                    Name (_SUN, 0x17)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00170000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SC0)
> -                {
> -                    Name (_SUN, 0x18)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00180000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SC8)
> -                {
> -                    Name (_SUN, 0x19)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x00190000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SD0)
> -                {
> -                    Name (_SUN, 0x1A)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001A0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SD8)
> -                {
> -                    Name (_SUN, 0x1B)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001B0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SE0)
> -                {
> -                    Name (_SUN, 0x1C)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001C0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SE8)
> -                {
> -                    Name (_SUN, 0x1D)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001D0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SF0)
> -                {
> -                    Name (_SUN, 0x1E)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001E0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Device (SF8)
> -                {
> -                    Name (_SUN, 0x1F)  // _SUN: Slot User Number
> -                    Name (_ADR, 0x001F0000)  // _ADR: Address
> -                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                    {
> -                        PCEJ (BSEL, _SUN)
> -                    }
> -                }
> -
> -                Method (DVNT, 2, NotSerialized)
> -                {
> -                    If ((Arg0 & One))
> -                    {
> -                        Notify (S00, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x02))
> -                    {
> -                        Notify (S08, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x04))
> -                    {
> -                        Notify (S10, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x08))
> -                    {
> -                        Notify (S18, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x10))
> -                    {
> -                        Notify (S20, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x20))
> -                    {
> -                        Notify (S28, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x40))
> -                    {
> -                        Notify (S30, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x80))
> -                    {
> -                        Notify (S38, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x0100))
> -                    {
> -                        Notify (S40, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x0200))
> -                    {
> -                        Notify (S48, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x0400))
> -                    {
> -                        Notify (S50, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x0800))
> -                    {
> -                        Notify (S58, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x1000))
> -                    {
> -                        Notify (S60, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x2000))
> -                    {
> -                        Notify (S68, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x4000))
> -                    {
> -                        Notify (S70, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x8000))
> -                    {
> -                        Notify (S78, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00010000))
> -                    {
> -                        Notify (S80, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00020000))
> -                    {
> -                        Notify (S88, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00040000))
> -                    {
> -                        Notify (S90, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00080000))
> -                    {
> -                        Notify (S98, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00100000))
> -                    {
> -                        Notify (SA0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00200000))
> -                    {
> -                        Notify (SA8, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00400000))
> -                    {
> -                        Notify (SB0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x00800000))
> -                    {
> -                        Notify (SB8, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x01000000))
> -                    {
> -                        Notify (SC0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x02000000))
> -                    {
> -                        Notify (SC8, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x04000000))
> -                    {
> -                        Notify (SD0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x08000000))
> -                    {
> -                        Notify (SD8, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x10000000))
> -                    {
> -                        Notify (SE0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x20000000))
> -                    {
> -                        Notify (SE8, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x40000000))
> -                    {
> -                        Notify (SF0, Arg1)
> -                    }
> -
> -                    If ((Arg0 & 0x80000000))
> -                    {
> -                        Notify (SF8, Arg1)
> -                    }
> -                }
> -
> -                Method (PCNT, 0, NotSerialized)
> -                {
> -                    BNUM = One
> -                    DVNT (PCIU, One)
> -                    DVNT (PCID, 0x03)
> -                }
>              }
> 
>              Device (S20)
>              {
>                  Name (_SUN, 0x04)  // _SUN: Slot User Number
>                  Name (_ADR, 0x00040000)  // _ADR: Address
>                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
> 
>              Device (S28)
>              {
>                  Name (_SUN, 0x05)  // _SUN: Slot User Number
>                  Name (_ADR, 0x00050000)  // _ADR: Address
> @@ -1779,22 +1289,21 @@
>                  If ((Arg0 & 0x40000000))
>                  {
>                      Notify (SF0, Arg1)
>                  }
> 
>                  If ((Arg0 & 0x80000000))
>                  {
>                      Notify (SF8, Arg1)
>                  }
>              }
> 
>              Method (PCNT, 0, NotSerialized)
>              {
>                  BNUM = Zero
>                  DVNT (PCIU, One)
>                  DVNT (PCID, 0x03)
> -                ^S18.PCNT ()
>              }
>          }
>      }
>  }
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  tests/data/acpi/pc/DSDT.hpbridge            | Bin 0 -> 4895 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
> 
> diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
> new file mode 100644
> index 0000000000000000000000000000000000000000..b0751398541bdf88ce405be9742aeba0b375dbc3
> GIT binary patch
> literal 4895
> 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  
> S66ohVtr{L;J8bx3aOwYF+mJl~
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 96a9237355..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/pc/DSDT.hpbridge",



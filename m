Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4763C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 12:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF2420738
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 12:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="MGNPrfA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF2420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEXIs-0005gD-Qu
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 08:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEXHE-00046k-MA
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 08:26:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEXHB-0007Hu-Sm
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 08:26:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id c15so9999106wrs.11
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CTIfMmRdRB86G3uTAepsYRumeLyhtCm4CWblqHGMVjU=;
 b=MGNPrfA6Tn+FjNy1k4gGhSBXhXiFpk6mhtI8JMMylHQ1+D261/PzXOiIEx4kYZPJe6
 FFORysFzwCVwY6lsGuppadNFDLwZS8/00ZWbVGHXIKszTen8sZl6/7FlyN31PJZqOJky
 nL1bVt82eAxWxrJbd/hbkISPJZH7xvCkwli5UUVB5aD3vTxTp0s9pzY4wlOI79zNS4ix
 E/iPXLaXmUr1/xE7lX+RXxlWpX32i9zixZ9BkZwTpyJuvNwuRzyRSZ68miTqM46Adbr7
 g3Mdzv6MM6jlTI3JuvDsfxubvs5MA1Jc753oN2ZZNNFSd0aOHAcRGUqLcv5ecaHnzphE
 Q/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CTIfMmRdRB86G3uTAepsYRumeLyhtCm4CWblqHGMVjU=;
 b=AIUutVDfKiwAPPm7B8Qqq1dNdDzt+GtkHL9hzl0W/A8f8nLFQOk+yJXnqIeYMs/TOJ
 Z6EZ6D9eTRsc8pVgvHmm//Sj/ue2u80CjEd4HMRoeWyXcYTwn0Qp8YIQjd2m2D6NFFjc
 EGvw9QZl0JgoUj207P9pv7IMmLqXEYRIVvZl6ruJbuPnr32APmXUCA8VaZFFBNrgVvG4
 2HzR8qPbUgoeDo3qUpCV6wCPD9e+4/jjeHKNKwt8Kcq878nwrwkuy/J4ybRi2DK4k4NC
 ZuX/vSy+ai19m3cETgd9I5XQQGiSh4sCZuRYJbJl1taJdeai9RQ27+5+5f2xdhzhkVtB
 tSrg==
X-Gm-Message-State: AOAM5333rMk8VxSJpQzdB/DsW6x0Lab7E0WV5vkO8kGCjOVLNEElaYEn
 bfmGt3/4NecQ4yDOq853WMrR8KWtn7ib1F2rHzdMcoxdOQo+gg==
X-Google-Smtp-Source: ABdhPJx+Tjfld/0guC1h9vM8CXG9jpyfp3RN2bNGpzMiXupOREgxYegL2a64y28DHj2xE6HCaa3hdOLGpRxLQvUJhls=
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr11537944wrm.291.1599308795918; 
 Sat, 05 Sep 2020 05:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200905103520.12626-1-ani@anisinha.ca>
In-Reply-To: <20200905103520.12626-1-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Sat, 5 Sep 2020 17:56:24 +0530
Message-ID: <CAARzgwzvqY14Vq3ZXdQRm6OP98s2U_nAOSqUjajVq_=H=5SSFw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] unit tests for change 'do not add hotplug related
 amls for cold plugged bridges'
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 5, 2020 at 4:05 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> The following patchset adds the unit test for the change:
> f80ba9e599 ("tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag")

Apologies. This change is incorrect. It should be :
e78c1c9a2e ("i440fx/acpi: do not add hotplug related amls for cold
plugged bridges")

>
> Please compare the diff of the DSDT table attached with the commit log with the following diff which
> was generated before appplying the above change. The major difference between the diffs are the absence
> of the following lines in the diff corresponding to this change:
>
> +                Name (_SUN, 0x03)  // _SUN: Slot User Number
> +                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
> +                    PCEJ (BSEL, _SUN)
>
> +                If ((Arg0 & 0x08))
> +                {
> +                    Notify (S18, Arg1)
> +                }
> +
>
> These are hotplug related amls which were present for slot 3 in the root pci bus before this change was applied.
> With the change, these amls have been removed. Hence, slot 3 where the bridge is attached is no longer hotplug
> capable.
>
> --Ani
>
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>   * Copyright (c) 2000 - 2018 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/pc/DSDT.bridge, Fri Sep  4 11:08:58 2020
> + * Disassembly of /tmp/aml-IEQEQ0, Fri Sep  4 11:08:58 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001A89 (6793)
> + *     Length           0x00001346 (4934)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x08
> + *     Checksum         0xBF
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
> @@ -859,521 +859,36 @@
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
> +                Name (_SUN, 0x03)  // _SUN: Slot User Number
> +                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
> -                    BNUM = One
> -                    DVNT (PCIU, One)
> -                    DVNT (PCID, 0x03)
> +                    PCEJ (BSEL, _SUN)
>                  }
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
> @@ -1633,32 +1148,37 @@
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
>
>              Device (SF8)
>              {
>                  Name (_SUN, 0x1F)  // _SUN: Slot User Number
>                  Name (_ADR, 0x001F0000)  // _ADR: Address
>                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
>
>              Method (DVNT, 2, NotSerialized)
>              {
> +                If ((Arg0 & 0x08))
> +                {
> +                    Notify (S18, Arg1)
> +                }
> +
>                  If ((Arg0 & 0x10))
>                  {
>                      Notify (S20, Arg1)
>                  }
>
>                  If ((Arg0 & 0x20))
>                  {
>                      Notify (S28, Arg1)
>                  }
>
>                  If ((Arg0 & 0x40))
>                  {
>                      Notify (S30, Arg1)
>                  }
>
>                  If ((Arg0 & 0x80))
> @@ -1779,22 +1299,21 @@
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
>
> ***
>
> Ani Sinha (3):
>   tests/acpi: list added acpi table binary file for pci bridge hotplug
>     test
>   tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
>     bridge flag
>   tests/acpi: add newly added acpi DSDT table blob for pci bridge
>     hotplug flag
>
>  tests/data/acpi/pc/DSDT.hpbridge | Bin 0 -> 4895 bytes
>  tests/qtest/bios-tables-test.c   |  15 +++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
>
> --
> 2.17.1
>


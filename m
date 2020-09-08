Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C6C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D1523C31
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1X+D+fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D1523C31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeC1-0005hL-LO
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeB2-00057P-6D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeAy-000394-Un
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599573647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flNatojKZFbGSfQSmYURQy0k6GZdpBiMVoDVRBmSqPY=;
 b=h1X+D+fZ5cAX96JCx5xw2kzMNUX+2/EC2+UcJuatf3oQ89eI66Npjcb7b/C9heJuU8OeGq
 LI4KplDlY9pVz3baczR7dlp3HiDL2EI/ynO5ot9bBklrqDZj6diaXpVmSKhLnrAx4mI19/
 B77aLW6r30fS8Oi6U7dM2gSidnEzhpM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-IBUdWtfsNQq7cOptXMLxGw-1; Tue, 08 Sep 2020 10:00:45 -0400
X-MC-Unique: IBUdWtfsNQq7cOptXMLxGw-1
Received: by mail-wr1-f70.google.com with SMTP id 33so7043137wre.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=flNatojKZFbGSfQSmYURQy0k6GZdpBiMVoDVRBmSqPY=;
 b=Reqh+CULGh2Zq8ZM4+KmMoKKIl7e/Vf+5m8Vd6OZU3BWEnyzYNiTfslCyoFYZjVCv3
 r/W1aZyvFUZz4r8h1wSJZc9fnArC5W6Brt/5RZrZgliVjfsqloPUE1x4fnaD3cRNDCWz
 XUm4TwJqivDBZJ9a5/tx4eeuOoUS/VFBDZq9XE05w9UCMIxHOZ6oXJ45RniebRfcWALx
 vmAHj6IcR3CFpu2kpAVhNuhvr80tmguNQz/sblA7la8hREXPL8hEaeXjeW0z+ntaHb/Q
 K3lBRlW7yQFX/iPBA7W1IPVGC2NusEijTQkJhCq3kwNTyeMmmYzjL5KU6zh1iwiMN6hb
 tr8g==
X-Gm-Message-State: AOAM531vZq0YkCt7FwjMyFEeZYQqaf7nD8emhfmiIikz9QDUm8/Clq9N
 RBD3n6o/dYTgFrSRoUf4mZqixxStlQxna3flUJDZGTz438vC2/G7CM3MjT4ug7FiCPZlYTJayzs
 qnQFm2V8IpJkM2Lc=
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4456808wmc.47.1599573643729; 
 Tue, 08 Sep 2020 07:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgM/0TC5C+ZeNzSLtPpumR1x1Qi/SnfnfPnbnPMhJ4STt45SnRUpWeSn6a4XsyQh5oNidkhQ==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4456780wmc.47.1599573643485; 
 Tue, 08 Sep 2020 07:00:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 b76sm32637689wme.45.2020.09.08.07.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:00:42 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:00:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 3/3] tests/acpi: add a new ACPI table in order to test
 root pci hotplug on/off
Message-ID: <20200908095957-mutt-send-email-mst@kernel.org>
References: <20200901150928.12428-1-ani@anisinha.ca>
 <20200901150928.12428-3-ani@anisinha.ca>
 <CAARzgwzFpfn1_u-SZHPEhbGpnC-MyYfsEunrTSX+rhx5+gojFQ@mail.gmail.com>
 <20200902083335.202b5419@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200902083335.202b5419@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 08:33:35AM +0200, Igor Mammedov wrote:
> On Wed, 2 Sep 2020 11:48:00 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
> 
> > On Tue, Sep 1, 2020 at 8:39 PM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > A new binary ACPI table tests/data/acpi/pc/DSDT.roothp is added in order
> > > to unit test hotplug on/off capability on the root pci bus for i440fx.
> > > The diff between the table DSDT.bridge and DSDT.roothp is listed below:
> > >
> > > @@ -1,30 +1,30 @@
> > >  /*
> > >   * Intel ACPI Component Architecture
> > >   * AML/ASL+ Disassembler version 20180105 (64-bit version)
> > >   * Copyright (c) 2000 - 2018 Intel Corporation
> > >   *
> > >   * Disassembling to symbolic ASL+ operators
> > >   *
> > > - * Disassembly of tests/data/acpi/pc/DSDT.bridge, Tue Sep  1 20:02:44 2020
> > > + * Disassembly of /tmp/aml-4FIZP0, Tue Sep  1 20:02:44 2020
> > >   *
> > >   * Original Table Header:
> > >   *     Signature        "DSDT"
> > > - *     Length           0x00001A89 (6793)
> > > + *     Length           0x0000140A (5130)
> > >   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > > - *     Checksum         0x08
> > > + *     Checksum         0xE5
> > >   *     OEM ID           "BOCHS "
> > >   *     OEM Table ID     "BXPCDSDT"
> > >   *     OEM Revision     0x00000001 (1)
> > >   *     Compiler ID      "BXPC"
> > >   *     Compiler Version 0x00000001 (1)
> > >   */
> > >  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
> > >  {
> > >      Scope (\)
> > >      {
> > >          OperationRegion (DBG, SystemIO, 0x0402, One)
> > >          Field (DBG, ByteAcc, NoLock, Preserve)
> > >          {
> > >              DBGB,   8
> > >          }
> > >
> > > @@ -831,61 +831,60 @@
> > >              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> > >              {
> > >                  IO (Decode16,
> > >                      0x0510,             // Range Minimum
> > >                      0x0510,             // Range Maximum
> > >                      0x01,               // Alignment
> > >                      0x0C,               // Length
> > >                      )
> > >              })
> > >          }
> > >      }
> > >
> > >      Scope (\_SB)
> > >      {
> > >          Scope (PCI0)
> > >          {
> > > -            Name (BSEL, Zero)
> > >              Device (S00)
> > >              {
> > >                  Name (_ADR, Zero)  // _ADR: Address
> > >              }
> > >
> > >              Device (S10)
> > >              {
> > >                  Name (_ADR, 0x00020000)  // _ADR: Address
> > >                  Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
> > >                  {
> > >                      Return (Zero)
> > >                  }
> > >
> > >                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
> > >                  {
> > >                      Return (Zero)
> > >                  }
> > >
> > >                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
> > >                  {
> > >                      Return (Zero)
> > >                  }
> > >              }
> > >
> > >              Device (S18)
> > >              {
> > >                  Name (_ADR, 0x00030000)  // _ADR: Address
> > > -                Name (BSEL, One)
> > > +                Name (BSEL, Zero)  
> > The bsel numbering is now starting from 0 for the bridge. I believe
> > this is because
> > 
> >        *bus_bsel = (*bsel_alloc)++;
> > 
> > The increment never happens for the root bus since the root bus is not
> > hotpluggable.
> 
> considering it needs an optional CLI option, it shouldn't be an issue.

Right. Defaults didn't change.

-- 
MST



Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE09D2339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE09D2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0XAx-00042u-QW
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0X2h-0006Rc-PG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0X2f-0008Iv-Q8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:17:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:54807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i0X2f-0008HW-Im
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:17:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 13:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="190322594"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by orsmga002.jf.intel.com with ESMTP; 21 Aug 2019 13:17:09 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 21 Aug 2019 13:17:09 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.208]) with mapi id 14.03.0439.000;
 Wed, 21 Aug 2019 13:17:09 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "rfc@edk2.groups.io"
 <rfc@edk2.groups.io>, "Yao, Jiewen" <jiewen.yao@intel.com>, "Kinney, Michael
 D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoD//467cAAPWXAAAAlUNOA=
Date: Wed, 21 Aug 2019 20:17:08 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9D9E82C@ORSMSX113.amr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9D74A@ORSMSX113.amr.corp.intel.com>
 <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
In-Reply-To: <adf3f3b8-1dc9-79e1-7411-4d9131657a1f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
X-Mailman-Approved-At: Wed, 21 Aug 2019 16:24:46 -0400
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>, qemu
 devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

It makes sense to match real HW.  That puts us back to
the reset vector and handling the initial SMI at
3000:8000.  That is all workable from a FW implementation
perspective.  It look like the only issue left is DMA.

DMA protection of memory ranges is a chipset feature.
For the current QEMU implementation, what ranges of
memory are guaranteed to be protected from DMA?  Is
it only A/B seg and TSEG?

Thanks,

Mike

> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Wednesday, August 21, 2019 10:40 AM
> To: Kinney, Michael D <michael.d.kinney@intel.com>;
> rfc@edk2.groups.io; Yao, Jiewen <jiewen.yao@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>; Laszlo
> Ersek <lersek@redhat.com>; devel@edk2.groups.io; qemu
> devel list <qemu-devel@nongnu.org>; Igor Mammedov
> <imammedo@redhat.com>; Chen, Yingwen
> <yingwen.chen@intel.com>; Nakajima, Jun
> <jun.nakajima@intel.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; Joao Marcal Lemos Martins
> <joao.m.martins@oracle.com>; Phillip Goerl
> <phillip.goerl@oracle.com>
> Subject: Re: [edk2-rfc] [edk2-devel] CPU hotplug using
> SMM with QEMU+OVMF
>=20
> On 21/08/19 19:25, Kinney, Michael D wrote:
> > Could we have an initial SMBASE that is within TSEG.
> >
> > If we bring in hot plug CPUs one at a time, then
> initial SMBASE in
> > TSEG can reprogram the SMBASE to the correct value for
> that CPU.
> >
> > Can we add a register to the hot plug controller that
> allows the BSP
> > to set the initial SMBASE value for a hot added CPU?
> The default can
> > be 3000:8000 for compatibility.
> >
> > Another idea is when the SMI handler runs for a hot
> add CPU event, the
> > SMM monarch programs the hot plug controller register
> with the SMBASE
> > to use for the CPU that is being added.  As each CPU
> is added, a
> > different SMBASE value can be programmed by the SMM
> Monarch.
>=20
> Yes, all of these would work.  Again, I'm interested in
> having something that has a hope of being implemented in
> real hardware.
>=20
> Another, far easier to implement possibility could be a
> lockable MSR (could be the existing
> MSR_SMM_FEATURE_CONTROL) that allows programming the
> SMBASE outside SMM.  It would be nice if such a bit
> could be defined by Intel.
>=20
> Paolo


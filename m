Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0FAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F201A21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 20:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F201A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0tNN-0004i5-1P
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 16:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0tMJ-0003ZQ-Nk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael.d.kinney@intel.com>) id 1i0tMH-0006fX-B7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:06:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:55537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <michael.d.kinney@intel.com>)
 id 1i0tMH-0006YY-2B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 16:06:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 13:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; d="scan'208";a="208298719"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2019 13:06:48 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 13:06:47 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.198]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.159]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 13:06:47 -0700
From: "Kinney, Michael D" <michael.d.kinney@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, "Yao, Jiewen"
 <jiewen.yao@intel.com>, "Kinney, Michael D" <michael.d.kinney@intel.com>
Thread-Topic: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5vU6QBeHgZE+cN7DIWDHHwKb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9d4AEPCbwgACNBoCAAaFPgIAADE2A//+WXtA=
Date: Thu, 22 Aug 2019 20:06:47 +0000
Message-ID: <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
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
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
In-Reply-To: <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor
 Mammedov <imammedo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

The SMBASE register is internal and cannot be directly accessed=20
by any CPU.  There is an SMBASE field that is member of the SMM Save
State area and can only be modified from SMM and requires the
execution of an RSM instruction from SMM for the SMBASE register to
be updated from the current SMBASE field value.  The new SMBASE
register value is only used on the next SMI.

https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol=
-1-2abcd-3abcd.pdf

Vol 3C - Section 34.11

  The default base address for the SMRAM is 30000H. This value is contained=
 in an internal processor register called
  the SMBASE register. The operating system or executive can relocate the S=
MRAM by setting the SMBASE field in the
  saved state map (at offset 7EF8H) to a new value (see Figure 34-4). The R=
SM instruction reloads the internal
  SMBASE register with the value in the SMBASE field each time it exits SMM=
. All subsequent SMI requests will use
  the new SMBASE value to find the starting address for the SMI handler (at=
 SMBASE + 8000H) and the SMRAM state
  save area (from SMBASE + FE00H to SMBASE + FFFFH). (The processor resets =
the value in its internal SMBASE
  register to 30000H on a RESET, but does not change it on an INIT.)

One idea to work around these issues is to startup OVMF with the maximum nu=
mber of
CPUs.  All the CPUs will be assigned an SMBASE address and at a safe time t=
o assign
the SMBASE values using the initial 3000:8000 SMI vector because there is a=
 guarantee
of no DMA at that point in the FW init.

Once all the CPUs have been initialized for SMM, the CPUs that are not need=
ed
can be hot removed.  As noted above, the SMBASE value does not change on
an INIT.  So as long as the hot add operation does not do a RESET, the
SMBASE value must be preserved.

Of course, this is not a good idea from a boot performance perspective,=20
especially if the max CPUs is a large value.

Another idea is to emulate this behavior.  If the hot plug controller
provide registers (only accessible from SMM) to assign the SMBASE address
for every CPU.  When a CPU is hot added, QEMU can set the internal SMBASE
register value from the hot plug controller register value.  If the SMM
Monarch sends an INIT or an SMI from the Local APIC to the hot added CPU,
then the SMBASE register should not be modified and the CPU starts executio=
n
within TSEG the first time it receives an SMI.

Jiewen and I can collect specific questions on this topic and continue
the discussion here.  For example, I do not think there is any method
other than what I referenced above to program the SMBASE register, but
I can ask if there are any other methods.

Thanks,

Mike

> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Thursday, August 22, 2019 11:43 AM
> To: Laszlo Ersek <lersek@redhat.com>; Kinney, Michael D
> <michael.d.kinney@intel.com>; rfc@edk2.groups.io; Yao,
> Jiewen <jiewen.yao@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>;
> devel@edk2.groups.io; qemu devel list <qemu-
> devel@nongnu.org>; Igor Mammedov <imammedo@redhat.com>;
> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
> <jun.nakajima@intel.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; Joao Marcal Lemos Martins
> <joao.m.martins@oracle.com>; Phillip Goerl
> <phillip.goerl@oracle.com>
> Subject: Re: [edk2-rfc] [edk2-devel] CPU hotplug using
> SMM with QEMU+OVMF
>=20
> On 22/08/19 19:59, Laszlo Ersek wrote:
> > The firmware and QEMU could agree on a formula, which
> would compute
> > the CPU-specific SMBASE from a value pre-programmed by
> the firmware,
> > and the initial APIC ID of the hot-added CPU.
> >
> > Yes, it would duplicate code -- the calculation --
> between QEMU and
> > edk2. While that's not optimal, it wouldn't be a first.
>=20
> No, that would be unmaintainable.  The best solution to
> me seems to be to make SMBASE programmable from non-SMM
> code if some special conditions hold.  Michael, would it
> be possible to get in contact with the Intel architects?
>=20
> Paolo


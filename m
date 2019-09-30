Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75589C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE7820679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE7820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwaf-0007Jr-6y
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiewen.yao@intel.com>) id 1iEwZu-0006rp-PL
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiewen.yao@intel.com>) id 1iEwZs-0003Tp-8P
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:23:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:1422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
 id 1iEwZr-0003Rn-W7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:23:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 07:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; d="scan'208";a="202899911"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 30 Sep 2019 07:22:59 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 07:22:58 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 07:22:58 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.165]) with mapi id 14.03.0439.000;
 Mon, 30 Sep 2019 22:22:55 +0800
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: "devel@edk2.groups.io" <devel@edk2.groups.io>, "imammedo@redhat.com"
 <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Subject: RE: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
Thread-Topic: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K
 SMRAM at default SMBASE address
Thread-Index: AQHVcsoJd8i/V0oK70G7GW0woCa/SKdDny4AgAAMooCAAJ75IA==
Date: Mon, 30 Sep 2019 14:22:54 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503F7DFDB3@shsmsx102.ccr.corp.intel.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
 <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
 <20190920102855.3fe2b689@redhat.com>
 <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
 <c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com>
 <20190924131936.7dec5e6c@redhat.com>
 <fb9c530c-f911-313d-6a79-5291e84327e5@redhat.com>
 <20190930143659.6de53f70@redhat.com>
In-Reply-To: <20190930143659.6de53f70@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzVhMjQ5YTktZTdlNC00ODA5LWI4N2MtYzM0NjViYmYxN2RjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiKzlvaUd2ek1DbDFIWGVOSTZYSWZ2c1p1MU5JTkxvWjczcHNDYWlsYjJcLzhcL3hLdkxMNko1SHZVRjhudkJJdFhWIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
 Brijesh Singh <brijesh.singh@amd.com>,
 "phillip.goerl@oracle.com" <phillip.goerl@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, "Kinney,
 Michael D" <michael.d.kinney@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

below

> -----Original Message-----
> From: devel@edk2.groups.io <devel@edk2.groups.io> On Behalf Of Igor
> Mammedov
> Sent: Monday, September 30, 2019 8:37 PM
> To: Laszlo Ersek <lersek@redhat.com>
> Cc: devel@edk2.groups.io; qemu-devel@nongnu.org; Chen, Yingwen
> <yingwen.chen@intel.com>; phillip.goerl@oracle.com;
> alex.williamson@redhat.com; Yao, Jiewen <jiewen.yao@intel.com>; Nakajima,
> Jun <jun.nakajima@intel.com>; Kinney, Michael D
> <michael.d.kinney@intel.com>; pbonzini@redhat.com;
> boris.ostrovsky@oracle.com; rfc@edk2.groups.io; joao.m.martins@oracle.com=
;
> Brijesh Singh <brijesh.singh@amd.com>
> Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K
> SMRAM at default SMBASE address
>=20
> On Mon, 30 Sep 2019 13:51:46 +0200
> "Laszlo Ersek" <lersek@redhat.com> wrote:
>=20
> > Hi Igor,
> >
> > On 09/24/19 13:19, Igor Mammedov wrote:
> > > On Mon, 23 Sep 2019 20:35:02 +0200
> > > "Laszlo Ersek" <lersek@redhat.com> wrote:
> >
> > >> I've got good results. For this (1/2) QEMU patch:
> > >>
> > >> Tested-by: Laszlo Ersek <lersek@redhat.com>
> > >>
> > >> I tested the following scenarios. In every case, I verified the OVMF
> > >> log, and also the "info mtree" monitor command's result (i.e. whethe=
r
> > >> "smbase-blackhole" / "smbase-window" were disabled or enabled).
> > >> Mostly, I diffed these text files between the test scenarios (lookin=
g
> > >> for desired / undesired differences). In the Linux guests, I checked
> > >> / compared the dmesg too (wrt. the UEFI memmap).
> > >>
> > >> - unpatched OVMF (regression test), Fedora guest, normal boot and S3
> > >>
> > >> - patched OVMF, but feature disabled with "-global
> > >>   mch.smbase-smram=3Doff" (another regression test), Fedora guest,
> > >>   normal boot and S3
> > >>
> > >> - patched OVMF, feature enabled, Fedora and various Windows guests
> > >>   (win7, win8, win10 families, client/server), normal boot and S3
> > >>
> > >> - a subset of the above guests, with S3 disabled (-global
> > >>   ICH9-LPC.disable_s3=3D1), and obviously S3 resume not tested
> > >>
> > >> SEV: used 5.2-ish Linux guest, with S3 disabled (no support under SE=
V
> > >> for that now):
> > >>
> > >> - unpatched OVMF (regression test), normal boot
> > >>
> > >> - patched OVMF but feature disabled on the QEMU cmdline (another
> > >>   regression test), normal boot
> > >>
> > >> - patched OVMF, feature enabled, normal boot.
> > >>
> > >> I plan to post the OVMF patches tomorrow, for discussion.
> > >>
> > >> (It's likely too early to push these QEMU / edk2 patches right now -=
-
> > >> we don't know yet if this path will take us to the destination. For
> > >> now, it certainly looks great.)
> > >
> > > Laszlo, thanks for trying it out.
> > > It's nice to hear that approach is somewhat usable.
> > > Hopefully we won't have to invent 'paused' cpu mode.
> > >
> > > Pls CC me on your patches
> > > (not that I qualify for reviewing,
> > > but may be I could learn a thing or two from it)
> >
> > Considering the plan at [1], the two patch sets [2] [3] should cover
> > step (01); at least as proof of concept.
> >
> > [1] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
> >     http://mid.mail-archive.com/20190830164802.1b17ff26@redhat.com
> >
> > [2] The current thread:
> >     [Qemu-devel] [PATCH 0/2] q35: mch: allow to lock down 128K RAM at
> default SMBASE address
> >     http://mid.mail-archive.com/20190917130708.10281-1-
> imammedo@redhat.com
> >
> > [3] [edk2-devel] [PATCH wave 1 00/10] support QEMU's "SMRAM at default
> SMBASE" feature
> >     http://mid.mail-archive.com/20190924113505.27272-1-lersek@redhat.co=
m
> >
> > (I'll have to figure out what SMI handler to put in place there, but I'=
d
> > like to experiment with that once we can cause a new CPU to start
> > executing code there, in SMM.)
> >
> > So what's next?
> >
> > To me it looks like we need to figure out how QEMU can make the OS call
> > into SMM (in the GPE cpu hotplug handler), passing in parameters and
> > such. This would be step (03).
> >
> > Do you agree?
> >
> > If so, I'll ask Jiewen about such OS->SMM calls separately, because I
> > seem to remember that there used to be an "SMM communcation table" of
> > sorts, for flexible OS->SMM calls. However, it appears to be deprecated
> > lately.
> we can try to resurrect and put over it some kind of protocol
> to describe which CPUs to where hotplugged.
>=20
> or we could put a parameter into SMI status register (IO port 0xb3)
> and the trigger SMI from GPE handler to tell SMI handler that cpu
> hotplug happened and then use QEMU's cpu hotplug interface
> to enumerate hotplugged CPUs for SMI handler.
>=20
> The later is probably simpler as we won't need to reinvent the wheel
> (just reuse the interface that's already in use by GPE handler).

[Jiewen] The PI specification Volume 4 - SMM defines EFI_MM_COMMUNICATION_P=
ROTOCOL.Communicate() - It can be used to communicate between OS and SMM ha=
ndler. But it requires the runtime protocol call. I am not sure how OS load=
er passes this information to OS kernel.

As such, I think using ACPI SCI/GPE -> software SMI handler is an easier wa=
y to achieve this. I also recommend this way.
For parameter passing, we can use 1) Port B2 (1 byte), 2) Port B3 (1 byte),=
 3) chipset scratch register (4 bytes or 8 bytes, based upon scratch regist=
er size), 4) ACPI NVS OPREGION, if the data structure is complicated.



> > Hmmm.... Yes, UEFI 2.8 has "Appendix O - UEFI ACPI Data Table", and it
> > writes (after defining the table format):
> >
> >     The first use of this UEFI ACPI table format is the SMM
> >     Communication ACPI Table. This table describes a special software
> >     SMI that can be used to initiate inter-mode communication in the OS
> >     present environment by non-firmware agents with SMM code.
> >
> >     Note: The use of the SMM Communication ACPI table is deprecated in
> >           UEFI spec. 2.7. This is due to the lack of a use case for
> >           inter-mode communication by non-firmware agents with SMM code
> >           and support for initiating this form of communication in
> >           common OSes.
> >
> > The changelog at the front of the UEFI spec also references the
> > Mantis#1691 spec ticket, "Remove/Deprecate SMM Communication ACPI
> Table"
> > (addressed in UEFI 2.6B).
> >
> > (I think that must have been a security ticket, because, while I
> > generally have access to Mantis tickets,
> > <https://mantis.uefi.org/mantis/view.php?id=3D1631> gives me "Access
> > Denied" :/ )
> >
> > Thanks,
> > Laszlo
> >
> >
> >
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
>=20
> View/Reply Online (#48283): https://edk2.groups.io/g/devel/message/48283
> Mute This Topic: https://groups.io/mt/34201782/1772286
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [jiewen.yao@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



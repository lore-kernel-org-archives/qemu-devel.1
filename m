Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78661C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B622075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B622075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEuwR-0007j9-Dl
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iEuvN-0007A7-51
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iEuvL-0005zZ-K8
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iEuvL-0005zH-Ba
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F27730832E1;
 Mon, 30 Sep 2019 12:37:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63D2160C83;
 Mon, 30 Sep 2019 12:37:01 +0000 (UTC)
Date: Mon, 30 Sep 2019 14:36:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Laszlo Ersek" <lersek@redhat.com>
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
Message-ID: <20190930143659.6de53f70@redhat.com>
In-Reply-To: <fb9c530c-f911-313d-6a79-5291e84327e5@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
 <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
 <20190920102855.3fe2b689@redhat.com>
 <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
 <c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com>
 <20190924131936.7dec5e6c@redhat.com>
 <fb9c530c-f911-313d-6a79-5291e84327e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 30 Sep 2019 12:37:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: yingwen.chen@intel.com, Brijesh Singh <brijesh.singh@amd.com>,
 devel@edk2.groups.io, phillip.goerl@oracle.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 13:51:46 +0200
"Laszlo Ersek" <lersek@redhat.com> wrote:

> Hi Igor,
> 
> On 09/24/19 13:19, Igor Mammedov wrote:
> > On Mon, 23 Sep 2019 20:35:02 +0200
> > "Laszlo Ersek" <lersek@redhat.com> wrote:  
> 
> >> I've got good results. For this (1/2) QEMU patch:
> >>
> >> Tested-by: Laszlo Ersek <lersek@redhat.com>
> >>
> >> I tested the following scenarios. In every case, I verified the OVMF
> >> log, and also the "info mtree" monitor command's result (i.e. whether
> >> "smbase-blackhole" / "smbase-window" were disabled or enabled).
> >> Mostly, I diffed these text files between the test scenarios (looking
> >> for desired / undesired differences). In the Linux guests, I checked
> >> / compared the dmesg too (wrt. the UEFI memmap).
> >>
> >> - unpatched OVMF (regression test), Fedora guest, normal boot and S3
> >>
> >> - patched OVMF, but feature disabled with "-global
> >>   mch.smbase-smram=off" (another regression test), Fedora guest,
> >>   normal boot and S3
> >>
> >> - patched OVMF, feature enabled, Fedora and various Windows guests
> >>   (win7, win8, win10 families, client/server), normal boot and S3
> >>
> >> - a subset of the above guests, with S3 disabled (-global
> >>   ICH9-LPC.disable_s3=1), and obviously S3 resume not tested
> >>
> >> SEV: used 5.2-ish Linux guest, with S3 disabled (no support under SEV
> >> for that now):
> >>
> >> - unpatched OVMF (regression test), normal boot
> >>
> >> - patched OVMF but feature disabled on the QEMU cmdline (another
> >>   regression test), normal boot
> >>
> >> - patched OVMF, feature enabled, normal boot.
> >>
> >> I plan to post the OVMF patches tomorrow, for discussion.
> >>
> >> (It's likely too early to push these QEMU / edk2 patches right now --
> >> we don't know yet if this path will take us to the destination. For
> >> now, it certainly looks great.)  
> >
> > Laszlo, thanks for trying it out.
> > It's nice to hear that approach is somewhat usable.
> > Hopefully we won't have to invent 'paused' cpu mode.
> >
> > Pls CC me on your patches
> > (not that I qualify for reviewing,
> > but may be I could learn a thing or two from it)  
> 
> Considering the plan at [1], the two patch sets [2] [3] should cover
> step (01); at least as proof of concept.
> 
> [1] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
>     http://mid.mail-archive.com/20190830164802.1b17ff26@redhat.com
> 
> [2] The current thread:
>     [Qemu-devel] [PATCH 0/2] q35: mch: allow to lock down 128K RAM at default SMBASE address
>     http://mid.mail-archive.com/20190917130708.10281-1-imammedo@redhat.com
> 
> [3] [edk2-devel] [PATCH wave 1 00/10] support QEMU's "SMRAM at default SMBASE" feature
>     http://mid.mail-archive.com/20190924113505.27272-1-lersek@redhat.com
> 
> (I'll have to figure out what SMI handler to put in place there, but I'd
> like to experiment with that once we can cause a new CPU to start
> executing code there, in SMM.)
> 
> So what's next?
> 
> To me it looks like we need to figure out how QEMU can make the OS call
> into SMM (in the GPE cpu hotplug handler), passing in parameters and
> such. This would be step (03).
> 
> Do you agree?
> 
> If so, I'll ask Jiewen about such OS->SMM calls separately, because I
> seem to remember that there used to be an "SMM communcation table" of
> sorts, for flexible OS->SMM calls. However, it appears to be deprecated
> lately.
we can try to resurrect and put over it some kind of protocol
to describe which CPUs to where hotplugged.

or we could put a parameter into SMI status register (IO port 0xb3)
and the trigger SMI from GPE handler to tell SMI handler that cpu
hotplug happened and then use QEMU's cpu hotplug interface
to enumerate hotplugged CPUs for SMI handler.

The later is probably simpler as we won't need to reinvent the wheel
(just reuse the interface that's already in use by GPE handler).

> Hmmm.... Yes, UEFI 2.8 has "Appendix O - UEFI ACPI Data Table", and it
> writes (after defining the table format):
> 
>     The first use of this UEFI ACPI table format is the SMM
>     Communication ACPI Table. This table describes a special software
>     SMI that can be used to initiate inter-mode communication in the OS
>     present environment by non-firmware agents with SMM code.
> 
>     Note: The use of the SMM Communication ACPI table is deprecated in
>           UEFI spec. 2.7. This is due to the lack of a use case for
>           inter-mode communication by non-firmware agents with SMM code
>           and support for initiating this form of communication in
>           common OSes.
> 
> The changelog at the front of the UEFI spec also references the
> Mantis#1691 spec ticket, "Remove/Deprecate SMM Communication ACPI Table"
> (addressed in UEFI 2.6B).
> 
> (I think that must have been a security ticket, because, while I
> generally have access to Mantis tickets,
> <https://mantis.uefi.org/mantis/view.php?id=1631> gives me "Access
> Denied" :/ )
> 
> Thanks,
> Laszlo
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> 
> View/Reply Online (#48282): https://edk2.groups.io/g/devel/message/48282
> Mute This Topic: https://groups.io/mt/34201782/1958639
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [imammedo@redhat.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



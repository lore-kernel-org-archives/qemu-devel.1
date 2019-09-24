Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70485C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4540A20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4540A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCit4-0006QU-Fa
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iCirC-0005YA-Qu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iCirA-00018Y-Gq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iCirA-000181-3v
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:19:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E84B1307D96D;
 Tue, 24 Sep 2019 11:19:42 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D53991001938;
 Tue, 24 Sep 2019 11:19:37 +0000 (UTC)
Date: Tue, 24 Sep 2019 13:19:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Laszlo Ersek" <lersek@redhat.com>
Subject: Re: [edk2-devel] [Qemu-devel] [PATCH 1/2] q35: implement 128K SMRAM
 at default SMBASE address
Message-ID: <20190924131936.7dec5e6c@redhat.com>
In-Reply-To: <c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
 <20190917130708.10281-2-imammedo@redhat.com>
 <561f4440-7c06-10d7-80ce-bbfa810fec59@redhat.com>
 <20190920102855.3fe2b689@redhat.com>
 <a581abbc-ec03-c332-b225-6f7cd3cfadae@redhat.com>
 <c18f1ada-3eca-d5f1-da4f-e74181c5a862@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 24 Sep 2019 11:19:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On Mon, 23 Sep 2019 20:35:02 +0200
"Laszlo Ersek" <lersek@redhat.com> wrote:

> On 09/20/19 11:28, Laszlo Ersek wrote:
> > On 09/20/19 10:28, Igor Mammedov wrote:  
> >> On Thu, 19 Sep 2019 19:02:07 +0200
> >> "Laszlo Ersek" <lersek@redhat.com> wrote:
> >>  
> >>> Hi Igor,
> >>>
> >>> (+Brijesh)
> >>>
> >>> long-ish pondering ahead, with a question at the end.  
> >> [...]
> >>  
> >>> Finally: can you please remind me why we lock down 128KB (32 pages) at
> >>> 0x3_0000, and not just half of that? What do we need the range at
> >>> [0x4_0000..0x4_FFFF] for?  
> >>
> >>
> >> If I recall correctly, CPU consumes 64K of save/restore area.
> >> The rest 64K are temporary RAM for using in SMI relocation handler,
> >> if it's possible to get away without it then we can drop it and
> >> lock only 64K required for CPU state. It won't help with SEV
> >> conflict though as it's in the first 64K.  
> > 
> > OK. Let's go with 128KB for now. Shrinking the area is always easier
> > than growing it.
> >   
> >> On QEMU side,  we can drop black-hole approach and allocate
> >> dedicated SMRAM region, which explicitly gets mapped into
> >> RAM address space and after SMI hanlder initialization, gets
> >> unmapped (locked). So that SMRAM would be accessible only
> >> from SMM context. That way RAM at 0x30000 could be used as
> >> normal when SMRAM is unmapped.  
> > 
> > I prefer the black-hole approach, introduced in your current patch
> > series, if it can work. Way less opportunity for confusion.
> > 
> > I've started work on the counterpart OVMF patches; I'll report back.  
> 
> I've got good results. For this (1/2) QEMU patch:
> 
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> 
> I tested the following scenarios. In every case, I verified the OVMF
> log, and also the "info mtree" monitor command's result (i.e. whether
> "smbase-blackhole" / "smbase-window" were disabled or enabled). Mostly,
> I diffed these text files between the test scenarios (looking for
> desired / undesired differences). In the Linux guests, I checked /
> compared the dmesg too (wrt. the UEFI memmap).
> 
> - unpatched OVMF (regression test), Fedora guest, normal boot and S3
> 
> - patched OVMF, but feature disabled with "-global mch.smbase-smram=off"
> (another regression test), Fedora guest, normal boot and S3
> 
> - patched OVMF, feature enabled, Fedora and various Windows guests
> (win7, win8, win10 families, client/server), normal boot and S3
> 
> - a subset of the above guests, with S3 disabled (-global
>   ICH9-LPC.disable_s3=1), and obviously S3 resume not tested
> 
> SEV: used 5.2-ish Linux guest, with S3 disabled (no support under SEV
> for that now):
> 
> - unpatched OVMF (regression test), normal boot
> 
> - patched OVMF but feature disabled on the QEMU cmdline (another
> regression test), normal boot
> 
> - patched OVMF, feature enabled, normal boot.
> 
> I plan to post the OVMF patches tomorrow, for discussion.
> 
> (It's likely too early to push these QEMU / edk2 patches right now -- we
> don't know yet if this path will take us to the destination. For now, it
> certainly looks great.)

Laszlo, thanks for trying it out.
It's nice to hear that approach is somewhat usable.
Hopefully we won't have to invent 'paused' cpu mode.

Pls CC me on your patches
(not that I qualify for reviewing,
but may be I could learn a thing or two from it)

> Thanks
> Laszlo
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> 
> View/Reply Online (#47864): https://edk2.groups.io/g/devel/message/47864
> Mute This Topic: https://groups.io/mt/34201782/1958639
> Group Owner: devel+owner@edk2.groups.io
> Unsubscribe: https://edk2.groups.io/g/devel/unsub  [imammedo@redhat.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



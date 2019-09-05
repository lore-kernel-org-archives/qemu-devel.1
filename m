Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F66C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E51D207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E51D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5txK-00057L-SP
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i5twc-0004as-SO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i5twb-0006rn-Ki
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i5twb-0006rJ-Bx
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C49561056FB1;
 Thu,  5 Sep 2019 15:45:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 143DA60C63;
 Thu,  5 Sep 2019 15:45:04 +0000 (UTC)
Date: Thu, 5 Sep 2019 17:45:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190905174503.2acaa46a@redhat.com>
In-Reply-To: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
 <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA25CC@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7728AB@shsmsx102.ccr.corp.intel.com>
 <20190827203102.56d0d048@redhat.com>
 <033ced1a-1399-968e-cce6-6b15a20b0baf@redhat.com>
 <20190830164802.1b17ff26@redhat.com>
 <a43d47e0-6e99-ad42-77d4-638421e8768c@redhat.com>
 <20190902104534.46e58c95@redhat.com>
 <2ef1910e-8879-028a-4db6-97a0ecc64083@redhat.com>
 <20190903165355.27e1eee0@redhat.com>
 <17985043-f16c-0ff4-6f60-b6762d72e848@redhat.com>
 <20190904115207.76bc6bfe@redhat.com>
 <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 05 Sep 2019 15:45:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 Alex Williamson <alex.williamson@redhat.com>, "Yao,
 Jiewen" <jiewen.yao@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 15:08:31 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 09/04/19 11:52, Igor Mammedov wrote:
> 
> >  it could be stolen RAM + black hole like TSEG, assuming fw can live without RAM(0x30000+128K) range
> >   (in this case fwcfg interface would only work for locking down the range)
> > 
> >  or
> > 
> >  we can actually have a dedicated SMRAM (like in my earlier RFC),
> >  in this case FW can use RAM(0x30000+128K) when SMRAM isn't mapped into RAM address space
> >  (in this case fwcfg would be used to temporarily map SMRAM into normal RAM and unmap/lock
> >   after SMI relocation handler was initialized).
> > 
> > If possible I'd prefer a simpler TSEG like variant.  
> 
> I think TSEG-like behavior is between these two. That is, I believe we
> should have explicit open/close/lock operations. And, when the range is
> closed (meaning, closed+unlocked, or closed+locked), then the black hole
> should take effect for code that's not running in SMM.
> 
> Put differently, its like the second choice, except the range never
> appears as normal RAM. "When SMRAM isn't mapped into RAM address space",
> then the address range shows "nothing" (black hole).
I guess we at point where patch is better then words, I'll send one as reply here shortly.
I've just implemented subset of above (opened, closed+locked).


> Regarding "fw can live without RAM(0x30000+128K) range" -- do you mean
> whether the firmware could use another RAM area for fw_cfg DMA?
> 
> If that's the question, then I wouldn't worry about it. I'd remove the
> 0x30000+128K range from the memory map, so the fw_cfg stuff (or anything
> else) would never allocate memory from the range. It's much more
> concerning to me however how the SMM infrastructure would deal with a
> hole in the memory map right there.
I didn't mean fwcfg in this context, what I meant if firmware were able
to avoid using RAM(0x30000+128K) range (since it becomes unusable after locking).
Looks like you just answered it here



Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57391C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7A220830
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7A220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG26t-0000rQ-8K
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 10:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iG261-0000SV-1j
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iG25y-0005AO-Ac
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iG25y-00058Z-20
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E31CC05AA56;
 Thu,  3 Oct 2019 14:28:40 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBB391001B13;
 Thu,  3 Oct 2019 14:28:36 +0000 (UTC)
Received: by virval.usersys.redhat.com (Postfix, from userid 500)
 id 933191005D3; Thu,  3 Oct 2019 16:28:35 +0200 (CEST)
Date: Thu, 3 Oct 2019 16:28:35 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [libvirt] [RFC] cpu_map: Remove pconfig from Icelake-Server CPU
 model
Message-ID: <20191003142835.GA4204@orkuz.int.mamuti.net>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
 <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
 <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
 <20190930161611.GP4884@orkuz.int.mamuti.net>
 <4d94d1d1-746b-dbe4-f705-b33e347f9138@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d94d1d1-746b-dbe4-f705-b33e347f9138@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 03 Oct 2019 14:28:40 +0000 (UTC)
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Kang,
 Luwei" <luwei.kang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "Hu, Robert" <robert.hu@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 11:20:42 +0200, Paolo Bonzini wrote:
> On 30/09/19 18:16, Jiri Denemark wrote:
> > On Mon, Sep 30, 2019 at 17:16:27 +0200, Paolo Bonzini wrote:
> >> On 30/09/19 16:31, Hu, Robert wrote:
> >>>> This might be a problem if there are plans to eventually make KVM support
> >>>> pconfig, though.  Paolo, Robert, are there plans to support pconfig in KVM in the
> >>>> future?
> >>> [Robert Hoo] 
> >>> Thanks Eduardo for efforts in resolving this issue, introduced from my Icelake CPU
> >>> model patch.
> >>> I've no idea about PCONFIG's detail and plan. Let me sync with Huang, Kai and answer
> >>> you soon.
> >>
> >> It's really, really unlikely.  It's possible that some future processor
> >> overloads PCONFIG in such a way that it will become virtualizable, but
> >> not IceLake.
> > 
> > I guess, the likelihood of this happening would be similar to
> > reintroducing other features, such as osxsave or ospke, right?
> 
> No, haveing osxsave and ospke was a mistake in the first place (they are
> not CPU features at all; they are more like a special way to let
> unprivileged programs read some bits of CR4).  For pconfig, it's just
> very unlikely.
> 
> >> Would it make sense for libvirt to treat absent CPU flags as "default
> >> off" during migration, so that it can leave out the flag in the command
> >> line if it's off?  If it's on, libvirt would pass pconfig=on as usual.
> >> This is a variant of [2], but more generally applicable:
> >>
> >>> [2] However starting a domain with Icelake-Server so that it can be
> >>> migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
> >>> impossible. This can be solved by a different hack, which would drop
> >>> pconfig=off from QEMU command line.
> > 
> > The domain XML does not contain a complete list of all CPU features.
> > Features which are implicitly included in a CPU model are not listed in
> > the XML. Count in the differences in libvirt's vs QEMU's definitions of
> > a particular CPU model and you can see feat=off cannot be mechanically
> > dropped from the command line as the CPU model itself could turn it on
> > by default and thus feat=off is not redundant.
> 
> I think I wasn't very clear, I meant "unsupported by QEMU" when I said
> "absent".  Libvirt on the destination knows that from
> query-cpu-model-expansion, so it can leave off pconfig if it is not
> supported by the destination QEMU.

Oh yeah, we should do this (and I plan to do so), but it won't really
help us in this case. Although it could potentially save us some work in
case we end up in a similar situation.

Jirka


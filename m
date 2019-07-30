Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE81C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35626229EB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35626229EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUGS-00053N-AR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46385)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hsUG5-0004cP-Go
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hsUG4-0001Kt-Hb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hsUG4-0001KE-Bo; Tue, 30 Jul 2019 11:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A35C330272;
 Tue, 30 Jul 2019 15:41:47 +0000 (UTC)
Received: from work-vm (ovpn-117-45.ams2.redhat.com [10.36.117.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFD175D6B2;
 Tue, 30 Jul 2019 15:41:45 +0000 (UTC)
Date: Tue, 30 Jul 2019 16:41:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190730154143.GE2678@work-vm>
References: <20190729145229.4333-1-imammedo@redhat.com>
 <20190729145229.4333-2-imammedo@redhat.com>
 <20190729175315.GK2756@work-vm>
 <20190730152558.2e1aa23a@Igors-MacBook-Pro>
 <41ee4043-0f91-9bfa-f3f6-f85358250bb9@redhat.com>
 <20190730163557.034b876d@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730163557.034b876d@Igors-MacBook-Pro>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 30 Jul 2019 15:41:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] memory: make MemoryRegion alias
 migratable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Tue, 30 Jul 2019 15:34:54 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 30/07/19 15:25, Igor Mammedov wrote:
> > > I'd guess you've meant RAMBlocks instead of memory regions, if that's it
> > > then yes, every alias pointing to RAM backed memory region will have
> > > RAMBlock that's points to aliased part of aliased memory region.
> > 
> > The question is just, does it break migration from old QEMU to new QEMU
> > on x86 (which has plenty of RAM-backed aliases)?  If not, explain that
> > in the commit message or in a code comment.
> 
> pc/q35 old<->new new<->old ping pong tests worked fine (qemu with default devices).
> 
> My understanding was that one needs to call vmstate_register_ram()
> to make memory region migratable, which marks specific RAMBlock
> as migratable. So just assigning new RAMBlock to mr->ram_block shouldn't
> affect migration, unless vmstate_register_ram() is called on alias.

You're right; that's actually relatively new and I forget about it.
 From Cedric's b895de50271 in 3.0, before that we migrated every
RAMBlock.

So yes, I think you should be OK.

Dave

> I'll add it to commit message.
> 
> > 
> > Paolo
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


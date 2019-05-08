Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A9C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E255120850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E255120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMRT-00024R-1a
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:17:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hOMPf-00014Z-Lv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hOMPe-00022U-Gb
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:15:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hOMPe-000224-BK; Wed, 08 May 2019 09:15:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BFCF309B172;
	Wed,  8 May 2019 13:15:09 +0000 (UTC)
Received: from work-vm (ovpn-117-175.ams2.redhat.com [10.36.117.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 622FB643DD;
	Wed,  8 May 2019 13:15:07 +0000 (UTC)
Date: Wed, 8 May 2019 14:15:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190508131505.GI2718@work-vm>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<87woj2cyhu.fsf@dusky.pond.sub.org> <20190508102621.GD2718@work-vm>
	<87pnot148a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnot148a.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 08 May 2019 13:15:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> >> 
> >> > Add a monitor command "dump-stack" to be used to dump the stack for the
> >> > current cpu.
> >> 
> >> I guess this is just for debugging.  Correct?
> >> 
> >> Shouldn't this be "info stack", to match "info registers" and "info
> >> cpustats"?
> >
> > Since this is primarily about walking the guests stack frames and not
> > walking qemu internal data structures, I think it's probably OK to be
> > a dump-stack rather than an info subcommand.
> 
> Well, "info registers" is also about the guest's state and not QEMU
> internal state.  Arguably, so are "info pic", "info tlb", ...

When doing an 'info registers' you don't have to interpret or parse 
much guest state, you just print it, and it's guest state that's
held separately (similarly a separate piece of state for info pic, info
tlb etc).  You might check the register state a little when you
decide which bits to print or how to format them, but that's about as
far as it goes.  So each of the 'info's (or query for qmp) correspond
to one logical chunk of qemu and/or guest state.

Printing a stack is a much hairier thing, with knowledge of guest
stack layout and potentially some heuristics.

> We have a long-standing tradition of using "info" for "pure"
> information-retrieving commands.  I rather like that pattern.
> 
> Ultimately your choice as the HMP maintainer, of course.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


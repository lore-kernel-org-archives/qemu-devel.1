Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD85C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E73208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E73208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1had3U-0003sS-4F
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1had2W-0003J7-R4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1had2V-0000jd-HD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1had2S-0000eG-07; Tue, 11 Jun 2019 05:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6A995AFE9;
 Tue, 11 Jun 2019 09:25:54 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A082B19C70;
 Tue, 11 Jun 2019 09:25:53 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:25:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190611092550.GC2777@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-11-kwolf@redhat.com>
 <20190607172948.GU2631@work-vm>
 <20190611092249.GD8112@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611092249.GD8112@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 11 Jun 2019 09:25:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] monitor: Split out monitor/core.c
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 07.06.2019 um 19:29 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Move the monitor core infrastructure from monitor/misc.c to
> > > monitor/core.c. This is code that can be shared for all targets, so
> > > compile it only once.
> > > 
> > > What remains in monitor/misc.c after this patch is mostly monitor
> > > command implementations and code that requires a system emulator or is
> > > even target-dependent.
> > > 
> > > The amount of function and particularly extern variables in
> > > monitor_int.h is probably a bit larger than it needs to be, but this way
> > > no non-trivial code modifications are needed. The interfaces between all
> > > monitor parts can be cleaned up later.
> > > 
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > 
> > OK, but can you call it anything other than core.* - I regularly end up
> > deleting things like that!
> 
> Oh, I didn't even think of this kind of core.*!
> 
> I imagine in practice it wouldn't be so bad to have a monitor/core.c
> because it's in a subdirectory, and it's under version control anyway.
> We already seem to have quite a few of them in subdirectories:
> 
>     ./hw/acpi/core.c
>     ./hw/bt/core.c
>     ./hw/cpu/core.c
>     ./hw/i2c/core.c
>     ./hw/ide/core.c
>     ./hw/sd/core.c
>     ./hw/usb/core.c

Yes, they all annoy me in the same way :-)

> But I'll gladly rename it if I can find a good name. Do you have any
> suggestions? Maybe just monitor/monitor.c?

Yes that's fine, thanks!

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


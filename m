Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DFFC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEF0208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEF0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1had0u-0002Dh-A0
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1haczu-0001iP-Dk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1haczq-0006Fu-OZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1haczm-000680-5O; Tue, 11 Jun 2019 05:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01C5F5D5E6;
 Tue, 11 Jun 2019 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-156.ams2.redhat.com
 [10.36.117.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8C2A611BD;
 Tue, 11 Jun 2019 09:22:50 +0000 (UTC)
Date: Tue, 11 Jun 2019 11:22:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190611092249.GD8112@localhost.localdomain>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-11-kwolf@redhat.com>
 <20190607172948.GU2631@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607172948.GU2631@work-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 11 Jun 2019 09:23:02 +0000 (UTC)
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

Am 07.06.2019 um 19:29 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Move the monitor core infrastructure from monitor/misc.c to
> > monitor/core.c. This is code that can be shared for all targets, so
> > compile it only once.
> > 
> > What remains in monitor/misc.c after this patch is mostly monitor
> > command implementations and code that requires a system emulator or is
> > even target-dependent.
> > 
> > The amount of function and particularly extern variables in
> > monitor_int.h is probably a bit larger than it needs to be, but this way
> > no non-trivial code modifications are needed. The interfaces between all
> > monitor parts can be cleaned up later.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> OK, but can you call it anything other than core.* - I regularly end up
> deleting things like that!

Oh, I didn't even think of this kind of core.*!

I imagine in practice it wouldn't be so bad to have a monitor/core.c
because it's in a subdirectory, and it's under version control anyway.
We already seem to have quite a few of them in subdirectories:

    ./hw/acpi/core.c
    ./hw/bt/core.c
    ./hw/cpu/core.c
    ./hw/i2c/core.c
    ./hw/ide/core.c
    ./hw/sd/core.c
    ./hw/usb/core.c

But I'll gladly rename it if I can find a good name. Do you have any
suggestions? Maybe just monitor/monitor.c?

Kevin


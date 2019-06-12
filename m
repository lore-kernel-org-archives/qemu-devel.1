Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4FC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D978720896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D978720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb00U-0000VI-27
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hazxv-00076e-1s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hazxr-0006jD-85
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>)
 id 1hazxn-0006Fn-8C; Wed, 12 Jun 2019 05:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00F0D20264;
 Wed, 12 Jun 2019 09:54:19 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3FEF60CCC;
 Wed, 12 Jun 2019 09:54:16 +0000 (UTC)
Date: Wed, 12 Jun 2019 17:54:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612095414.GC17381@xz-x1>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-5-kwolf@redhat.com>
 <877e9r41fu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877e9r41fu.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 09:54:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/11] monitor: Create MonitorHMP with
 readline state
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 11:07:01AM +0200, Markus Armbruster wrote:

[...]

> > +struct MonitorHMP {
> > +    Monitor common;
> > +    /*
> > +     * State used only in the thread "owning" the monitor.
> > +     * If @use_io_thread, this is @mon_iothread.
> > +     * Else, it's the main thread.
> > +     * These members can be safely accessed without locks.
> > +     */
> > +    ReadLineState *rs;
> > +};
> > +
> 
> Hmm.
> 
> The monitor I/O thread code makes an effort not to restrict I/O thread
> use to QMP, even though we only use it there.  Whether the code would
> actually work for HMP as well we don't know.
> 
> Readline was similar until your PATCH 02: the code made an effort not to
> restrict it to HMP, even though we only use it there.  Whether the code
> would actually work for QMP as well we don't know.
> 
> Should we stop pretending and hard-code "I/O thread only for QMP"?
> 
> If yes, the comment above gets simplified by the patch that hard-codes
> "I/O thread only for QMP".
> 
> If no, we should perhaps point out that we currently don't use an I/O
> thread with HMP.  The comment above seems like a good place for that.

Yes I agree on that if we're refactoring the comment then we can make
it more explicit here.  For my own preference, I would prefer the
latter one, even we can have a bigger comment above MonitorHMP
mentioning that it's only used in main thread so no lock is needed for
all the HMP only structs (until someone wants to hammer on HMP again).

Thanks,

-- 
Peter Xu


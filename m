Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63894C04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3738F21743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3738F21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSujt-0003cc-G9
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 22:42:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSujC-0003Lm-Vp
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSujC-0002Ve-4R
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hSujB-0002VC-VH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:42:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED9783082E5A
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 02:42:08 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB73C19C5B;
	Tue, 21 May 2019 02:42:06 +0000 (UTC)
Date: Tue, 21 May 2019 10:42:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190521024204.GT16681@xz-x1>
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-14-peterx@redhat.com>
	<a9ca7154-d63d-c454-0474-d61c68d9e3ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9ca7154-d63d-c454-0474-d61c68d9e3ed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 21 May 2019 02:42:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/15] qmp: Expose
 manual_dirty_log_protect via "query-kvm"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 11:30:01AM -0500, Eric Blake wrote:
> On 5/19/19 10:08 PM, Peter Xu wrote:
> > Expose the new capability via "query-kvm" QMP command too so we know
> > whether that's turned on on the source VM when we want.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c  | 5 +++++
> >  include/sysemu/kvm.h | 2 ++
> >  qapi/misc.json       | 6 +++++-
> >  qmp.c                | 1 +
> >  4 files changed, 13 insertions(+), 1 deletion(-)
> > 
> 
> > +++ b/qapi/misc.json
> > @@ -253,9 +253,13 @@
> >  #
> >  # @present: true if KVM acceleration is built into this executable
> >  #
> > +# @manual-dirty-log-protect: true if manual dirty log protect is enabled
> > +#
> 
> If we want this exposed (and Paolo is right that we might not), it needs
> '(since 4.1)' designation.

Yes I'll drop them.  Still, thanks to review the grammar part (as
always).

-- 
Peter Xu


Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B4BC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1173D2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNS7-0008CV-8R
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:22:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTNMJ-0004by-V1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTNMI-0001BN-PA
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTNMF-000187-Uh; Wed, 22 May 2019 05:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3012A3058838;
	Wed, 22 May 2019 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-92.ams2.redhat.com
	[10.36.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 06448604D7;
	Wed, 22 May 2019 09:16:12 +0000 (UTC)
Date: Wed, 22 May 2019 11:16:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522091611.GA6087@localhost.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-2-mehta.aaru20@gmail.com>
	<d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
	<1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 22 May 2019 09:16:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 1/9] qapi/block-core: add
 option for io_uring
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.05.2019 um 02:51 hat Aarushi Mehta geschrieben:
> On Tue, 2019-05-21 at 19:39 -0500, Eric Blake wrote:
> > On 5/21/19 6:52 PM, Aarushi Mehta wrote:
> > > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > 
> > Sparse on the details. The subject line says what, but without a
> > 'why'
> > for how io_uring is different from existing aio options, it's hard to
> > see why I'd want to use it. Do you have any benchmark numbers?
> 
> For peak performance, io_uring helps us get to 1.7M 4k IOPS with
> polling. aio reaches a performance cliff much lower than that, at 608K.
> If we disable polling, io_uring is able to drive about 1.2M IOPS for
> the (otherwise) same test case.
> 
> More details, and the source for the above is at
> http://kernel.dk/io_uring.pdf
> 
> > > ---
> > >  qapi/block-core.json | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index 7ccbfff9d0..116995810a 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -2776,11 +2776,12 @@
> > >  #
> > >  # @threads:     Use qemu's thread pool
> > >  # @native:      Use native AIO backend (only Linux and Windows)
> > > +# @io_uring:    Use linux io_uring
> > 
> > Missing a '(since 4.1)' tag.
> > 
> > >  #
> > >  # Since: 2.9
> > >  ##
> > >  { 'enum': 'BlockdevAioOptions',
> > > -  'data': [ 'threads', 'native' ] }
> > > +  'data': [ 'threads', 'native','io_uring' ] }
> > 
> > Missing space after ',' (not essential, but matching style is nice).
> > Should the new element be defined conditionally, so that
> > introspection
> > only sees the new enum member when compiled for Linux?
> > 
> I'm not sure what would be the benefits of that? We already check for
> Linux at configure, and this would reduce readability. We aren't doing
> this for native.

BlockdevAioOptions is used in BlockdevOptionsFile, which contains the
options for two different drivers: file-posix and file-win32. Both of
them support both 'threads' and 'native'. However, I don't think you'll
add the new mode to the Windows driver. So I think making it conditional
on CONFIG_POSIX at least is necessary.

Kevin


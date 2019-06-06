Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD759C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8412C206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqv8-00071l-AT
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:51:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYquI-0006Zm-5z
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYquG-0004hE-Me
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:50:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hYquE-0004ec-LK; Thu, 06 Jun 2019 07:50:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97D0C5277D;
	Thu,  6 Jun 2019 11:50:00 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3C70691AC;
	Thu,  6 Jun 2019 11:49:52 +0000 (UTC)
Message-ID: <364d2c7f23f0b0bb4eb8331e103625813cf67175.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Aarushi Mehta
	<mehta.aaru20@gmail.com>
Date: Thu, 06 Jun 2019 14:49:51 +0300
In-Reply-To: <871s08efp3.fsf@dusky.pond.sub.org>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
	<20190603123823.32661-3-mehta.aaru20@gmail.com>
	<871s08efp3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 06 Jun 2019 11:50:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 2/9] qapi/block-core: add
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-06-05 at 07:58 +0200, Markus Armbruster wrote:
> Aarushi Mehta <mehta.aaru20@gmail.com> writes:
> 
> > Option only enumerates for hosts that support it.
> 
> Blank line here, please.  Same in other patches.
> 
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > ---
> >  qapi/block-core.json | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1defcde048..db7eedd058 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2792,11 +2792,13 @@
> >  #
> >  # @threads:     Use qemu's thread pool
> >  # @native:      Use native AIO backend (only Linux and Windows)
> > +# @io_uring:    Use linux io_uring (since 4.1)
> >  #
> >  # Since: 2.9
> >  ##
> >  { 'enum': 'BlockdevAioOptions',
> > -  'data': [ 'threads', 'native' ] }
> > +  'data': [ 'threads', 'native',
> > +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
> 
> We prefer '-' over '_' in the QAPI schema: 'io-uring' instead of
> 'io_uring'.  Exceptions can be made when existing siblings use '_' (not
> the case here), or to match how the thing is commonly spelled outside
> QEMU.  Up to the subject matter experts; I just want to make sure it's
> not accidental

I agree with that.
Other than that,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



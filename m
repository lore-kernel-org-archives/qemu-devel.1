Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A647C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3045220693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3045220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMtG-0003Cr-DN
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnMt6-0002nG-T6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnMt4-0002cc-MM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnMt0-0002Lh-6E; Tue, 16 Jul 2019 08:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26320300CB0B;
 Tue, 16 Jul 2019 12:48:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8876C5D71B;
 Tue, 16 Jul 2019 12:48:40 +0000 (UTC)
Message-ID: <ad961906a5fe82fc7492b0346e9f33bb37e051d7.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 15:48:39 +0300
In-Reply-To: <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
References: <20190716081516.27374-1-mlevitsk@redhat.com>
 <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 12:48:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-07-16 at 14:41 +0200, Max Reitz wrote:
> On 16.07.19 10:15, Maxim Levitsky wrote:
> > preallocation=off and preallocation=metadata
> > both allocate luks header only, and preallocation=falloc/full
> > is passed to underlying file.
> > 
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534951
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c       | 29 ++++++++++++++++++++++++++---
> >  qapi/block-core.json |  5 ++++-
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > 
> > Changes from V3: updated the blockdev-create description
> 
> Looks good functionally, but there is a syntax problem:
> 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 8237424ae6..034a645652 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> 
> [...]
> 
> > @@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
> >          .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
> >      };
> >  
> > +    if (luks_opts->has_preallocation)
> > +        preallocation = luks_opts->preallocation;
> 
> This lacks curly brackets.
In my defense, I am too much used to this due to kernel programming.
Eventually I will stop missing this.

> 
> > +
> >      ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
> > -                                         errp);
> > +                                         preallocation, errp);
> >      if (ret < 0) {
> >          goto fail;
> >      }
> 
> [...]
> 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 0d43d4f37c..9c04d83fa2 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4205,13 +4205,16 @@
> >  #
> >  # @file             Node to create the image format on
> >  # @size             Size of the virtual disk in bytes
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off/metadata/falloc/full (since: 4.2)
> 
> Also, this lacks a closing parenthesis somewhere.
True, I need more coffee.


> 
> Max
> 
> >  #
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> >    'data': { 'file':             'BlockdevRef',
> > -            'size':             'size' } }
> > +            'size':             'size',
> > +            '*preallocation':   'PreallocMode' } }
> >  
> >  ##
> >  # @BlockdevCreateOptionsNfs:
> > 
> 
> 


Best regards,
	Maxim Levitsky




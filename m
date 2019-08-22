Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90711C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A8D22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A8D22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kQh-0003tc-JT
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kLU-0006k0-53
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kLS-0005zB-Ok
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0kLQ-0005vZ-4K; Thu, 22 Aug 2019 06:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79370308FE8D;
 Thu, 22 Aug 2019 10:29:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431815C206;
 Thu, 22 Aug 2019 10:29:16 +0000 (UTC)
Date: Thu, 22 Aug 2019 11:29:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190822102914.GE3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <6b9b4bf7-5765-400b-7452-e37ec797eed1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b9b4bf7-5765-400b-7452-e37ec797eed1@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 10:29:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/13] qcrypto-luks: misc
 refactoring
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 05:40:11PM -0400, John Snow wrote:
> 
> 
> On 8/14/19 4:22 PM, Maxim Levitsky wrote:
> > This is also a preparation for key read/write/erase functions
> > 
> 
> This is a matter of taste and I am not usually reviewing LUKS patches
> (So don't take me too seriously), but I would prefer not to have "misc"
> patches and instead split things out by individual changes along with a
> nice commit message for each change.
> 
> > * use master key len from the header
> 
> This touches enough lines that you could make it its own patch, I think.
> 
> > * prefer to use crypto params in the QCryptoBlockLUKS
> >   over passing them as function arguments
> 
> I think the same is true here, and highlighting which variables you are
> sticking into state instead of leaving as functional parameters would be
> nice to see without all the other changes.
> 
> > * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> 
> This can likely be squashed with whichever patch of yours first needs to
> use it, because it's so short.
> 
> > * Add comments to various crypto parameters in the QCryptoBlockLUKS
> > 
> 
> Can probably be squashed with item #2.

Agreed, with all these points  - it is too hard to review this
for correctness with everything merged in one commit, so I'll
wait for v2 before reviewing much more.

> > @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAlgorithm cipher,
> >      }
> >  }
> >  
> > +static int masterkeylen(QCryptoBlockLUKS *luks)
> > +{
> > +    return luks->header.key_bytes;
> > +}
> > +
> > +
> 
> generally QEMU uses snake_case_names; please spell as "master_key_len".

Also naming convention in this file expects "qcrypto_block_luks_" prefix
for all methods


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


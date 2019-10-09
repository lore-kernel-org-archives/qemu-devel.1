Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5ECE2054F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ECE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJd6-0006Fs-Ac
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIIyD-00044Y-Ep
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 16:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIIyC-00035k-78
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 16:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIIy9-00035F-Ke; Wed, 09 Oct 2019 16:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D16E71DBC;
 Wed,  9 Oct 2019 20:54:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C672F6017E;
 Wed,  9 Oct 2019 20:54:00 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id AD03E4E589;
 Wed,  9 Oct 2019 20:54:00 +0000 (UTC)
Date: Wed, 9 Oct 2019 16:54:00 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <693191110.5428739.1570654440496.JavaMail.zimbra@redhat.com>
In-Reply-To: <287afb96-bfb7-5e6e-ca1c-0e2845f8ef3c@redhat.com>
References: <20191009194740.8079-1-crosa@redhat.com>
 <20191009194740.8079-2-crosa@redhat.com>
 <287afb96-bfb7-5e6e-ca1c-0e2845f8ef3c@redhat.com>
Subject: Re: [PATCH v2 1/4] qemu-iotests: remove bash shebang from library
 files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.122.151, 10.4.195.18]
Thread-Topic: qemu-iotests: remove bash shebang from library files
Thread-Index: 2MRtY1XOi4WL2k8COvBkYY26ulFOgA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 09 Oct 2019 20:54:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Eric Blake" <eblake@redhat.com>
> To: "Cleber Rosa" <crosa@redhat.com>, qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org, "Max Reitz" <mreitz@redhat.com>, "Kevin Wolf" <kwolf@redhat.com>, qemu-trivial@nongnu.org,
> "Michael Tokarev" <mjt@tls.msk.ru>, "Laurent Vivier" <laurent@vivier.eu>
> Sent: Wednesday, October 9, 2019 3:51:56 PM
> Subject: Re: [PATCH v2 1/4] qemu-iotests: remove bash shebang from library files
> 
> On 10/9/19 2:47 PM, Cleber Rosa wrote:
> > Due to not being able to find a reason to have shebangs on files that
> > are not executable.
> > 
> > While at it, add a mode hint to emacs, which would be clueless or
> > plain wrong about these containing shell code.
> > 
> > Suggested-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/qemu-iotests/common.config  | 2 +-
> >   tests/qemu-iotests/common.filter  | 2 +-
> >   tests/qemu-iotests/common.nbd     | 3 +--
> >   tests/qemu-iotests/common.pattern | 2 +-
> >   tests/qemu-iotests/common.qemu    | 2 +-
> >   tests/qemu-iotests/common.rc      | 2 +-
> >   tests/qemu-iotests/common.tls     | 2 +-
> >   7 files changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/common.config
> > b/tests/qemu-iotests/common.config
> > index 9bd1a5a6fc..b85a6a6f96 100644
> > --- a/tests/qemu-iotests/common.config
> > +++ b/tests/qemu-iotests/common.config
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/env bash
> > +# -*- emacs mode: sh -*-
> 
> I thought my version:
> # hey emacs, this file will be sourced by bash -*- mode: sh -*-
> was cuter, but that's not a requirement, and yours works  ;)
> 

I will not make any disputes on that! :)

Thanks for the reviews!
- Cleber.

> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 


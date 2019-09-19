Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FADC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2058A217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2058A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iArvd-0004gh-2l
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iArug-00045A-EG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iArue-0008V5-K7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iArua-0008T2-U1; Thu, 19 Sep 2019 04:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5D0A20F2;
 Thu, 19 Sep 2019 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.116.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E087196AE;
 Thu, 19 Sep 2019 08:35:31 +0000 (UTC)
Date: Thu, 19 Sep 2019 10:35:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190919083530.GC6645@localhost.localdomain>
References: <20190918085519.17290-1-kwolf@redhat.com>
 <b0f72b9f-69b1-4e1d-4321-d30c7d85355f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f72b9f-69b1-4e1d-4321-d30c7d85355f@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 19 Sep 2019 08:35:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Require Python 3.5 or later
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.09.2019 um 20:49 hat John Snow geschrieben:
> 
> 
> On 9/18/19 4:55 AM, Kevin Wolf wrote:
> > Running iotests is not required to build QEMU, so we can have stricter
> > version requirements for Python here and can make use of new features
> > and drop compatibility code earlier.
> > 
> > This makes qemu-iotests skip all Python tests if a Python version before
> > 3.5 is used for the build.
> > 
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/check | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index 875399d79f..a68f414d6c 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -633,6 +633,13 @@ then
> >       export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
> >   fi
> > +# Note that if the Python conditional here evaluates True we will exit
> > +# with status 1 which is a shell 'false' value.
> > +python_usable=false
> > +if ! $PYTHON -c 'import sys; sys.exit(sys.version_info >= (3,5))'; then
> > +    python_usable=true
> > +fi
> > +
> 
> Do we want this as a temporary fix only until we can stipulate the same
> version in the configure file?

I thought that maybe we should leave the code around so that at some
later point, we could upgrade it to 3.6 (or something else) before QEMU
as a whole does so.

In fact... Could we already require 3.6 now instead of using 3.5, which
I think we only chose because of Debian Stretch (oldstable)?

Kevin


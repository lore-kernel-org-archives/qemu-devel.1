Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72177C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464DA21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464DA21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAl4i-0005LY-BJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 21:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iAl2w-0004JI-63
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 21:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iAl2v-0001ys-3d
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 21:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iAl2s-0001xp-Hu; Wed, 18 Sep 2019 21:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AD88307CDEA;
 Thu, 19 Sep 2019 01:15:41 +0000 (UTC)
Received: from localhost (ovpn-116-86.gru2.redhat.com [10.97.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC4515D9CC;
 Thu, 19 Sep 2019 01:15:38 +0000 (UTC)
Date: Wed, 18 Sep 2019 22:15:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190919011536.GM4082@habkost.net>
References: <20190918085519.17290-1-kwolf@redhat.com>
 <b0f72b9f-69b1-4e1d-4321-d30c7d85355f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f72b9f-69b1-4e1d-4321-d30c7d85355f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 01:15:41 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 18, 2019 at 02:49:25PM -0400, John Snow wrote:
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
> 
> If so, leaving a comment with "python2" in it anywhere will help locate this
> later.

There are other sys.version_info checks in the tree, so we'll
surely grep for them once we remove python2 support:

scripts/decodetree.py:if sys.version_info >= (3, 4):
scripts/qapi/common.py:            if sys.version_info[0] >= 3:
scripts/qapi/common.py:        if sys.version_info[0] >= 3:
scripts/qapi/common.py:        if sys.version_info[0] >= 3:
scripts/qmp/qmp-shell:if sys.version_info[0] == 2:
tests/qemu-iotests/044:if sys.version_info.major == 2:
tests/qemu-iotests/163:if sys.version_info.major == 2:
tests/qemu-iotests/iotests.py:    if sys.version_info.major >= 3:
tests/qemu-iotests/iotests.py:        if sys.version_info.major >= 3:
tests/qemu-iotests/nbd-fault-injector.py:if sys.version_info.major >= 3:

-- 
Eduardo


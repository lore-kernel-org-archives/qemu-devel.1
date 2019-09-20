Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00451C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52072086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFEZ-0006KT-BA
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iBFCb-0004D6-Nb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iBFCa-0007uQ-JG
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iBFCX-0007sg-66; Fri, 20 Sep 2019 05:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FDB118C427A;
 Fri, 20 Sep 2019 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-81.ams2.redhat.com
 [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B46A75C1B5;
 Fri, 20 Sep 2019 09:27:30 +0000 (UTC)
Date: Fri, 20 Sep 2019 11:27:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 1/2] iotests: Require Python 3.6 or later
Message-ID: <20190920092729.GC5458@localhost.localdomain>
References: <20190919162905.21830-1-kwolf@redhat.com>
 <20190919162905.21830-2-kwolf@redhat.com>
 <5f0e3c27-1c33-0f9b-485b-c3e4a6700138@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0e3c27-1c33-0f9b-485b-c3e4a6700138@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 09:27:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.09.2019 um 10:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 19.09.2019 19:29, Kevin Wolf wrote:
> > Running iotests is not required to build QEMU, so we can have stricter
> > version requirements for Python here and can make use of new features
> > and drop compatibility code earlier.
> > 
> > This makes qemu-iotests skip all Python tests if a Python version before
> > 3.6 is used for the build.
> > 
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/qemu-iotests/check | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > index 875399d79f..588c453a94 100755
> > --- a/tests/qemu-iotests/check
> > +++ b/tests/qemu-iotests/check
> > @@ -633,6 +633,12 @@ then
> >       export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
> >   fi
> >   
> > +python_usable=false
> > +if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >= (3,6) else 1)'
> > +then
> > +    python_usable=true
> > +fi
> > +
> >   default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
> >   default_alias_machine=$($QEMU_PROG -machine help | \
> >      sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
> > @@ -809,7 +815,12 @@ do
> >           start=$(_wallclock)
> >   
> >           if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
> > -            run_command="$PYTHON $seq"
> > +            if $python_usable; then
> 
> hmm I wanted to say that this should not work, as python_usable is a
> string. But I checked and see - it's work. Wow. Googled. And now I
> understand that here "false" or "true" command is called, to obtain
> it's return value.. I don't like bash and don't know its best
> practice, but I'd prefer python_usable to be just return value of your
> python command, like
> 
> above:
> 
>    $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >= (3,6) else 1)'
>    python_usable=$?
> 
> and here:
> 
>    if [ $python_usable -eq 0 ]; then

I'm just trying to be consistent with other variables used in the
'check' script. It has many boolean variables and they all end up
calling the true/false commands.

And actually I think the version used is easier to read, even if maybe
not as easy to understand why exactly it works.

Kevin


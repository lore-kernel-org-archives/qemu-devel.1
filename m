Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8084321479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8084321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfU7-0002cC-Ky
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOfTK-0002IV-Pd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOfTJ-0007cQ-Pd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hOfTJ-0007bv-K0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7C4F81F18;
	Thu,  9 May 2019 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-186.ams2.redhat.com
	[10.36.116.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2246A17CEB;
	Thu,  9 May 2019 09:36:05 +0000 (UTC)
Date: Thu, 9 May 2019 11:36:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190509093604.GC6850@localhost.localdomain>
References: <20190508182339.22447-1-ehabkost@redhat.com>
	<87ftpo89le.fsf@dusky.pond.sub.org>
	<20190509092425.GB6850@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509092425.GB6850@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 09 May 2019 09:36:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Require python3 >= 3.5
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.05.2019 um 11:24 hat Kevin Wolf geschrieben:
> Am 09.05.2019 um 07:45 hat Markus Armbruster geschrieben:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> > > diff --git a/.travis.yml b/.travis.yml
> > > index 66448d99d6..0f6986b3f1 100644
> > > --- a/.travis.yml
> > > +++ b/.travis.yml
> > > @@ -211,7 +211,7 @@ matrix:
> > >          - CONFIG="--target-list=x86_64-softmmu"
> > >        language: python
> > >        python:
> > > -        - "3.4"
> > > +        - "3.5"
> > >  
> > >  
> > >      - env:
> > 
> > Easily missed, good work.
> > 
> > My grep for similar references to Python versions we don't support found
> > a few 2.x, x < 7.  Not this patch's problem, of course, but let me show
> > them anyway:
> 
> I'm sure that we have a few more instances of Python 2 compatibility
> code in qemu-iotests that can be removed after this is merged. These are
> what I could find quickly, but there are probably more:
> 
>     242:        # Read one byte in a way compatible with Python 2
>     iotests.py:        # Python < 3.4 needs to know not to add whitespace when pretty-printing:
> 
>     149:from __future__ import print_function
>     165:from __future__ import print_function
>     iotests.py:from __future__ import print_function
>     nbd-fault-injector.py:from __future__ import print_function
>     qcow2.py:from __future__ import print_function
>     qed.py:from __future__ import print_function
> 
>     044:if sys.version_info.major == 2:
>     163:if sys.version_info.major == 2:
>     iotests.py:    if sys.version_info.major >= 3:
>     iotests.py:        if sys.version_info.major >= 3:
>     nbd-fault-injector.py:if sys.version_info.major >= 3:
> 
> I'm planning to take care of the qemu-iotests ones.
> 
> Also, with Python 3.5 as the new minimum, I think I'd like to add type
> hints to iotests.py and possibly the qemu package (for QEMUQtestMachine
> and friends). The syntax isn't as nice as if we could go straight to
> 3.6, but still, finally some type checking instead of running into
> stupid runtime bugs!

Ah, sorry, I was getting too excited there. We only deprecate 2.x now
(and not even in this patch), but don't remove it yet. So I guess this
will have to wait until next year.

Kevin


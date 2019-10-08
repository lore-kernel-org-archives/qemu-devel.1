Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647CC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1AC20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1AC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlha-0003Og-Uo
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iHlcY-0006un-Ul
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iHlcW-0000AS-BW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:17:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14509)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iHlcW-00009A-3L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB555302C08A;
 Tue,  8 Oct 2019 09:17:26 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5254B5D70D;
 Tue,  8 Oct 2019 09:17:18 +0000 (UTC)
Date: Tue, 8 Oct 2019 10:17:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] netmap: support git-submodule build otption
Message-ID: <20191008091715.GC1192@redhat.com>
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
 <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
 <87zhicg2ce.fsf@dusky.pond.sub.org>
 <CAFEAcA9ydS1LR+dW+mT9gCPrevov_U9jKKrEKu2De_OTWeCETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ydS1LR+dW+mT9gCPrevov_U9jKKrEKu2De_OTWeCETg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 08 Oct 2019 09:17:27 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Luigi Rizzo <rizzo@iet.unipi.it>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 01:39:30PM +0100, Peter Maydell wrote:
> On Mon, 7 Oct 2019 at 13:36, Markus Armbruster <armbru@redhat.com> wrote:
> > If CI of QEMU code isn't useful, then I suspect the QEMU code isn't
> > useful, period.  Giuseppe assures us the netmap QEMU code *is* useful.
> > It followe we better make sure our CI covers it.
> 
> It would be an interesting idea to have a requirement that
> any new library dependency can't be introduced into QEMU
> unless one of the systems we do builds on can be set up
> so the new code is compiled...

Being able to at least compile code successfully is a pretty low bar
to cross in terms of CI, so I think that's reasonable in general.

I would not stop in terms of libraries though. We should document our
broader expectations for CI

Compilation

 - All new code must be compiled in one of[1] our CI systems.
 
   This implies

    - Libraries must be available in some OS we compile for

    - New host architectures must have cross compilers available

    - New OS distro targets must have VM test image support

This is not far off what we unofficially expect already, so
it shouldn't be too distruptive if we formally adopt it as a
mandatory rule.

Testing

 - All significant new features should have either unit or
   functional or integration test coverage

 ... something something something ...

We've not really set any expectations around CI beyond compile
testing thus far. We've got a mix of unit testing & functional
testing in the tests/ dir. We're increasingly getting stuff
added there when major features are added. Making this mandatory
is probably too large a step, but it is likely helpful if we
at least set some recommendations / guidelines to push people
in the direction we want to go longer term.

Regards,
Daniel

[1] Having to say "one of" is not especially great. It would be very nice
    to get to the point where we have either container images or VM images
    and no matter what CI harness(es) we use, they always run with either
    a container or VM image[2]. Even if we have bare metal machines available
    we can still execute actual builds inside containers or VM images so
    everyone uses a consistent environment for everything related to CI.

[2] macOS is a problem/exception here given that we can't legally distribute
    VM images, nor can we provide a cross compiler toolchain. For everything
    else we can make VM/container images though.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


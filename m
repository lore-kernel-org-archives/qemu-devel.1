Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA313C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE62207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE62207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haNvX-0001ZX-2t
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1haNrz-0008Pg-72
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1haNqP-0008WU-VO
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:12:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1haNqP-0008Ub-Pc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5573030BC572;
 Mon, 10 Jun 2019 17:12:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6259C5B681;
 Mon, 10 Jun 2019 17:12:16 +0000 (UTC)
Date: Mon, 10 Jun 2019 18:12:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190610171213.GK7809@redhat.com>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190610131105.GJ22416@habkost.net>
 <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 10 Jun 2019 17:12:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10, 2019 at 02:21:57PM +0100, Peter Maydell wrote:
> On Mon, 10 Jun 2019 at 14:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
> > > Hi. This fails to build on one of my buildtest machines:
> > >
> > > ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> > >        Use --python=/path/to/python to specify a supported Python.
> > >
> > > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > > box; it's one of the gcc compile farm machines so upgrades to its
> > > OS are not really under my control.)
> >
> > Ubuntu 16.04 LTS (Xenial) was released in April 2016.  Doesn't
> > that mean Trusty is not a supported build platform since April
> > 2018?
> 
> Possibly, but as I say the gcc compile farm is what it is.
> Regardless of the strict letter of the deprecation policy,
> when we start running into issues with the set of build test
> machines I tend to feel we may be being a bit over-hasty in
> deprecating things.

There's been two new LTS releases of Ubuntu since then
with Xenial and Bionic, so IMHO, it is pretty reasonable
to want to drop Trusty rather than continuing to spend time
on software versions from 2014 and before. Both our Travis
and Docker setups use Xenial as minimum and the number of
our developers stuck using Trusty is likely negligible.

What gap is your gcc compile farm filling & can we find an
alternate way to address that gap that's viable ?

Does the gcc compile farm include Docker to let us run the
build in a container from the compile farm. Or can we use
a Docker container on a modern x86_64 host to test the same
thing. We have docker containers for all Linux OS we need
to target, and docker containers for non-x86_64 arches that
cross compile.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


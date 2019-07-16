Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9CCC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BCC2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BCC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnRVI-00051z-O9
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 13:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hnRV9-0004dw-0z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hnRV7-0001vJ-Li
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hnRV7-0001ui-CX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:44:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B49792BE9F;
 Tue, 16 Jul 2019 17:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FC6560C44;
 Tue, 16 Jul 2019 17:44:22 +0000 (UTC)
Date: Tue, 16 Jul 2019 18:44:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190716174420.GA857@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 16 Jul 2019 17:44:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 07:09:37PM +0200, Aleksandar Markovic wrote:
> On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 16/07/2019 13.17, Aleksandar Markovic wrote:
> > > Hello, Gerd, Daniel, and others involved.
> > >
> > > I have multiple reports from end users that say that transition from
> > > SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
> > > In that light, they don't appreciate removing SDL 1.2 support from
> > > QEMU. The most notable example is Ubutnu 16.04, where it looks there
> > > is no way of installing SDL 2.0 that does not involve complete OS
> > > upgrade, which, for various reasons, many are not willing to do.
> >
> > What's the problem here? According to
> > https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should be
> > available there.
> >
> 
> Yes, we, as developers, are good at upgrading, we like flexibility in
> our development systems, and naturally want to try latest and greatest
> tools and libraries.

We were actually very conservative in requiring use of SDL 2. We shipped
QEMU with both SDL 1.2 & 2.0 support for many releases, and have only
dropped SDL 1.2 support *5* years after SDL 2.0 was shipped.

> However, in QA / build / test environments, the things seem to look
> different. Their main concern is stability and repeatibility of their
> systems. They don't like updates and upgrades. If a new of library
> is available for an OS, this does not mean it will be installed, or it
> will be desired to be installed.

No one ever wants to change what they do currently. That's totally
understandable & normal, but that comes with a cost to the project
to maintain compatibility indefinitely. That is not viable for a
project with limited maintainer resources.

There needs to be a balance between adding new technology, and
keeping compatibility with existing technology. QEMU has done
that for a very long time shipping SDL1.2 & SDL2 support in
parallel. More generally our platform support policy and our
feature deprecation policy try to set expectations for consumers
for what to expect in future releases.

> It appears that Ubuntu 16.04 came originally with SDL 1.2, and
> SDL 2.0 was made available later on.

That is not the case. Ubuntu has shipped both SDL 1.2 and 2.0
concurrently as options, even in the previous 14.04 LTS, and
probably before that too.

> That is the problem: We make, in my opinion, an incorrect logical
> leap here: we assume that if a package is available for an OS, it is
> installed (or should be installed) on any instance of an OS.

We're not assuming that it is installed, as everyone's OS install
packageset is going to be different. We're just assuming that it is
possible to be installed as an official vendor package, should the
user want that feature. This is not unreasonable IMHO.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


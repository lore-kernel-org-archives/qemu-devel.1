Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556DC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4622620693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4622620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnS0s-0000o8-42
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hnS0g-0000PU-DM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hnS0f-0006ro-4V
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hnS0e-0006rG-RI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 219C33091783;
 Tue, 16 Jul 2019 18:17:04 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B5DD600C4;
 Tue, 16 Jul 2019 18:16:59 +0000 (UTC)
Date: Tue, 16 Jul 2019 19:16:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190716181657.GC857@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
 <CAL1e-=jDKUo7UrXz4wPuby4fWHXEK0pj2k_=sXiHz=zz+66u4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=jDKUo7UrXz4wPuby4fWHXEK0pj2k_=sXiHz=zz+66u4A@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 18:17:04 +0000 (UTC)
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

On Tue, Jul 16, 2019 at 08:06:24PM +0200, Aleksandar Markovic wrote:
> > > It appears that Ubuntu 16.04 came originally with SDL 1.2, and
> > > SDL 2.0 was made available later on.
> >
> > That is not the case. Ubuntu has shipped both SDL 1.2 and 2.0
> > concurrently as options, even in the previous 14.04 LTS, and
> > probably before that too.
> >
> 
> Thank you for finding this out.
> 
> However, this bring to surface another problematic point:
> 
> We assume that introduction of SDL 2.0 to Ubuntu is a green light
> for deprecating SDL 1.2. In fact, SDL 1.2 is not deprecated by
> Ubuntu (at least not by 16.04) - as established by you.
>

> > > That is the problem: We make, in my opinion, an incorrect logical
> > > leap here: we assume that if a package is available for an OS, it is
> > > installed (or should be installed) on any instance of an OS.
> >
> > We're not assuming that it is installed, as everyone's OS install
> > packageset is going to be different. We're just assuming that it is
> > possible to be installed as an official vendor package, should the
> > user want that feature. This is not unreasonable IMHO.
> >
> 
> Again, what I find problematic is that we don't take deprecating
> of older version of a library by a distribution as our reference point,
> but our reference point is introducing of a new version.

Distros don't really do "deprecation" as a concept though.
They will continue to ship an old version of a library for
as long as they need to ship some application that consumes
it. IOW, the fact that SDL 1.2 exists still indicates that some
application the distro cares about is unable to build with
SDL 2 yet.

For this reason you'll even see distros still shipping GTK-1,
despite GTK-2 being released in 2002 and GTK-3 in 2011 and
GTK-4 appearing real soon.  IOW, it wouldn't surprise me if
SDL 1.2 exists in distros for another 10 years, despite the
upstream project considering it obsolete long ago. This
doesn't mean it is desirable / neccessary to continue to
support SDL 1.2 in downstream apps, when SDL 2 is widely
available.

> Daniel, in any case, thanks a lot for your responses, I will not
> respond to another email of yours in this thread, since I would be
> just repeating myself - I also responded to Peter and Thomas,
> so you can read those responses too for more details.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


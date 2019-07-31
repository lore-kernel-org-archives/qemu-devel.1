Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D17C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97B1206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97B1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmD8-0002sb-3q
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35382)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hsmCj-0002SN-GM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hsmCi-0007dK-9K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hsmCi-0007bj-4H
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67662307D91F;
 Wed, 31 Jul 2019 10:51:30 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0EAA5D6A7;
 Wed, 31 Jul 2019 10:51:27 +0000 (UTC)
Date: Wed, 31 Jul 2019 11:51:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190731105124.GB12463@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net>
 <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <87zhku90bd.fsf@dusky.pond.sub.org>
 <54711eb6-4d87-665a-c95a-749ee125b7c9@redhat.com>
 <CAFEAcA8EC2xmskmxSmrpR0XZ_55pkBp3GLGrUbb7z=SXzQAerw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8EC2xmskmxSmrpR0XZ_55pkBp3GLGrUbb7z=SXzQAerw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 31 Jul 2019 10:51:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 11:45:41AM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2019 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
> > IMHO we should get rid of mandating typedefs. They are causing too much
> > trouble - e.g. do you also remember the issues with duplicated typedefs
> > in certain compiler versions in the past? (these should be hopefully
> > gone now, but still...)
> >
> > And many QEMU developers are also working on the Linux kernel, which
> > rather forbids typedefs. Having to switch your mind back and forth
> > whether to use typedefs or not is really annoying.
> 
> I would rather keep typedefs -- it's one of the style issues we're
> reasonably consistent with. QEMU isn't the kernel, and its style
> is not the same on many points. If we switch to "use 'struct Foo'"
> we'll have a codebase which becomes rapidly very inconsistent
> about whether we use 'struct' or not.

I tend to agree - while people may work on kernel code, plenty do not
work on kernel code & QEMU is not following kernel code pratices more
generally. I think it is more compelling to align with glib given that
it is a core part of QEMU codebase. I'd much rather QEMU more closely
align with glib and increasingly drop stuff that QEMU has reinvented
in favour of using GLib features. For example I could see GObject as
a  base for QOM in future, and typedefs are a normal practice in this
case.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


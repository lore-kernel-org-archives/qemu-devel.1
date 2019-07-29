Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BDBC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE966206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE966206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs0uk-0006ML-6l
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hs0uM-0005xM-EF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hs0uL-0001mh-0M
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:21:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hs0uK-0001l5-Rn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 189092F8BC3;
 Mon, 29 Jul 2019 08:21:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8C24608D0;
 Mon, 29 Jul 2019 08:21:18 +0000 (UTC)
Date: Mon, 29 Jul 2019 09:21:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190729082115.GB32718@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 08:21:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 27, 2019 at 07:20:15PM +0100, Peter Maydell wrote:
> On Sat, 27 Jul 2019 at 13:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 27/07/19 09:16, Markus Armbruster wrote:
> > > We started with a single trace-events.  That wasn't good, so we split it
> > > up into one per directory.  That isn't good, so what about splitting it
> > > up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
> > > instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.
> >
> > For Make this would all work great, however not for Meson because it
> > doesn't allow per-file compile flags.
> 
> Apologies for randomly parachuting into this email thread, but if
> Meson doesn't support per-file compile flags then what's the plan
> for handling the cases where we currently need per-file compile flags ?

I'd suggest we don't actually /need/ per-file compiler flags in most
cases. eg when we add  $foo.o-libs += $(FOO_LIBS) that's not really
a per-file setting when it gets expanded onto the final linker line.
Its just a "-lfoo" that gets used for the library as a while.

> (This is one of the things that I thought was quite a nice move
> forward in our make infrastructure -- we now have clean syntax
> for saying "these files need to be built with these warnings disabled
> or these extra include paths or whatever" and also "these files
> imply we're going to need to link against library X".)

You can disable warnings selectively per file using a Pragma in the
source.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


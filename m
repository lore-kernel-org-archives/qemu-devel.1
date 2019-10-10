Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2913C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07BC20659
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07BC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIcQV-0004K7-31
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 13:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iIcPq-0003se-PD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iIcPp-0002VO-3k
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iIcPo-0002Uw-Rr
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D55843090FE3;
 Thu, 10 Oct 2019 17:39:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-19.ams2.redhat.com [10.36.112.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16E79614C1;
 Thu, 10 Oct 2019 17:39:39 +0000 (UTC)
Date: Thu, 10 Oct 2019 18:39:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Is network backend vde worth keeping? (was: Is network backend
 netmap worth keeping?)
Message-ID: <20191010173935.GA16081@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <878spwct7p.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878spwct7p.fsf_-_@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 10 Oct 2019 17:39:51 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, renzo@cs.unibo.it,
 Julia Suvorova <jusual@mail.ru>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 08:21:14PM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Please excuse the attention-grabbing subject.
> 
> Again.
> 
> [...]
> > So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> > build and install netmap software from sources.  Which pretty much
> 
> CONFIG_VDE seems to be similarly cumbersome to build-test.

VDE2 package is available in Ubuntu at least, so we could possibly
build in our CI that way I believe:

  https://packages.ubuntu.com/disco/vde2

> > ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
> [...]
> 
> The vde backend was added in commit 8a16d273887 (Jul 2008).  The commit
> message blames it on Luca Bigliardi.  Julia (cc'ed) fixed a bug in 2018.
> Can't see any other VDE-specific activity since we split net/vde.c off
> net.c in 2009.
> 
> I found a github repository virtualsquare/vde-2, which seems to be
> pertinent.  Recent commits have been merged by
> danielinux@users.noreply.github.com, which looks anti-social enough to
> me not to bother with a cc.  Further digging coughed up Renzo Davoli
> (cc'ed).

The website(s) are certainly not very clear as to what's the right
thing to be using.

The vde-2 code appears to be deprecated from what I can see though

http://wiki.virtualsquare.org/#!repos.md

"The vde-2 vde_switch is fully compatible with vdeplug4. Although
 it has not been rewritten yet, it includes several tools that are
 actual like vde\switch and wirefilter."

The vdeplug4 repo docs do refer to QEMU's  'vde' network config

   https://github.com/rd235/vdeplug4

but the repository doesn't show especially high level of activity
and I don't see this in any distros, only the old vde-2.

> > Why is the QEMU netmap backend worth keeping?
> >
> > Who is using the netmap backend?
> >
> > How do they obtain a netmap-enabled QEMU?  Compile it from sources
> > themselves?
> >
> > Would it make sense to have netmap packaged in common Linux distros?
> 
> Same questions for the QEMU vde backend.

It is in Ubuntu.  If it isn't widely available in distributions though,
that is surely a reflection the level of usage amongst users. 

The popular high performance userspace networking project(s) (DPDK) these
days all seem to be based around QEMU's vhostuser or TAP backends, which
is good as it means QEMU doesn't need to support an application specific
backend.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


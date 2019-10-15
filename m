Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A34C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5182064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5182064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIC5-0002cQ-It
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iKIAn-0001px-BL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iKIAk-0000i8-Gd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iKIAk-0000hV-Ag
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE0DC3084045;
 Tue, 15 Oct 2019 08:27:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F536012E;
 Tue, 15 Oct 2019 08:27:10 +0000 (UTC)
Date: Tue, 15 Oct 2019 09:27:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: RFC: Why dont we move to newer capstone?
Message-ID: <20191015082708.GB22859@redhat.com>
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
 <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 15 Oct 2019 08:27:12 +0000 (UTC)
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 05, 2019 at 02:33:34PM +0100, Peter Maydell wrote:
> On Sat, 5 Oct 2019 at 11:21, Lucien Murray-Pitts
> <lucienmp.qemu@gmail.com> wrote:
> > Whilst working on a m68k patch I noticed that the capstone in use
> > today (3.0) doesnt support the M68K and thus a hand turned disasm
> > function is used.
> >
> > The newer capstone (5.0) appears to support a few more CPU, inc. m68k.
> >
> > Why we move to this newer capstone?
> 
> Moving to a newer capstone sounds like a good idea. The only
> reason we haven't moved forward as far as I'm aware is that
> nobody has done the work to send a patch to do that move
> forward to the newer version. Richard Henderson would
> probably know if there was any other blocker.

Bearing in mind our distro support policy, we need to continue to
support 3.0 series of capstone for a while yet based on what I
see in various distros. eg Ubuntu 18.04 LTS has 3.0.4, as does
Fedora 29.  Version 4.0 is only in a few very new distros:

   https://repology.org/project/capstone/versions

We can of course use features from newer capstone, *provided* we correctly
do conditional compilation so that we can still build against 3.0 series
on distros that have that version.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


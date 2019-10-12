Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E15C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 13:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1608E2089F
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1608E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJHvt-0006rP-7j
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 09:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iJHvI-0006SM-C2
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iJHvG-0001tH-LJ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iJHvG-0001tC-G5
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:59:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2907518C8910;
 Sat, 12 Oct 2019 13:59:05 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A571F60BFB;
 Sat, 12 Oct 2019 13:59:04 +0000 (UTC)
Date: Sat, 12 Oct 2019 10:59:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
Message-ID: <20191012135903.GO4084@habkost.net>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
 <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
 <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
 <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
 <e5956649-c691-c7f1-de33-afa2bb272a20@redhat.com>
 <CAFEAcA90=bpsPhYyoYMzxCnnr8V+_dDuGXPLn5B_VqQFEu3Dvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA90=bpsPhYyoYMzxCnnr8V+_dDuGXPLn5B_VqQFEu3Dvw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Sat, 12 Oct 2019 13:59:05 +0000 (UTC)
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 04:39:00PM +0100, Peter Maydell wrote:
> On Thu, 19 Sep 2019 at 16:37, Eric Blake <eblake@redhat.com> wrote:
> >
> > On 9/19/19 10:22 AM, Peter Maydell wrote:
> >
> > > Alex looked at this and suggests the problem is probably because
> > > you're doing an in-tree build.
> >
> > Bingo.  I thought we wanted to get rid of that, though.  What's the
> > status on forcing out-of-tree builds?  (I'll adapt, but only once
> > patches are in that force me to).
> 
> I think the general consensus was that it would probably
> be a good idea, but nobody's actually written any code :-)
> (Among other things, various bits of CI infra, probably
> the tests/vm code, etc, need updating to not try to do
> an in-tree build.)

We have another issue introduced by this patch and not fixed yet,
caused by this sphinx-build bug:
https://github.com/sphinx-doc/sphinx/issues/2946

We're triggering that bug because the interop/index.html and
interop/qemu-ga.8 rules are using the same doctree cache
directory.

-- 
Eduardo


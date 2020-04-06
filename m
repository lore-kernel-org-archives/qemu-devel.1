Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66837C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD70248DC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD70248DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLU3a-0001Hu-Cu
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ruben@mrbrklyn.com>) id 1jLU2z-0000jJ-Uy
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ruben@mrbrklyn.com>) id 1jLU2y-0004k5-8t
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:52:25 -0400
Received: from www2.mrbrklyn.com ([96.57.23.82]:50942 helo=mrbrklyn.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ruben@mrbrklyn.com>)
 id 1jLU2y-0004iI-4x; Mon, 06 Apr 2020 11:52:24 -0400
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id 915C0163FB0; Mon,  6 Apr 2020 11:52:22 -0400 (EDT)
Date: Mon, 6 Apr 2020 11:52:22 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: QEMU participation to Google Season of Docs
Message-ID: <20200406155222.GA13914@www2.mrbrklyn.com>
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
 <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
 <f20f5784-d810-54d7-a25e-5394b2b75abd@redhat.com>
 <CAFEAcA8cS+7K1Wrguc0PyvRfZgaNpTNA4tSUsn13dxCcWz0ASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8cS+7K1Wrguc0PyvRfZgaNpTNA4tSUsn13dxCcWz0ASw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 96.57.23.82
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-discuss <qemu-discuss@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

never use google docs


On Mon, Apr 06, 2020 at 11:57:11AM +0100, Peter Maydell wrote:
> On Mon, 6 Apr 2020 at 11:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 04/04/20 03:37, John Snow wrote:
> > > I have a lot of opinions and thoughts on python and how docs should be
> > > laid out, but I'm afraid I'm not so good at understanding all of the
> > > options and "use cases" of QEMU to confidently lay out a top-level TOC.
> > > Maybe if we collaborated on a TOC we could give a clear project
> > > guideline to a GSoC/GSoD contributor.
> >
> > That's actually how a good technical writer can help us!  The main
> > problem we have with our docs is the disconnect between docs/system
> > (formerly qemu-doc) and the .txt files in docs/.  We know the material,
> > but it's hard to reorganize docs/system to make room for everything else.
> >
> > Reorganizing the TOC to fit all the material in both categories would be
> > the best outcome of our participation in GSoD.
> 
> Yep, and unlike last year we've actually (almost) completed
> the transition to Sphinx so we have a workable structure/tooling
> for a tech writer to work with.
> 
> thanks
> -- PMM

-- 
So many immigrant groups have swept through our town
that Brooklyn, like Atlantis, reaches mythological
proportions in the mind of the world - RI Safir 1998
http://www.mrbrklyn.com 

DRM is THEFT - We are the STAKEHOLDERS - RI Safir 2002
http://www.nylxs.com - Leadership Development in Free Software
http://www2.mrbrklyn.com/resources - Unpublished Archive 
http://www.coinhangout.com - coins!
http://www.brooklyn-living.com 

Being so tracked is for FARM ANIMALS and extermination camps, 
but incompatible with living as a free human being. -RI Safir 2013



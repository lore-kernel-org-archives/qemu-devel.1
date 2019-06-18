Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B37FC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1345320823
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1345320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8hH-0002Zo-5O
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56538)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hd8gV-00023w-UW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hd8gU-0004dx-TK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hd8gS-0004bm-N5; Tue, 18 Jun 2019 03:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A33D12F8BF5;
 Tue, 18 Jun 2019 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAF4B60922;
 Tue, 18 Jun 2019 07:37:30 +0000 (UTC)
Date: Tue, 18 Jun 2019 09:37:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190618073729.GB4296@localhost.localdomain>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <54598cf4-a326-5385-2d86-d2dd43f26f47@redhat.com>
 <125166e6-2983-aaa8-2dad-14c5c7081fd8@virtuozzo.com>
 <20190617160319.GL7397@linux.fritz.box>
 <4672fcf1-8998-698f-9ae7-af00b39b7322@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4672fcf1-8998-698f-9ae7-af00b39b7322@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 18 Jun 2019 07:37:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi: block-dirty-bitmap-remove
 transaction action
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.06.2019 um 09:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 17.06.2019 19:03, Kevin Wolf wrote:
> > Am 17.06.2019 um 13:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 08.06.2019 1:26, John Snow wrote:
> >>>
> >>>
> >>> On 6/3/19 8:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> >>>> Hi all!
> >>>>
> >>>> Here is block-dirty-bitmap-remove transaction action.
> >>>>
> >>>> It is used to do transactional movement of the bitmap (which is
> >>>> possible in conjunction with merge command). Transactional bitmap
> >>>> movement is needed in scenarios with external snapshot, when we don't
> >>>> want to leave copy of the bitmap in the base image.
> >>>>
> >>>
> >>> Oh, interesting. I see why you want this now. OK, let's do it.
> >>>
> >>
> >>
> >> Hi John!
> >>
> >> Hmm, could you stage it, or should I fix something? Seems I've answered all questions.
> >> We need this for our nearest release and wanting to avoid x-vz- prefixes in the API,
> >> I'd be very grateful if we merge it soon.
> > 
> > I hope you won't have to do this, but in any case x-vz- isn't the right
> > prefix. Please read section '6. Downstream extension of QMP' in
> > docs/interop/qmp-spec.txt before adding your own extensions.
> > 
> > According to the spec, your prefix would be something like
> > __com.virtuozzo-...
> > 
> 
> Thanks for pointing to that, I thought about this some time ago when saw Red Hat prefixes..
> Still x-vz- is a lot better than nothing and most probably will not intersect with future
> things. However, we'll move to correct prefixes of course.

Yes, I agree that x-vz- is unlikely to cause any trouble in practice,
it's just out-of-spec strictly speaking. So for anything new that you
introduce, it would be better to follow the spec.

Kevin


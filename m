Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAB9C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3192C20652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3192C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuwm-0003vc-GC
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcu74-0005Nn-HE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcu73-0008OB-9K
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hcu6y-00080c-2s; Mon, 17 Jun 2019 12:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABA445D674;
 Mon, 17 Jun 2019 16:03:25 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B15E269182;
 Mon, 17 Jun 2019 16:03:22 +0000 (UTC)
Date: Mon, 17 Jun 2019 18:03:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190617160319.GL7397@linux.fritz.box>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <54598cf4-a326-5385-2d86-d2dd43f26f47@redhat.com>
 <125166e6-2983-aaa8-2dad-14c5c7081fd8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125166e6-2983-aaa8-2dad-14c5c7081fd8@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 17 Jun 2019 16:03:25 +0000 (UTC)
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

Am 17.06.2019 um 13:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 08.06.2019 1:26, John Snow wrote:
> > 
> > 
> > On 6/3/19 8:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> >> Hi all!
> >>
> >> Here is block-dirty-bitmap-remove transaction action.
> >>
> >> It is used to do transactional movement of the bitmap (which is
> >> possible in conjunction with merge command). Transactional bitmap
> >> movement is needed in scenarios with external snapshot, when we don't
> >> want to leave copy of the bitmap in the base image.
> >>
> > 
> > Oh, interesting. I see why you want this now. OK, let's do it.
> > 
> 
> 
> Hi John!
> 
> Hmm, could you stage it, or should I fix something? Seems I've answered all questions.
> We need this for our nearest release and wanting to avoid x-vz- prefixes in the API,
> I'd be very grateful if we merge it soon.

I hope you won't have to do this, but in any case x-vz- isn't the right
prefix. Please read section '6. Downstream extension of QMP' in
docs/interop/qmp-spec.txt before adding your own extensions.

According to the spec, your prefix would be something like
__com.virtuozzo-...

Kevin


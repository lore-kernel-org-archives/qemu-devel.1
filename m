Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39744C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E042082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E042082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb4Ji-0008LH-8v
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb4DW-0005RL-3R
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb459-0001e0-18
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb451-0001TZ-J2; Wed, 12 Jun 2019 10:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A792830872D7;
 Wed, 12 Jun 2019 14:18:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 848305C644;
 Wed, 12 Jun 2019 14:18:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 174AF1138648; Wed, 12 Jun 2019 16:18:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-4-kwolf@redhat.com>
 <875zpb5j4b.fsf@dusky.pond.sub.org>
 <20190612112807.GB9699@localhost.localdomain>
Date: Wed, 12 Jun 2019 16:18:08 +0200
In-Reply-To: <20190612112807.GB9699@localhost.localdomain> (Kevin Wolf's
 message of "Wed, 12 Jun 2019 13:28:07 +0200")
Message-ID: <87tvcux4yn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 14:18:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/11] monitor: Make MonitorQMP a child
 class of Monitor
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.06.2019 um 09:59 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Currently, struct Monitor mixes state that is only relevant for HMP,
>> > state that is only relevant for QMP, and some actually shared state.
>> > In particular, a MonitorQMP field is present in the state of any
>> > monitor, even if it's not a QMP monitor and therefore doesn't use the
>> > state.
>> >
>> > As a first step towards a clean separation between QMP and HMP, let
>> > MonitorQMP extend Monitor and create a MonitorQMP object only when the
>> > monitor is actually a QMP monitor.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> This is a bit harder to review than necessary, because it mixes the
>> largely mechanical "replace QMP member by child class" with the
>> necessary prerequisite "clean up to access QMP stuff only when the
>> monitor is actually a QMP monitor".  I'm going to post a split.
>> 
>> Effectively preexisting: we go from Monitor * to MonitorQMP * without
>> checking in several places.  I'll throw in assertions.
>
> Since I don't think doing both in one patch makes review a lot harder
> (and in fact think your patch 2.5 is harder to review for completeness
> that the combined patch)

I disagree with the parenthesis.  The completeness argument is really
simple: each occurence of member qmp is either guarded by a "is a QMP
monitor" conditional, or an "is a QMP monitor" assertion, or in a
callback that takes a QMP monitor converted to void * (I didn't bother
asserting anything there).

>                          and since both Dave and you already reviewed
> the patch in its current form

Actually, I didn't review the patch "in its current form", because I
found that more bothersome than splitting it up and reviewing the parts.

By effectively squashing together the parts, you have of course every
right to claim the resulting code passed my review.  That's not quite
the same as claiming my R-by for the *patch*.

>                                   I don't want to invalidate that
> review, I'm going to keep it as a single patch and just squash in the
> additional assertions where container_of() is used. The resulting code
> is the same anyway.

Having the commit message explain that the patch mixes mechanical change
for the "replace QMP member by child class" data reorganization with its
prerequisite cleanup "access QMP stuff only when the monitor is actually
a QMP monitor" might suffice to make me acquiesce to the squashed patch.


Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7583ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8586520873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8586520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKISs-0005qd-Ln
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iKIRy-0005Ad-Nq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iKIRx-0008Km-Hr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iKIRu-0008Jt-Q8; Tue, 15 Oct 2019 04:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E32A830655F9;
 Tue, 15 Oct 2019 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B081960C80;
 Tue, 15 Oct 2019 08:44:44 +0000 (UTC)
Date: Tue, 15 Oct 2019 10:44:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PULL 01/19] util/hbitmap: strict hbitmap_reset
Message-ID: <20191015084443.GA4093@localhost.localdomain>
References: <20191011212550.27269-1-jsnow@redhat.com>
 <20191011212550.27269-2-jsnow@redhat.com>
 <15c20480-0240-bdd2-2cc2-60c388022e86@redhat.com>
 <e403b26e-5775-a134-b23f-2fbc698dca25@redhat.com>
 <0642e0a5-4304-6e7a-318e-0251c9642f46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0642e0a5-4304-6e7a-318e-0251c9642f46@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 15 Oct 2019 08:44:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.10.2019 um 20:10 hat John Snow geschrieben:
>=20
>=20
> On 10/11/19 7:18 PM, John Snow wrote:
> >=20
> >=20
> > On 10/11/19 5:48 PM, Eric Blake wrote:
> >> On 10/11/19 4:25 PM, John Snow wrote:
> >>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>
> >>> hbitmap_reset has an unobvious property: it rounds requested region=
 up.
> >>> It may provoke bugs, like in recently fixed write-blocking mode of
> >>> mirror: user calls reset on unaligned region, not keeping in mind t=
hat
> >>> there are possible unrelated dirty bytes, covered by rounded-up reg=
ion
> >>> and information of this unrelated "dirtiness" will be lost.
> >>>
> >>> Make hbitmap_reset strict: assert that arguments are aligned, allow=
ing
> >>> only one exception when @start + @count =3D=3D hb->orig_size. It's =
needed
> >>> to comfort users of hbitmap_next_dirty_area, which cares about
> >>> hb->orig_size.
> >>>
> >>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> >>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>> Message-Id: <20190806152611.280389-1-vsementsov@virtuozzo.com>
> >>> [Maintainer edit: Max's suggestions from on-list. --js]
> >>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>> ---
> >>> =A0 include/qemu/hbitmap.h | 5 +++++
> >>> =A0 tests/test-hbitmap.c=A0=A0 | 2 +-
> >>> =A0 util/hbitmap.c=A0=A0=A0=A0=A0=A0=A0=A0 | 4 ++++
> >>> =A0 3 files changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>
> >>> +++ b/util/hbitmap.c
> >>> @@ -476,6 +476,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start=
,
> >>> uint64_t count)
> >>> =A0=A0=A0=A0=A0 /* Compute range in the last layer.=A0 */
> >>> =A0=A0=A0=A0=A0 uint64_t first;
> >>> =A0=A0=A0=A0=A0 uint64_t last =3D start + count - 1;
> >>> +=A0=A0=A0 uint64_t gran =3D 1ULL << hb->granularity;
> >>> +
> >>> +=A0=A0=A0 assert(!(start & (gran - 1)));
> >>> +=A0=A0=A0 assert(!(count & (gran - 1)) || (start + count =3D=3D hb=
->orig_size));
> >>
> >> I know I'm replying a bit late (since this is now a pull request), b=
ut
> >> would it be worth using the dedicated macro:
> >>
> >> assert(QEMU_IS_ALIGNED(start, gran));
> >> assert(QEMU_IS_ALIGNED(count, gran) || start + count =3D=3D hb->orig=
_size);
> >>
> >> instead of open-coding it?=A0 (I would also drop the extra () around=
 the
> >> right half of ||). If we want it, that would now be a followup patch=
.
>=20
> I've noticed that seasoned C programmers hate extra parentheses a lot.
> I've noticed that I cannot remember operator precedence enough to ever
> feel like this is actually an improvement.
>=20
> Something about a nice weighted tree of ((expr1) || (expr2)) feels
> soothing to my weary eyes. So, if it's not terribly important, I'd
> prefer to leave it as-is.

I don't mind the parentheses, but I do prefer QEMU_IS_ALIGNED() to the
open-coded version. Would that be a viable compromise?

Kevin


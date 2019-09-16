Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F287C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538C2206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538C2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m1Q-0003ED-Uh
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i9lw2-0007vG-Pl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i9lw1-00070h-3O
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i9lvu-0006vV-Hb; Mon, 16 Sep 2019 04:00:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5698518CB8F5;
 Mon, 16 Sep 2019 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-251.ams2.redhat.com
 [10.36.116.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E94FB9D4E;
 Mon, 16 Sep 2019 08:00:03 +0000 (UTC)
Date: Mon, 16 Sep 2019 10:00:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190916080002.GB10930@localhost.localdomain>
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
 <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
 <c0f0831f-851b-a76d-208c-22d97e4392d8@virtuozzo.com>
 <57111ad3-6acc-1027-2e5a-f203929e48b6@redhat.com>
 <c773ab2c-368c-825e-dd51-5ff8b5060c2b@virtuozzo.com>
 <f125fc22-98ae-3146-4fba-524da959bf17@redhat.com>
 <0ccc2288-fd76-25f9-0cc7-c92fd8ea5d36@virtuozzo.com>
 <495800ff-c664-7a9b-4b3f-0bea9741784e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <495800ff-c664-7a9b-4b3f-0bea9741784e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 16 Sep 2019 08:00:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.09.2019 um 20:49 hat John Snow geschrieben:
> On 9/12/19 4:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> > Also, I'm not sure about "are" suggested by Max. "are" is for plural, but here I meant
> > one object: sum of @start and @count.
> > 
> 
> There's not great agreement universally about how to treat things like
> collective nouns. Sometimes "Data" is singular, but sometimes it's
> plural. "It depends."
> 
> In this case, "start + count" refers to one sum, but two constituent
> pieces, so it's functioning like a collective noun.
> 
> We might say "a + b (together) /are/ ..." but also "the sum of a + b /is/".
> 
> > So, you may use exactly "Sum of @start and @count is" or "(@start + @count) sum is" or
> > just "(@start + @count) is", whichever you like more.
> > 
> 
> I like using "the sum of @x and @y is" for being grammatically unambiguous.
> 
> updated and pushed.
> 
> (Sorry about my language again! --js)

Time to revive https://patchwork.kernel.org/patch/8725621/? ;-)

Kevin


Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35897C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0360921783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 10:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcAb-000495-VQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 06:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iFc99-0003ZY-Oe
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iFc98-0001FL-LB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 06:46:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iFc91-00019N-TU; Wed, 02 Oct 2019 06:46:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A121368B1;
 Wed,  2 Oct 2019 10:46:06 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 164005D9D6;
 Wed,  2 Oct 2019 10:46:02 +0000 (UTC)
Date: Wed, 2 Oct 2019 12:46:00 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191002104600.GC6129@angien.pipo.sk>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 02 Oct 2019 10:46:06 +0000 (UTC)
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 12:07:54 -0400, John Snow wrote:
> 
> 
> On 10/1/19 11:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 01.10.2019 17:10, John Snow wrote:
> >>
> >>
> >> On 10/1/19 10:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> >>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> >>>> ultimately what we want is to be able to find the "addressable" name for
> >>>> the node the bitmap is attached to, which would be the name of the first
> >>>> ancestor node that isn't a filter. (OR, the name of the block-backend
> >>>> above that node.)
> >>> Not the name of ancestor node, it will break mapping: it must be name of the
> >>> node itself or name of parent (may be through several filters) block-backend
> >>>
> >>
> >> Ah, you are right of course -- because block-backends are the only
> >> "nodes" for which we actually descend the graph and add the bitmap to
> >> its child.
> >>
> >> So the real back-resolution mechanism is:
> >>
> 
> Amendment:
>    - If our local node-name N is well-formed, use this.

I'd like to re-iterate that the necessity to keep node names same on
both sides of migration is unexpected, undocumented and in some cases
impossible.

If you want to mandate that they must be kept the same please document
it and also note the following:

- during migrations the storage layout may change e.g. a backing chain
  may become flattened, thus keeping node names stable beyond the top
  layer is impossible

- in some cases (readonly image in a cdrom not present on destination,
  thus not relevant here probably) it may even become impossible to
  create any node thus keeping the top node may be impossible

- it should be documented when and why this happens and how management
  tools are supposed to do it

- please let me know what's actually expected, since libvirt
  didn't enable blockdev yet we can fix any unexpected expectations

- Document it so that the expectations don't change after this.

- Ideally node names will not be bound to anything and freely
  changeable. If necessary we can provide a map to qemu during migration
  which is probably less painful and more straightforward than keeping
  them in sync somehow ...

>    - Otherwise:
> >> - Find the first non-filter ancestor, A
> >> - if A is not a block-backend, we must use our node-local name.
>      Amendment: If it's not a BB, we have no addressable name
>                 for the bitmap and this is an error.
> >> - if A's name is empty, we must use our node-local name.
>      Amendment: If it's empty, we have no addressable name
>                 for the bitmap and this is an error.
> >> - If the name we have chosen is not id_wellformed, we have no
> >> migration-stable addressable name for this bitmap and the migration must
> >> fail!
>      (Handled by above amendments.)



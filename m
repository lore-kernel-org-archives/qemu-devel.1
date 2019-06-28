Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FECC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301D62064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301D62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsiD-0006tu-AM
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgrgA-0003Jp-5A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgrg9-0005Xq-2N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgrg6-0005Ue-B2; Fri, 28 Jun 2019 10:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F49988306;
 Fri, 28 Jun 2019 14:16:32 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 152225D704;
 Fri, 28 Jun 2019 14:16:29 +0000 (UTC)
Date: Fri, 28 Jun 2019 16:16:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190628141628.GK5179@dhcp-200-226.str.redhat.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <w517e97dogw.fsf@maestria.local.igalia.com>
 <20190628092057.GA5179@dhcp-200-226.str.redhat.com>
 <w515zoqjass.fsf@maestria.local.igalia.com>
 <20190628100422.GE5179@dhcp-200-226.str.redhat.com>
 <w51v9wpj191.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51v9wpj191.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 14:16:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.06.2019 um 15:19 hat Alberto Garcia geschrieben:
> On Fri 28 Jun 2019 12:04:22 PM CEST, Kevin Wolf wrote:
> > Am 28.06.2019 um 11:53 hat Alberto Garcia geschrieben:
> >> On Fri 28 Jun 2019 11:20:57 AM CEST, Kevin Wolf wrote:
> >> >> >> I would consider 64k cluster/8k subcluster as too extreme for me.
> >> >> 
> >> >> I forgot to add: this 64k/8k ratio is only with my current prototype.
> >> >> 
> >> >> In practice if we go with the 128-bit L2 entries we would have 64
> >> >> subclusters per cluster, or 32 if we want to have a separate
> >> >> QCOW_OFLAG_ZERO for each subcluster (would we need this?).
> >> >
> >> > Yes, I think we'd want to have a separate zero flag for each
> >> > subcluster.  Otherwise, when writing to a zero cluster, you'd have to
> >> > COW the whole supercluster again.
> >> 
> >> Yes if the original cluster had the QCOW_OFLAG_ZERO bit, not if it
> >> was simply unallocated.
> >
> > Right, but that leaving clusters simply unallocated doesn't quite cut
> > it is something we already noticed before writing the spec for
> > v3. Only really necessary when you have a backing file, of course, but
> > that's one of the more interesting cases for subclusters anyway.
> 
> I wonder if it would be possible to have a hybrid solution:
> 
> With 64 bits to indicate the allocation status of each subcluster we
> still have the original L2 entry with its QCOW_OFLAG_ZERO bit, so we
> need to specify what happens if that bit is set and at the same time
> some subclusters are marked as allocated.
> 
> One possibility is that allocated subclusters have actual data and the
> rest are zero subclusters.

Hm, yes, that would be possible.

However, that would require some addtional complexity in write_zeroes
then: If the zero flag isn't set yet, then we need to check that no
other subcluster is unallocated before we can turn the zero flag on for
the whole cluster. You couldn't have subclusters referring to the
backing file and zeroed subclusters at the same time.

Maybe doubling the number of bits would actually be worth the additional
complexity in write_zeroes.

Another thing to consider is that with two bits per subcluster, we'd
still have one combination left for other purposes (we only have
unallocated, allocated, zero). In previous discussions, we talked about
the possibility of using that for a new "write-through to backing file"
cluster type. It's not clear if this is a good idea, but it came up
multiple times in the past.

Kevin


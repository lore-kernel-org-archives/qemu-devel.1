Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC867C3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1013206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1013206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKx9-000426-Ss
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyKwU-0003W6-CP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyKwR-0006JT-U5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyKwR-0006Iz-Ol
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C04A68535C;
 Thu, 15 Aug 2019 18:57:41 +0000 (UTC)
Received: from work-vm (ovpn-117-19.ams2.redhat.com [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4285E1001925;
 Thu, 15 Aug 2019 18:57:40 +0000 (UTC)
Date: Thu, 15 Aug 2019 19:57:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Message-ID: <20190815185737.GC2883@work-vm>
References: <20190815200815.2cffc21b@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815200815.2cffc21b@luklap>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 18:57:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> Hello Everyone,
> These Patches add support for continious replication to colo.
> Please review.


OK, for those who haven't followed COLO for so long; 'continuous
replication' is when after the first primary fails, you can promote the 
original secondary to a new primary and start replicating again;

i.e. current COLO gives you

p<->s
    <primary fails>
    s

with your patches you can do

    s becomes p2
    p2<->s2

and you're back to being resilient again.

Which is great; because that was always an important missing piece.

Do you have some test scripts/setup for this - it would be great
to automate some testing.

Dave

> Regards,
> Lukas Straub
> 
> v2:
>  - fix email formating
>  - fix checkpatch.pl warnings
>  - fix patchew error
>  - clearer commit messages
> 
> Lukas Straub (3):
>   Replication: Ignore requests after failover
>   net/filter.c: Add Options to insert filters anywhere in the filter
>     list
>   Update Documentation
> 
>  block/replication.c  |  38 ++++++++-
>  docs/COLO-FT.txt     | 185 ++++++++++++++++++++++++++++++++-----------
>  include/net/filter.h |   2 +
>  net/filter.c         |  71 ++++++++++++++++-
>  qemu-options.hx      |  10 +--
>  5 files changed, 250 insertions(+), 56 deletions(-)
> 
> --
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


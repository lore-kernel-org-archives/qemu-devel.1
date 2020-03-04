Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941AEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2632166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF8e/p/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2632166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9PAv-0002O6-JV
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j9P9n-0000Se-4W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j9P9m-000787-56
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j9P9m-00077C-21
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583309609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmXNyWHsRL6hsnawBkrLdWYRS+qxOL9/4aV82FlZ34c=;
 b=dF8e/p/mnVHlTPb/zqRwatsT18URpy7UDP7fHpiZc933mlO+xSbgEsra/2mpl/JVVzVlry
 3A+60AeqAVA9l+jibG4cMD2gjm6wO1MdnNc3B4Ofx41wItAcoSqy/3FhhTELe4w7tHBMHu
 HT5w2cf+tKRlDk4nCvMhca4mQUB0Zfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-pVYGoZUCNpiroFGM_qSoOA-1; Wed, 04 Mar 2020 03:13:26 -0500
X-MC-Unique: pVYGoZUCNpiroFGM_qSoOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 133058010E3;
 Wed,  4 Mar 2020 08:13:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF3E119E9C;
 Wed,  4 Mar 2020 08:13:20 +0000 (UTC)
Message-ID: <977fe965521f8fd3c1886f391fdff035c168fa27.camel@redhat.com>
Subject: Re: [PATCH v4 07/11] monitor/hmp: move hmp_snapshot_* to
 block-hmp-cmds.c hmp_snapshot_blkdev is from GPLv2 version of the
 hmp-cmds.c thus have to change the licence to GPLv2
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 04 Mar 2020 10:13:20 +0200
In-Reply-To: <20200303171532.GG5733@linux.fritz.box>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
 <20200130123448.21093-8-mlevitsk@redhat.com>
 <20200303171532.GG5733@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-03 at 18:15 +0100, Kevin Wolf wrote:
> Am 30.01.2020 um 13:34 hat Maxim Levitsky geschrieben:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Very long subject line. I suppose the license notice should be in the
> body instead.
> 
> >  block/monitor/block-hmp-cmds.c | 56 ++++++++++++++++++++++++++++++++--
> >  include/block/block-hmp-cmds.h |  4 +++
> >  include/monitor/hmp.h          |  3 --
> >  monitor/hmp-cmds.c             | 47 ----------------------------
> >  4 files changed, 58 insertions(+), 52 deletions(-)
> > 
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> > index 8e8288c2f1..b83687196f 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -1,10 +1,13 @@
> >  /*
> >   * Blockdev HMP commands
> >   *
> > + *  Authors:
> > + *  Anthony Liguori   <aliguori@us.ibm.com>
> > + *
> >   * Copyright (c) 2003-2008 Fabrice Bellard
> >   *
> > - * This work is licensed under the terms of the GNU GPL, version 2 or
> > - * later.  See the COPYING file in the top-level directory.
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> 
> Please also copy the next paragraph of the license header:
> 
>  * Contributions after 2012-01-13 are licensed under the terms of the
>  * GNU GPL, version 2 or (at your option) any later version.
> 
> Kevin
Will do,
Best regards,
	Maxim Levitsky



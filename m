Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E5C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B818F20848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIzi6S10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B818F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9B9k-0000Db-V8
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9B91-0007nt-7a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9B90-0007Ch-1f
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:15:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9B8z-0007CL-SL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583255745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBwn3k5fPnTEZL02ahNIK+9mcbyappKI8KA3QUX7jyQ=;
 b=IIzi6S10XbW8UtYzUteUTmzz8Bxx+k8/UQqxAdUZk8aZ5bfEYbsbN1vnEL3+rzed8I0AsE
 aJA8HqZiiM2v1taYNuqj6f+/UNtFs1qRZJBqVq65kHQIu0DtHQ7enGASTrvPqE6Lprk1ec
 kFfnuumpWbSUl/bZGwCZrcuwLHqZULM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-2rdOhHlGM8m2mTso30HaBw-1; Tue, 03 Mar 2020 12:15:43 -0500
X-MC-Unique: 2rdOhHlGM8m2mTso30HaBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 555F610883A2;
 Tue,  3 Mar 2020 17:15:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-229.ams2.redhat.com [10.36.117.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E255C557;
 Tue,  3 Mar 2020 17:15:33 +0000 (UTC)
Date: Tue, 3 Mar 2020 18:15:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 07/11] monitor/hmp: move hmp_snapshot_* to
 block-hmp-cmds.c hmp_snapshot_blkdev is from GPLv2 version of the hmp-cmds.c
 thus have to change the licence to GPLv2
Message-ID: <20200303171532.GG5733@linux.fritz.box>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
 <20200130123448.21093-8-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200130123448.21093-8-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 13:34 hat Maxim Levitsky geschrieben:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Very long subject line. I suppose the license notice should be in the
body instead.

>  block/monitor/block-hmp-cmds.c | 56 ++++++++++++++++++++++++++++++++--
>  include/block/block-hmp-cmds.h |  4 +++
>  include/monitor/hmp.h          |  3 --
>  monitor/hmp-cmds.c             | 47 ----------------------------
>  4 files changed, 58 insertions(+), 52 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index 8e8288c2f1..b83687196f 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -1,10 +1,13 @@
>  /*
>   * Blockdev HMP commands
>   *
> + *  Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *
>   * Copyright (c) 2003-2008 Fabrice Bellard
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> - * later.  See the COPYING file in the top-level directory.
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.

Please also copy the next paragraph of the license header:

 * Contributions after 2012-01-13 are licensed under the terms of the
 * GNU GPL, version 2 or (at your option) any later version.

Kevin



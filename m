Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C9C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3EB2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3EB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQ3z-0003sV-Ur
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:32:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQ2y-0003Oi-Ao
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQ2x-0002k0-H5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLQ2v-0002id-J9; Tue, 30 Apr 2019 06:31:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDC2881DE1;
	Tue, 30 Apr 2019 10:31:32 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95E46756D8;
	Tue, 30 Apr 2019 10:31:31 +0000 (UTC)
Date: Tue, 30 Apr 2019 12:31:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190430103130.GC5607@linux.fritz.box>
References: <20190430100802.15368-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190430100802.15368-1-berto@igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 30 Apr 2019 10:31:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix error handling in the
 compression code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430103130.VkulHRAjRxmUqR_avPOEDSdRrfjfTRAOl5R7kge0fmk@z>

Am 30.04.2019 um 12:08 hat Alberto Garcia geschrieben:
> This patch fixes a few things in the way error codes are handled in
> the qcow2 compression code:
> 
> a) qcow2_co_pwritev_compressed() expects qcow2_co_compress() to only
>    return -1 or -2 on failure, but this is not correct. Since the
>    change from qcow2_compress() to qcow2_co_compress() in commit
>    ceb029cd6feccf9f7607 the new code can also return -EINVAL (although
>    there does not seem to exist any code path that would cause that
>    error in the current implementation).
> 
> b) -1 and -2 are ad-hoc error codes defined in qcow2_compress().
>    This patch replaces them with standard constants from errno.h.
> 
> c) Both qcow2_compress() and qcow2_co_do_compress() return a negative
>    value on failure, but qcow2_co_pwritev_compressed() stores the
>    value in an unsigned data type.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin


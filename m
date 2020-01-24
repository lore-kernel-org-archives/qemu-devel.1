Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9675C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872AD2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU2L9rov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872AD2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwfr-00043I-Pr
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuwef-0002cy-MP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuwee-00083l-Mu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:57:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuwee-00083I-K3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579863456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGrRTCl7V4OLtN1n6JdIxX+jb3DLTIFc/Z0upRGwhtw=;
 b=LU2L9rov1fM/f0dSdLw60SxCHFi5/qpQZSOngxS/PgO6L+RvwKIqtMszspHrHLUNMS2t3M
 lT4zwfdnpY216X/Auy4+/o/kholfnWJyWqPeJOqxmuCuI7QA6omnTx83tVXmBSTBNSRKxi
 AMWyZ+3ve2Ol1XghUNSD8yc0R7vR4nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-ZaWFzIdyM6aQDd-WeKLpiQ-1; Fri, 24 Jan 2020 05:57:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFC3B800D48;
 Fri, 24 Jan 2020 10:57:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B8485F13;
 Fri, 24 Jan 2020 10:57:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/7] migration/block-dirty-bitmap: rename finish_lock to
 just lock
In-Reply-To: <20200122132328.31156-3-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 22 Jan 2020 16:23:23 +0300")
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
 <20200122132328.31156-3-vsementsov@virtuozzo.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 11:57:22 +0100
Message-ID: <87a76d5dgt.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZaWFzIdyM6aQDd-WeKLpiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: quintela@redhat.com
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> finish_lock is bad name, as lock used not only on process end.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I still would like the cleanup suggested on the previous patch, but this
one is ok.



Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8485206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RauxpA/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8485206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42ly-0003en-SR
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j42b1-0003LJ-9l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j42b0-00046i-E9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:07:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j42b0-00046Z-Ai
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582031245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDt5UnUzEprtNAdi03P6hDvKK7pSRcmHvdxzRo8NhFc=;
 b=RauxpA/n1FjDP9i25G7CgicNmUgRndCh5svoc/PHqX87uWgp1+jWI3031xUYcBF6serVvT
 ZY8OnpIzm6Zz8cgzzKYwuJ8aMzx+nLr1zo+y30WUIxqZ7gpxIFjiQf+yDrDnGG2geBdvVW
 jsbD5j5DrLB4nI2oIS9cwW/mLjRrO4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-w0FbEr42MOCdGnjD2ruZHA-1; Tue, 18 Feb 2020 08:06:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D1818B9FC2;
 Tue, 18 Feb 2020 13:06:44 +0000 (UTC)
Received: from redhat.com (ovpn-117-81.ams2.redhat.com [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E66A17DC8;
 Tue, 18 Feb 2020 13:06:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] migration/block: rename BLOCK_SIZE macro
In-Reply-To: <20200218110209.800294-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 18 Feb 2020 11:02:09 +0000")
References: <20200218110209.800294-1-stefanha@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 18 Feb 2020 14:06:38 +0100
Message-ID: <877e0km4dd.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: w0FbEr42MOCdGnjD2ruZHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Both <linux/fs.h> and <sys/mount.h> define BLOCK_SIZE macros.  Avoiding
> using that name in block/migration.c.
>
> I noticed this when including <liburing.h> (Linux io_uring) from
> "block/aio.h" and compilation failed.  Although patches adding that
> include haven't been sent yet, it makes sense to rename the macro now in
> case someone else stumbles on it in the meantime.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

queuing it.

Thanks.



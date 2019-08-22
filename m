Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B92CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259B3233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QTVJlk4d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XUHs+VzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259B3233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0prX-0007d4-A9
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cornelia.huck@mailbox.org>) id 1i0pqP-0006Qk-Dq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cornelia.huck@mailbox.org>) id 1i0pqN-0006wT-00
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:21:49 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:55422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cornelia.huck@mailbox.org>)
 id 1i0pqM-0006tf-5L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:21:46 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mx2.mailbox.org (Postfix) with ESMTPS id BF785A191D;
 Thu, 22 Aug 2019 18:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:subject:subject:from:from
 :date:date:received; s=mail20150812; t=1566490898; bh=QdVznrxmMV
 tdNYc4e9E+YInw2Z3XOK9LgKgT5H7bZ0E=; b=QTVJlk4dmxVekd/B+s6nvu2WXi
 wFKiJ2pKLHqJ5WQF5x3kppZq4BdgC4fYCZkJrh9pPoT8T6HQfyD2YRGcMcwhXmOT
 1wXW+9KzbQ6Twz8LptUR/pasXNypuU3WeTgGTIIVno7oR+4+JDw5Rfd3EDTs2tDy
 dL9f83qkhP8l4KqFR7u9t+fAWtQpuBAooF5C/BwuBL0JtB6A7/XnEJ/o1lzR0gJ4
 EJSP9SNvkwFut+43ruK4AqM3FBDLeWMZ0A52URqnrQ8ze8JrwcOy+BoSbqLojyx9
 EgQ4YcIuYnn3TI9sE27FkdOKAO5yrQwWVl0V8srMpMaSXxqHFVGFRl3jPB/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1566490899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+nglHMdf/bhRMMzm/hQWZf8PmKzHjeOtEG2fNdjCiM=;
 b=XUHs+VzVjEpFn8oZE7HI6LN1km8iWNsvA22sDoti36T+FmrSvWB1cVB7o0+rFPzklXUY6u
 i6zgpIep5auXVZlHWfRKy5/z8JwB4cxs5xCMPvq6E+BkP38z4WW3SqSDxr7JeWvYlYc69V
 URrWLwpfaEwaxd/EH8HnUHL5P4yDXfoBy9xm5t4A0Vt75zargeI400voLqsFrkbDTaBLXE
 c772buNOmOjAJI6Z8s+uC4wezSH9UlQBv0eK9qje9aNaaJ+RQb1y2++TA+uCoQMZHW0t0k
 0WMm/kmP8TVg7roj74mM0mBBEWEg7QQ0kdVm+i9ZRvtB63EAGJ3jQtay599AQw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de
 [80.241.56.125]) (amavisd-new, port 10030)
 with ESMTP id tJlWy2HJwAm7; Thu, 22 Aug 2019 18:21:38 +0200 (CEST)
Date: Thu, 22 Aug 2019 18:21:37 +0200
From: Cornelia Huck <cornelia.huck@mailbox.org>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Message-ID: <20190822182137.0f8ed9d2.cornelia.huck@mailbox.org>
In-Reply-To: <20190821155327.25208-1-berrange@redhat.com>
References: <20190821155327.25208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 80.241.60.215
Subject: Re: [Qemu-devel] [PATCH] tests: make filemonitor test more robust
 to event ordering
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
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 16:53:27 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> The ordering of events that are emitted during the rmdir
> test have changed with kernel >=3D 5.3. Semantically both
> new & old orderings are correct, so we must be able to
> cope with either.
>=20
> To cope with this, when we see an unexpected event, we
> push it back onto the queue and look and the subsequent
> event to see if that matches instead.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/test-util-filemonitor.c | 43 +++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 9 deletions(-)

Tested-by: Cornelia Huck <cohuck@redhat.com>

I tried to review this patch, but I fear I'm out of my depth here :(


Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F16C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A172467F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A172467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59237 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXhlc-0002zO-Ae
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:52:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXhkl-0002fn-C2
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXhkk-0004Im-F8
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hXhkk-0004Ga-9t
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6EB9356C4;
	Mon,  3 Jun 2019 07:51:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4C91001DE0;
	Mon,  3 Jun 2019 07:51:28 +0000 (UTC)
Date: Mon, 3 Jun 2019 09:51:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Julia Suvorova <jusual@mail.ru>
Message-ID: <20190603075127.GB6523@linux.fritz.box>
References: <20190602201709.11901-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602201709.11901-1-jusual@mail.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 03 Jun 2019 07:51:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: Drop unused BlockAIOCB
 submission method
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.06.2019 um 22:17 hat Julia Suvorova geschrieben:
> Callback-based laio_submit() and laio_cancel() were left after
> rewriting Linux AIO backend to coroutines in hope that they would be
> used in other code that could bypass coroutines. They can be safely
> removed because they have not been used since that time.
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>

Thanks, applied to the block branch.

Kevin


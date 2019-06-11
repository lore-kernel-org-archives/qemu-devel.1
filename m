Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75DFC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF21820657
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF21820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacZt-0007Gb-SX
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hacUz-0002px-7t
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hacUw-0005T9-H6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:51:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hacUk-0004ZK-SX; Tue, 11 Jun 2019 04:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C1CD3086203;
 Tue, 11 Jun 2019 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-156.ams2.redhat.com
 [10.36.117.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 791301001B03;
 Tue, 11 Jun 2019 08:49:48 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:49:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: l00284672 <lizhengui@huawei.com>
Message-ID: <20190611084941.GB8112@localhost.localdomain>
References: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
 <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
 <49e6310d-1c1c-2379-47e6-7239e0058e78@huawei.com>
 <487a3a9d-92b3-bed4-4082-5701cd4bd08d@redhat.com>
 <98826c00-3dae-3972-c68a-f86f544c2093@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <98826c00-3dae-3972-c68a-f86f544c2093@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 11 Jun 2019 08:49:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: unlock
 qemu_global_mutex before pread when attach disk
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
Cc: qemu-block@nongnu.org, eric.fangyi@huawei.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, jiangyiwen@huawei.com,
 stefanha@redhat.com, wangjie88@huawei.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.06.2019 um 04:53 hat l00284672 geschrieben:
> -- Would the "open" hang as well in that case?
>    The "open" doesn't hang in that case.
>=20
> Do you have any better solutions to solve this problem in the case?

Yes, but unfortunately it's a lot harder.

This is roughly what you'd have to do:

1. Make QMP command handlers async (patches from Marc-Andr=E9 are on the
   list)
2. Stop using HMP drive_add and instead switch to QMP blockdev-add
3. Move the blockdev-add code into a coroutine
4. Make .bdrv_open a coroutine_fn
5. Move the pread() in file-posix to the thread pool and let the
   coroutine yield while the request is running

Only with all of these pieces in place we'll be able to release the
global mutex while we're waiting for the pread() to complete.

Kevin


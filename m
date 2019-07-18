Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72CFC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA232080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA232080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7su-0005GW-TH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 10:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1ho7sk-0004kh-DR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ho7sj-0006tf-BC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:59:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1ho7sg-0006rY-5z; Thu, 18 Jul 2019 10:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55B7C335CF;
 Thu, 18 Jul 2019 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-130.ams2.redhat.com
 [10.36.117.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACCFB19D7A;
 Thu, 18 Jul 2019 14:59:32 +0000 (UTC)
Date: Thu, 18 Jul 2019 16:59:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>
Message-ID: <20190718145931.GD5454@localhost.localdomain>
References: <ad4c52a9-e848-e3fd-3c1b-046d2670c025@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad4c52a9-e848-e3fd-3c1b-046d2670c025@yandex-team.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 18 Jul 2019 14:59:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] BDRV request fragmentation and virtio-blk write
 submission guarantees (2nd try)
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
Cc: qemu-block@nongnu.org, yc-core@yandex-team.ru, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.07.2019 um 15:52 hat =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=AF=D0=BA=D0=BE=D0=B2=D0=BB=D0=B5=D0=B2 geschrieben:
> Hi everyone,
>=20
> My previous message was misformatted, so here's another one. Sorry abou=
t
> that.
>=20
> We're currently working on implementing a qemu BDRV format driver which=
 we
> are using with virtio-blk devices.
>=20
> I have a question concerning BDRV request fragmentation and virtio-blk =
write
> request submission which is not entirely clear to me by only reading vi=
rtio
> spec. Could you please consider the following case and give some additi=
onal
> guidance?
>=20
> 1. Our BDRV format driver has a notion of max supported transfer size. =
So we
> implement BlockDriver::bdrv_refresh_limits where we fill out
> BlockLimits::max_transfer and opt_transfer fields.
>=20
> 2. virtio-blk exposes max_transfer as a virtio_blk_config::opt_io_size
> field, which (according to spec 1.1) is a **suggested** maximum. We rea=
d
> "suggested" as "guest driver may still send requests that don't fit int=
o
> opt_io_size and we should handle those"...
>=20
> 3. ... and judging by code in block/io.c qemu block layer handles such
> requests by fragmenting them into several BDRV requests if request size=
 is >
> max_transfer
>=20
> 4. Guest will see request completion only after all fragments are handl=
ed.
> However each fragment submission path can call qemu_coroutine_yield and=
 move
> on to submitting next request available in virtq before completely
> submitting the rest of the fragments. Which means the following situati=
on is
> possible where BDRV sees 2 write requests in virtq, both of which are l=
arger
> than max_transfer:
>=20
> Blocks: -----------------------------
>=20
> Write1: ------xxxxxxxx
>=20
> Write2: ------yyyyyyyy
>=20
> Write1Chunk1: xxxx
>=20
> Write2Chunk1: yyyy
>=20
> Write2Chunk2: ----yyyy
>=20
> Write1Chunk1: ----xxxx
>=20
> Blocks: ------yyyyxxxx-----------------
>=20
>=20
> In above scenario guest virtio-blk driver decided to submit 2 intersect=
ing
> write requests, both of which are larger than ||max_transfer, and then =
call
> hypervisor.
>=20
> I understand that virtio-blk may handle requests out of order, so guest=
 must
> not make any assumptions on relative order in which those requests will=
 be
> handled.
>=20
> However, can guest driver expect that whatever the submission order wil=
l be,
> the actual intersecting writes will be atomic?
>=20
> In other words, will it be correct for conforming virtio-blk driver to
> expect only "xxxxxxxx" or "yyyyyyyy" but not anything else in between, =
after
> both requests are reported as completed?
>=20
> Because i think that is something that may happen in qemu right now, if=
 i
> understood correctly.

I don't think atomicity is promised anywhere in the virtio
specification, and I agree with you that this case can happen (it
probably happens much more frequently when you use image formats instead
of raw files).

On the other hand, there is no good reason for a guest OS to submit two
write request to the same blocks in parallel. Even if it could expect
that one of the requests wins, the end result would still be undefined,
so I don't think this could ever be a useful thing to do. (Well, I guess
it could replace flipping a coin...)

Kevin


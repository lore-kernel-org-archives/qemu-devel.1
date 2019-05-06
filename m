Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEBDC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 12:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096DD20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="eM10q50E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096DD20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56141 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNd2t-0004Fl-AR
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 08:48:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hNd1z-0003u2-8d
	for qemu-devel@nongnu.org; Mon, 06 May 2019 08:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hNd1y-00023G-0F
	for qemu-devel@nongnu.org; Mon, 06 May 2019 08:47:43 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:47892)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>)
	id 1hNd1u-0001wK-Pa; Mon, 06 May 2019 08:47:39 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E01742E0DAC;
	Mon,  6 May 2019 15:47:34 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	ENiBhISRbV-lYUGGEN3; Mon, 06 May 2019 15:47:34 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1557146854; bh=91P+p+9ZSykY/eGPrZszfb9DN0MwJFrIYM26q2V4C1o=;
	h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
	b=eM10q50EBdnne5PziNfN81RRZ3a2DXkgTARFm2MdmWjtdO++GNdDRnFe1D7RqD46l
	Qm1vUr/kUMFSxhtsJ/r/gcJY+hpVD6ixKGuRvmIxqb0dbBZ7RTXLB+EChPBB8VcaXJ
	0gL6eCGOdA/Su/RXSeMamTr0K0Qc2HPDJyWprx5E=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:408:250:b6ff:fe97:2682])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	yWj5bSFPvv-lYG4lcgk; Mon, 06 May 2019 15:47:34 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client certificate not present)
To: Kevin Wolf <kwolf@redhat.com>
References: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
	<20190429103816.GE8492@localhost.localdomain>
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <acda1900-6d9f-e551-6310-4192514be35a@yandex-team.ru>
Date: Mon, 6 May 2019 15:47:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429103816.GE8492@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] aio context ownership during bdrv_close()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?B?eWMtY29yZSAo0YDQsNGB0YHRi9C70Lo=?= =?UTF-8?B?0LAp?=
	<yc-core@yandex-team.ru>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/04/2019 13:38, Kevin Wolf wrote:
> Am 26.04.2019 um 14:24 hat Anton Kuchin geschrieben:
>> I can't figure out ownership of aio context during bdrv_close().
>>
>> As far as I understand bdrv_unref() shold be called with acquired aio
>> context to prevent concurrent operations (at least most usages in bloc=
kdev.c
>> explicitly acquire and release context, but not all).
> I think the theory is like this:
>
> 1. bdrv_unref() can only be called from the main thread
>
> 2. A block node for which bdrv_close() is called has no references. If
>     there are no more parents that keep it in a non-default iothread,
>     they should be in the main AioContext. So no locks need to be taken
>     during bdrv_close().
>
> In practice, 2. is not fully true today, even though block devices do
> stop their dataplane and move the block nodes back to the main
> AioContext on shutdown. I am currently working on some fixes related to
> this, afterwards the situation should be better.
>
>> But if refcount reaches zero and bs is going to be deleted in bdrv_clo=
se()
>> we need to ensure that drain is finished data is flushed and there are=
 no
>> more pending coroutines and bottomhalves, so drain and flush functions=
 can
>> enter coroutine and perform yield in several places. As a result contr=
ol
>> returns to coroutine caller that will release aio context and when
>> completion bh will continue cleanup process it will be executed withou=
t
>> ownership of context. Is this a valid situation?
> Do you have an example where this happens?
>
> Normally, leaving the coroutine means that the AioContext lock is
> released, but it is later reentered from the same AioContext, so the
> lock will be taken again.
I was wrong. Coroutines do acquire aio context when reentered.
>
>> Moreover if yield happens bs that is being deleted has zero refcount b=
ut is
>> still present in lists graph_bdrv_states and all_bdrv_states and can b=
e
>> accidentally accessed. Shouldn't we remove it from these lists ASAP wh=
en
>> deletion process starts as we do from monitor_bdrv_states?
> Hm, I think it should only disappear when the image file is actually
> closed. But in practice, it probably makes little difference either way=
.

I'm still worried about a period of time since coroutine yields and=20
until it is reentered, looks like aio context can be grabbed by other=20
code and bs can be treated as valid.

I have no example of such situation too but I see there bdrv_aio_flush=20
and bdrv_co_flush_to_disk callbacks which are called during flush and=20
can take unpredicable time to complete (e.g. raw_aio_flush in file-win32=20
uses thread pool inside to process request and RBD can also be affected=20
but I didn't dig deep enough to be sure).

If main loop starts processing next qmp command before completion is=20
called lists will be in inconsistent state and hard to debug=20
use-after-free bugs and crashes can happen.

Fix seems trivial and shouldn't break any existing code.

---

diff --git a/block.c b/block.c
index 16615bc876..25c3b72520 100644
--- a/block.c
+++ b/block.c
@@ -4083,14 +4083,14 @@ static void bdrv_delete(BlockDriverState *bs)
 =C2=A0=C2=A0=C2=A0=C2=A0 assert(bdrv_op_blocker_is_empty(bs));
 =C2=A0=C2=A0=C2=A0=C2=A0 assert(!bs->refcnt);

-=C2=A0=C2=A0=C2=A0 bdrv_close(bs);
-
 =C2=A0=C2=A0=C2=A0=C2=A0 /* remove from list, if necessary */
 =C2=A0=C2=A0=C2=A0=C2=A0 if (bs->node_name[0] !=3D '\0') {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_REMOVE(&graph_bd=
rv_states, bs, node_list);
 =C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_REMOVE(&all_bdrv_states, bs, bs_list);

+=C2=A0=C2=A0=C2=A0 bdrv_close(bs);
+
 =C2=A0=C2=A0=C2=A0=C2=A0 g_free(bs);
 =C2=A0}

--


>
> Kevin


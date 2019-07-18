Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E126C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF1A21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uVrqSr8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF1A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8KK-0004IU-Df
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho8K8-0003t2-Tp
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho8K5-0004SD-Vu
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:28:00 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:39850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1ho8Jy-0004G7-Hn; Thu, 18 Jul 2019 11:27:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 609012E1453;
 Thu, 18 Jul 2019 18:27:41 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 2fWXfVEZuq-Re5iqDoO; Thu, 18 Jul 2019 18:27:41 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563463661; bh=CsxhowDIj972Hspclq+FXaG9QdYdnfeJ3iCHM3+OOwU=;
 h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
 b=uVrqSr8wOZzK9yAti/VfkL+QLkvai0/MWg87j+j17o/AiLSflE2kPMcfd6nSOy/oK
 4wrLVvh3Ak92UwEq8Rx9LACEOLxaO6hldGd486Hq/ayPgEj6xB1apSgxyN6PAla5wv
 Om2RWMgCaW/euplaDh1KN8S2YhDRuLgproOKz/gQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 yyDYJ7NJj8-Re6SE0de; Thu, 18 Jul 2019 18:27:40 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
To: Kevin Wolf <kwolf@redhat.com>
References: <ad4c52a9-e848-e3fd-3c1b-046d2670c025@yandex-team.ru>
 <20190718145931.GD5454@localhost.localdomain>
From: =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?=
 <wrfsh@yandex-team.ru>
Message-ID: <7249ccbd-4980-6797-d5b4-ee2bd82ab35e@yandex-team.ru>
Date: Thu, 18 Jul 2019 18:27:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718145931.GD5454@localhost.localdomain>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] BDRV request fragmentation and virtio-blk write
 submission guarantees (2nd try)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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


Evgeny Yakovlev
Lead Software Engineer, Yandex.Cloud Hypervisor Team

On 18.07.2019 17:59, Kevin Wolf wrote:
> Am 18.07.2019 um 15:52 hat =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=AF=D0=BA=D0=BE=D0=B2=D0=BB=D0=B5=D0=B2 geschrieben:
>> Hi everyone,
>>
>> My previous message was misformatted, so here's another one. Sorry abo=
ut
>> that.
>>
>> We're currently working on implementing a qemu BDRV format driver whic=
h we
>> are using with virtio-blk devices.
>>
>> I have a question concerning BDRV request fragmentation and virtio-blk=
 write
>> request submission which is not entirely clear to me by only reading v=
irtio
>> spec. Could you please consider the following case and give some addit=
ional
>> guidance?
>>
>> 1. Our BDRV format driver has a notion of max supported transfer size.=
 So we
>> implement BlockDriver::bdrv_refresh_limits where we fill out
>> BlockLimits::max_transfer and opt_transfer fields.
>>
>> 2. virtio-blk exposes max_transfer as a virtio_blk_config::opt_io_size
>> field, which (according to spec 1.1) is a **suggested** maximum. We re=
ad
>> "suggested" as "guest driver may still send requests that don't fit in=
to
>> opt_io_size and we should handle those"...
>>
>> 3. ... and judging by code in block/io.c qemu block layer handles such
>> requests by fragmenting them into several BDRV requests if request siz=
e is >
>> max_transfer
>>
>> 4. Guest will see request completion only after all fragments are hand=
led.
>> However each fragment submission path can call qemu_coroutine_yield an=
d move
>> on to submitting next request available in virtq before completely
>> submitting the rest of the fragments. Which means the following situat=
ion is
>> possible where BDRV sees 2 write requests in virtq, both of which are =
larger
>> than max_transfer:
>>
>> Blocks: -----------------------------
>>
>> Write1: ------xxxxxxxx
>>
>> Write2: ------yyyyyyyy
>>
>> Write1Chunk1: xxxx
>>
>> Write2Chunk1: yyyy
>>
>> Write2Chunk2: ----yyyy
>>
>> Write1Chunk1: ----xxxx
>>
>> Blocks: ------yyyyxxxx-----------------
>>
>>
>> In above scenario guest virtio-blk driver decided to submit 2 intersec=
ting
>> write requests, both of which are larger than ||max_transfer, and then=
 call
>> hypervisor.
>>
>> I understand that virtio-blk may handle requests out of order, so gues=
t must
>> not make any assumptions on relative order in which those requests wil=
l be
>> handled.
>>
>> However, can guest driver expect that whatever the submission order wi=
ll be,
>> the actual intersecting writes will be atomic?
>>
>> In other words, will it be correct for conforming virtio-blk driver to
>> expect only "xxxxxxxx" or "yyyyyyyy" but not anything else in between,=
 after
>> both requests are reported as completed?
>>
>> Because i think that is something that may happen in qemu right now, i=
f i
>> understood correctly.
> I don't think atomicity is promised anywhere in the virtio
> specification, and I agree with you that this case can happen (it
> probably happens much more frequently when you use image formats instea=
d
> of raw files).
>
> On the other hand, there is no good reason for a guest OS to submit two
> write request to the same blocks in parallel. Even if it could expect
> that one of the requests wins, the end result would still be undefined,
> so I don't think this could ever be a useful thing to do. (Well, I gues=
s
> it could replace flipping a coin...)
> Kevin


Thanks Kevin. I agree that described guest behavior does not a have a=20
sensible reason behind it. However, just based on purely theoretical=20
basis, according to virtio-blk contract, is it valid for guest to even=20
_assume_ that above situation with 2 requests _must_ be resolved in one=20
of two specific cases i described and not anything in between? In other=20
words that writes will be atomic even if their relative order is=20
undefined. We could not get a clear answer from virtio spec ourselves.

For instance, IIRC, nvme spec declares atomicity guarantees as well as=20
ordering for specific commands ("6.4 Atomic Operations").

Evgeny


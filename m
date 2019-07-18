Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F0C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ED320873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YQ8cUgUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ED320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6i9-0007gc-UE
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho6hz-0007HW-GK
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1ho6hy-0000zw-Cx
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:44:31 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:44288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1ho6hv-0000sz-4v; Thu, 18 Jul 2019 09:44:28 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E577D2E14F6;
 Thu, 18 Jul 2019 16:44:18 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 puBdVFgaQd-iIUGqgOu; Thu, 18 Jul 2019 16:44:18 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563457458; bh=I11CP6gu9I8IAM70a5x0Y1g1HZhBe3ThveJ+dcp/9AM=;
 h=Date:Message-ID:To:Subject:From:Cc;
 b=YQ8cUgUJiFohtLNcp9FFiKwCQP4fWqY/DK4DU0Vud1J2KpOiKxOZUC99tUS9eflz0
 OhDiFxoHnaIKXOz6ycwu3m441MPrvhSqS6deyuwy3Cenjb28+tbJM/UM1zcvtZH8qk
 Iw8RavzHT3Rpx8ql6JhAhKbweeEN93eqwgCBq+Gk=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 ORBzfGYxAv-iIwSJYP2; Thu, 18 Jul 2019 16:44:18 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
From: =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?=
 <wrfsh@yandex-team.ru>
To: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <8146312c-8a9c-3c4e-ab80-a3f42cc1d6ce@yandex-team.ru>
Date: Thu, 18 Jul 2019 16:44:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] BDRV request fragmentation and vitio-blk write
 submission guarantees
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
Cc: qemu-block@nongnu.org, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi everyone,

We're currently working on implementing a qemu BDRV format driver which 
we are using with virtio-blk devices.

I have a question concerning BDRV request fragmentation and virtio-blk 
write request submission which is not entirely clear to me by only 
reading virtio spec. Could you please consider the following case and 
give some additional guidance?

1. Our BDRV format driver has a notion of max supported transfer size. 
So we implement BlockDriver::bdrv_refresh_limits where we fill out 
BlockLimits::max_transfer and opt_transfer fields.

2. virtio-blk exposes max_transfer as a virtio_blk_config::opt_io_size 
field, which (according to spec 1.1) is a **suggested** maximum. We read 
"suggested" as "guest driver may still send requests that don't fit into 
opt_io_size and we should handle those"...

3. ... and judging by code in block/io.c qemu block layer handles such 
requests by fragmenting them into several BDRV requests if request size 
is > max_transfer

4. Guest will see request completion only after all fragments are 
handled. However each fragment submission path can call 
qemu_coroutine_yield and move on to submitting next request available in 
virtq before completely submitting the rest of the fragments. Which 
means the following situation is possible where BDRV sees 2 write 
requests in virtq, both of which are larger than max_transfer:

||

|Blocks: |-------------------------------------> Write1: xxxxxxxx 
Write2: yyyyyyyy Write1Chunk1: xxxx Write2Chunk1: yyyy Write2Chunk2: 
yyyy Write1Chunk1: xxxx Blocks: |------------yyyyxxxx----------------->|

||

|In above scenario guest virtio-blk driver decided to submit 2 
intersecting write requests, both of which are larger than 
||max_transfer, and then call hypervisor.|

|I understand that virtio-blk may handle requests out of order, so guest 
must not make any assumptions on relative order in which those requests 
will be handled.|

|However, can guest driver expect that whatever the submission order 
will be, the actual intersecting writes will be atomic?|

|In other words, will it be correct for conforming virtio-blk driver to 
expect only "|||xxxxxxxx" or "||||yyyyyyyy" but not anything else in 
between, after both requests are reported as completed?||

||Because i think that is something that may happen in qemu right now, 
if i understood correctly. ||

||||

||Thanks!| |



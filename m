Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B19C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BB52077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="If+pd6m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BB52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzvD-0007oN-BP
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:25:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hJztx-00074U-Fu
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hJztv-0006QT-GL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:24:25 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:51190)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>)
	id 1hJzts-0006Lp-AI; Fri, 26 Apr 2019 08:24:20 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C8F192E149E;
	Fri, 26 Apr 2019 15:24:16 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	yR8WjDfDE5-OG8e04ls; Fri, 26 Apr 2019 15:24:16 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1556281456; bh=LrAeaVdvVYxOnt5NfY8PDQ0SjshpCMbsTsCQjxKVEtQ=;
	h=Date:Message-ID:To:Subject:From:Cc;
	b=If+pd6m70awrVIxZsDWLRXKJXfz8YzKQUSbzJ8C3lr9FhzmH3UaNPcgQ+XFvYKJHw
	GrLH5HqTbSHvVUjHJ1tSq5YGU0ILjtLIVB7aB4/iipzX+VYzI4HXh9s3EUX7TTY/+q
	yYIIw6+AWlngBaMuCdtUaZLEss2t01IQe7UuKHm0=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:408:250:b6ff:fe97:2682])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	s5GLEYPMzZ-OGGemuqI; Fri, 26 Apr 2019 15:24:16 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client certificate not present)
From: Anton Kuchin <antonkuchin@yandex-team.ru>
To: qemu-block@nongnu.org
Message-ID: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
Date: Fri, 26 Apr 2019 15:24:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] aio context ownership during bdrv_close()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	=?UTF-8?B?eWMtY29yZSAo0YDQsNGB0YHRi9C70Lo=?= =?UTF-8?B?0LAp?=
	<yc-core@yandex-team.ru>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426122415.-Wdx2EavrLpba2vkM1oxqMnff7UAtao00uV6a3mDMrc@z>

I can't figure out ownership of aio context during bdrv_close().

As far as I understand bdrv_unref() shold be called with acquired aio 
context to prevent concurrent operations (at least most usages in 
blockdev.c explicitly acquire and release context, but not all).

But if refcount reaches zero and bs is going to be deleted in 
bdrv_close() we need to ensure that drain is finished data is flushed 
and there are no more pending coroutines and bottomhalves, so drain and 
flush functions can enter coroutine and perform yield in several places. 
As a result control returns to coroutine caller that will release aio 
context and when completion bh will continue cleanup process it will be 
executed without ownership of context. Is this a valid situation?

Moreover if yield happens bs that is being deleted has zero refcount but 
is still present in lists graph_bdrv_states and all_bdrv_states and can 
be accidentally accessed. Shouldn't we remove it from these lists ASAP 
when deletion process starts as we do from monitor_bdrv_states?




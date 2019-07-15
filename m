Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACEBC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036D4205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="r0fTJWwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036D4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2lj-0001Us-VW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1hn2lO-0000YV-Q8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <antonkuchin@yandex-team.ru>) id 1hn2lN-0007eJ-MG
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:19:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:57778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <antonkuchin@yandex-team.ru>)
 id 1hn2lN-0007cW-29
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:19:37 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1573A2E09D4;
 Mon, 15 Jul 2019 18:19:33 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
 [2a02:6b8:0:1a2d::30])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 Osil3jOvYq-JWU4hd4p; Mon, 15 Jul 2019 18:19:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563203973; bh=oHSN9tRqyQmgp6ExT34H34+6DXSTqUcC7AIO797Ooq8=;
 h=Date:Message-ID:Subject:From:To:Cc;
 b=r0fTJWwWbnpFRBvEdxlJ4IE8HX1VT53dYvoGU+mowY5cPVR2Dgyl1NO71YgXRpXoV
 T9cgnW7vfu5/93zZ6nBrZgpRduYSooFSv1Ot0BR9HTCZWGt1vitUxDnag7JUHK/ers
 DAAW1ms7mlGHE2+r2psDjJLm5xwgULMNpDBsG00Q=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:250:b6ff:fe97:2682])
 by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 Yp97kkQQFk-JW9873Sf; Mon, 15 Jul 2019 18:19:32 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
To: qemu-devel@nongnu.org
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <9f644e46-6fc5-01ea-068a-fdbf9e08b828@yandex-team.ru>
Date: Mon, 15 Jul 2019 18:19:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] What events should be handled in iohandler context?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm trying to understand contexts and handlers/notifiers and a bit 
confused about two contexts living in main loop: qemu_aio_context and 
iohandler_ctx. It is mentioned in the iohandler_ctx comment that 
qemu_aio_context can't be reused because "iohandlers mustn't be polled 
by aio_poll(qemu_aio_context)" but there is no exlanation why.

I tried to find examples and failed to understand why virtio-net 
eventfds are registred to iohandler_ctx with generic virtio callback 
virtio_device_start_ioeventfd_impl() but TX bottom-half and handlers of 
back-end TAP use qemu_aio_context.

Can you explain a little bit why we need some fds to be polled and some 
not to be polled? And how can I choose which context is right for me?

Thanks in advance for your help!

Anton



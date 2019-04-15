Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6EC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5692075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FNQlqO1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5692075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFygl-0002Gs-Mh
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:18:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyfn-0001we-Vx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyfn-00024x-0w
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:17:11 -0400
Received: from forwardcorp1p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b6:217]:54254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyfm-00022f-FL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:17:10 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9AC7F2E1496;
	Mon, 15 Apr 2019 13:17:07 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	2AqKBt4n2I-H7ea79j8; Mon, 15 Apr 2019 13:17:07 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555323427; bh=9yvuk7EMCBzKyv1Eak4izaCX1knNEpiUYLnXOMNnpu4=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=FNQlqO1Zd6pmT/JvP95pGERgjhcYFJUXTeQAxnd7/tArkBQhc1EijgUni2Z7AxRR/
	GtCi1gPRjwkEVjZrU7/RmqR6OuDJQRb35InuypE+UHqAt7fEB/PSpItHfQNEBUTlrN
	iB05KJw34nOkozHxOUrzs3PlNWnd9nQCaCdqY8qs=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net ([::1])
	by mxbackcorp2j.mail.yandex.net with LMTP id 8TRl72Bk
	for <yury-kotov@yandex-team.ru>; Mon, 15 Apr 2019 13:17:02 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
	Mon, 15 Apr 2019 13:17:01 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
In-Reply-To: <20190415101101.GF5718@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 15 Apr 2019 13:17:06 +0300
Message-Id: <251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
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
Cc: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415101706.8NhXQwW_0gefVyuLjdOsBLMjmq_Qtc-oFj4ly2uAmlE@z>

15.04.2019, 13:11, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
>> =C2=A0Hi,
>>
>> =C2=A0Just to clarify. I see two possible solutions:
>>
>> =C2=A01) Since the migration code doesn't receive fd, it isn't respons=
ible for
>> =C2=A0closing it. So, it may be better to use migrate_fd_param for bot=
h
>> =C2=A0incoming/outgoing and add dupping for migrate_fd_param. Thus, cl=
ients must
>> =C2=A0close the fd themselves. But existing clients will have a leak.
>
> We can't break existing clients in this way as they are correctly
> using the monitor with its current semantics.
>
>> =C2=A02) If we don't duplicate fd, then at least we should remove fd f=
rom
>> =C2=A0the corresponding list. Therefore, the solution is to fix qemu_c=
lose to find
>> =C2=A0the list and remove fd from it. But qemu_close is currently cons=
istent with
>> =C2=A0qemu_open (which opens/dups fd), so adding additional logic migh=
t not be
>> =C2=A0a very good idea.
>
> qemu_close is not appropriate place to deal with something speciifc
> to the montor.
>
>> =C2=A0I don't see any other solution, but I might miss something.
>> =C2=A0What do you think?
>
> All callers of monitor_get_fd() will close() the FD they get back.
> Thus monitor_get_fd() should remove it from the list when it returns
> it, and we should add API docs to monitor_get_fd() to explain this.
>
Ok, it sounds reasonable. But monitor_get_fd is only about outgoing migra=
tion.
But what about the incoming migration? It doesn't use monitor_get_fd but =
just
converts input string to int and use it as fd.

Regards,
Yury



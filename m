Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD99C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158922075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cmbZWeN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158922075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47853 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyod-0004rc-A6
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:26:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFymr-0003eU-Ei
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFymq-0000yu-F1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:24:29 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:53048)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFymq-0000wj-1q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:24:28 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 79E9B2E1297;
	Mon, 15 Apr 2019 13:24:25 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	2Opk7rDdbX-OPeeAc0s; Mon, 15 Apr 2019 13:24:25 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555323865; bh=MxEnWmUE7Rmd/ZhT2SineXDTPZV2D50zECwIU+qm92Y=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=cmbZWeN0ttjsB2MzYjJW+h7FS6pSJ8dvbIsQcS9kCi9INHsd4wQy8RhEDQzkGPhQS
	BsFN8mcaAUu4G/yXq+EEI1ZViwSonuVXaHTJZSxicet5tLDnwPHEI0iRl1nw+9/Mte
	s6xYZDV8S1FYY7c58pdr5Nw3BWwZVNnYR7UKG6J0=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net ([::1])
	by mxbackcorp2j.mail.yandex.net with LMTP id EcNJSSQ9
	for <yury-kotov@yandex-team.ru>; Mon, 15 Apr 2019 13:24:20 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
	Mon, 15 Apr 2019 13:24:19 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
In-Reply-To: <251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 15 Apr 2019 13:24:24 +0300
Message-Id: <255121555323859@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415102424.wAhkqpB9x7SHMKTzKLfoRRd3vzsUpF8Dm9jph1F3eJk@z>

15.04.2019, 13:17, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> 15.04.2019, 13:11, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
>> =C2=A0On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
>>> =C2=A0=C2=A0Hi,
>>>
>>> =C2=A0=C2=A0Just to clarify. I see two possible solutions:
>>>
>>> =C2=A0=C2=A01) Since the migration code doesn't receive fd, it isn't =
responsible for
>>> =C2=A0=C2=A0closing it. So, it may be better to use migrate_fd_param =
for both
>>> =C2=A0=C2=A0incoming/outgoing and add dupping for migrate_fd_param. T=
hus, clients must
>>> =C2=A0=C2=A0close the fd themselves. But existing clients will have a=
 leak.
>>
>> =C2=A0We can't break existing clients in this way as they are correctl=
y
>> =C2=A0using the monitor with its current semantics.
>>
>>> =C2=A0=C2=A02) If we don't duplicate fd, then at least we should remo=
ve fd from
>>> =C2=A0=C2=A0the corresponding list. Therefore, the solution is to fix=
 qemu_close to find
>>> =C2=A0=C2=A0the list and remove fd from it. But qemu_close is current=
ly consistent with
>>> =C2=A0=C2=A0qemu_open (which opens/dups fd), so adding additional log=
ic might not be
>>> =C2=A0=C2=A0a very good idea.
>>
>> =C2=A0qemu_close is not appropriate place to deal with something speci=
ifc
>> =C2=A0to the montor.
>>

But qemu_close is already deal with monitor:
It uses monitor_fdset_dup_fd_find & monitor_fdset_dup_fd_remove to find a=
nd
remove fd from monitor's dup_fds list.

>>> =C2=A0=C2=A0I don't see any other solution, but I might miss somethin=
g.
>>> =C2=A0=C2=A0What do you think?
>>
>> =C2=A0All callers of monitor_get_fd() will close() the FD they get bac=
k.
>> =C2=A0Thus monitor_get_fd() should remove it from the list when it ret=
urns
>> =C2=A0it, and we should add API docs to monitor_get_fd() to explain th=
is.
>
> Ok, it sounds reasonable. But monitor_get_fd is only about outgoing mig=
ration.
> But what about the incoming migration? It doesn't use monitor_get_fd bu=
t just
> converts input string to int and use it as fd.
>

Regards,
Yury


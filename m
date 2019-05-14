Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51082084E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zY4+lQZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51082084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49371 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYoP-0002VY-6t
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:53:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQYmX-00014V-VG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQYmW-0003Ch-Sg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:51:53 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48496)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>)
	id 1hQYmW-0003AW-Cw; Tue, 14 May 2019 10:51:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 68B912E14F6;
	Tue, 14 May 2019 17:51:49 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	sgF9F34Cph-pnwiRTeV; Tue, 14 May 2019 17:51:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1557845509; bh=s3gxYFqYchK31Dp1Ps5PBifr264EivQcBssC1AxNjdE=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=zY4+lQZCHZH07OMVeM7OfKf5HvBa7CmemsGegYyMJbpIFmOEXOoOMo9DDvimTe7ow
	yw4T7SegfIpgXYvNmoqVcX7CGaakXeiLsIt3Hvdg30uJ+SFukyVmd0+sMecIGLU7mm
	6+0BidXQ2sHQcrVZ0+Z5DwKSw2L6LqzUnw2bZ5EQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id FYBigfli
	for <yury-kotov@yandex-team.ru>; Tue, 14 May 2019 17:51:44 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
	Tue, 14 May 2019 17:51:44 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com>
References: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
	<4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 14 May 2019 17:51:49 +0300
Message-Id: <1059121557845504@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH RESEND] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2019, 17:05, "Eric Blake" <eblake@redhat.com>:
> On 5/14/19 8:15 AM, Yury Kotov wrote:
>> =C2=A0monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find=
()
>> =C2=A0returns mon_fdset->id which is int64_t. Downcast from int64_t to=
 int leads to
>> =C2=A0a bug with removing fd from fdset which id >=3D 2^32.
>> =C2=A0So, fix return types for these function.
>
> fd's cannot exceed 2^32. We should instead be fixing anything that uses
> int64_t with an fd to be properly limited to 32 bits. That is, I think
> the real problem is in qapi/misc.json:
>
> =C2=A0{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int'}=
 }
> instead of 'fd':'int32'. For that matter, 'fdset-id' larger than 32
> bits is unlikely to be useful (there's no reason to have more fdsets
> than you can have possible fds to put in those sets).
>
> NACK to this version, but a v2 that addresses the real problem is
> worthwhile.
>

Ok, so I will change fdset_id type int64_t -> int everywhere and
int64_t -> int32_t for qmp commands. Right?

>> =C2=A0+++ b/include/monitor/monitor.h
>> =C2=A0@@ -46,7 +46,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool h=
as_fdset_=3D
>> =C2=A0id, int64_t fdset_id,
>> =C2=A0=C2=A0int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>> =C2=A0=C2=A0int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)=
;
>> =C2=A0=C2=A0void monitor_fdset_dup_fd_remove(int dup_fd);
>> =C2=A0-int monitor_fdset_dup_fd_find(int dup_fd);
>> =C2=A0+int64_t monitor_fdset_dup_fd_find(int dup_fd);
>> =C2=A0=3D20
>
> Your patch came through corrupted. You may want to double-check how you
> are sending them, to ensure they are not mangled.
>

Omg, sorry. I just copy-pasted my previous patch from mail client in raw =
format
and I did not notice the escape characters, because of which the patch is
incorrect.

Regards,
Yury


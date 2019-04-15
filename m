Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A7AC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154D32070D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KpGuapW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyGd-00037P-6X
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:51:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyFp-0002dh-9R
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyFn-0004Wm-Iz
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:50:21 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:53474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hFyFj-0004VC-VL
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:50:17 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CDF582E124E;
	Mon, 15 Apr 2019 12:50:10 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	UgIlpAgJxk-o9oa9Bpu; Mon, 15 Apr 2019 12:50:10 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555321810; bh=fXKK66QPLDrSfz/JgAehCzJxIeqEUXisPKponFeWRIk=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=KpGuapW5yC6SDlWFqHQo3nJtnu+chxJyIxhvSypx16BusROS6Ztje5wbMAFQzhMts
	32ujFwThvS/qY9kLiN6jHg6wnZZW2OQLrM3QQDCXmYR+8wGgpQIcsg7V0GFckSjYrP
	tZgvwdOYOHxARlnnf+oHqrYoHXzBh3YiSK/oeBv0=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id yD56tfcS
	for <yury-kotov@yandex-team.ru>; Mon, 15 Apr 2019 12:50:04 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
	Mon, 15 Apr 2019 12:50:03 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
	Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 15 Apr 2019 12:50:08 +0300
Message-Id: <243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
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
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415095008.K-J9ZRb3xP1a_aIIIjOa7v1floeyvCzJUdnEYGTDAAA@z>

Hi,

Just to clarify. I see two possible solutions:

1) Since the migration code doesn't receive fd, it isn't responsible for
closing it. So, it may be better to use migrate_fd_param for both
incoming/outgoing and add dupping for migrate_fd_param. Thus, clients mus=
t
close the fd themselves. But existing clients will have a leak.

2) If we don't duplicate fd, then at least we should remove fd from
the corresponding list. Therefore, the solution is to fix qemu_close to f=
ind
the list and remove fd from it. But qemu_close is currently consistent wi=
th
qemu_open (which opens/dups fd), so adding additional logic might not be
a very good idea.

I don't see any other solution, but I might miss something.
What do you think?

Regards,
Yury

11.04.2019, 15:58, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> 11.04.2019, 15:39, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
>> =C2=A0On Thu, Apr 11, 2019 at 03:31:43PM +0300, Yury Kotov wrote:
>>> =C2=A0=C2=A011.04.2019, 15:04, "Daniel P. Berrang=C3=A9" <berrange@re=
dhat.com>:
>>> =C2=A0=C2=A0> On Wed, Apr 10, 2019 at 12:26:52PM +0300, Yury Kotov wr=
ote:
>>> =C2=A0=C2=A0>> =C2=A0Currently such case is possible for incoming:
>>> =C2=A0=C2=A0>> =C2=A0QMP: add-fd (fdset =3D 0, fd of some file):
>>> =C2=A0=C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adds fd to fdset 0 and r=
eturns QEMU's fd (e.g. 33)
>>> =C2=A0=C2=A0>> =C2=A0QMP: migrate-incoming (uri =3D "fd:33"): fd is s=
tored in QIOChannel *ioc
>>> =C2=A0=C2=A0>> =C2=A0...
>>> =C2=A0=C2=A0>> =C2=A0Incoming migration completes and unrefs ioc -> c=
lose(33)
>>> =C2=A0=C2=A0>> =C2=A0QMP: remove-fd (fdset =3D 0, fd =3D 33):
>>> =C2=A0=C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0removes fd from fdset 0 =
and qemu_close() -> close(33) =3D> double close
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> IMHO this is user error.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> You've given the FD to QEMU and told it to use it for m=
igration.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> Once you've done that you should not be calling remove-=
fd.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> remove-fd should only be used in some error code path. =
ie if you
>>> =C2=A0=C2=A0> have called add-fd, and then some failure means you've =
decided you
>>> =C2=A0=C2=A0> can't invoke 'migrate-incoming'. Now you should call "r=
emove-fd".
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> AFAIK, we have never documented that 'add-fd' must be p=
aired
>>> =C2=A0=C2=A0> with 'remove-fd'.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> IOW, I think this "fix" is in fact not a fix - it is in=
stead
>>> =C2=A0=C2=A0> changing the semantics of when "remove-fd" should be us=
ed.
>>> =C2=A0=C2=A0>
>>>
>>> =C2=A0=C2=A0I think it might be user's error but fd is still in cur_m=
on->fds (in getfd case)
>>> =C2=A0=C2=A0or in mon_fdsets (in add-fd case). So if fd is still exis=
ts in the lists why
>>> =C2=A0=C2=A0user can't close/remove it?
>>>
>>> =C2=A0=C2=A0So, there are 2 valid options:
>>> =C2=A0=C2=A01) fd is still valid after migration (dup)
>>
>> =C2=A0If we do this then existing mgmt apps using QEMU who don't expec=
t to need
>> =C2=A0to call remove-fd are going to be leaking FDs forever.
>
> Ok, so what do you think about modifying qemu_close to remove fd from t=
hese two
> lists? Currently it tryes to remove fd only from mon_fdsets->dup_fds.
>
> Regards,
> Yury
>
>>> =C2=A0=C2=A02) fd is closed but also removed from the appropriate lis=
t
>>
>> =C2=A0monitor_get_fd currently leaves the FD on the list.
>>
>> =C2=A0if all current users of that API are closing the FD
>> =C2=A0themselves, then we could change that method to remove
>> =C2=A0it from the list.
>>
>> =C2=A0Either way the requirements in this area are pooly documented
>> =C2=A0both from QEMU's internal POV and from mgmt app public QMP pov.
>>
>> =C2=A0Regards,
>> =C2=A0Daniel
>> =C2=A0--
>> =C2=A0|: https://berrange.com -o- https://www.flickr.com/photos/dberra=
nge :|
>> =C2=A0|: https://libvirt.org -o- https://fstop138.berrange.com :|
>> =C2=A0|: https://entangle-photo.org -o- https://www.instagram.com/dber=
range :|


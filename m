Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD87C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A00C2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YrgjOCdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A00C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7Lj-0002V0-8M
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:10:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hT7KV-0001pO-5O
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hT7KT-0006kG-BP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:09:31 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:53816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hT7KT-0006iv-0Z
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:09:29 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 93ED12E14E3;
	Tue, 21 May 2019 19:09:22 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	FZHCzsTzhw-9MpWDfBp; Tue, 21 May 2019 19:09:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558454962; bh=ku/v1ZEdvxAkgj7g/lT+/mOqFmhEGn8+Xh+YuvfNsXU=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=YrgjOCdCIuKgQ5BUW27WFtOFaJin2E5WRR4l34PskX+AJFVBMQJebBbIlSsgj33w/
	r2U0a0Jnq1IMv8GVZWHMhPQ65hUC1D8Byj+08GZYOsDBasewo+iIna3J3IULWsqzfY
	AnW7Lkus5+i5jOTWf/UfuIU0w0WHhD0EeyhC7kmo=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::162])
	by dlvcorp1p.mail.yandex.net with LMTP id aTXEVgaaEo-Uf2dqOpm
	for <yury-kotov@yandex-team.ru>; Tue, 21 May 2019 19:09:11 +0300
Received: by sas2-76706d252d16.qloud-c.yandex.net with HTTP;
	Tue, 21 May 2019 19:09:11 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <346471557826571@vla1-9d3c37294942.qloud-c.yandex.net>
References: <259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
	<1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418160300.GI2984@work-vm>
	<1201831555604730@vla1-1374b6242101.qloud-c.yandex.net>
	<20190418170118.GK2984@work-vm>
	<164761555609613@myt4-a988562a11ab.qloud-c.yandex.net>
	<346471557826571@vla1-9d3c37294942.qloud-c.yandex.net>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 21 May 2019 19:09:21 +0300
Message-Id: <677601558454951@sas2-76706d252d16.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

14.05.2019, 12:36, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Ping
>
> 18.04.2019, 20:46, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>> =C2=A018.04.2019, 20:01, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>>> =C2=A0=C2=A0* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>>> =C2=A0=C2=A0=C2=A018.04.2019, 19:03, "Dr. David Alan Gilbert" <dgilb=
ert@redhat.com>:
>>>> =C2=A0=C2=A0=C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A018.04.2019, 17:20, "Dr. David Alan Gilber=
t" <dgilbert@redhat.com>:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru=
) wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A015.04.2019, 14:30, "Dr. David Al=
an Gilbert" <dgilbert@redhat.com>:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (ber=
range@redhat.com) wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0On Mon, Apr 15, 2019 at=
 12:15:12PM +0100, Dr. David Alan Gilbert wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=
=A9 (berrange@redhat.com) wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > On Mon, Apr 15, 201=
9 at 01:33:21PM +0300, Yury Kotov wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > 15.04.2019, 13:25=
, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > On Mon, Apr 15,=
 2019 at 01:17:06PM +0300, Yury Kotov wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A015.04.20=
19, 13:11, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> On Mon=
, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
Hi,
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
Just to clarify. I see two possible solutions:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
1) Since the migration code doesn't receive fd, it isn't responsible for
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
closing it. So, it may be better to use migrate_fd_param for both
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
incoming/outgoing and add dupping for migrate_fd_param. Thus, clients mus=
t
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
close the fd themselves. But existing clients will have a leak.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> We can=
't break existing clients in this way as they are correctly
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> using =
the monitor with its current semantics.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
2) If we don't duplicate fd, then at least we should remove fd from
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
the corresponding list. Therefore, the solution is to fix qemu_close to f=
ind
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
the list and remove fd from it. But qemu_close is currently consistent wi=
th
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
qemu_open (which opens/dups fd), so adding additional logic might not be
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
a very good idea.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> qemu_c=
lose is not appropriate place to deal with something speciifc
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> to the=
 montor.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
I don't see any other solution, but I might miss something.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0=
What do you think?
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> All ca=
llers of monitor_get_fd() will close() the FD they get back.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> Thus m=
onitor_get_fd() should remove it from the list when it returns
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> it, an=
d we should add API docs to monitor_get_fd() to explain this.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0Ok, it s=
ounds reasonable. But monitor_get_fd is only about outgoing migration.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0But what=
 about the incoming migration? It doesn't use monitor_get_fd but just
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0converts=
 input string to int and use it as fd.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > The incoming mi=
gration expects the FD to be passed into QEMU by the mgmt
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > app when it is =
exec'ing the QEMU binary. It doesn't interact with the
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > monitor at all =
AFAIR.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > >
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > Oh, sorry. This u=
se case is not obvious. We used add-fd to pass fd for
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > migrate-incoming =
and such way has described problems.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> >
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > That's a bug in you=
r usage of QEMU IMHO, as the incoming code is not
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > designed to use add=
-fd.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> Hmm, that's true - al=
though:
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> a) It's very non-obvi=
ous
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> b) Unfortunate, since=
 it would go well with -incoming defer
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Yeah I think this is a =
screw up on QMEU's part when introducing 'defer'.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0We should have mandated=
 use of 'add-fd' when using 'defer', since FD
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0inheritance-over-execve=
() should only be used for command line args,
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0not monitor commands.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Not sure how to best fi=
x this is QEMU though without breaking back
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0compat for apps using '=
defer' already.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0> We could add mon-fd: transport=
s that has the same behaviour as now for
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0> outgoing, and for incoming use=
s the add-fd stash.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0Oh, I'm sorry again. I think my =
suggestion about monitor_fd_param wasn't
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0relevant to this issue. If migra=
te-incoming + "fd:" + add-fd is an invalid use
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0case, should we disallow this?
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0I may add a check to fd_start_in=
coming_migration if fd is in mon fds list.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0But I'm afraid there are users l=
ike me who are already using this wrong use case.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0Because currently nothing in QEM=
U's docs disallow this.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0So which solution is better in y=
our opinion?
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A01) Disallow fd's from mon fds li=
st in fd_start_incoming_migration
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> I'm surprised anything could be doing t=
hat - how would a user know what
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> the correct fd index was?
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0Hmm, add-fd returns correct fd value. May=
be I din't catch you question...
>>>> =C2=A0=C2=A0=C2=A0>
>>>> =C2=A0=C2=A0=C2=A0> I don't understand, where does it return it?
>>>> =C2=A0=C2=A0=C2=A0>
>>>>
>>>> =C2=A0=C2=A0=C2=A0From misc.json:
>>>> =C2=A0=C2=A0=C2=A0# Example:
>>>> =C2=A0=C2=A0=C2=A0#
>>>> =C2=A0=C2=A0=C2=A0# -> { "execute": "add-fd", "arguments": { "fdset-=
id": 1 } }
>>>> =C2=A0=C2=A0=C2=A0# <- { "return": { "fdset-id": 1, "fd": 3 } }
>>>> =C2=A0=C2=A0=C2=A0#
>>>>
>>>> =C2=A0=C2=A0=C2=A0"fd": 3 is a valid fd for migrate-incoming(uri =3D=
 "fd:3")
>>>
>>> =C2=A0=C2=A0Ah OK.
>>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A02) Allow these fds, but dup them=
 or close them correctly
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> I think I'd leave the current (confusin=
g) fd: as it is, maybe put a note
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> in the manual.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0So, using fd from fdset will be an undefi=
ned behavior, right?
>>>> =C2=A0=C2=A0=C2=A0>
>>>> =C2=A0=C2=A0=C2=A0> For incoming, yes.
>>>> =C2=A0=C2=A0=C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0And how to migrate-incoming defe=
r through fd correctly?
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A01) Add "mon-fd:" protocol to wor=
k with fds passed by "add-fd/remove-fd" commands
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0as suggested by Dave
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> That's my preference; it's explicitly n=
amed and consistent, and it
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0> doesn't touch the existing fd code.
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0Ok, but please tell me what you think of =
my suggestion (2) about using fd added
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0by the "getfd" command for incoming migra=
tion. It doesn't requires introducing
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0new protocol and will be consistent with =
outgoing migration through fd.
>>>> =C2=A0=C2=A0=C2=A0>
>>>> =C2=A0=C2=A0=C2=A0> I worry how qemu knows whether the command means=
 it comes from the getfd
>>>> =C2=A0=C2=A0=C2=A0> command or is actually a normal fd like now?
>>>> =C2=A0=C2=A0=C2=A0> Can you give an example.
>>>> =C2=A0=C2=A0=C2=A0>
>>>>
>>>> =C2=A0=C2=A0=C2=A0getfd manages naming fds list.
>>>> =C2=A0=C2=A0=C2=A0# -> { "execute": "getfd", "arguments": { "fdname"=
: "fd1" } }
>>>> =C2=A0=C2=A0=C2=A0So, for migrate (not incoming) is now valid migrat=
e(uri=3D"fd:fd1")
>>>>
>>>> =C2=A0=C2=A0=C2=A0I want the same for migrate-incoming. If fdname is=
 parseable int, then it is
>>>> =C2=A0=C2=A0=C2=A0an old format. Otherwise - it is a name of fd adde=
d by addfd.
>>>>
>>>> =C2=A0=C2=A0=C2=A0There is a function "monitor_fd_param" which do ex=
actly what I mean:
>>>> =C2=A0=C2=A0=C2=A0int monitor_fd_param(Monitor *mon, const char *fdn=
ame, Error **errp) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... local vars ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_isdigit(fdname[0=
]) && mon) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd=
 =3D monitor_get_fd(mon, fdname, &local_err);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd=
 =3D qemu_parse_fd(fdname);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... report err to errp ...
>>>> =C2=A0=C2=A0=C2=A0}
>>>
>>> =C2=A0=C2=A0OK, if we're already using monitor_fd_param everywhere th=
en I think
>>> =C2=A0=C2=A0we're already down the rat-hole of guessing whether we're=
 an add-fd or
>>> =C2=A0=C2=A0fd by whether it's an integer, and I agree with you that =
we should
>>> =C2=A0=C2=A0just fix incoming to use that.
>>>
>>> =C2=A0=C2=A0Now, that means I guess we need to modify monitor_fd_para=
m to tell us
>>> =C2=A0=C2=A0which type of fd it got, so we know whether to close it l=
ater?
>>>
>>> =C2=A0=C2=A0Dave
>>> =C2=A0=C2=A0P.S. I'm out from tomorrow for a weekish.
>>
>> =C2=A0I think the right way is to check whether fd is added by add-fd =
and if so then
>> =C2=A0return error. Because IIUC the only valid usage of add-fd is to =
use
>> =C2=A0qemu_open("/dev/fdset/<fdset_id>") which finds suitable fd from =
fdset.
>> =C2=A0Such behavior is incompatible with fd:<fd_num> at all, as such s=
yntax
>> =C2=A0doesn't imply the using of particular fd. But if so, why add-fd =
returns
>> =C2=A0the value of added fd?..
>>
>> =C2=A0But if I'm right it's enough to:
>> =C2=A01) Modify monitor_fd_param to check where fd comes from and disa=
llow using
>> =C2=A0=C2=A0=C2=A0=C2=A0fd of "add-fd",
>> =C2=A02) As we discussed earlier, modify monitor_get_fd to remove name=
d fd from its
>> =C2=A0=C2=A0=C2=A0=C2=A0list before return,
>
> Omg, monitor_fd_param is already do so... Sorry, so the problem only in
> incoming case.
>
>> =C2=A03) Use monitor_fd_param in migrate_incoming for "fd:" proto.
>>
>> =C2=A0I'm not insist. May be it's ok to use fd from fdset directly and=
 so qemu_close
>> =C2=A0should be modifyed.
>>
>> =C2=A0Just to clarify what I mean:
>> =C2=A0fdset is a struct:
>> =C2=A0struct MonFdset {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int64_t id;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) fds;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) dup_fds;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_ENTRY(MonFdset) next;
>> =C2=A0};
>>
>> =C2=A0* add-fd appends new fd to "->fds" list.
>> =C2=A0* qemu_open("/dev/fdset/X", int perms) is looking for suitable (=
by perms) fd
>> =C2=A0=C2=A0=C2=A0from fdset with id X, dup it and append "->dup_fds" =
list.
>> =C2=A0* qemu_close(int fd) tryes to find the fd in all "->dup_fds" lis=
ts
>> =C2=A0=C2=A0=C2=A0of all fdsets and remove it. And closes fd anyway.
>>
>> =C2=A0If not to disallow using fds added by add-fd then there are thre=
e
>> =C2=A0possible solutions:
>> =C2=A01) dup fd in monitor_fd_param it the fd is from some fdset,
>> =C2=A02) remove the fd from "->fds" list in qemu_close
>> =C2=A03) don't close it in qemu_close, so client is responsible to clo=
se it by
>> =C2=A0=C2=A0=C2=A0=C2=A0remove-fd.
>>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A02) My suggestion about monitor_f=
d_param and make "fd:" for
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0migrate/migrate-incoming consist=
ent. So user will be able to use
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A0getfd + migrate-incoming
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>> =C2=A03) Both of them or something els=
e
>>>> =C2=A0=C2=A0=C2=A0>> =C2=A0>>
>>>> =C2=A0=C2=A0=C2=A0>>
>
> Regards,
> Yury


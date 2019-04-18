Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F3C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF55F20835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ti1P9xZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF55F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9Aj-00059D-2r
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:41:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH95k-00012i-4L
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH95i-0007w9-LT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:36:48 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:33884)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH95f-0007nR-I5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:36:45 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7A9ED2E0E69;
	Thu, 18 Apr 2019 18:36:35 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	2kpynvxa5h-aYiaLBnR; Thu, 18 Apr 2019 18:36:35 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555601795; bh=ZGPqk73r3s7eYjWCltQRawrM14dHsZYWcnfR7AYvU6Y=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=Ti1P9xZi67jn9+fIYPfWTyIoVrd58DIcUyc52Ln0zqsYbMeQnfaTQFjZffb7f0NRg
	x6mr0Dzvs1q9/xFcXtYls6ZhMS+dATNiAp2mkgKogH+ibpo8Ihbpk7+ItNo9rU9RkP
	7CPZ0T6mV1wjTlLfdvA+ZXLKipZ4W3Ql7shFr22Y=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id ngdYgggK
	for <yury-kotov@yandex-team.ru>; Thu, 18 Apr 2019 18:36:29 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Thu, 18 Apr 2019 18:36:29 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190418141956.GF2984@work-vm>
References: <243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 18 Apr 2019 18:36:34 +0300
Message-Id: <1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1619::183
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
Message-ID: <20190418153634.yUiybWTcS5IqCYROWqBcO3eb75HMU6tKGthwmnnKCJk@z>

18.04.2019, 17:20, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A015.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> =C2=A0>> =C2=A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David Ala=
n Gilbert wrote:
>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote=
:
>> =C2=A0>> =C2=A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Koto=
v wrote:
>> =C2=A0>> =C2=A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=C3=A9" <ber=
range@redhat.com>:
>> =C2=A0>> =C2=A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury =
Kotov wrote:
>> =C2=A0>> =C2=A0> > > >> =C2=A015.04.2019, 13:11, "Daniel P. Berrang=C3=
=A9" <berrange@redhat.com>:
>> =C2=A0>> =C2=A0> > > >> =C2=A0> On Mon, Apr 15, 2019 at 12:50:08PM +03=
00, Yury Kotov wrote:
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Hi,
>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Just to clarify. I see two poss=
ible solutions:
>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A01) Since the migration code doe=
sn't receive fd, it isn't responsible for
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0closing it. So, it may be bette=
r to use migrate_fd_param for both
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0incoming/outgoing and add duppi=
ng for migrate_fd_param. Thus, clients must
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0close the fd themselves. But ex=
isting clients will have a leak.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0> We can't break existing clients in thi=
s way as they are correctly
>> =C2=A0>> =C2=A0> > > >> =C2=A0> using the monitor with its current sem=
antics.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A02) If we don't duplicate fd, th=
en at least we should remove fd from
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the corresponding list. Therefo=
re, the solution is to fix qemu_close to find
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the list and remove fd from it.=
 But qemu_close is currently consistent with
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0qemu_open (which opens/dups fd)=
, so adding additional logic might not be
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0a very good idea.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0> qemu_close is not appropriate place to=
 deal with something speciifc
>> =C2=A0>> =C2=A0> > > >> =C2=A0> to the montor.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0I don't see any other solution,=
 but I might miss something.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0What do you think?
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0> All callers of monitor_get_fd() will c=
lose() the FD they get back.
>> =C2=A0>> =C2=A0> > > >> =C2=A0> Thus monitor_get_fd() should remove it=
 from the list when it returns
>> =C2=A0>> =C2=A0> > > >> =C2=A0> it, and we should add API docs to moni=
tor_get_fd() to explain this.
>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0> > > >> =C2=A0Ok, it sounds reasonable. But monitor_ge=
t_fd is only about outgoing migration.
>> =C2=A0>> =C2=A0> > > >> =C2=A0But what about the incoming migration? I=
t doesn't use monitor_get_fd but just
>> =C2=A0>> =C2=A0> > > >> =C2=A0converts input string to int and use it =
as fd.
>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0> > > > The incoming migration expects the FD to be pas=
sed into QEMU by the mgmt
>> =C2=A0>> =C2=A0> > > > app when it is exec'ing the QEMU binary. It doe=
sn't interact with the
>> =C2=A0>> =C2=A0> > > > monitor at all AFAIR.
>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0> > >
>> =C2=A0>> =C2=A0> > > Oh, sorry. This use case is not obvious. We used =
add-fd to pass fd for
>> =C2=A0>> =C2=A0> > > migrate-incoming and such way has described probl=
ems.
>> =C2=A0>> =C2=A0> >
>> =C2=A0>> =C2=A0> > That's a bug in your usage of QEMU IMHO, as the inc=
oming code is not
>> =C2=A0>> =C2=A0> > designed to use add-fd.
>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0> Hmm, that's true - although:
>> =C2=A0>> =C2=A0> a) It's very non-obvious
>> =C2=A0>> =C2=A0> b) Unfortunate, since it would go well with -incoming=
 defer
>> =C2=A0>>
>> =C2=A0>> =C2=A0Yeah I think this is a screw up on QMEU's part when int=
roducing 'defer'.
>> =C2=A0>>
>> =C2=A0>> =C2=A0We should have mandated use of 'add-fd' when using 'def=
er', since FD
>> =C2=A0>> =C2=A0inheritance-over-execve() should only be used for comma=
nd line args,
>> =C2=A0>> =C2=A0not monitor commands.
>> =C2=A0>>
>> =C2=A0>> =C2=A0Not sure how to best fix this is QEMU though without br=
eaking back
>> =C2=A0>> =C2=A0compat for apps using 'defer' already.
>> =C2=A0>
>> =C2=A0> We could add mon-fd: transports that has the same behaviour as=
 now for
>> =C2=A0> outgoing, and for incoming uses the add-fd stash.
>> =C2=A0>
>>
>> =C2=A0Oh, I'm sorry again. I think my suggestion about monitor_fd_para=
m wasn't
>> =C2=A0relevant to this issue. If migrate-incoming + "fd:" + add-fd is =
an invalid use
>> =C2=A0case, should we disallow this?
>> =C2=A0I may add a check to fd_start_incoming_migration if fd is in mon=
 fds list.
>> =C2=A0But I'm afraid there are users like me who are already using thi=
s wrong use case.
>> =C2=A0Because currently nothing in QEMU's docs disallow this.
>>
>> =C2=A0So which solution is better in your opinion?
>> =C2=A01) Disallow fd's from mon fds list in fd_start_incoming_migratio=
n
>
> I'm surprised anything could be doing that - how would a user know what
> the correct fd index was?
>

Hmm, add-fd returns correct fd value. Maybe I din't catch you question...

>> =C2=A02) Allow these fds, but dup them or close them correctly
>
> I think I'd leave the current (confusing) fd: as it is, maybe put a not=
e
> in the manual.
>

So, using fd from fdset will be an undefined behavior, right?

>> =C2=A0And how to migrate-incoming defer through fd correctly?
>> =C2=A01) Add "mon-fd:" protocol to work with fds passed by "add-fd/rem=
ove-fd" commands
>> =C2=A0as suggested by Dave
>
> That's my preference; it's explicitly named and consistent, and it
> doesn't touch the existing fd code.
>

Ok, but please tell me what you think of my suggestion (2) about using fd=
 added
by the "getfd" command for incoming migration. It doesn't requires introd=
ucing
new protocol and will be consistent with outgoing migration through fd.

>
>> =C2=A02) My suggestion about monitor_fd_param and make "fd:" for
>> =C2=A0migrate/migrate-incoming consistent. So user will be able to use
>> =C2=A0getfd + migrate-incoming
>> =C2=A03) Both of them or something else
>>

Regards,
Yury



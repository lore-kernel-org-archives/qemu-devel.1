Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DEEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EA720862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="T3ZBg0hF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EA720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTs3-00063k-8B
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:37:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQTrF-0005jY-M9
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQTrC-0007ks-Md
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:36:24 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:58478)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQTrB-0007cQ-F2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:36:22 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7FC352E098A;
	Tue, 14 May 2019 12:36:17 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	Onb6saaT0K-aHwK2rEX; Tue, 14 May 2019 12:36:17 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1557826577; bh=ZZH4SRw/EV+JprWDSDZrm/jgIVM1shrlLRup46h1iAM=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=T3ZBg0hF5oD1hu/qnJRzqrpaVR7IbHC8H8WB9VIGE7+HGTTo5gkL56mE2wLsPJ32/
	h9FtQrbe90FplNb1oozjPIBGFyiI9W+c3v+51qUXOUgVdU9n3Wgzrv2wKpmr18ALV5
	U5lXdzXItO8ShMI6CcomHk9Ey1ekxd4D5dRkOJ/o=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net ([::1])
	by mxbackcorp2j.mail.yandex.net with LMTP id 4TdZJygr
	for <yury-kotov@yandex-team.ru>; Tue, 14 May 2019 12:36:12 +0300
Received: by vla1-9d3c37294942.qloud-c.yandex.net with HTTP;
	Tue, 14 May 2019 12:36:11 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <164761555609613@myt4-a988562a11ab.qloud-c.yandex.net>
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
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 14 May 2019 12:36:16 +0300
Message-Id: <346471557826571@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
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

18.04.2019, 20:46, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> 18.04.2019, 20:01, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
>> =C2=A0* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>> =C2=A0=C2=A018.04.2019, 19:03, "Dr. David Alan Gilbert" <dgilbert@red=
hat.com>:
>>> =C2=A0=C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>> =C2=A0=C2=A0>> =C2=A018.04.2019, 17:20, "Dr. David Alan Gilbert" <dgi=
lbert@redhat.com>:
>>> =C2=A0=C2=A0>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote=
:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A015.04.2019, 14:30, "Dr. David Alan Gilb=
ert" <dgilbert@redhat.com>:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@r=
edhat.com) wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0On Mon, Apr 15, 2019 at 12:15:=
12PM +0100, Dr. David Alan Gilbert wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (b=
errange@redhat.com) wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > On Mon, Apr 15, 2019 at 01=
:33:21PM +0300, Yury Kotov wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > 15.04.2019, 13:25, "Dani=
el P. Berrang=C3=A9" <berrange@redhat.com>:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > On Mon, Apr 15, 2019 a=
t 01:17:06PM +0300, Yury Kotov wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A015.04.2019, 13:=
11, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> On Mon, Apr 1=
5, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Hi,
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Just t=
o clarify. I see two possible solutions:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A01) Sin=
ce the migration code doesn't receive fd, it isn't responsible for
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0closin=
g it. So, it may be better to use migrate_fd_param for both
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0incomi=
ng/outgoing and add dupping for migrate_fd_param. Thus, clients must
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0close =
the fd themselves. But existing clients will have a leak.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> We can't brea=
k existing clients in this way as they are correctly
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> using the mon=
itor with its current semantics.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A02) If =
we don't duplicate fd, then at least we should remove fd from
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the co=
rresponding list. Therefore, the solution is to fix qemu_close to find
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the li=
st and remove fd from it. But qemu_close is currently consistent with
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0qemu_o=
pen (which opens/dups fd), so adding additional logic might not be
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0a very=
 good idea.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> qemu_close is=
 not appropriate place to deal with something speciifc
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> to the montor=
.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0I don'=
t see any other solution, but I might miss something.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0What d=
o you think?
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> All callers o=
f monitor_get_fd() will close() the FD they get back.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> Thus monitor_=
get_fd() should remove it from the list when it returns
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> it, and we sh=
ould add API docs to monitor_get_fd() to explain this.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0Ok, it sounds r=
easonable. But monitor_get_fd is only about outgoing migration.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0But what about =
the incoming migration? It doesn't use monitor_get_fd but just
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0converts input =
string to int and use it as fd.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > The incoming migration=
 expects the FD to be passed into QEMU by the mgmt
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > app when it is exec'in=
g the QEMU binary. It doesn't interact with the
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > monitor at all AFAIR.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > >
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > Oh, sorry. This use case=
 is not obvious. We used add-fd to pass fd for
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > migrate-incoming and suc=
h way has described problems.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> >
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > That's a bug in your usage=
 of QEMU IMHO, as the incoming code is not
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > designed to use add-fd.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> Hmm, that's true - although:
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> a) It's very non-obvious
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> b) Unfortunate, since it wou=
ld go well with -incoming defer
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Yeah I think this is a screw u=
p on QMEU's part when introducing 'defer'.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0We should have mandated use of=
 'add-fd' when using 'defer', since FD
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0inheritance-over-execve() shou=
ld only be used for command line args,
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0not monitor commands.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Not sure how to best fix this =
is QEMU though without breaking back
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>> =C2=A0compat for apps using 'defer' =
already.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0> We could add mon-fd: transports that =
has the same behaviour as now for
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0> outgoing, and for incoming uses the a=
dd-fd stash.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0Oh, I'm sorry again. I think my suggest=
ion about monitor_fd_param wasn't
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0relevant to this issue. If migrate-inco=
ming + "fd:" + add-fd is an invalid use
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0case, should we disallow this?
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0I may add a check to fd_start_incoming_=
migration if fd is in mon fds list.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0But I'm afraid there are users like me =
who are already using this wrong use case.
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0Because currently nothing in QEMU's doc=
s disallow this.
>>> =C2=A0=C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0So which solution is better in your opi=
nion?
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A01) Disallow fd's from mon fds list in f=
d_start_incoming_migration
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0> I'm surprised anything could be doing that - h=
ow would a user know what
>>> =C2=A0=C2=A0>> =C2=A0> the correct fd index was?
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0Hmm, add-fd returns correct fd value. Maybe I di=
n't catch you question...
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> I don't understand, where does it return it?
>>> =C2=A0=C2=A0>
>>>
>>> =C2=A0=C2=A0From misc.json:
>>> =C2=A0=C2=A0# Example:
>>> =C2=A0=C2=A0#
>>> =C2=A0=C2=A0# -> { "execute": "add-fd", "arguments": { "fdset-id": 1 =
} }
>>> =C2=A0=C2=A0# <- { "return": { "fdset-id": 1, "fd": 3 } }
>>> =C2=A0=C2=A0#
>>>
>>> =C2=A0=C2=A0"fd": 3 is a valid fd for migrate-incoming(uri =3D "fd:3"=
)
>>
>> =C2=A0Ah OK.
>>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A02) Allow these fds, but dup them or clo=
se them correctly
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0> I think I'd leave the current (confusing) fd: =
as it is, maybe put a note
>>> =C2=A0=C2=A0>> =C2=A0> in the manual.
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0So, using fd from fdset will be an undefined beh=
avior, right?
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> For incoming, yes.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0And how to migrate-incoming defer throu=
gh fd correctly?
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A01) Add "mon-fd:" protocol to work with =
fds passed by "add-fd/remove-fd" commands
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0as suggested by Dave
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0> That's my preference; it's explicitly named an=
d consistent, and it
>>> =C2=A0=C2=A0>> =C2=A0> doesn't touch the existing fd code.
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>>
>>> =C2=A0=C2=A0>> =C2=A0Ok, but please tell me what you think of my sugg=
estion (2) about using fd added
>>> =C2=A0=C2=A0>> =C2=A0by the "getfd" command for incoming migration. I=
t doesn't requires introducing
>>> =C2=A0=C2=A0>> =C2=A0new protocol and will be consistent with outgoin=
g migration through fd.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> I worry how qemu knows whether the command means it com=
es from the getfd
>>> =C2=A0=C2=A0> command or is actually a normal fd like now?
>>> =C2=A0=C2=A0> Can you give an example.
>>> =C2=A0=C2=A0>
>>>
>>> =C2=A0=C2=A0getfd manages naming fds list.
>>> =C2=A0=C2=A0# -> { "execute": "getfd", "arguments": { "fdname": "fd1"=
 } }
>>> =C2=A0=C2=A0So, for migrate (not incoming) is now valid migrate(uri=3D=
"fd:fd1")
>>>
>>> =C2=A0=C2=A0I want the same for migrate-incoming. If fdname is parsea=
ble int, then it is
>>> =C2=A0=C2=A0an old format. Otherwise - it is a name of fd added by ad=
dfd.
>>>
>>> =C2=A0=C2=A0There is a function "monitor_fd_param" which do exactly w=
hat I mean:
>>> =C2=A0=C2=A0int monitor_fd_param(Monitor *mon, const char *fdname, Er=
ror **errp) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... local vars ...
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_isdigit(fdname[0]) && m=
on) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D mo=
nitor_get_fd(mon, fdname, &local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D qe=
mu_parse_fd(fdname);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... report err to errp ...
>>> =C2=A0=C2=A0}
>>
>> =C2=A0OK, if we're already using monitor_fd_param everywhere then I th=
ink
>> =C2=A0we're already down the rat-hole of guessing whether we're an add=
-fd or
>> =C2=A0fd by whether it's an integer, and I agree with you that we shou=
ld
>> =C2=A0just fix incoming to use that.
>>
>> =C2=A0Now, that means I guess we need to modify monitor_fd_param to te=
ll us
>> =C2=A0which type of fd it got, so we know whether to close it later?
>>
>> =C2=A0Dave
>> =C2=A0P.S. I'm out from tomorrow for a weekish.
>
> I think the right way is to check whether fd is added by add-fd and if =
so then
> return error. Because IIUC the only valid usage of add-fd is to use
> qemu_open("/dev/fdset/<fdset_id>") which finds suitable fd from fdset.
> Such behavior is incompatible with fd:<fd_num> at all, as such syntax
> doesn't imply the using of particular fd. But if so, why add-fd returns
> the value of added fd?..
>
> But if I'm right it's enough to:
> 1) Modify monitor_fd_param to check where fd comes from and disallow us=
ing
> =C2=A0=C2=A0=C2=A0fd of "add-fd",
> 2) As we discussed earlier, modify monitor_get_fd to remove named fd fr=
om its
> =C2=A0=C2=A0=C2=A0list before return,

Omg, monitor_fd_param is already do so... Sorry, so the problem only in
incoming case.

> 3) Use monitor_fd_param in migrate_incoming for "fd:" proto.
>
> I'm not insist. May be it's ok to use fd from fdset directly and so qem=
u_close
> should be modifyed.
>
> Just to clarify what I mean:
> fdset is a struct:
> struct MonFdset {
> =C2=A0=C2=A0=C2=A0=C2=A0int64_t id;
> =C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) fds;
> =C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) dup_fds;
> =C2=A0=C2=A0=C2=A0=C2=A0QLIST_ENTRY(MonFdset) next;
> };
>
> * add-fd appends new fd to "->fds" list.
> * qemu_open("/dev/fdset/X", int perms) is looking for suitable (by perm=
s) fd
> =C2=A0=C2=A0from fdset with id X, dup it and append "->dup_fds" list.
> * qemu_close(int fd) tryes to find the fd in all "->dup_fds" lists
> =C2=A0=C2=A0of all fdsets and remove it. And closes fd anyway.
>
> If not to disallow using fds added by add-fd then there are three
> possible solutions:
> 1) dup fd in monitor_fd_param it the fd is from some fdset,
> 2) remove the fd from "->fds" list in qemu_close
> 3) don't close it in qemu_close, so client is responsible to close it b=
y
> =C2=A0=C2=A0=C2=A0remove-fd.
>
>>> =C2=A0=C2=A0>> =C2=A0>
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A02) My suggestion about monitor_fd_param=
 and make "fd:" for
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0migrate/migrate-incoming consistent. So=
 user will be able to use
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A0getfd + migrate-incoming
>>> =C2=A0=C2=A0>> =C2=A0>> =C2=A03) Both of them or something else
>>> =C2=A0=C2=A0>> =C2=A0>>
>>> =C2=A0=C2=A0>>

Regards,
Yury


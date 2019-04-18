Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0281EC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8C4217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bQv7Mae8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8C4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBFI-0008L7-4X
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 13:54:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hHBD4-0007Bw-A4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hHB7m-00028w-0P
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:47:03 -0400
Received: from forwardcorp1p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b6:217]:51764)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hHB7l-00027j-4p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:47:01 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A57842E0DE8;
	Thu, 18 Apr 2019 20:46:58 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	PPMFAky8Ju-kwNWwrDi; Thu, 18 Apr 2019 20:46:58 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555609618; bh=ItsT5gRN7qRuth3wMYgVKsQumFMJiXiF4CKQORCq9dM=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=bQv7Mae8QNQhsPrSN5DhDaN+rgJVVxjHfiqZLMxYhP1eg6udV9Dlo2niLG6wE/ld7
	kctqXXvJA4Lo0U7htopIa/nNyeDjCV9VQQj/Uk/2V0vYMGiOmVdrpsV8Y7V4t+fYxc
	Sshhp1tFUaSpxxForfxz3b2Xaa8u5B17+dZQIuQo=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id gzd1N0kE
	for <yury-kotov@yandex-team.ru>; Thu, 18 Apr 2019 20:46:53 +0300
Received: by myt4-a988562a11ab.qloud-c.yandex.net with HTTP;
	Thu, 18 Apr 2019 20:46:53 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190418170118.GK2984@work-vm>
References: <259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
	<1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418160300.GI2984@work-vm>
	<1201831555604730@vla1-1374b6242101.qloud-c.yandex.net>
	<20190418170118.GK2984@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 18 Apr 2019 20:46:58 +0300
Message-Id: <164761555609613@myt4-a988562a11ab.qloud-c.yandex.net>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418174658.LoVBSWi7b9eouaeDuIJ2AMlknDRbyz1D1DQSmyPqQDo@z>

18.04.2019, 20:01, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A018.04.2019, 19:03, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>> =C2=A018.04.2019, 17:20, "Dr. David Alan Gilbert" <dgilbert@r=
edhat.com>:
>> =C2=A0>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>> =C2=A0>> =C2=A015.04.2019, 14:30, "Dr. David Alan Gilbert" <d=
gilbert@redhat.com>:
>> =C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.c=
om) wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0On Mon, Apr 15, 2019 at 12:15:12PM +0=
100, Dr. David Alan Gilbert wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange=
@redhat.com) wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > On Mon, Apr 15, 2019 at 01:33:21P=
M +0300, Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > 15.04.2019, 13:25, "Daniel P. B=
errang=C3=A9" <berrange@redhat.com>:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > On Mon, Apr 15, 2019 at 01:17=
:06PM +0300, Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A015.04.2019, 13:11, "Da=
niel P. Berrang=C3=A9" <berrange@redhat.com>:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> On Mon, Apr 15, 2019=
 at 12:50:08PM +0300, Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Hi,
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Just to clari=
fy. I see two possible solutions:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A01) Since the =
migration code doesn't receive fd, it isn't responsible for
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0closing it. S=
o, it may be better to use migrate_fd_param for both
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0incoming/outg=
oing and add dupping for migrate_fd_param. Thus, clients must
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0close the fd =
themselves. But existing clients will have a leak.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> We can't break exist=
ing clients in this way as they are correctly
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> using the monitor wi=
th its current semantics.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A02) If we don'=
t duplicate fd, then at least we should remove fd from
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the correspon=
ding list. Therefore, the solution is to fix qemu_close to find
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the list and =
remove fd from it. But qemu_close is currently consistent with
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0qemu_open (wh=
ich opens/dups fd), so adding additional logic might not be
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0a very good i=
dea.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> qemu_close is not ap=
propriate place to deal with something speciifc
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> to the montor.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0I don't see a=
ny other solution, but I might miss something.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0What do you t=
hink?
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> All callers of monit=
or_get_fd() will close() the FD they get back.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> Thus monitor_get_fd(=
) should remove it from the list when it returns
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> it, and we should ad=
d API docs to monitor_get_fd() to explain this.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0Ok, it sounds reasonab=
le. But monitor_get_fd is only about outgoing migration.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0But what about the inc=
oming migration? It doesn't use monitor_get_fd but just
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0converts input string =
to int and use it as fd.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > The incoming migration expect=
s the FD to be passed into QEMU by the mgmt
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > app when it is exec'ing the Q=
EMU binary. It doesn't interact with the
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > > monitor at all AFAIR.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > >
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > Oh, sorry. This use case is not=
 obvious. We used add-fd to pass fd for
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > > migrate-incoming and such way h=
as described problems.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> >
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > That's a bug in your usage of QEM=
U IMHO, as the incoming code is not
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> > designed to use add-fd.
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> Hmm, that's true - although:
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> a) It's very non-obvious
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0> b) Unfortunate, since it would go w=
ell with -incoming defer
>> =C2=A0>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Yeah I think this is a screw up on QM=
EU's part when introducing 'defer'.
>> =C2=A0>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0We should have mandated use of 'add-f=
d' when using 'defer', since FD
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0inheritance-over-execve() should only=
 be used for command line args,
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0not monitor commands.
>> =C2=A0>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0Not sure how to best fix this is QEMU=
 though without breaking back
>> =C2=A0>> =C2=A0>> =C2=A0>> =C2=A0compat for apps using 'defer' already=
.
>> =C2=A0>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> We could add mon-fd: transports that has the=
 same behaviour as now for
>> =C2=A0>> =C2=A0>> =C2=A0> outgoing, and for incoming uses the add-fd s=
tash.
>> =C2=A0>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0Oh, I'm sorry again. I think my suggestion abo=
ut monitor_fd_param wasn't
>> =C2=A0>> =C2=A0>> =C2=A0relevant to this issue. If migrate-incoming + =
"fd:" + add-fd is an invalid use
>> =C2=A0>> =C2=A0>> =C2=A0case, should we disallow this?
>> =C2=A0>> =C2=A0>> =C2=A0I may add a check to fd_start_incoming_migrati=
on if fd is in mon fds list.
>> =C2=A0>> =C2=A0>> =C2=A0But I'm afraid there are users like me who are=
 already using this wrong use case.
>> =C2=A0>> =C2=A0>> =C2=A0Because currently nothing in QEMU's docs disal=
low this.
>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0So which solution is better in your opinion?
>> =C2=A0>> =C2=A0>> =C2=A01) Disallow fd's from mon fds list in fd_start=
_incoming_migration
>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0> I'm surprised anything could be doing that - how woul=
d a user know what
>> =C2=A0>> =C2=A0> the correct fd index was?
>> =C2=A0>> =C2=A0>
>> =C2=A0>>
>> =C2=A0>> =C2=A0Hmm, add-fd returns correct fd value. Maybe I din't cat=
ch you question...
>> =C2=A0>
>> =C2=A0> I don't understand, where does it return it?
>> =C2=A0>
>>
>> =C2=A0From misc.json:
>> =C2=A0# Example:
>> =C2=A0#
>> =C2=A0# -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
>> =C2=A0# <- { "return": { "fdset-id": 1, "fd": 3 } }
>> =C2=A0#
>>
>> =C2=A0"fd": 3 is a valid fd for migrate-incoming(uri =3D "fd:3")
>
> Ah OK.
>
>> =C2=A0>> =C2=A0>> =C2=A02) Allow these fds, but dup them or close them=
 correctly
>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0> I think I'd leave the current (confusing) fd: as it i=
s, maybe put a note
>> =C2=A0>> =C2=A0> in the manual.
>> =C2=A0>> =C2=A0>
>> =C2=A0>>
>> =C2=A0>> =C2=A0So, using fd from fdset will be an undefined behavior, =
right?
>> =C2=A0>
>> =C2=A0> For incoming, yes.
>> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0And how to migrate-incoming defer through fd c=
orrectly?
>> =C2=A0>> =C2=A0>> =C2=A01) Add "mon-fd:" protocol to work with fds pas=
sed by "add-fd/remove-fd" commands
>> =C2=A0>> =C2=A0>> =C2=A0as suggested by Dave
>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0> That's my preference; it's explicitly named and consi=
stent, and it
>> =C2=A0>> =C2=A0> doesn't touch the existing fd code.
>> =C2=A0>> =C2=A0>
>> =C2=A0>>
>> =C2=A0>> =C2=A0Ok, but please tell me what you think of my suggestion =
(2) about using fd added
>> =C2=A0>> =C2=A0by the "getfd" command for incoming migration. It doesn=
't requires introducing
>> =C2=A0>> =C2=A0new protocol and will be consistent with outgoing migra=
tion through fd.
>> =C2=A0>
>> =C2=A0> I worry how qemu knows whether the command means it comes from=
 the getfd
>> =C2=A0> command or is actually a normal fd like now?
>> =C2=A0> Can you give an example.
>> =C2=A0>
>>
>> =C2=A0getfd manages naming fds list.
>> =C2=A0# -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
>> =C2=A0So, for migrate (not incoming) is now valid migrate(uri=3D"fd:fd=
1")
>>
>> =C2=A0I want the same for migrate-incoming. If fdname is parseable int=
, then it is
>> =C2=A0an old format. Otherwise - it is a name of fd added by addfd.
>>
>> =C2=A0There is a function "monitor_fd_param" which do exactly what I m=
ean:
>> =C2=A0int monitor_fd_param(Monitor *mon, const char *fdname, Error **e=
rrp) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... local vars ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qemu_isdigit(fdname[0]) && mon) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D monitor_g=
et_fd(mon, fdname, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D qemu_pars=
e_fd(fdname);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0... report err to errp ...
>> =C2=A0}
>
> OK, if we're already using monitor_fd_param everywhere then I think
> we're already down the rat-hole of guessing whether we're an add-fd or
> fd by whether it's an integer, and I agree with you that we should
> just fix incoming to use that.
>
> Now, that means I guess we need to modify monitor_fd_param to tell us
> which type of fd it got, so we know whether to close it later?
>
> Dave
> P.S. I'm out from tomorrow for a weekish.
>

I think the right way is to check whether fd is added by add-fd and if so=
 then
return error. Because IIUC the only valid usage of add-fd is to use
qemu_open("/dev/fdset/<fdset_id>") which finds suitable fd from fdset.
Such behavior is incompatible with fd:<fd_num> at all, as such syntax
doesn't imply the using of particular fd. But if so, why add-fd returns
the value of added fd?..

But if I'm right it's enought to:
1) Modify monitor_fd_param to check where fd comes from and disallow usin=
g
   fd of "add-fd",
2) As we discussed earlier, modify monitor_get_fd to remove named fd from=
 its
   list before return,
3) Use monitor_fd_param in migrate_incoming for "fd:" proto.

I'm not insist. May be it's ok to use fd from fdset directly and so qemu_=
close
should be modifyed.

Just to clarify what I mean:
fdset is a struct:
struct MonFdset {
    int64_t id;
    QLIST_HEAD(, MonFdsetFd) fds;
    QLIST_HEAD(, MonFdsetFd) dup_fds;
    QLIST_ENTRY(MonFdset) next;
};

* add-fd appends new fd to "->fds" list.
* qemu_open("/dev/fdset/X", int perms) is looking for suitable (by perms)=
 fd
  from fdset with id X, dup it and append "->dup_fds" list.
* qemu_close(int fd) tryes to find the fd in all "->dup_fds" lists
  of all fdsets and remove it. And closes fd anyway.

If not to disallow using fds added by add-fd then there are three
possible solutions:
1) dup fd in monitor_fd_param it the fd is from some fdset,
2) remove the fd from "->fds" list in qemu_close
3) don't close it in qemu_close, so client is responsible to close it by
   remove-fd.

Regards,
Yury

>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A02) My suggestion about monitor_fd_param and ma=
ke "fd:" for
>> =C2=A0>> =C2=A0>> =C2=A0migrate/migrate-incoming consistent. So user w=
ill be able to use
>> =C2=A0>> =C2=A0>> =C2=A0getfd + migrate-incoming
>> =C2=A0>> =C2=A0>> =C2=A03) Both of them or something else
>> =C2=A0>> =C2=A0>>
>> =C2=A0>>
>>



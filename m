Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B4C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F48F2171F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F48F2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHATv-0007nZ-ET
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 13:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hHASZ-0007AH-6r
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hHAPi-0006AL-Jh
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hHAPc-00066g-Uq
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:01:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 635D588ABE;
	Thu, 18 Apr 2019 17:01:23 +0000 (UTC)
Received: from work-vm (ovpn-117-54.ams2.redhat.com [10.36.117.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C82AD60BE5;
	Thu, 18 Apr 2019 17:01:21 +0000 (UTC)
Date: Thu, 18 Apr 2019 18:01:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190418170118.GK2984@work-vm>
References: <259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
	<1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418160300.GI2984@work-vm>
	<1201831555604730@vla1-1374b6242101.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1201831555604730@vla1-1374b6242101.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 18 Apr 2019 17:01:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418170119.pWM8Xy4NUNa1AilHLMfVq_R_6GNHhHdEw-bbgnHVca8@z>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 18.04.2019, 19:03, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A018.04.2019, 17:20, "Dr. David Alan Gilbert" <dgilbert@redhat.com>=
:
> >> =A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0>> =A015.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@redha=
t.com>:
> >> =A0>> =A0> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0>> =A0>> =A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David A=
lan Gilbert wrote:
> >> =A0>> =A0>> =A0> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0>> =A0>> =A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Ko=
tov wrote:
> >> =A0>> =A0>> =A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=E9" <berr=
ange@redhat.com>:
> >> =A0>> =A0>> =A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yur=
y Kotov wrote:
> >> =A0>> =A0>> =A0> > > >> =A015.04.2019, 13:11, "Daniel P. Berrang=E9"=
 <berrange@redhat.com>:
> >> =A0>> =A0>> =A0> > > >> =A0> On Mon, Apr 15, 2019 at 12:50:08PM +030=
0, Yury Kotov wrote:
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0Hi,
> >> =A0>> =A0>> =A0> > > >> =A0>>
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0Just to clarify. I see two possible=
 solutions:
> >> =A0>> =A0>> =A0> > > >> =A0>>
> >> =A0>> =A0>> =A0> > > >> =A0>> =A01) Since the migration code doesn't=
 receive fd, it isn't responsible for
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0closing it. So, it may be better to=
 use migrate_fd_param for both
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0incoming/outgoing and add dupping f=
or migrate_fd_param. Thus, clients must
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0close the fd themselves. But existi=
ng clients will have a leak.
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0> We can't break existing clients in this=
 way as they are correctly
> >> =A0>> =A0>> =A0> > > >> =A0> using the monitor with its current sema=
ntics.
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0>> =A02) If we don't duplicate fd, then a=
t least we should remove fd from
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0the corresponding list. Therefore, =
the solution is to fix qemu_close to find
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0the list and remove fd from it. But=
 qemu_close is currently consistent with
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0qemu_open (which opens/dups fd), so=
 adding additional logic might not be
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0a very good idea.
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0> qemu_close is not appropriate place to =
deal with something speciifc
> >> =A0>> =A0>> =A0> > > >> =A0> to the montor.
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0I don't see any other solution, but=
 I might miss something.
> >> =A0>> =A0>> =A0> > > >> =A0>> =A0What do you think?
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0> All callers of monitor_get_fd() will cl=
ose() the FD they get back.
> >> =A0>> =A0>> =A0> > > >> =A0> Thus monitor_get_fd() should remove it =
from the list when it returns
> >> =A0>> =A0>> =A0> > > >> =A0> it, and we should add API docs to monit=
or_get_fd() to explain this.
> >> =A0>> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0>> =A0> > > >> =A0Ok, it sounds reasonable. But monitor_get=
_fd is only about outgoing migration.
> >> =A0>> =A0>> =A0> > > >> =A0But what about the incoming migration? It=
 doesn't use monitor_get_fd but just
> >> =A0>> =A0>> =A0> > > >> =A0converts input string to int and use it a=
s fd.
> >> =A0>> =A0>> =A0> > > >
> >> =A0>> =A0>> =A0> > > > The incoming migration expects the FD to be p=
assed into QEMU by the mgmt
> >> =A0>> =A0>> =A0> > > > app when it is exec'ing the QEMU binary. It d=
oesn't interact with the
> >> =A0>> =A0>> =A0> > > > monitor at all AFAIR.
> >> =A0>> =A0>> =A0> > > >
> >> =A0>> =A0>> =A0> > >
> >> =A0>> =A0>> =A0> > > Oh, sorry. This use case is not obvious. We use=
d add-fd to pass fd for
> >> =A0>> =A0>> =A0> > > migrate-incoming and such way has described pro=
blems.
> >> =A0>> =A0>> =A0> >
> >> =A0>> =A0>> =A0> > That's a bug in your usage of QEMU IMHO, as the i=
ncoming code is not
> >> =A0>> =A0>> =A0> > designed to use add-fd.
> >> =A0>> =A0>> =A0>
> >> =A0>> =A0>> =A0> Hmm, that's true - although:
> >> =A0>> =A0>> =A0> a) It's very non-obvious
> >> =A0>> =A0>> =A0> b) Unfortunate, since it would go well with -incomi=
ng defer
> >> =A0>> =A0>>
> >> =A0>> =A0>> =A0Yeah I think this is a screw up on QMEU's part when i=
ntroducing 'defer'.
> >> =A0>> =A0>>
> >> =A0>> =A0>> =A0We should have mandated use of 'add-fd' when using 'd=
efer', since FD
> >> =A0>> =A0>> =A0inheritance-over-execve() should only be used for com=
mand line args,
> >> =A0>> =A0>> =A0not monitor commands.
> >> =A0>> =A0>>
> >> =A0>> =A0>> =A0Not sure how to best fix this is QEMU though without =
breaking back
> >> =A0>> =A0>> =A0compat for apps using 'defer' already.
> >> =A0>> =A0>
> >> =A0>> =A0> We could add mon-fd: transports that has the same behavio=
ur as now for
> >> =A0>> =A0> outgoing, and for incoming uses the add-fd stash.
> >> =A0>> =A0>
> >> =A0>>
> >> =A0>> =A0Oh, I'm sorry again. I think my suggestion about monitor_fd=
_param wasn't
> >> =A0>> =A0relevant to this issue. If migrate-incoming + "fd:" + add-f=
d is an invalid use
> >> =A0>> =A0case, should we disallow this?
> >> =A0>> =A0I may add a check to fd_start_incoming_migration if fd is i=
n mon fds list.
> >> =A0>> =A0But I'm afraid there are users like me who are already usin=
g this wrong use case.
> >> =A0>> =A0Because currently nothing in QEMU's docs disallow this.
> >> =A0>>
> >> =A0>> =A0So which solution is better in your opinion?
> >> =A0>> =A01) Disallow fd's from mon fds list in fd_start_incoming_mig=
ration
> >> =A0>
> >> =A0> I'm surprised anything could be doing that - how would a user k=
now what
> >> =A0> the correct fd index was?
> >> =A0>
> >>
> >> =A0Hmm, add-fd returns correct fd value. Maybe I din't catch you que=
stion...
> >
> > I don't understand, where does it return it?
> >
>=20
> From misc.json:
> # Example:
> #
> # -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
> # <- { "return": { "fdset-id": 1, "fd": 3 } }
> #
>=20
> "fd": 3 is a valid fd for migrate-incoming(uri =3D "fd:3")

Ah OK.

> >> =A0>> =A02) Allow these fds, but dup them or close them correctly
> >> =A0>
> >> =A0> I think I'd leave the current (confusing) fd: as it is, maybe p=
ut a note
> >> =A0> in the manual.
> >> =A0>
> >>
> >> =A0So, using fd from fdset will be an undefined behavior, right?
> >
> > For incoming, yes.
> >
> >> =A0>> =A0And how to migrate-incoming defer through fd correctly?
> >> =A0>> =A01) Add "mon-fd:" protocol to work with fds passed by "add-f=
d/remove-fd" commands
> >> =A0>> =A0as suggested by Dave
> >> =A0>
> >> =A0> That's my preference; it's explicitly named and consistent, and=
 it
> >> =A0> doesn't touch the existing fd code.
> >> =A0>
> >>
> >> =A0Ok, but please tell me what you think of my suggestion (2) about =
using fd added
> >> =A0by the "getfd" command for incoming migration. It doesn't require=
s introducing
> >> =A0new protocol and will be consistent with outgoing migration throu=
gh fd.
> >
> > I worry how qemu knows whether the command means it comes from the ge=
tfd
> > command or is actually a normal fd like now?
> > Can you give an example.
> >
>=20
> getfd manages naming fds list.
> # -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
> So, for migrate (not incoming) is now valid migrate(uri=3D"fd:fd1")
>=20
> I want the same for migrate-incoming. If fdname is parseable int, then =
it is
> an old format. Otherwise - it is a name of fd added by addfd.
>=20
> There is a function "monitor_fd_param" which do exactly what I mean:
> int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp) {
>     ... local vars ...
>     if (!qemu_isdigit(fdname[0]) && mon) {
>         fd =3D monitor_get_fd(mon, fdname, &local_err);
>     } else {
>         fd =3D qemu_parse_fd(fdname);
>     }
>     ... report err to errp ...
> }

OK, if we're already using monitor_fd_param everywhere then I think
we're already down the rat-hole of guessing whether we're an add-fd or
fd by whether it's an integer, and I agree with you that we should
just fix incoming to use that.

Now, that means I guess we need to modify monitor_fd_param to tell us
which type of fd it got, so we know whether to close it later?

Dave
P.S. I'm out from tomorrow for a weekish.


> >> =A0>
> >> =A0>> =A02) My suggestion about monitor_fd_param and make "fd:" for
> >> =A0>> =A0migrate/migrate-incoming consistent. So user will be able t=
o use
> >> =A0>> =A0getfd + migrate-incoming
> >> =A0>> =A03) Both of them or something else
> >> =A0>>
> >>
>=20
> Regards,
> Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


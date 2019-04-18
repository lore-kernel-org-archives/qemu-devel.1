Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A19C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DC020693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DC020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9Wk-0006qU-3G
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 12:04:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH9VN-0006Dn-1V
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH9VL-00033R-Cl
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hH9VL-00032r-4b
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A36A7307D771;
	Thu, 18 Apr 2019 16:03:05 +0000 (UTC)
Received: from work-vm (ovpn-117-54.ams2.redhat.com [10.36.117.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5605160BE5;
	Thu, 18 Apr 2019 16:03:03 +0000 (UTC)
Date: Thu, 18 Apr 2019 17:03:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190418160300.GI2984@work-vm>
References: <251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
	<1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 18 Apr 2019 16:03:13 +0000 (UTC)
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
Message-ID: <20190418160300.p5eelEB1yk_PxTuo4ZDWC39RAVYKUCJv74xzfVtOMck@z>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 18.04.2019, 17:20, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A015.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@redhat.com>=
:
> >> =A0> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0>> =A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David Alan Gi=
lbert wrote:
> >> =A0>> =A0> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0>> =A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wr=
ote:
> >> =A0>> =A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=E9" <berrange@r=
edhat.com>:
> >> =A0>> =A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Koto=
v wrote:
> >> =A0>> =A0> > > >> =A015.04.2019, 13:11, "Daniel P. Berrang=E9" <berr=
ange@redhat.com>:
> >> =A0>> =A0> > > >> =A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yur=
y Kotov wrote:
> >> =A0>> =A0> > > >> =A0>> =A0Hi,
> >> =A0>> =A0> > > >> =A0>>
> >> =A0>> =A0> > > >> =A0>> =A0Just to clarify. I see two possible solut=
ions:
> >> =A0>> =A0> > > >> =A0>>
> >> =A0>> =A0> > > >> =A0>> =A01) Since the migration code doesn't recei=
ve fd, it isn't responsible for
> >> =A0>> =A0> > > >> =A0>> =A0closing it. So, it may be better to use m=
igrate_fd_param for both
> >> =A0>> =A0> > > >> =A0>> =A0incoming/outgoing and add dupping for mig=
rate_fd_param. Thus, clients must
> >> =A0>> =A0> > > >> =A0>> =A0close the fd themselves. But existing cli=
ents will have a leak.
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0> We can't break existing clients in this way a=
s they are correctly
> >> =A0>> =A0> > > >> =A0> using the monitor with its current semantics.
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0>> =A02) If we don't duplicate fd, then at leas=
t we should remove fd from
> >> =A0>> =A0> > > >> =A0>> =A0the corresponding list. Therefore, the so=
lution is to fix qemu_close to find
> >> =A0>> =A0> > > >> =A0>> =A0the list and remove fd from it. But qemu_=
close is currently consistent with
> >> =A0>> =A0> > > >> =A0>> =A0qemu_open (which opens/dups fd), so addin=
g additional logic might not be
> >> =A0>> =A0> > > >> =A0>> =A0a very good idea.
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0> qemu_close is not appropriate place to deal w=
ith something speciifc
> >> =A0>> =A0> > > >> =A0> to the montor.
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0>> =A0I don't see any other solution, but I mig=
ht miss something.
> >> =A0>> =A0> > > >> =A0>> =A0What do you think?
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0> All callers of monitor_get_fd() will close() =
the FD they get back.
> >> =A0>> =A0> > > >> =A0> Thus monitor_get_fd() should remove it from t=
he list when it returns
> >> =A0>> =A0> > > >> =A0> it, and we should add API docs to monitor_get=
_fd() to explain this.
> >> =A0>> =A0> > > >> =A0>
> >> =A0>> =A0> > > >> =A0Ok, it sounds reasonable. But monitor_get_fd is=
 only about outgoing migration.
> >> =A0>> =A0> > > >> =A0But what about the incoming migration? It doesn=
't use monitor_get_fd but just
> >> =A0>> =A0> > > >> =A0converts input string to int and use it as fd.
> >> =A0>> =A0> > > >
> >> =A0>> =A0> > > > The incoming migration expects the FD to be passed =
into QEMU by the mgmt
> >> =A0>> =A0> > > > app when it is exec'ing the QEMU binary. It doesn't=
 interact with the
> >> =A0>> =A0> > > > monitor at all AFAIR.
> >> =A0>> =A0> > > >
> >> =A0>> =A0> > >
> >> =A0>> =A0> > > Oh, sorry. This use case is not obvious. We used add-=
fd to pass fd for
> >> =A0>> =A0> > > migrate-incoming and such way has described problems.
> >> =A0>> =A0> >
> >> =A0>> =A0> > That's a bug in your usage of QEMU IMHO, as the incomin=
g code is not
> >> =A0>> =A0> > designed to use add-fd.
> >> =A0>> =A0>
> >> =A0>> =A0> Hmm, that's true - although:
> >> =A0>> =A0> a) It's very non-obvious
> >> =A0>> =A0> b) Unfortunate, since it would go well with -incoming def=
er
> >> =A0>>
> >> =A0>> =A0Yeah I think this is a screw up on QMEU's part when introdu=
cing 'defer'.
> >> =A0>>
> >> =A0>> =A0We should have mandated use of 'add-fd' when using 'defer',=
 since FD
> >> =A0>> =A0inheritance-over-execve() should only be used for command l=
ine args,
> >> =A0>> =A0not monitor commands.
> >> =A0>>
> >> =A0>> =A0Not sure how to best fix this is QEMU though without breaki=
ng back
> >> =A0>> =A0compat for apps using 'defer' already.
> >> =A0>
> >> =A0> We could add mon-fd: transports that has the same behaviour as =
now for
> >> =A0> outgoing, and for incoming uses the add-fd stash.
> >> =A0>
> >>
> >> =A0Oh, I'm sorry again. I think my suggestion about monitor_fd_param=
 wasn't
> >> =A0relevant to this issue. If migrate-incoming + "fd:" + add-fd is a=
n invalid use
> >> =A0case, should we disallow this?
> >> =A0I may add a check to fd_start_incoming_migration if fd is in mon =
fds list.
> >> =A0But I'm afraid there are users like me who are already using this=
 wrong use case.
> >> =A0Because currently nothing in QEMU's docs disallow this.
> >>
> >> =A0So which solution is better in your opinion?
> >> =A01) Disallow fd's from mon fds list in fd_start_incoming_migration
> >
> > I'm surprised anything could be doing that - how would a user know wh=
at
> > the correct fd index was?
> >
>=20
> Hmm, add-fd returns correct fd value. Maybe I din't catch you question.=
..

I don't understand, where does it return it?

> >> =A02) Allow these fds, but dup them or close them correctly
> >
> > I think I'd leave the current (confusing) fd: as it is, maybe put a n=
ote
> > in the manual.
> >
>=20
> So, using fd from fdset will be an undefined behavior, right?

For incoming, yes.

> >> =A0And how to migrate-incoming defer through fd correctly?
> >> =A01) Add "mon-fd:" protocol to work with fds passed by "add-fd/remo=
ve-fd" commands
> >> =A0as suggested by Dave
> >
> > That's my preference; it's explicitly named and consistent, and it
> > doesn't touch the existing fd code.
> >
>=20
> Ok, but please tell me what you think of my suggestion (2) about using =
fd added
> by the "getfd" command for incoming migration. It doesn't requires intr=
oducing
> new protocol and will be consistent with outgoing migration through fd.

I worry how qemu knows whether the command means it comes from the getfd
command or is actually a normal fd like now?
Can you give an example.

Dave

> >
> >> =A02) My suggestion about monitor_fd_param and make "fd:" for
> >> =A0migrate/migrate-incoming consistent. So user will be able to use
> >> =A0getfd + migrate-incoming
> >> =A03) Both of them or something else
> >>
>=20
> Regards,
> Yury
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


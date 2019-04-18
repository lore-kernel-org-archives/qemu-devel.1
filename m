Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F2C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9003E20675
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9003E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH7uR-0000EZ-L8
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 10:21:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH7tY-0008Hz-D2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hH7tW-000146-TE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:20:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hH7tW-00012o-It
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D7EC30B2550;
	Thu, 18 Apr 2019 14:20:04 +0000 (UTC)
Received: from work-vm (ovpn-117-54.ams2.redhat.com [10.36.117.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FAD75C642;
	Thu, 18 Apr 2019 14:19:59 +0000 (UTC)
Date: Thu, 18 Apr 2019 15:19:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190418141956.GF2984@work-vm>
References: <243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 18 Apr 2019 14:20:05 +0000 (UTC)
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
Message-ID: <20190418141956._57tdW2IB6ejZIux_XXE29eEkr3gpqBbflXTkgM5NAU@z>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 15.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David Alan Gilbert =
wrote:
> >> =A0> * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >> =A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wrote:
> >> =A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=E9" <berrange@redhat.=
com>:
> >> =A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Kotov wrot=
e:
> >> =A0> > > >> =A015.04.2019, 13:11, "Daniel P. Berrang=E9" <berrange@r=
edhat.com>:
> >> =A0> > > >> =A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Koto=
v wrote:
> >> =A0> > > >> =A0>> =A0Hi,
> >> =A0> > > >> =A0>>
> >> =A0> > > >> =A0>> =A0Just to clarify. I see two possible solutions:
> >> =A0> > > >> =A0>>
> >> =A0> > > >> =A0>> =A01) Since the migration code doesn't receive fd,=
 it isn't responsible for
> >> =A0> > > >> =A0>> =A0closing it. So, it may be better to use migrate=
_fd_param for both
> >> =A0> > > >> =A0>> =A0incoming/outgoing and add dupping for migrate_f=
d_param. Thus, clients must
> >> =A0> > > >> =A0>> =A0close the fd themselves. But existing clients w=
ill have a leak.
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0> We can't break existing clients in this way as they=
 are correctly
> >> =A0> > > >> =A0> using the monitor with its current semantics.
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0>> =A02) If we don't duplicate fd, then at least we s=
hould remove fd from
> >> =A0> > > >> =A0>> =A0the corresponding list. Therefore, the solution=
 is to fix qemu_close to find
> >> =A0> > > >> =A0>> =A0the list and remove fd from it. But qemu_close =
is currently consistent with
> >> =A0> > > >> =A0>> =A0qemu_open (which opens/dups fd), so adding addi=
tional logic might not be
> >> =A0> > > >> =A0>> =A0a very good idea.
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0> qemu_close is not appropriate place to deal with so=
mething speciifc
> >> =A0> > > >> =A0> to the montor.
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0>> =A0I don't see any other solution, but I might mis=
s something.
> >> =A0> > > >> =A0>> =A0What do you think?
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0> All callers of monitor_get_fd() will close() the FD=
 they get back.
> >> =A0> > > >> =A0> Thus monitor_get_fd() should remove it from the lis=
t when it returns
> >> =A0> > > >> =A0> it, and we should add API docs to monitor_get_fd() =
to explain this.
> >> =A0> > > >> =A0>
> >> =A0> > > >> =A0Ok, it sounds reasonable. But monitor_get_fd is only =
about outgoing migration.
> >> =A0> > > >> =A0But what about the incoming migration? It doesn't use=
 monitor_get_fd but just
> >> =A0> > > >> =A0converts input string to int and use it as fd.
> >> =A0> > > >
> >> =A0> > > > The incoming migration expects the FD to be passed into Q=
EMU by the mgmt
> >> =A0> > > > app when it is exec'ing the QEMU binary. It doesn't inter=
act with the
> >> =A0> > > > monitor at all AFAIR.
> >> =A0> > > >
> >> =A0> > >
> >> =A0> > > Oh, sorry. This use case is not obvious. We used add-fd to =
pass fd for
> >> =A0> > > migrate-incoming and such way has described problems.
> >> =A0> >
> >> =A0> > That's a bug in your usage of QEMU IMHO, as the incoming code=
 is not
> >> =A0> > designed to use add-fd.
> >> =A0>
> >> =A0> Hmm, that's true - although:
> >> =A0> a) It's very non-obvious
> >> =A0> b) Unfortunate, since it would go well with -incoming defer
> >>
> >> =A0Yeah I think this is a screw up on QMEU's part when introducing '=
defer'.
> >>
> >> =A0We should have mandated use of 'add-fd' when using 'defer', since=
 FD
> >> =A0inheritance-over-execve() should only be used for command line ar=
gs,
> >> =A0not monitor commands.
> >>
> >> =A0Not sure how to best fix this is QEMU though without breaking bac=
k
> >> =A0compat for apps using 'defer' already.
> >
> > We could add mon-fd: transports that has the same behaviour as now fo=
r
> > outgoing, and for incoming uses the add-fd stash.
> >
>=20
> Oh, I'm sorry again. I think my suggestion about monitor_fd_param wasn'=
t
> relevant to this issue. If migrate-incoming + "fd:" + add-fd is an inva=
lid use
> case, should we disallow this?
> I may add a check to fd_start_incoming_migration if fd is in mon fds li=
st.
> But I'm afraid there are users like me who are already using this wrong=
 use case.
> Because currently nothing in QEMU's docs disallow this.
>=20
> So which solution is better in your opinion?
> 1) Disallow fd's from mon fds list in fd_start_incoming_migration

I'm surprised anything could be doing that - how would a user know what
the correct fd index was?

> 2) Allow these fds, but dup them or close them correctly

I think I'd leave the current (confusing) fd: as it is, maybe put a note
in the manual.

> And how to migrate-incoming defer through fd correctly?
> 1) Add "mon-fd:" protocol to work with fds passed by "add-fd/remove-fd"=
 commands
> as suggested by Dave

That's my preference; it's explicitly named and consistent, and it
doesn't touch the existing fd code.

Dave

> 2) My suggestion about monitor_fd_param and make "fd:" for
> migrate/migrate-incoming consistent. So user will be able to use
> getfd + migrate-incoming
> 3) Both of them or something else
>=20
> Regards,
> Yury Kotov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


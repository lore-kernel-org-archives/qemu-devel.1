Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5BAC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0906D20818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0906D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFzq1-0005VM-93
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:31:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFzp7-0005Bv-Mg
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFzp6-0000df-Cl
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:30:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hFzp6-0000dA-3B
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 372573086201;
	Mon, 15 Apr 2019 11:30:51 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 645A95D707;
	Mon, 15 Apr 2019 11:30:49 +0000 (UTC)
Date: Mon, 15 Apr 2019 12:30:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190415113045.GI2852@work-vm>
References: <20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415111911.GK5718@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 15 Apr 2019 11:30:51 +0000 (UTC)
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415113046.h3otAmCZCBOffF738maaUDIH3Wf-pt_mPOhnKf4l1UY@z>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wrote:
> > > > 15.04.2019, 13:25, "Daniel P. Berrang=E9" <berrange@redhat.com>:
> > > > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Kotov wrote:
> > > > >> =A015.04.2019, 13:11, "Daniel P. Berrang=E9" <berrange@redhat.=
com>:
> > > > >> =A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrot=
e:
> > > > >> =A0>> =A0Hi,
> > > > >> =A0>>
> > > > >> =A0>> =A0Just to clarify. I see two possible solutions:
> > > > >> =A0>>
> > > > >> =A0>> =A01) Since the migration code doesn't receive fd, it is=
n't responsible for
> > > > >> =A0>> =A0closing it. So, it may be better to use migrate_fd_pa=
ram for both
> > > > >> =A0>> =A0incoming/outgoing and add dupping for migrate_fd_para=
m. Thus, clients must
> > > > >> =A0>> =A0close the fd themselves. But existing clients will ha=
ve a leak.
> > > > >> =A0>
> > > > >> =A0> We can't break existing clients in this way as they are c=
orrectly
> > > > >> =A0> using the monitor with its current semantics.
> > > > >> =A0>
> > > > >> =A0>> =A02) If we don't duplicate fd, then at least we should =
remove fd from
> > > > >> =A0>> =A0the corresponding list. Therefore, the solution is to=
 fix qemu_close to find
> > > > >> =A0>> =A0the list and remove fd from it. But qemu_close is cur=
rently consistent with
> > > > >> =A0>> =A0qemu_open (which opens/dups fd), so adding additional=
 logic might not be
> > > > >> =A0>> =A0a very good idea.
> > > > >> =A0>
> > > > >> =A0> qemu_close is not appropriate place to deal with somethin=
g speciifc
> > > > >> =A0> to the montor.
> > > > >> =A0>
> > > > >> =A0>> =A0I don't see any other solution, but I might miss some=
thing.
> > > > >> =A0>> =A0What do you think?
> > > > >> =A0>
> > > > >> =A0> All callers of monitor_get_fd() will close() the FD they =
get back.
> > > > >> =A0> Thus monitor_get_fd() should remove it from the list when=
 it returns
> > > > >> =A0> it, and we should add API docs to monitor_get_fd() to exp=
lain this.
> > > > >> =A0>
> > > > >> =A0Ok, it sounds reasonable. But monitor_get_fd is only about =
outgoing migration.
> > > > >> =A0But what about the incoming migration? It doesn't use monit=
or_get_fd but just
> > > > >> =A0converts input string to int and use it as fd.
> > > > >
> > > > > The incoming migration expects the FD to be passed into QEMU by=
 the mgmt
> > > > > app when it is exec'ing the QEMU binary. It doesn't interact wi=
th the
> > > > > monitor at all AFAIR.
> > > > >
> > > >=20
> > > > Oh, sorry. This use case is not obvious. We used add-fd to pass f=
d for
> > > > migrate-incoming and such way has described problems.
> > >=20
> > > That's a bug in your usage of QEMU IMHO, as the incoming code is no=
t
> > > designed to use add-fd.
> >=20
> > Hmm, that's true - although:
> >   a) It's very non-obvious
> >   b) Unfortunate, since it would go well with -incoming defer
>=20
> Yeah I think this is a screw up on QMEU's part when introducing 'defer'=
.
>=20
> We should have mandated use of 'add-fd' when using 'defer', since FD
> inheritance-over-execve() should only be used for command line args,
> not monitor commands.
>=20
> Not sure how to best fix this is QEMU though without breaking back
> compat for apps using 'defer' already.

We could add mon-fd: transports that has the same behaviour as now for
outgoing, and for incoming uses the add-fd stash.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


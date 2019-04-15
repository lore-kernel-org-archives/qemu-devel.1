Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A9C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8092073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8092073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFzas-0001Dp-J7
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:16:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFza3-0000ok-Fj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFza2-0008I8-AM
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hFza2-0008Hv-12
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77B8730832C9;
	Mon, 15 Apr 2019 11:15:16 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4BB219C4F;
	Mon, 15 Apr 2019 11:15:14 +0000 (UTC)
Date: Mon, 15 Apr 2019 12:15:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190415111511.GG2852@work-vm>
References: <20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415104725.GI5718@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 15 Apr 2019 11:15:16 +0000 (UTC)
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
Message-ID: <20190415111512.8kGDSA4DF8fN8iCpZ6UoeL3-LfHy4ROwAK3u6r7NmLY@z>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wrote:
> > 15.04.2019, 13:25, "Daniel P. Berrang=E9" <berrange@redhat.com>:
> > > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Kotov wrote:
> > >> =A015.04.2019, 13:11, "Daniel P. Berrang=E9" <berrange@redhat.com>=
:
> > >> =A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
> > >> =A0>> =A0Hi,
> > >> =A0>>
> > >> =A0>> =A0Just to clarify. I see two possible solutions:
> > >> =A0>>
> > >> =A0>> =A01) Since the migration code doesn't receive fd, it isn't =
responsible for
> > >> =A0>> =A0closing it. So, it may be better to use migrate_fd_param =
for both
> > >> =A0>> =A0incoming/outgoing and add dupping for migrate_fd_param. T=
hus, clients must
> > >> =A0>> =A0close the fd themselves. But existing clients will have a=
 leak.
> > >> =A0>
> > >> =A0> We can't break existing clients in this way as they are corre=
ctly
> > >> =A0> using the monitor with its current semantics.
> > >> =A0>
> > >> =A0>> =A02) If we don't duplicate fd, then at least we should remo=
ve fd from
> > >> =A0>> =A0the corresponding list. Therefore, the solution is to fix=
 qemu_close to find
> > >> =A0>> =A0the list and remove fd from it. But qemu_close is current=
ly consistent with
> > >> =A0>> =A0qemu_open (which opens/dups fd), so adding additional log=
ic might not be
> > >> =A0>> =A0a very good idea.
> > >> =A0>
> > >> =A0> qemu_close is not appropriate place to deal with something sp=
eciifc
> > >> =A0> to the montor.
> > >> =A0>
> > >> =A0>> =A0I don't see any other solution, but I might miss somethin=
g.
> > >> =A0>> =A0What do you think?
> > >> =A0>
> > >> =A0> All callers of monitor_get_fd() will close() the FD they get =
back.
> > >> =A0> Thus monitor_get_fd() should remove it from the list when it =
returns
> > >> =A0> it, and we should add API docs to monitor_get_fd() to explain=
 this.
> > >> =A0>
> > >> =A0Ok, it sounds reasonable. But monitor_get_fd is only about outg=
oing migration.
> > >> =A0But what about the incoming migration? It doesn't use monitor_g=
et_fd but just
> > >> =A0converts input string to int and use it as fd.
> > >
> > > The incoming migration expects the FD to be passed into QEMU by the=
 mgmt
> > > app when it is exec'ing the QEMU binary. It doesn't interact with t=
he
> > > monitor at all AFAIR.
> > >
> >=20
> > Oh, sorry. This use case is not obvious. We used add-fd to pass fd fo=
r
> > migrate-incoming and such way has described problems.
>=20
> That's a bug in your usage of QEMU IMHO, as the incoming code is not
> designed to use add-fd.

Hmm, that's true - although:
  a) It's very non-obvious
  b) Unfortunate, since it would go well with -incoming defer

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


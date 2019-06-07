Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B30C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D823D20840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D823D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGvh-0007um-4i
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hZG1j-0001VC-U5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hZFtw-0006Ki-Ic
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hZFtp-00067K-Ca; Fri, 07 Jun 2019 10:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0F09C18B2D1;
 Fri,  7 Jun 2019 14:31:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 649CF5F595;
 Fri,  7 Jun 2019 14:31:05 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:31:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607143102.GL28838@redhat.com>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607140357.GK28838@redhat.com>
 <20190607142514.GE5055@dhcp-200-226.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607142514.GE5055@dhcp-200-226.str.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 14:31:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 00/10] monitor: Split monitor.c in
 core/HMP/QMP/misc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 04:25:14PM +0200, Kevin Wolf wrote:
> Am 07.06.2019 um 16:03 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Fri, Jun 07, 2019 at 03:54:20PM +0200, Kevin Wolf wrote:
> > > monitor.c mixes a lot of different things in a single file: The cor=
e
> > > monitor infrastructure, HMP infrastrcture, QMP infrastructure, and =
the
> > > implementation of several HMP and QMP commands. Almost worse, struc=
t
> > > Monitor mixes state for HMP, for QMP, and state actually shared bet=
ween
> > > all monitors. monitor.c must be linked with a system emulator and e=
ven
> > > requires per-target compilation because some of the commands it
> > > implements access system emulator state.
> > >=20
> > > The reason why I care about this is that I'm working on a protoype =
for a
> > > storage daemon, which wants to use QMP (but probably not HMP) and
> > > obviously doesn't have any system emulator state. So I'm interested=
 in
> > > some core monitor parts that can be linked to non-system-emulator t=
ools.
> > >=20
> > > This series first creates separate structs MonitorQMP and MonitorHM=
P
> > > which inherit from Monitor, and then moves the associated infrastru=
cture
> > > code into separate source files.
> > >=20
> > > While the split is probably not perfect, I think it's an improvemen=
t of
> > > the current state even for QEMU proper, and it's good enough so I c=
an
> > > link my storage daemon against just monitor/core.o and monitor/qmp.=
o and
> > > get a useless QMP monitor that parses the JSON input and rejects
> > > everything as an unknown command.
> > >=20
> > > Next I'll try to teach it a subset of QMP commands that can actuall=
y be
> > > supported in a tool, but while there will be a few follow-up patche=
s to
> > > achieve this, I don't expect that this work will bring up much that
> > > needs to be changed in the splitting process done in this series.
> > >=20
> > > Kevin Wolf (10):
> > >   monitor: Remove unused password prompting fields
> > >   monitor: Split monitor_init in HMP and QMP function
> > >   monitor: Make MonitorQMP a child class of Monitor
> > >   monitor: Create MonitorHMP with readline state
> > >   monitor: Move cmd_table to MonitorHMP
> > >   Move monitor.c to monitor/misc.c
> > >   monitor: Create monitor_int.h with common definitions
> > >   monitor: Split out monitor/qmp.c
> > >   monitor: Split out monitor/hmp.c
> > >   monitor: Split out monitor/core.c
> > >=20
> > >  include/monitor/monitor.h |    8 +-
> > >  monitor/monitor_int.h     |  207 ++
> > >  hmp.c                     |    4 +-
> > >  monitor.c                 | 4727 ---------------------------------=
----
> > >  monitor/core.c            |  604 +++++
> > >  monitor/hmp.c             | 1351 +++++++++++
> > >  monitor/misc.c            | 2406 +++++++++++++++++++
> > >  monitor/qmp.c             |  404 ++++
> > >  Makefile.objs             |    1 +
> > >  Makefile.target           |    3 +-
> > >  monitor/Makefile.objs     |    2 +
> >=20
> > It will be nice to have the monitor code split up a bit more.
> >=20
> > I'm not a fan, however, of having both $ROOT/qmp.c and $ROOT/monitor/=
qmp.c
> > Likwise  $ROOT/hmp.c and $ROOT/monitor/hmp.c.  Can we move those othe=
r
> > existing files out of the root dir, into monitor/, so we don't have t=
wo
> > files with the same name in different dirs.
>=20
> $ROOT/hmp.c and $ROOT/qmp.c contain various command implementations,
> just as $ROOT/monitor/misc.c. This is still a bit of a mess. I'll have
> to address this at least partially in the next step because I need to
> separate commands that can be linked with tools from those that require
> a system emulator.
>=20
> My plan involves at least creating some monitor/qmp-cmds-*.c, which
> might already make $ROOT/qmp.c empty. Even though I don't strictly need
> it, there's no reason not to do the same for HMP, too. In any case, I'd
> rather address this in a separate follow-up series.

Ok, if you have a plan for this, that's fine with me.

> But if people prefer, I can move the existing files in the root
> directory to monitor/{qmp,hmp}-cmds.c temporarily in this series and
> then work from there with follow-ups until they are empty (or maybe I
> don't even have to make them completely empty then).

A plain rename like this won't hurt in the meantime.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B3C206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B3C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BJU-0003rK-7Q
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1BHH-0002ay-1v
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1BHF-0003x4-Cd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1BHF-0003wh-2m
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:14:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DE51302C06D;
 Fri, 23 Aug 2019 15:14:56 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B268600F8;
 Fri, 23 Aug 2019 15:14:51 +0000 (UTC)
Date: Fri, 23 Aug 2019 16:14:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190823151448.GL2784@work-vm>
References: <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
 <20190823140948.GI2784@work-vm> <20190823142054.GK9654@redhat.com>
 <20190823142602.GJ2784@work-vm> <20190823144052.GL9654@redhat.com>
 <20190823145634.GK2784@work-vm> <20190823150508.GM9654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190823150508.GM9654@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 23 Aug 2019 15:14:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Aug 23, 2019 at 03:56:34PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Fri, Aug 23, 2019 at 03:26:02PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > > On Fri, Aug 23, 2019 at 03:09:48PM +0100, Dr. David Alan Gilber=
t wrote:
> > > > > > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > > > > Hi
> > > > > > >=20
> > > > > > > On Fri, Aug 23, 2019 at 5:00 PM Dr. David Alan Gilbert
> > > > > > > <dgilbert@redhat.com> wrote:
> > > > > > > >
> > > > > > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > > > > >
> > > > > > > > <snip>
> > > > > > > >
> > > > > > > > > This means QEMU still has to iterate over every single =
client
> > > > > > > > > on the bus to identify them. If you're doing that, ther=
e's
> > > > > > > > > no point in owning a well known service at all. Just it=
erate
> > > > > > > > > over the unique bus names and look for the exported obj=
ect
> > > > > > > > > path /org/qemu/VMState
> > > > > > > > >
> > > > > > > >
> > > > > > > > Not knowing anything about DBus security, I want to ask h=
ow do
> > > > > > > > we handle security here?
> > > > > > >=20
> > > > > > > First of all, we are talking about cooperative processes, a=
nd having a
> > > > > > > specific bus for each qemu instance. So some amount of secu=
rity/trust
> > > > > > > is already assumed.
> > > > > >=20
> > > > > > Some but we need to keep it as limited as possible; for examp=
le two
> > > > > > reasons for having separate processes both come down to secur=
ity:
> > > > > >=20
> > > > > >   a) vtpm - however screwy the qemu is, you can never get to =
the keys in
> > > > > > the vtpm
> > > > >=20
> > > > > Processes connected to dbus can only call the DBus APIs that vt=
pm
> > > > > actually exports.  The vtpm should simply *not* export a DBus
> > > > > API that allows anything to fetch the keys.
> > > > >=20
> > > > > If it did want to export APIs for fetching keys, then we would
> > > > > have to ensure suitable dbus /selinux policy was created to
> > > > > prevent unwarranted access.
> > > >=20
> > > > This was really just one example of where the security/trust isn'=
t
> > > > assumed; however a more concrete case is migration of a vtpm, and=
 even
> > > > though it's probably encrypted blob you still don't want some oth=
er
> > > > device to grab the migration data - or to say reinitialise the vt=
pm.
> > >=20
> > > That can be dealt with by the dbus security policies, provided
> > > you either run the vtpm as a different user ID from the other
> > > untrustworthy helpers, or use a different selinux context for
> > > vtpm. You can then express that only the user that QEMU is
> > > running under can talk to vtpm over dbus.
> >=20
> > The need for the extra user ID or selinux context is a pain;
> > but probably warranted for the vTPM;  in general though some of this
> > exists because of the choice of DBus and wouldn't be a problem for
> > something that had a point-to-point socket it sent everything over.
>=20
> NB be careful to use s/DBus/DBus bus/
>=20
> DBus the protocol is fine to be used in a point-to-point socket
> scenario - the use of the bus is strictly optional.
>=20
> If all communication we expect is exclusively  Helper <-> QEMU,
> then I'd argue in favour of dbus in point-to-point mode.
>=20
> The use cases Stefan brought up for virtiofsd though is what
> I think brings the idea of using the bus relevant. It is the
> desire to allow online control/mgmt of the helper, which
> introduces a 3rd party which isn't QEMU. Instead either libvirt
> or a standalone admin/debugging tool. With multiple parties
> involved I think the bus becomes relevant
>=20
> With p2p mode you could have 2 dbus socket for Helper <-> QEMU
> and another dbus socket for Helper <-> libvirt/debugging, but
> this isn't an obvious security win over using the bus, as you
> now need different access rules for each of the p2p sockets
> to say who can connect to which socket.=20

Right; point-2-point doesn't worry me much as long as we're careful;
it's now we're suddenly proposing something much more general that
I think we need to start being really careful.

> > > Where I think you could have problems is if you needed finer
> > > grainer control with selinux. eg if vstpm exports 2 different
> > > services, you can't allow access to one service, but forbid
> > > access to the other service.
> > >=20
> > > > > >   b) virtio-gpu, loads of complex GPU code that can't break t=
he main
> > > > > > qemu process.
> > > > >=20
> > > > > That's no problem - virtio-gpu crashes, it disappears from the =
dbus
> > > > > bus, but everything else keeps running.
> > > >=20
> > > > Crashing is the easy case; assume it's malicious and you don't wa=
nt it
> > > > getting to say a storage device provided by another vhost-user de=
vice.
> > >=20
> > > If we assume that the 2 processes can't commnuicate / access each
> > > other outside DBus, then the attack avenues added by use of dbus
> > > are most likely either:
> > >=20
> > >  - invoking some DBus method that should not be allowed due
> > >    to incomplete dbus security policy.=20
> > >=20
> > >  - finding a crash in a dbus client library that you can somehow
> > >    exploit to get remote code execution in the separate process
> > >=20
> > >    I won't claim this is impossible, but I think it helps to be
> > >    using a standard, widely used battle tested RPC impl, rather
> > >    than a home grown RPC protocol.
> >=20
> > It's only the policy case I worry about; and my point here is if we
> > decide to use dbus then we have to think properly about security and
> > defined stuff.
> >=20
> > >=20
> > >=20
> > > > > > > But if necessary, dbus can enforce policies on who is allow=
ed to own a
> > > > > > > name, or to send/receive message from. As far as I know, th=
is is
> > > > > > > mostly user/group policies.
> > > > > > >=20
> > > > > > > But there is also SELinux checks to send_msg and acquire_sv=
c (see
> > > > > > > dbus-daemon(1))
> > > > > >=20
> > > > > > But how does something like SELinux interact with a private d=
bus=20
> > > > > > rather than the system dbus?
> > > > >=20
> > > > > There's already two dbus-daemon's on each host - the system one=
 and
> > > > > the session one, and they get different selinux contexts,
> > > > > system_dbus_t and unconfined_dbus_t.
> > > > >=20
> > > > > Since libvirt would be responsible for launching these private =
dbus
> > > > > daemons it would be easy to make it run  svirt_dbus_t for examp=
le.
> > > > > Actually it would be  svirt_dbus_t:s0:cNNN,cMMM to get uniquene=
ss
> > > > > per VM.
> > > > >=20
> > > > > Will of course require us to talk to the SELinux maintainers to
> > > > > get some sensible policy rules created.
> > > >=20
> > > > This all relies on SELinux and running privileged qemu/vhost-user=
 pairs;
> > > > needing to do that purely to enforce security seems wrong.
> > >=20
> > > Compare to an alternative bus-less solution where each helper has
> > > a direct UNIX socket connection to QEMU.
> > >=20
> > > If two helpers are running as the same user ID, then can still
> > > directly attack each other via things like ptrace or /proc/$PID/mem=
,
> > > unless you've used SELinux to isolate them, or run each as a distin=
ct
> > > user ID.  If you do the latter, then we can still easily isolate
> > > them using dbus.
> >=20
> > You can lock those down pretty easily though.
>=20
> How were you thinking ?
>=20
> If you're not using SELinux or separate user IDs, then AFAICT you've
> got a choice of using seccomp or containers.  seccomp is really hard
> to get a useful policy out of with QEMU, and using containers for
> each helper process adds a level of complexity worse than selinux
> or separate user IDs, so isn't an obvious win over using dbus.

You can just drop the CAP_SYS_PTRACE on the whole lot for that;
I thought there was something for /proc/.../mem as well.

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


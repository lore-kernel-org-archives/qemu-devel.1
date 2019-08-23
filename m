Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E8AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357E720870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357E720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B38-0003pq-1R
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1Azb-0000Fu-LW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1Aza-0001RN-0i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1AzZ-0001RA-Od
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33C54881362;
 Fri, 23 Aug 2019 14:56:41 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 216F02632E;
 Fri, 23 Aug 2019 14:56:36 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:56:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190823145634.GK2784@work-vm>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
 <20190823140948.GI2784@work-vm> <20190823142054.GK9654@redhat.com>
 <20190823142602.GJ2784@work-vm> <20190823144052.GL9654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190823144052.GL9654@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 23 Aug 2019 14:56:41 +0000 (UTC)
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
> On Fri, Aug 23, 2019 at 03:26:02PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Fri, Aug 23, 2019 at 03:09:48PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > > Hi
> > > > >=20
> > > > > On Fri, Aug 23, 2019 at 5:00 PM Dr. David Alan Gilbert
> > > > > <dgilbert@redhat.com> wrote:
> > > > > >
> > > > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > > >
> > > > > > <snip>
> > > > > >
> > > > > > > This means QEMU still has to iterate over every single clie=
nt
> > > > > > > on the bus to identify them. If you're doing that, there's
> > > > > > > no point in owning a well known service at all. Just iterat=
e
> > > > > > > over the unique bus names and look for the exported object
> > > > > > > path /org/qemu/VMState
> > > > > > >
> > > > > >
> > > > > > Not knowing anything about DBus security, I want to ask how d=
o
> > > > > > we handle security here?
> > > > >=20
> > > > > First of all, we are talking about cooperative processes, and h=
aving a
> > > > > specific bus for each qemu instance. So some amount of security=
/trust
> > > > > is already assumed.
> > > >=20
> > > > Some but we need to keep it as limited as possible; for example t=
wo
> > > > reasons for having separate processes both come down to security:
> > > >=20
> > > >   a) vtpm - however screwy the qemu is, you can never get to the =
keys in
> > > > the vtpm
> > >=20
> > > Processes connected to dbus can only call the DBus APIs that vtpm
> > > actually exports.  The vtpm should simply *not* export a DBus
> > > API that allows anything to fetch the keys.
> > >=20
> > > If it did want to export APIs for fetching keys, then we would
> > > have to ensure suitable dbus /selinux policy was created to
> > > prevent unwarranted access.
> >=20
> > This was really just one example of where the security/trust isn't
> > assumed; however a more concrete case is migration of a vtpm, and eve=
n
> > though it's probably encrypted blob you still don't want some other
> > device to grab the migration data - or to say reinitialise the vtpm.
>=20
> That can be dealt with by the dbus security policies, provided
> you either run the vtpm as a different user ID from the other
> untrustworthy helpers, or use a different selinux context for
> vtpm. You can then express that only the user that QEMU is
> running under can talk to vtpm over dbus.

The need for the extra user ID or selinux context is a pain;
but probably warranted for the vTPM;  in general though some of this
exists because of the choice of DBus and wouldn't be a problem for
something that had a point-to-point socket it sent everything over.

> Where I think you could have problems is if you needed finer
> grainer control with selinux. eg if vstpm exports 2 different
> services, you can't allow access to one service, but forbid
> access to the other service.
>=20
> > > >   b) virtio-gpu, loads of complex GPU code that can't break the m=
ain
> > > > qemu process.
> > >=20
> > > That's no problem - virtio-gpu crashes, it disappears from the dbus
> > > bus, but everything else keeps running.
> >=20
> > Crashing is the easy case; assume it's malicious and you don't want i=
t
> > getting to say a storage device provided by another vhost-user device=
.
>=20
> If we assume that the 2 processes can't commnuicate / access each
> other outside DBus, then the attack avenues added by use of dbus
> are most likely either:
>=20
>  - invoking some DBus method that should not be allowed due
>    to incomplete dbus security policy.=20
>=20
>  - finding a crash in a dbus client library that you can somehow
>    exploit to get remote code execution in the separate process
>=20
>    I won't claim this is impossible, but I think it helps to be
>    using a standard, widely used battle tested RPC impl, rather
>    than a home grown RPC protocol.

It's only the policy case I worry about; and my point here is if we
decide to use dbus then we have to think properly about security and
defined stuff.

>=20
>=20
> > > > > But if necessary, dbus can enforce policies on who is allowed t=
o own a
> > > > > name, or to send/receive message from. As far as I know, this i=
s
> > > > > mostly user/group policies.
> > > > >=20
> > > > > But there is also SELinux checks to send_msg and acquire_svc (s=
ee
> > > > > dbus-daemon(1))
> > > >=20
> > > > But how does something like SELinux interact with a private dbus=20
> > > > rather than the system dbus?
> > >=20
> > > There's already two dbus-daemon's on each host - the system one and
> > > the session one, and they get different selinux contexts,
> > > system_dbus_t and unconfined_dbus_t.
> > >=20
> > > Since libvirt would be responsible for launching these private dbus
> > > daemons it would be easy to make it run  svirt_dbus_t for example.
> > > Actually it would be  svirt_dbus_t:s0:cNNN,cMMM to get uniqueness
> > > per VM.
> > >=20
> > > Will of course require us to talk to the SELinux maintainers to
> > > get some sensible policy rules created.
> >=20
> > This all relies on SELinux and running privileged qemu/vhost-user pai=
rs;
> > needing to do that purely to enforce security seems wrong.
>=20
> Compare to an alternative bus-less solution where each helper has
> a direct UNIX socket connection to QEMU.
>=20
> If two helpers are running as the same user ID, then can still
> directly attack each other via things like ptrace or /proc/$PID/mem,
> unless you've used SELinux to isolate them, or run each as a distinct
> user ID.  If you do the latter, then we can still easily isolate
> them using dbus.

You can lock those down pretty easily though.

Dave

>=20
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


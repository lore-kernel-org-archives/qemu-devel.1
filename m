Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF9AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C886E2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C886E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AHw-0006Jz-3K
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1AGN-0004dC-Kd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1AGM-0003ec-A5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1AGM-0003eO-2j
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DCD12CE905;
 Fri, 23 Aug 2019 14:09:57 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EC841C92A;
 Fri, 23 Aug 2019 14:09:50 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:09:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190823140948.GI2784@work-vm>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 23 Aug 2019 14:09:57 +0000 (UTC)
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Fri, Aug 23, 2019 at 5:00 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> >
> > <snip>
> >
> > > This means QEMU still has to iterate over every single client
> > > on the bus to identify them. If you're doing that, there's
> > > no point in owning a well known service at all. Just iterate
> > > over the unique bus names and look for the exported object
> > > path /org/qemu/VMState
> > >
> >
> > Not knowing anything about DBus security, I want to ask how do
> > we handle security here?
>=20
> First of all, we are talking about cooperative processes, and having a
> specific bus for each qemu instance. So some amount of security/trust
> is already assumed.

Some but we need to keep it as limited as possible; for example two
reasons for having separate processes both come down to security:

  a) vtpm - however screwy the qemu is, you can never get to the keys in
the vtpm

  b) virtio-gpu, loads of complex GPU code that can't break the main
qemu process.

> But if necessary, dbus can enforce policies on who is allowed to own a
> name, or to send/receive message from. As far as I know, this is
> mostly user/group policies.
>=20
> But there is also SELinux checks to send_msg and acquire_svc (see
> dbus-daemon(1))

But how does something like SELinux interact with a private dbus=20
rather than the system dbus?

> >
> > I want to know that the external device that's giving me migration da=
ta
> > is the device I think I'm speaking to, not one of the other devices;
>=20
> DBus is not the problem nor the solution here.

Well, if the migration data was squirting down the existing vhost-user
channel then there would be no risk here; so the use of dbus is creating
the problem.

> But what defines that device-service strong relationship? Can you
> generalize it? I don't think so.
>=20
> What DBus can guarantee is that the unique-id you are talking to is
> always the same connection (thus the same process).
>=20
> > I also dont want different devices chatting to each other over dbus
> > unless we're very careful.
>=20
> That's a bus policy job.

OK, as long as you somehow set it up.

Dave

> >
> > Dave
> >
> > > Regards,
> > > Daniel
> > > --
> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/d=
berrange :|
> > > |: https://libvirt.org         -o-            https://fstop138.berr=
ange.com :|
> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/d=
berrange :|
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1FEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8440C2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8440C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AGs-0005A2-H8
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i1AG1-0004Ty-O8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i1AG0-0003Yn-9D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i1AG0-0003YJ-3I
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:09:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0370FC044CDE;
 Fri, 23 Aug 2019 14:09:34 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5077D1001938;
 Fri, 23 Aug 2019 14:09:29 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:09:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190823140926.GI9654@redhat.com>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 23 Aug 2019 14:09:34 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 05:48:37PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Aug 23, 2019 at 5:00 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
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
>=20
> But if necessary, dbus can enforce policies on who is allowed to own a
> name, or to send/receive message from. As far as I know, this is
> mostly user/group policies.

Yep, the bulk of dbus policy restrictions are tied to user/groups.
After all, if two processes are under the same user ID, in general
any restrictions dbus tried to place on them are worthless as they
can simply attack each other outside dbus.

Running helpers as different UID from QEMU itself makes sense.

Running every single helper as a distinct UID is likely unmanagably
complex - especially if the helpers need certain privileges to
do their job.

> But there is also SELinux checks to send_msg and acquire_svc (see
> dbus-daemon(1))

SELinux gives us more fine grained control.

For example, consider each vhost user helper process

   "virtiofs_t"=20

and QEMU is "svirt_t"

You can write a rule which says  svirt_t can send messages
to virtiofs_t, which allows QEMU to talk to the helpers.

Two helper processes both running "virtiofs_t" will, however,
not be able to talk to each other.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


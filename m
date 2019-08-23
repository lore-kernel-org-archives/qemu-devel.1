Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81222133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81222133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BOe-0007Xs-Tt
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i1BNs-0006xy-At
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i1BNr-0007EE-8d
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:21:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i1BNr-0007Dr-3g
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:21:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2056630A5A70;
 Fri, 23 Aug 2019 15:21:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6CCA5D9CA;
 Fri, 23 Aug 2019 15:21:40 +0000 (UTC)
Date: Fri, 23 Aug 2019 16:21:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190823152137.GN9654@redhat.com>
References: <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
 <20190823140948.GI2784@work-vm> <20190823142054.GK9654@redhat.com>
 <20190823142602.GJ2784@work-vm> <20190823144052.GL9654@redhat.com>
 <20190823145634.GK2784@work-vm> <20190823150508.GM9654@redhat.com>
 <20190823151448.GL2784@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190823151448.GL2784@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 15:21:46 +0000 (UTC)
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 04:14:48PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Fri, Aug 23, 2019 at 03:56:34PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > If two helpers are running as the same user ID, then can still
> > > > directly attack each other via things like ptrace or /proc/$PID/m=
em,
> > > > unless you've used SELinux to isolate them, or run each as a dist=
inct
> > > > user ID.  If you do the latter, then we can still easily isolate
> > > > them using dbus.
> > >=20
> > > You can lock those down pretty easily though.
> >=20
> > How were you thinking ?
> >=20
> > If you're not using SELinux or separate user IDs, then AFAICT you've
> > got a choice of using seccomp or containers.  seccomp is really hard
> > to get a useful policy out of with QEMU, and using containers for
> > each helper process adds a level of complexity worse than selinux
> > or separate user IDs, so isn't an obvious win over using dbus.
>=20
> You can just drop the CAP_SYS_PTRACE on the whole lot for that;
> I thought there was something for /proc/.../mem as well.

If they're running the same user ID & not SELinux constrained, I don't
think that trying to block PRACTE / /proc/$PID/mem offers a reassuring
level of security separation, as there's still plenty of other files
that will be readable & writable to both vhostuser helper daemons which
can be leveraged as indirect attack vectors - auditing both helpers and
every library they link to to ensure nothing can be exploited is very
hard.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


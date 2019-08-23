Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11518C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94D32133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94D32133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BW9-0007Dy-Jk
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1BQt-0001c7-8o
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1BQr-000061-Mx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1BQr-00005Y-HF
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2AE23081CF6;
 Fri, 23 Aug 2019 15:24:52 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 876436E706;
 Fri, 23 Aug 2019 15:24:47 +0000 (UTC)
Date: Fri, 23 Aug 2019 16:24:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190823152445.GM2784@work-vm>
References: <20190823130014.GG2784@work-vm>
 <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
 <20190823140948.GI2784@work-vm> <20190823142054.GK9654@redhat.com>
 <20190823142602.GJ2784@work-vm> <20190823144052.GL9654@redhat.com>
 <20190823145634.GK2784@work-vm> <20190823150508.GM9654@redhat.com>
 <20190823151448.GL2784@work-vm> <20190823152137.GN9654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190823152137.GN9654@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 23 Aug 2019 15:24:52 +0000 (UTC)
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
> On Fri, Aug 23, 2019 at 04:14:48PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Fri, Aug 23, 2019 at 03:56:34PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > > > If two helpers are running as the same user ID, then can still
> > > > > directly attack each other via things like ptrace or /proc/$PID=
/mem,
> > > > > unless you've used SELinux to isolate them, or run each as a di=
stinct
> > > > > user ID.  If you do the latter, then we can still easily isolat=
e
> > > > > them using dbus.
> > > >=20
> > > > You can lock those down pretty easily though.
> > >=20
> > > How were you thinking ?
> > >=20
> > > If you're not using SELinux or separate user IDs, then AFAICT you'v=
e
> > > got a choice of using seccomp or containers.  seccomp is really har=
d
> > > to get a useful policy out of with QEMU, and using containers for
> > > each helper process adds a level of complexity worse than selinux
> > > or separate user IDs, so isn't an obvious win over using dbus.
> >=20
> > You can just drop the CAP_SYS_PTRACE on the whole lot for that;
> > I thought there was something for /proc/.../mem as well.
>=20
> If they're running the same user ID & not SELinux constrained, I don't
> think that trying to block PRACTE / /proc/$PID/mem offers a reassuring
> level of security separation, as there's still plenty of other files
> that will be readable & writable to both vhostuser helper daemons which
> can be leveraged as indirect attack vectors - auditing both helpers and
> every library they link to to ensure nothing can be exploited is very
> hard.

Still, it doesn't mean we shouldn't be careful about anything new we
add.

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


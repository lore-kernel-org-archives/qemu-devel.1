Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A3C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF940206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O652rZcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF940206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2brX-0007iT-1C
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j2bqb-0006jd-BD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j2bqZ-00046B-QV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:21:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j2bqZ-00043j-MI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690091;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+G2+zJhbEi81mUOxVr5LUvYYSTLIK/6AKr99X/arHY=;
 b=O652rZcqknxAnhK0cEv5fXFN7qRhadK3dXeuqGHpG32Byxb/ZO8oqKHJjPRlQswMsk7DvN
 2jjDki+OFHsgQdrUy73E/+8pI65w62LfvAM+FkZtEVrSm2oZDt16W9LNb6bGBQh89v7B1J
 2x8FvdxSXzFvqKWoXLCThzqv1uxf+XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-kQFKjD_oPhKm3lf5jitWfw-1; Fri, 14 Feb 2020 09:21:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB524DBF0;
 Fri, 14 Feb 2020 14:21:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A2E8477C;
 Fri, 14 Feb 2020 14:21:14 +0000 (UTC)
Date: Fri, 14 Feb 2020 14:21:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: docs: Update vhost-user spec regarding backend program conventions
Message-ID: <20200214142112.GD613610@redhat.com>
References: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
 <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
 <98d72096ad005ecfd5861e4f8f74a9c503e976b2.camel@intel.com>
 <CAMxuvaztAsaXeGeuMp=mhq3BC7cRLbQh+6d9a2RuZ59DU9U5_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMxuvaztAsaXeGeuMp=mhq3BC7cRLbQh+6d9a2RuZ59DU9U5_g@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kQFKjD_oPhKm3lf5jitWfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 03:00:34PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 14, 2020 at 2:24 PM Boeuf, Sebastien
> <sebastien.boeuf@intel.com> wrote:
> >
> > Hi Marc-Andre,
> >
> > On Tue, 2020-02-11 at 22:24 +0100, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi
> > >
> > > On Tue, Feb 11, 2020 at 4:24 PM Boeuf, Sebastien
> > > <sebastien.boeuf@intel.com> wrote:
> > > > From c073d528b8cd7082832fd1825dc33dd65b305aa2 Mon Sep 17 00:00:00
> > > > 2001
> > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > Date: Tue, 11 Feb 2020 16:01:22 +0100
> > > > Subject: [PATCH] docs: Update vhost-user spec regarding backend
> > > > program
> > > >  conventions
> > > >
> > > > The vhost-user specification is not clearly stating the expected
> > > > behavior from a backend program whenever the client disconnects.
> > > >
> > > > This patch addresses the issue by defining the default behavior and
> > > > proposing an alternative through a command line option.
> > > >
> > > > By default, a backend program will have to keep listening even if
> > > > the
> > > > client disconnects, unless told otherwise through the newly
> > > > introduced
> > > > option --exit-on-disconnect.
> > > >
> > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  docs/interop/vhost-user.rst | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-
> > > > user.rst
> > > > index 5f8b3a456b..da9a1ebc4c 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -1323,6 +1323,10 @@ The backend program must end (as quickly and
> > > > cleanly as possible) when
> > > >  the SIGTERM signal is received. Eventually, it may receive SIGKILL
> > > > by
> > > >  the management layer after a few seconds.
> > > >
> > > > +By default, the backend program continues running after the client
> > > > +disconnects. It accepts only 1 connection at a time on each UNIX
> > > > domain
> > > > +socket.
> > >
> > > I don't think that's the most common behaviour. libvhost-user will
> > > panic() on disconnect in general, unless the error/exit is handled
> > > gracefully by the backend.
> >
> > It's not the default behavior from libvhost-user, but that's exactly
> > something I'd like to see changing. This should be the normal case if
> > you think about a standard client/server connection, where the server
> > would simply listen again after the client disconnects.
>=20
> I disagree, a "normal" lifecycle is a single connection & instance per de=
vice.
>=20
> Having the backend handle multiple connections is needlessly more
> complicated. You need to correctly handle multiple states, flushed
> anything private between connections etc. It should be optional.
>=20
>=20
> > >
> > > The most common case is to have 1-1 relation between device/qemu
> > > instance and backend.
> >
> > Yes this part is fine, but that's not a reason why the backend should
> > terminates.
>=20
> It is simpler to ensure it is reset correctly.
>=20
> >
> > >
> > > Why not restart the backend for another instance?
> >
> > Because you need some management tool to do so. And I think that by
> > default it could be interesting to have the least amount of extra
> > management involved.
>=20
> The management layer should be involved if any side crashes or restart an=
yway.

Further, this vhost-user.rst spec document is explicitly describing
the contract between the vhost-user binaries and the management
layer. So it doesn't make sense to say update this doc to describe
desired semantics for usage /without/ a management layer.

So I agree, the default behaviour should be that there is one binary
spawned at time the associated device is initialization, and that
the lifetime of the binary is 1:1 associated with the lifetime of
the VM, or until the device is unplugged.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



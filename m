Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725EC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B3F2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B3F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrTC-0007vy-5X
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hcrRN-0006ld-MT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hcrRM-0002ZX-8O
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hcrRL-0002Yq-Oh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:12:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFC41307F5FF;
 Mon, 17 Jun 2019 13:12:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C710B8BE26;
 Mon, 17 Jun 2019 13:12:41 +0000 (UTC)
Date: Mon, 17 Jun 2019 14:12:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190617131239.GC3380@redhat.com>
References: <20190617114005.24603-1-berrange@redhat.com>
 <bad5a34e-509e-3f55-e2fe-17d28681d6fe@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bad5a34e-509e-3f55-e2fe-17d28681d6fe@vivier.eu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 17 Jun 2019 13:12:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix includes to find
 SIOCGSTAMP with latest kernel headers
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 01:47:48PM +0200, Laurent Vivier wrote:
> Le 17/06/2019 =C3=A0 13:40, Daniel P. Berrang=C3=A9 a =C3=A9crit=C2=A0:
> > The SIOCGSTAMP symbol was previously defined in the
> > asm-generic/sockios.h header file. QEMU sees that header
> > indirectly via
> >=20
> >    sys/socket.h
> >     -> bits/socket.h
> >         -> asm/socket.h
> >             -> asm-generic/socket.h
> >                 -> asm/sockios.h
> >                     -> asm-generic/sockios.h
> >=20
> > In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> > the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> > Instead it provides only SIOCGSTAMP_OLD.
> >=20
> > The linux/sockios.h header now defines SIOCGSTAMP using either
> > SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. This linux only
> > header file is not pulled in by QEMU though, so we get a build
> > failure:
> >=20
> > qemu/linux-user/ioctls.h:225:9: error: =E2=80=98SIOCGSTAMP=E2=80=99 u=
ndeclared here (not in a function); did you mean =E2=80=98SIOCSRARP=E2=80=
=99?
> >   225 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> >       |         ^~~~~~~~~~
> > qemu/linux-user/syscall.c:4855:23: note: in definition of macro =E2=80=
=98IOCTL=E2=80=99
> >  4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } =
},
> >       |                       ^~~
> > qemu/linux-user/ioctls.h:226:9: error: =E2=80=98SIOCGSTAMPNS=E2=80=99=
 undeclared here (not in a function); did you mean =E2=80=98SIOCGSTAMP_OL=
D=E2=80=99?
> >   226 |   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec=
)))
> >       |         ^~~~~~~~~~~~
> > qemu/linux-user/syscall.c:4855:23: note: in definition of macro =E2=80=
=98IOCTL=E2=80=99
> >  4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } =
},
> >       |                       ^~~
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  linux-user/syscall.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index b187c1281d..f13e260b02 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -37,6 +37,7 @@
> >  #include <sched.h>
> >  #include <sys/timex.h>
> >  #include <sys/socket.h>
> > +#include <linux/sockios.h>
> >  #include <sys/un.h>
> >  #include <sys/uio.h>
> >  #include <poll.h>
> >=20
>=20
> We already had a patch for that:
>=20
> https://patchew.org/QEMU/20190604071915.288045-1-borntraeger@de.ibm.com=
/
>=20
> but the value of SIOCGSTAMP depends on the size of struct timeval. The
> host part must be able to process SIOCGSTAMP_OLD and SIOCGSTAMP_NEW if
> it defines them.

I've sent a v2 that attempts to handle both struct sizes


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A9C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B228208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B228208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39751 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVKe-0000Vj-Jj
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlVJd-0008Ey-BD
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlVJb-0006GJ-QZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hlVJb-0006Fg-I4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:24:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD4BB3083392;
 Thu, 11 Jul 2019 09:24:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 536EF5C1B5;
 Thu, 11 Jul 2019 09:24:32 +0000 (UTC)
Date: Thu, 11 Jul 2019 10:24:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Message-ID: <20190711092430.GC11930@redhat.com>
References: <20190617131103.1413-1-berrange@redhat.com>
 <b6d3c3b0-da81-8b59-1660-83ef5423b097@vivier.eu>
 <CAATJJ0K4xZ4iPxBKz-iCv6sDTjWE5y+-wg7T9OOiRq4tTG__mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAATJJ0K4xZ4iPxBKz-iCv6sDTjWE5y+-wg7T9OOiRq4tTG__mA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 11 Jul 2019 09:24:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 10:02:01AM +0200, Christian Ehrhardt wrote:
> On Mon, Jun 17, 2019 at 5:35 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >
> > Le 17/06/2019 =C3=A0 15:11, Daniel P. Berrang=C3=A9 a =C3=A9crit :
> > > The SIOCGSTAMP symbol was previously defined in the
> > > asm-generic/sockios.h header file. QEMU sees that header
> > > indirectly via sys/socket.h
> > >
> > > In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> > > the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> > > Instead it provides only SIOCGSTAMP_OLD, which only uses a
> > > 32-bit time_t on 32-bit architectures.
> > >
> > > The linux/sockios.h header then defines SIOCGSTAMP using
> > > either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
> > > SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
> > > on 32-bit architectures
> > >
> > > To cope with this we must now define two separate syscalls,
> > > with corresponding old and new sizes, as well as including
> > > the new linux/sockios.h header.
> > >
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > >  linux-user/ioctls.h        | 15 +++++++++++++++
> > >  linux-user/syscall.c       |  1 +
> > >  linux-user/syscall_defs.h  |  5 +++++
> > >  linux-user/syscall_types.h |  4 ++++
> > >  4 files changed, 25 insertions(+)
> > >
> > > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > > index 5e84dc7c3a..5a6d6def7e 100644
> > > --- a/linux-user/ioctls.h
> > > +++ b/linux-user/ioctls.h
> > > @@ -222,8 +222,23 @@
> > >    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_i=
freq)))
> > >    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
> > >    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
> > > +
> > > +#ifdef SIOCGSTAMP_OLD
> > > +  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> > > +#else
> > >    IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> > > +#endif
> > > +#ifdef SIOCGSTAMPNS_OLD
> > > +  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)=
))
> > > +#else
> > >    IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> > > +#endif
> > > +#ifdef SIOCGSTAMP_NEW
> > > +  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64))=
)
> > > +#endif
> > > +#ifdef SIOCGSTAMPNS_NEW
> > > +  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec6=
4)))
> > > +#endif
> > >
> > >    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
> > >    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
> > > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > > index b187c1281d..f13e260b02 100644
> > > --- a/linux-user/syscall.c
> > > +++ b/linux-user/syscall.c
> > > @@ -37,6 +37,7 @@
> > >  #include <sched.h>
> > >  #include <sys/timex.h>
> > >  #include <sys/socket.h>
> > > +#include <linux/sockios.h>
> > >  #include <sys/un.h>
> > >  #include <sys/uio.h>
> > >  #include <poll.h>
> > > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > > index 7f141f699c..7830b600e7 100644
> > > --- a/linux-user/syscall_defs.h
> > > +++ b/linux-user/syscall_defs.h
> > > @@ -750,6 +750,11 @@ struct target_pollfd {
> > >
> > >  #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timev=
al) */
> > >  #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (times=
pec) */
> > > +#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (time=
val) */
> > > +#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (time=
spec) */
> > > +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6=
, sizeof(long long) + sizeof(long)) /* Get stamp (timeval64) */
> > > +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7=
, sizeof(long long) + sizeof(long)) /* Get stamp (timespec64) */
> > kernel defines:
> >
> > #define SIOCGSTAMP_NEW   _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
> > #define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
> >
> > So it should be TARGET_IOR(0x89, 0x6, abi_llong[2])
> >
> > Their codes are 0x80108906 and 80108907.
>=20
> Hi,
> I found the discussion around this topic being almost a month old.
> And related to this fedora bug [1] was closed by adding [2] which
> matches [3] that was nacked in the discussion here.
>=20
> Since I found nothing later (neither qemu commits nor further
> discussions) I wonder if it has fallen through the cracks OR if there
> was a kernel fix/change to resolve it (if that is the case a pointer
> to the related kernel change would be nice)?

I didn't have time to address the feedback to this v2, and since the
immediate problem for Fedora has a workaround, its been lower priority
especially since my understanding of linux-iser is limited.

IOW, If anyone wants to take over my patch proposal here feel free. It
would obviously be nice to fix for this 4.1 release if practical.

>=20
> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1718926
> [2]: https://src.fedoraproject.org/rpms/qemu/blob/master/f/0005-NOT-UPS=
TREAM-Build-fix-with-latest-kernel.patch
> [3]: https://patchew.org/QEMU/20190604071915.288045-1-borntraeger@de.ib=
m.com/
>=20
> > Thanks,
> > Laurent
> >
>=20
>=20
> --=20
> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


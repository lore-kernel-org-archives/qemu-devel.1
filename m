Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73521C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C02F208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 08:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C02F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlU2i-0000QM-CG
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 04:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1hlU2C-0008RO-4v
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1hlU2A-0006Mt-M2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:02:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1hlU2A-0006LX-Fm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 04:02:30 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1hlU28-0005ez-In
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:02:28 +0000
Received: by mail-ua1-f72.google.com with SMTP id d1so882252uak.23
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 01:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FBlpKQcfevzmyQhC3ZU2LozlX2sdjdgD3qSnxcPJTLY=;
 b=b3cjLiDAD311xUbMGEIbEQWf1lb+s+QHUIJEyAYk3ruwnxjESZFrwoXJC8HHowsFN5
 zIs3xyYaYM5ilZVHnzS5JlPARZ2cEMVt23uR+aGnJ+6ZGeP/Uu+TJ7a5NMCN/Xt03c8u
 fLKpzXRNidXIuKIT/TwjG6cAfW1xDdZbZG34/l/EedXIrKq+uUGeP2wrIQjp65DNH9GT
 NI45KjoQi5k5E4BFQD6787fH1a+JNn6/QKhNLXOTYlirE4g41cyrwdcHSSpHkk45JKPV
 mlpLH5FfgSwEGon8sDlT1BtZwXvHZwwje4x0kLyxoT3WR+2E+8VdVfkzKhUu1LUtPouG
 pdtg==
X-Gm-Message-State: APjAAAXZ778BKWnlLDFbDcMU5DtdpJu4IhJiNCSPTTv6OE9b2BZ18dFn
 On5VGou84gtuPHJlTzK1mLZg8/pYrieaqVZ7aAHKCqLRL4XYIHVGv8swpsDPErEdtevTcgKvYQn
 OgUGvh2sQaKhZFk1ogmR6Bld04Y3BBQGSofqDu70Fu04PMKEV
X-Received: by 2002:ab0:7143:: with SMTP id k3mr2055046uao.91.1562832147451;
 Thu, 11 Jul 2019 01:02:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvLT7mkyqC52FZMMDMPKZ/HVBXHT8xsg/bpo4DvkmCl9lF0HkV/HzzMWM3JVNohrOpn3ortf36i6v5O+zEe9M=
X-Received: by 2002:ab0:7143:: with SMTP id k3mr2055017uao.91.1562832147190;
 Thu, 11 Jul 2019 01:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131103.1413-1-berrange@redhat.com>
 <b6d3c3b0-da81-8b59-1660-83ef5423b097@vivier.eu>
In-Reply-To: <b6d3c3b0-da81-8b59-1660-83ef5423b097@vivier.eu>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 11 Jul 2019 10:02:01 +0200
Message-ID: <CAATJJ0K4xZ4iPxBKz-iCv6sDTjWE5y+-wg7T9OOiRq4tTG__mA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 5:35 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 17/06/2019 =C3=A0 15:11, Daniel P. Berrang=C3=A9 a =C3=A9crit :
> > The SIOCGSTAMP symbol was previously defined in the
> > asm-generic/sockios.h header file. QEMU sees that header
> > indirectly via sys/socket.h
> >
> > In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> > the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> > Instead it provides only SIOCGSTAMP_OLD, which only uses a
> > 32-bit time_t on 32-bit architectures.
> >
> > The linux/sockios.h header then defines SIOCGSTAMP using
> > either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
> > SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
> > on 32-bit architectures
> >
> > To cope with this we must now define two separate syscalls,
> > with corresponding old and new sizes, as well as including
> > the new linux/sockios.h header.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  linux-user/ioctls.h        | 15 +++++++++++++++
> >  linux-user/syscall.c       |  1 +
> >  linux-user/syscall_defs.h  |  5 +++++
> >  linux-user/syscall_types.h |  4 ++++
> >  4 files changed, 25 insertions(+)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index 5e84dc7c3a..5a6d6def7e 100644
> > --- a/linux-user/ioctls.h
> > +++ b/linux-user/ioctls.h
> > @@ -222,8 +222,23 @@
> >    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq=
)))
> >    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
> >    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
> > +
> > +#ifdef SIOCGSTAMP_OLD
> > +  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> > +#else
> >    IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> > +#endif
> > +#ifdef SIOCGSTAMPNS_OLD
> > +  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> > +#else
> >    IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> > +#endif
> > +#ifdef SIOCGSTAMP_NEW
> > +  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
> > +#endif
> > +#ifdef SIOCGSTAMPNS_NEW
> > +  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64)))
> > +#endif
> >
> >    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
> >    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
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
> > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > index 7f141f699c..7830b600e7 100644
> > --- a/linux-user/syscall_defs.h
> > +++ b/linux-user/syscall_defs.h
> > @@ -750,6 +750,11 @@ struct target_pollfd {
> >
> >  #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) =
*/
> >  #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec)=
 */
> > +#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timeval)=
 */
> > +#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (timespec=
) */
> > +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6, si=
zeof(long long) + sizeof(long)) /* Get stamp (timeval64) */
> > +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7, si=
zeof(long long) + sizeof(long)) /* Get stamp (timespec64) */
> kernel defines:
>
> #define SIOCGSTAMP_NEW   _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
> #define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
>
> So it should be TARGET_IOR(0x89, 0x6, abi_llong[2])
>
> Their codes are 0x80108906 and 80108907.

Hi,
I found the discussion around this topic being almost a month old.
And related to this fedora bug [1] was closed by adding [2] which
matches [3] that was nacked in the discussion here.

Since I found nothing later (neither qemu commits nor further
discussions) I wonder if it has fallen through the cracks OR if there
was a kernel fix/change to resolve it (if that is the case a pointer
to the related kernel change would be nice)?

[1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1718926
[2]: https://src.fedoraproject.org/rpms/qemu/blob/master/f/0005-NOT-UPSTREA=
M-Build-fix-with-latest-kernel.patch
[3]: https://patchew.org/QEMU/20190604071915.288045-1-borntraeger@de.ibm.co=
m/

> Thanks,
> Laurent
>


--=20
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd


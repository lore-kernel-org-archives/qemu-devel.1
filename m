Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3923C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7948F208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqpxYoPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7948F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVGb-0001qs-AU
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioVFw-0001P3-TJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioVFu-0007rT-U7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:29:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioVFu-0007py-PF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578328165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q8CozOD8fWMyAYDpG9wpf5iEk7Ru8pTXrKyo2w8ZjZI=;
 b=cqpxYoPsuqVlf/Uxf//X1+b2Jo/itKvfX70qIFqe+9nkz7jiUTmmP8D01P6mZJxlQ33fF7
 Uz2uoLHl89xD61RYcQLCa/2BDFcoyvxsevwZNydqOi0EVRPLbIe7ISrwCfz/yGiCWbmO27
 U0EOyrO+qe2jokfdk/7a7LC4nDKc7Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-6v4Q3ml-MOq3KGJKOnapDQ-1; Mon, 06 Jan 2020 11:29:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731618048E2
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 16:29:22 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B2C7672C0;
 Mon,  6 Jan 2020 16:29:18 +0000 (UTC)
Date: Mon, 6 Jan 2020 16:29:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 011/104] virtiofsd: Fix common header and define for QEMU
 builds
Message-ID: <20200106162916.GH2798@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-12-dgilbert@redhat.com>
 <20200103122247.GQ2753983@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200103122247.GQ2753983@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6v4Q3ml-MOq3KGJKOnapDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:37:31PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > All of the fuse files include config.h and define GNU_SOURCE
> > where we don't have either under our build - remove them.
>=20
> There's a bunch of other random changes in this patch - were these
> all fallout from removing the config.h header, or were they meant
> for a separate commit ?

I've moved the removals of cuse_lowlevel_init call and
version printing into the earlier 'Trim down imported files'.
So we're left with header and #define tweaks.

I've added:
   'Fixup path to the kernel's fuse.h in the QEMUs world.'

to the commit message.

Dave


> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/buffer.c         |  3 ---
> >  tools/virtiofsd/fuse_i.h         |  3 +++
> >  tools/virtiofsd/fuse_loop_mt.c   |  3 +--
> >  tools/virtiofsd/fuse_lowlevel.c  | 12 +-----------
> >  tools/virtiofsd/fuse_opt.c       |  1 -
> >  tools/virtiofsd/fuse_signals.c   |  1 -
> >  tools/virtiofsd/passthrough_ll.c |  9 ++-------
> >  7 files changed, 7 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
> > index 38521f5889..1d7e6d2439 100644
> > --- a/tools/virtiofsd/buffer.c
> > +++ b/tools/virtiofsd/buffer.c
> > @@ -9,9 +9,6 @@
> >   * See the file COPYING.LIB
> >   */
> > =20
> > -#define _GNU_SOURCE
> > -
> > -#include "config.h"
> >  #include "fuse_i.h"
> >  #include "fuse_lowlevel.h"
> >  #include <assert.h>
> > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > index 1119e85e57..0b5acc8765 100644
> > --- a/tools/virtiofsd/fuse_i.h
> > +++ b/tools/virtiofsd/fuse_i.h
> > @@ -6,6 +6,9 @@
> >   * See the file COPYING.LIB
> >   */
> > =20
> > +#define FUSE_USE_VERSION 31
> > +
> > +
> >  #include "fuse.h"
> >  #include "fuse_lowlevel.h"
> > =20
> > diff --git a/tools/virtiofsd/fuse_loop_mt.c b/tools/virtiofsd/fuse_loop=
_mt.c
> > index 39e080d9ff..00138b2ab3 100644
> > --- a/tools/virtiofsd/fuse_loop_mt.c
> > +++ b/tools/virtiofsd/fuse_loop_mt.c
> > @@ -8,11 +8,10 @@
> >   * See the file COPYING.LIB.
> >   */
> > =20
> > -#include "config.h"
> >  #include "fuse_i.h"
> > -#include "fuse_kernel.h"
> >  #include "fuse_lowlevel.h"
> >  #include "fuse_misc.h"
> > +#include "standard-headers/linux/fuse.h"
> > =20
> >  #include <assert.h>
> >  #include <errno.h>
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 0d7b2c3dc9..497eb25487 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -9,14 +9,10 @@
> >   * See the file COPYING.LIB
> >   */
> > =20
> > -#define _GNU_SOURCE
> > -
> > -#include "config.h"
> >  #include "fuse_i.h"
> > -#include "fuse_kernel.h"
> > +#include "standard-headers/linux/fuse.h"
> >  #include "fuse_misc.h"
> >  #include "fuse_opt.h"
> > -#include "mount_util.h"
> > =20
> >  #include <assert.h>
> >  #include <errno.h>
> > @@ -2093,7 +2089,6 @@ static struct {
> >      [FUSE_RENAME2] =3D { do_rename2, "RENAME2" },
> >      [FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE"=
 },
> >      [FUSE_LSEEK] =3D { do_lseek, "LSEEK" },
> > -    [CUSE_INIT] =3D { cuse_lowlevel_init, "CUSE_INIT" },
> >  };
> > =20
> >  #define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
> > @@ -2220,7 +2215,6 @@ void fuse_lowlevel_version(void)
> >  {
> >      printf("using FUSE kernel interface version %i.%i\n", FUSE_KERNEL_=
VERSION,
> >             FUSE_KERNEL_MINOR_VERSION);
> > -    fuse_mount_version();
> >  }
> > =20
> >  void fuse_lowlevel_help(void)
> > @@ -2310,10 +2304,6 @@ struct fuse_session *fuse_session_new(struct fus=
e_args *args,
> >          goto out4;
> >      }
> > =20
> > -    if (se->debug) {
> > -        fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE=
_VERSION);
> > -    }
> > -
> >      se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_H=
EADER_SIZE;
> > =20
> >      list_init_req(&se->list);
> > diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
> > index edd36f4a3b..1fee55e266 100644
> > --- a/tools/virtiofsd/fuse_opt.c
> > +++ b/tools/virtiofsd/fuse_opt.c
> > @@ -10,7 +10,6 @@
> >   */
> > =20
> >  #include "fuse_opt.h"
> > -#include "config.h"
> >  #include "fuse_i.h"
> >  #include "fuse_misc.h"
> > =20
> > diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_sign=
als.c
> > index 19d6791cb9..10a6f88088 100644
> > --- a/tools/virtiofsd/fuse_signals.c
> > +++ b/tools/virtiofsd/fuse_signals.c
> > @@ -8,7 +8,6 @@
> >   * See the file COPYING.LIB
> >   */
> > =20
> > -#include "config.h"
> >  #include "fuse_i.h"
> >  #include "fuse_lowlevel.h"
> > =20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index a79ec2c70d..0e543353a4 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -35,15 +35,10 @@
> >   * \include passthrough_ll.c
> >   */
> > =20
> > -#define _GNU_SOURCE
> > -#define FUSE_USE_VERSION 31
> > -
> > -#include "config.h"
> > -
> > +#include "fuse_lowlevel.h"
> >  #include <assert.h>
> >  #include <dirent.h>
> >  #include <errno.h>
> > -#include <fuse_lowlevel.h>
> >  #include <inttypes.h>
> >  #include <limits.h>
> >  #include <pthread.h>
> > @@ -58,6 +53,7 @@
> > =20
> >  #include "passthrough_helpers.h"
> > =20
> > +#define HAVE_POSIX_FALLOCATE 1
> >  /*
> >   * We are re-using pointers to our `struct lo_inode` and `struct
> >   * lo_dirp` elements as inodes. This means that we must be able to
> > @@ -1303,7 +1299,6 @@ int main(int argc, char *argv[])
> >          ret =3D 0;
> >          goto err_out1;
> >      } else if (opts.show_version) {
> > -        printf("FUSE library version %s\n", fuse_pkgversion());
> >          fuse_lowlevel_version();
> >          ret =3D 0;
> >          goto err_out1;
> > --=20
> > 2.23.0
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



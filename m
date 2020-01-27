Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89611C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5329024679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDbDNhv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5329024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAE5-0006PQ-Gy
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwADH-0005lD-Gk
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwADF-0004e6-Kf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwADF-0004dk-AK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580153899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcKv3IplqNlyl2lcPdqIrwlnvS+S/oIGzJdupMEuVHM=;
 b=hDbDNhv0Nn+pRrcQhtXLuDpzjly6FlMQNSh5XfpS9VJEZt1MtCstu/Mt4E8EWoxVTE5WlC
 J94O+bx9xyxrtkuA3m6XP6iSTi6UX5EI6on6XnR9mMtK4K1AOCa0l56UVA6HtPjOAzKQg6
 tT8u6vIsxhkmHvLHjVM2bV+J/e0fqCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-YAizSOXANL6TgsC5kwIDFg-1; Mon, 27 Jan 2020 14:38:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E06DA18B9FC4
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 19:38:16 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 496E21001B30;
 Mon, 27 Jan 2020 19:38:10 +0000 (UTC)
Date: Mon, 27 Jan 2020 19:38:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PULL 016/111] virtiofsd: Add options for virtio
Message-ID: <20200127193808.GB3419@work-vm>
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <20200123115841.138849-17-dgilbert@redhat.com>
 <m1r1zlqf71.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <m1r1zlqf71.fsf@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YAizSOXANL6TgsC5kwIDFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christophe de Dinechin (dinechin@redhat.com) wrote:
>=20
> Dr. David Alan Gilbert (git) writes:
>=20
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Add options to specify parameters for virtio-fs paths, i.e.
> >
> >    ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu
>=20
> Shouldn't that be --socket-path=3D/tmp/vhostqemu now?

Oops yes it should, that was the old syntax

> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_i.h        |  1 +
> >  tools/virtiofsd/fuse_lowlevel.c | 11 ++++++++---
> >  tools/virtiofsd/helper.c        | 14 +++++++-------
> >  3 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > index bae06992e0..26b1a7da88 100644
> > --- a/tools/virtiofsd/fuse_i.h
> > +++ b/tools/virtiofsd/fuse_i.h
> > @@ -63,6 +63,7 @@ struct fuse_session {
> >      struct fuse_notify_req notify_list;
> >      size_t bufsize;
> >      int error;
> > +    char *vu_socket_path;
> >  };
> >
> >  struct fuse_chan {
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 8552cfb8af..17e8718283 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -2115,8 +2115,11 @@ reply_err:
> >      }
> >
> >  static const struct fuse_opt fuse_ll_opts[] =3D {
> > -    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
> > -    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_other=
s, 1),
> > +    LL_OPTION("debug", debug, 1),
> > +    LL_OPTION("-d", debug, 1),
> > +    LL_OPTION("--debug", debug, 1),
> > +    LL_OPTION("allow_root", deny_others, 1),
> > +    LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> >      FUSE_OPT_END
> >  };
> >
> > @@ -2132,7 +2135,9 @@ void fuse_lowlevel_help(void)
> >       * These are not all options, but the ones that are
> >       * potentially of interest to an end-user
> >       */
> > -    printf("    -o allow_root          allow access by root\n");
> > +    printf(
> > +        "    -o allow_root              allow access by root\n"
> > +        "    --socket-path=3DPATH         path for the vhost-user sock=
et\n");
> >  }
> >
> >  void fuse_session_destroy(struct fuse_session *se)
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 9333691525..676032e71f 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -127,13 +127,13 @@ static const struct fuse_opt conn_info_opt_spec[]=
 =3D {
> >
> >  void fuse_cmdline_help(void)
> >  {
> > -    printf(
> > -        "    -h   --help            print help\n"
> > -        "    -V   --version         print version\n"
> > -        "    -d   -o debug          enable debug output (implies -f)\n=
"
> > -        "    -f                     foreground operation\n"
> > -        "    -o max_idle_threads    the maximum number of idle worker =
threads\n"
> > -        "                           allowed (default: 10)\n");
> > +    printf("    -h   --help                print help\n"
> > +           "    -V   --version             print version\n"
> > +           "    -d   -o debug              enable debug output (implie=
s -f)\n"
> > +           "    -f                         foreground operation\n"
> > +           "    -o max_idle_threads        the maximum number of idle =
worker "
> > +           "threads\n"
> > +           "                               allowed (default: 10)\n");
> >  }
> >
> >  static int fuse_helper_opt_proc(void *data, const char *arg, int key,
>=20
>=20
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



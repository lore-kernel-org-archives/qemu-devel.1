Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E689C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1AC20673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFpMc0tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1AC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwnu-0005Wh-8s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipwjN-0000kL-K8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipwjL-00062N-TI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:01:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipwjL-0005zY-Mk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578672107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8mHPxxPLkxImEkrHl483hMWEfB2gBBZ/4NPjUOAcWg=;
 b=cFpMc0tRXWuM/EHTqTsEbHH891MgWFNtPzwJ7En/nNB+aRCTpe5fxoEK5+FymPMD96e9Ke
 Z7+1Zt2Auor2/3c09Vtz0iMI6jM3GLxoQotrCEDiSjzGk/Zuk7/W77tCxoCiEIDGEU420o
 HRLJ3pQf/G++Y49rHAoCzFtw6SEKoO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-57KDMSfmPxqdt8HYn_ncxg-1; Fri, 10 Jan 2020 11:01:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E28C5184B1F0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:01:44 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07C0A1001B0B;
 Fri, 10 Jan 2020 16:01:38 +0000 (UTC)
Date: Fri, 10 Jan 2020 16:01:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 014/104] virtiofsd: Add options for virtio
Message-ID: <20200110160136.GJ3901@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-15-dgilbert@redhat.com>
 <20200103151813.GH2753983@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200103151813.GH2753983@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 57KDMSfmPxqdt8HYn_ncxg-1
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
> On Thu, Dec 12, 2019 at 04:37:34PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Add options to specify parameters for virtio-fs paths, i.e.
> >=20
> >    ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_i.h        |  1 +
> >  tools/virtiofsd/fuse_lowlevel.c | 17 ++++++++++++-----
> >  tools/virtiofsd/helper.c        | 22 +++++++++++-----------
> >  3 files changed, 24 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > index 0b5acc8765..f58be71e4b 100644
> > --- a/tools/virtiofsd/fuse_i.h
> > +++ b/tools/virtiofsd/fuse_i.h
> > @@ -63,6 +63,7 @@ struct fuse_session {
> >      struct fuse_notify_req notify_list;
> >      size_t bufsize;
> >      int error;
> > +    char *vu_socket_path;
> >  };
> > =20
> >  struct fuse_chan {
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 167701b453..da708161e1 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -2118,8 +2118,12 @@ reply_err:
> >      }
> > =20
> >  static const struct fuse_opt fuse_ll_opts[] =3D {
> > -    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
> > -    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_other=
s, 1),
> > +    LL_OPTION("debug", debug, 1),
> > +    LL_OPTION("-d", debug, 1),
> > +    LL_OPTION("--debug", debug, 1),
>=20
> Pre-existing, but I'm not convinced we really need 3 different
> ways to enable debugging - I would think -d / --debug is sufficient,
> without needing "-o debug".

Given it's existing, I'll leave that.

> > +    LL_OPTION("allow_root", deny_others, 1),
> > +    LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
> > +    LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
>=20
> Similarly here I'm not convinced we need to add both
> "--socket-path PATH" and "-o vhost_user_socket=3DPATH"
>=20
>=20
> IIRC, we need --socket-path for compliance with QEMU's
> standard execution model for vhost helpers.

OK, deleted -o vhost_user_socket   - it was there because
our existing kata glue and test setups were using it.


Dave

> >      FUSE_OPT_END
> >  };
> > =20
> > @@ -2135,9 +2139,12 @@ void fuse_lowlevel_help(void)
> >       * These are not all options, but the ones that are
> >       * potentially of interest to an end-user
> >       */
> > -    printf("    -o allow_other         allow access by all users\n"
> > -           "    -o allow_root          allow access by root\n"
> > -           "    -o auto_unmount        auto unmount on process termina=
tion\n");
> > +    printf(
> > +        "    -o allow_other             allow access by all users\n"
> > +        "    -o allow_root              allow access by root\n"
> > +        "    --socket-path=3DPATH         path for the vhost-user sock=
et\n"
> > +        "    -o vhost_user_socket=3DPATH  path for the vhost-user sock=
et\n"
> > +        "    -o auto_unmount            auto unmount on process termin=
ation\n");
> >  }
> > =20
> >  void fuse_session_destroy(struct fuse_session *se)
> > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > index 8afccfc15e..48e38a7963 100644
> > --- a/tools/virtiofsd/helper.c
> > +++ b/tools/virtiofsd/helper.c
> > @@ -128,17 +128,17 @@ static const struct fuse_opt conn_info_opt_spec[]=
 =3D {
> > =20
> >  void fuse_cmdline_help(void)
> >  {
> > -    printf(
> > -        "    -h   --help            print help\n"
> > -        "    -V   --version         print version\n"
> > -        "    -d   -o debug          enable debug output (implies -f)\n=
"
> > -        "    -f                     foreground operation\n"
> > -        "    -s                     disable multi-threaded operation\n=
"
> > -        "    -o clone_fd            use separate fuse device fd for ea=
ch "
> > -        "thread\n"
> > -        "                           (may improve performance)\n"
> > -        "    -o max_idle_threads    the maximum number of idle worker =
threads\n"
> > -        "                           allowed (default: 10)\n");
> > +    printf("    -h   --help                print help\n"
> > +           "    -V   --version             print version\n"
> > +           "    -d   -o debug              enable debug output (implie=
s -f)\n"
> > +           "    -f                         foreground operation\n"
> > +           "    -s                         disable multi-threaded oper=
ation\n"
> > +           "    -o clone_fd                use separate fuse device fd=
 for "
> > +           "each thread\n"
> > +           "                               (may improve performance)\n=
"
> > +           "    -o max_idle_threads        the maximum number of idle =
worker "
> > +           "threads\n"
> > +           "                               allowed (default: 10)\n");
> >  }
> > =20
> >  static int fuse_helper_opt_proc(void *data, const char *arg, int key,
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


